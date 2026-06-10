# GitHub Actions Templates for Anclora Workflows

**Purpose**: Reusable CI/CD workflow templates for different infrastructure combinations
**Updated**: 2026-06-10
**Usage**: Copy and customize for your repository

---

## Overview

Anclora repos use different infrastructure combinations:

 | Pattern | Frontend | Backend | Database | Example |
 | --- | --- | --- | --- | --- |
 | **Pattern A** | Vercel | Render | Supabase | Nexus, SyncXML |
 | **Pattern B** | Vercel | Vercel Serverless | Neon | Content Generator |
 | **Pattern C** | Self-hosted | Render | PostgreSQL | Data Lab |
 | **Pattern D** | Vercel | Lambda | DynamoDB | Future |

This document provides templates for each pattern.

---

## Template A: Vercel Frontend + Render Backend + Supabase DB

**Use this for**: Nexus, SyncXML, and similar apps

### `.github/workflows/ci-development.yml`

```yaml
name: CI — Development

on:
  push:
    branches: [development]
  pull_request:
    branches: [development]

jobs:
  lint-and-type-check:
    runs-on: ubuntu-latest
    steps:

      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4

        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies

        run: npm ci

      - name: Lint

        run: npm run lint

      - name: Type check

        run: npm run type-check

  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:

          - 5432:5432

    steps:

      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4

        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies

        run: npm ci

      - name: Run tests

        run: npm test -- --coverage
        env:
          DATABASE_URL: postgres://postgres:postgres@localhost:5432/test_db

      - name: Upload coverage

        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info
          fail_ci_if_error: true

  build:
    runs-on: ubuntu-latest
    needs: [lint-and-type-check, test]
    steps:

      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4

        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies

        run: npm ci

      - name: Build frontend

        run: npm run build
        env:
          NEXT_PUBLIC_API_URL: ${{ secrets.DEV_API_URL }}

      - name: Build backend

        working-directory: ./backend
        run: npm run build

  security:
    runs-on: ubuntu-latest
    steps:

      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4

        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies

        run: npm ci

      - name: Security audit

        run: npm audit --audit-level=moderate
        continue-on-error: true

  deploy-preview:
    runs-on: ubuntu-latest
    needs: [build, security]
    if: github.event_name == 'pull_request'
    steps:

      - uses: actions/checkout@v4
      - uses: vercel/action@main

        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID_FRONTEND }}
          scope: ${{ secrets.VERCEL_ORG_ID }}
          args: --prod=false

```text

### `.github/workflows/deploy-staging.yml`

```yaml
name: Deploy — Staging

on:
  push:
    branches: [staging]

jobs:
  test-staging:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_PASSWORD: postgres
    steps:

      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4

        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies

        run: npm ci

      - name: Run e2e tests

        run: npm run test:e2e
        env:
          DATABASE_URL: postgres://postgres:postgres@localhost:5432/test_db
          API_URL: ${{ secrets.STAGING_API_URL }}

  load-test:
    runs-on: ubuntu-latest
    steps:

      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4

        with:
          node-version: '20'

      - name: Run load tests

        run: npm run test:load
        env:
          TARGET_URL: ${{ secrets.STAGING_API_URL }}
          RPS: 1000

  deploy-frontend-staging:
    runs-on: ubuntu-latest
    needs: [test-staging, load-test]
    steps:

      - uses: actions/checkout@v4
      - uses: vercel/action@main

        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID_FRONTEND }}
          scope: ${{ secrets.VERCEL_ORG_ID }}
          args: --prod --yes
        env:
          NEXT_PUBLIC_API_URL: ${{ secrets.STAGING_API_URL }}

  deploy-backend-staging:
    runs-on: ubuntu-latest
    needs: [test-staging, load-test]
    steps:

      - uses: actions/checkout@v4
      - name: Deploy to Render

        run: |
          curl https://api.render.com/deploy/srv-${{ secrets.RENDER_SERVICE_ID }}?key=${{ secrets.RENDER_API_KEY }} -X POST
        env:
          RENDER_SERVICE_ID: ${{ secrets.RENDER_SERVICE_STAGING_ID }}

  migrate-database-staging:
    runs-on: ubuntu-latest
    needs: [deploy-backend-staging]
    steps:

      - uses: actions/checkout@v4
      - name: Run migrations

        run: npm run migrate:staging
        env:
          SUPABASE_PROJECT_ID: ${{ secrets.SUPABASE_PROJECT_ID_STAGING }}
          SUPABASE_DB_PASSWORD: ${{ secrets.SUPABASE_DB_PASSWORD_STAGING }}

```text

### `.github/workflows/deploy-production.yml`

```yaml
name: Deploy — Production

on:
  push:
    branches: [production]
    tags:

      - 'v*'

jobs:
  smoke-tests:
    runs-on: ubuntu-latest
    steps:

      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4

        with:
          node-version: '20'

      - name: Run smoke tests

        run: npm run test:smoke
        env:
          API_URL: ${{ secrets.PRODUCTION_API_URL }}

  canary-deployment:
    runs-on: ubuntu-latest
    needs: [smoke-tests]
    steps:

      - uses: actions/checkout@v4
      - name: Deploy canary (5% traffic)

        run: |
          echo "Deploying to 5% traffic"
          # Platform-specific canary logic
          vercel --prod --yes --alias staging

  monitor:
    runs-on: ubuntu-latest
    needs: [canary-deployment]
    steps:

      - name: Check monitoring alerts

        run: |
          # Verify alerting is configured
          echo "Verifying production monitoring"

  deploy-production:
    runs-on: ubuntu-latest
    needs: [monitor]
    environment: production
    steps:

      - uses: actions/checkout@v4
      - uses: vercel/action@main

        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID_FRONTEND }}
          scope: ${{ secrets.VERCEL_ORG_ID }}
          args: --prod --yes
        env:
          NEXT_PUBLIC_API_URL: ${{ secrets.PRODUCTION_API_URL }}

      - name: Deploy backend to Render

        run: |
          curl https://api.render.com/deploy/srv-${{ secrets.RENDER_SERVICE_ID }}?key=${{ secrets.RENDER_API_KEY }} -X POST
        env:
          RENDER_SERVICE_ID: ${{ secrets.RENDER_SERVICE_PRODUCTION_ID }}

  post-deploy-validation:
    runs-on: ubuntu-latest
    needs: [deploy-production]
    steps:

      - name: Validate production deployment

        run: |
          # Health checks
          curl -f https://api.anclora.app/health || exit 1
          # Check critical endpoints
          npm run test:production

      - name: Notify deployment

        run: |
          # Send notification (Slack, email, etc.)
          echo "Production deployment successful"

```text

---

## Template B: Vercel Full-Stack + Neon DB + Vercel Blob

**Use this for**: Content Generator and similar serverless apps

### `.github/workflows/ci-development-vercel.yml`

```yaml
name: CI — Development (Vercel)

on:
  push:
    branches: [development]
  pull_request:
    branches: [development]

env:
  DATABASE_URL: ${{ secrets.DEV_DATABASE_URL }}
  BLOB_TOKEN: ${{ secrets.DEV_BLOB_TOKEN }}

jobs:
  lint-and-test:
    runs-on: ubuntu-latest
    steps:

      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4

        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies

        run: npm ci

      - name: Lint

        run: npm run lint

      - name: Type check

        run: npm run type-check

      - name: Unit tests

        run: npm test -- --coverage

      - name: Integration tests

        run: npm run test:integration
        env:
          DATABASE_URL: ${{ secrets.DEV_DATABASE_URL }}

  build-and-preview:
    runs-on: ubuntu-latest
    needs: [lint-and-test]
    if: github.event_name == 'pull_request'
    steps:

      - uses: actions/checkout@v4
      - uses: vercel/action@main

        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          scope: ${{ secrets.VERCEL_ORG_ID }}
          args: --prod=false
        env:
          DATABASE_URL: ${{ secrets.DEV_DATABASE_URL }}
          BLOB_TOKEN: ${{ secrets.DEV_BLOB_TOKEN }}

```text

### `.github/workflows/deploy-production-vercel.yml`

```yaml
name: Deploy — Production (Vercel)

on:
  push:
    branches: [production]

env:
  DATABASE_URL: ${{ secrets.PRODUCTION_DATABASE_URL }}
  BLOB_TOKEN: ${{ secrets.PRODUCTION_BLOB_TOKEN }}

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production
    steps:

      - uses: actions/checkout@v4

      - name: Deploy to Vercel

        uses: vercel/action@main
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          scope: ${{ secrets.VERCEL_ORG_ID }}
          args: --prod --yes
        env:
          DATABASE_URL: ${{ secrets.PRODUCTION_DATABASE_URL }}
          BLOB_TOKEN: ${{ secrets.PRODUCTION_BLOB_TOKEN }}

      - name: Run migrations

        run: npm run migrate:prod

```text

---

## Template C: Self-Hosted + Render Backend + PostgreSQL

**Use this for**: Data Lab and similar apps with custom deployment

```yaml
name: CI/CD — Self-Hosted

on:
  push:
    branches: [development, staging, production]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:

      - uses: actions/checkout@v4
      - uses: docker/build-push-action@v5

        with:
          push: false
          load: true
          tags: anclora-app:${{ github.sha }}

  deploy-development:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/development'
    needs: [build]
    steps:

      - name: Deploy to development

        run: |
          # SSH into deployment server and pull latest
          ssh ${{ secrets.DEV_SERVER_USER }}@${{ secrets.DEV_SERVER_HOST }} << 'EOF'
            cd /app
            git pull origin development
            docker-compose up -d
            npm run migrate
          EOF

  deploy-production:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/production'
    environment: production
    needs: [build]
    steps:

      - name: Deploy to production

        run: |
          ssh ${{ secrets.PROD_SERVER_USER }}@${{ secrets.PROD_SERVER_HOST }} << 'EOF'
            cd /app
            git pull origin production
            docker-compose up -d
            npm run migrate
            npm run health-check
          EOF

```text

---

## Common Configurations

### GitHub Secrets Template

Every repo needs these secrets:

```text

# Vercel

VERCEL_TOKEN
VERCEL_ORG_ID
VERCEL_PROJECT_ID_FRONTEND
VERCEL_PROJECT_ID_BACKEND

# Database (Pattern A)

SUPABASE_PROJECT_ID
SUPABASE_DB_PASSWORD
DEV_DATABASE_URL
STAGING_DATABASE_URL
PRODUCTION_DATABASE_URL

# Database (Pattern B)

DEV_BLOB_TOKEN
PRODUCTION_BLOB_TOKEN

# Render

RENDER_API_KEY
RENDER_SERVICE_ID
RENDER_SERVICE_STAGING_ID
RENDER_SERVICE_PRODUCTION_ID

# URLs

DEV_API_URL
STAGING_API_URL
PRODUCTION_API_URL

# Self-hosted

DEV_SERVER_USER
DEV_SERVER_HOST
PROD_SERVER_USER
PROD_SERVER_HOST

```text

### Environment Variables Template

Create `.env.example` in repo root:

```bash

# Development

NODE_ENV=development
DATABASE_URL=postgresql://user:password@localhost:5432/dev_db
API_URL=http://localhost:3000
NEXT_PUBLIC_API_URL=http://localhost:3001

# Staging (set in CI/CD)

STAGING_DATABASE_URL=
STAGING_API_URL=

# Production (set in CI/CD)

PRODUCTION_DATABASE_URL=
PRODUCTION_API_URL=

```text

---

## Quick Start: Setup CI/CD for Your Repo

1. **Copy appropriate template** based on your infrastructure pattern
2. **Create `.github/workflows/` directory** in your repo
3. **Paste workflow files** into that directory
4. **Add GitHub Secrets** (use template above)
5. **Test first PR** to `development` to verify workflow runs
6. **Monitor Actions tab** to see workflow progress

---

## Testing Workflows Locally

Use **act** to test GitHub Actions locally:

```bash

# Install act (https://github.com/nektos/act)

brew install act

# List available jobs

act -l

# Run specific job

act push --job lint-and-type-check

# Run with secrets

act -s VERCEL_TOKEN=your_token

```text

---

## Troubleshooting Workflows

### Workflow doesn't trigger

- [ ] Check branch name matches `on.push.branches`
- [ ] Verify branch protection rules don't block
- [ ] Check if branch exists remotely

### Steps fail silently

- [ ] Check `continue-on-error: true` (removes red flags)
- [ ] Check environment variables are set
- [ ] Check secrets are added to GitHub
- [ ] Check job dependencies with `needs:`

### Deployment fails

- [ ] Verify API keys/tokens are current
- [ ] Check service quotas (Vercel, Render, etc.)
- [ ] Review service logs (Vercel, Render dashboard)
- [ ] Check networking/firewall rules

---

## Advanced: Workflow Matrix Strategy

For testing multiple Node versions:

```yaml
strategy:
  matrix:
    node-version: [18.x, 20.x]

steps:

  - uses: actions/setup-node@v4

    with:
      node-version: ${{ matrix.node-version }}

```text

---

## Related Documents

- [GITHUB_WORKFLOW_STANDARDS.md](GITHUB_WORKFLOW_STANDARDS.md) — Standards and branch strategy
- [WORKFLOW_ORCHESTRATION_GUIDE.md](WORKFLOW_ORCHESTRATION_GUIDE.md) — Automation with agents

---

**Maintained by**: Anclora Engineering Team
**Last updated**: 2026-06-10
