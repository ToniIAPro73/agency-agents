# GitHub Workflow Standards for Anclora Ecosystem

**Purpose**: Establish consistent Git branching strategy, CI/CD pipeline, and deployment automation across all Anclora repositories  
**Status**: ACTIVE (2026-06-10)  
**Applies To**: All application repos (products), not tooling repos  
**Maintainer**: Anclora Engineering Team

---

## 1. Branch Strategy — Git Flow for Anclora

### Branch Structure (Mandatory)

Every application repository MUST have exactly these permanent branches:

```
main (production-ready)
├── production (deployed to production)
├── staging (pre-production validation)
├── development (integration branch for features)
└── [temporary branches] (feature/*, fix/*, chore/*)
```

### Branch Responsibilities

#### `main` (Production Freeze)
- **Purpose**: Historical record of production releases
- **Deployment**: None (read-only reference)
- **Merge policy**: Only from `production` via tagged release
- **Protection**: Require PR review, status checks pass
- **Protected**: Yes

#### `production` (Production Environment)
- **Purpose**: Live customer-facing code
- **Deployment**: Auto-deploy on merge
- **Source**: Merge from `staging` (git-flow/promote-staging-to-production.sh)
- **Merge policy**: Squash merge preferred, require PR review
- **Tags**: Automatic semantic version tags (v2026.06.10-nexus-production)
- **Protected**: Yes, require status checks + branch protection

#### `staging` (Pre-Production Testing)
- **Purpose**: Final validation before production
- **Deployment**: Auto-deploy to staging environment
- **Source**: Merge from `development` (git-flow/promote-development-to-staging.sh)
- **Merge policy**: Squash merge preferred
- **Testing**: Must pass full test suite + load tests
- **Protected**: Yes, require status checks

#### `development` (Integration Branch)
- **Purpose**: Merge point for all feature branches
- **Deployment**: Auto-deploy to development/preview environment
- **Source**: Merge from feature/*, fix/*, chore/* branches
- **Merge policy**: Squash merge for feature branches, regular merge for release prep
- **CI/CD**: Lint, unit tests, build, deploy to preview
- **Protected**: Yes, require status checks + 1 approving review

#### Temporary Branches (`feature/*`, `fix/*`, `chore/*`)
- **Naming**: 
  - `feature/user-authentication` (new capability)
  - `fix/login-timeout-bug` (bug fix)
  - `chore/update-dependencies` (maintenance)
  - `docs/improve-readme` (documentation)
- **Source**: Branch from `development`
- **Merge back to**: `development` (PR required)
- **Lifespan**: Delete after merge
- **Max age**: 30 days (auto-flagged for deletion)

---

## 2. Commit Strategy

### Commit Message Format

Use **conventional commits**:

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types (Required)

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation
- **style**: Code style (formatting, missing semicolons)
- **refactor**: Code refactoring without feature changes
- **perf**: Performance improvements
- **test**: Test additions or fixes
- **chore**: Build, CI, dependency updates

### Examples

```
feat(auth): add two-factor authentication

Implement TOTP-based 2FA for user accounts.
Adds backup codes and recovery procedures.

Closes #123
Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

```
fix(api): resolve race condition in user creation

Use database transaction to ensure atomicity.
Added mutex lock for concurrent requests.

Fixes #456
```

### Branching Commits

- **Feature commits**: Squash before merge to `development` (1 commit = 1 feature)
- **Release commits**: Create separate commit for version bump
- **Hotfix commits**: Tag immediately after merge to `production`

---

## 3. Pull Request Requirements

### PR Checklist (Mandatory)

```markdown
- [ ] Branch name follows convention (feature/*, fix/*, chore/*)
- [ ] Commits follow conventional commit format
- [ ] Code passes linting and type checks
- [ ] Tests added/updated for changes
- [ ] At least 1 approving review required
- [ ] All CI checks pass
- [ ] Linked to issue(s) with "Closes #123"
- [ ] No merge conflicts with target branch
- [ ] Documentation updated (README, API docs, etc.)
```

### PR Titles

Use conventional format:

```
feat: add user dashboard
fix: resolve timeout in payment processing
docs: improve API documentation
chore: upgrade dependencies to latest versions
```

### Approval Requirements

- **to `development`**: 1 approving review minimum
- **to `staging`**: 2 approving reviews + pass full test suite
- **to `production`**: 3 approving reviews + pass load tests + security audit

### Branch Protection Rules

**All permanent branches** require:
- ✅ At least N approving reviews
- ✅ All status checks must pass
- ✅ Require branches to be up to date before merge
- ✅ Require conversation resolution before merge
- ✅ Require signed commits
- ✅ Restrict who can push (admin only for production)

---

## 4. Deployment Strategy

### Automatic Deployments

| Branch | Environment | Trigger | Approval | Rollback |
| --- | --- | --- | --- | --- |
| `development` | Dev/Preview | PR merge | None | Auto-revert |
| `staging` | Staging | PR merge | Manual review | Auto-revert |
| `production` | Production | PR merge | Mandatory 3-approval | Manual via hotfix |

### Deployment Process

1. **Code Push** → `development` branch
2. **CI/CD Validation** (lint, test, build)
3. **Deploy to Preview** (auto)
4. **Manual Testing** (staging validation)
5. **Promote to Staging** via `promote-development-to-staging.sh`
6. **Staging QA** (full test suite, load tests)
7. **Promote to Production** via `promote-staging-to-production.sh`
8. **Production Monitoring** (logs, metrics, alerting)

### Rollback Procedures

**For staging/production**:
```bash
# Revert last commit
git revert <commit-hash>
git push origin <branch>

# Or reset to previous release tag
git reset --hard <previous-tag>
git push origin <branch> --force  # ONLY if no consumers

# Or deploy previous release
vercel --prod --yes  # Redeploy previous version
```

---

## 5. Infrastructure-Specific Configurations

### Configuration Variables by Infrastructure

Repos use different databases, deployment platforms, and configurations. Define these in:

- `.env.development` (local development)
- `.env.staging` (staging environment)
- `.env.production` (production environment)
- **GitHub Secrets** (sensitive credentials)
- **Environment Variables** (platform-specific)

### Common Patterns

#### Supabase + Vercel Frontend + Render Backend (e.g., Nexus)

```yaml
# GitHub Actions
- name: Deploy Frontend
  with:
    project-id: anclora-nexus-frontend
    target: production
    
- name: Deploy Backend
  with:
    service-id: anclora-nexus-backend
    api-key: ${{ secrets.RENDER_API_KEY }}

- name: Migrate Database
  with:
    supabase-project-id: ${{ secrets.SUPABASE_PROJECT_ID }}
    db-password: ${{ secrets.SUPABASE_DB_PASSWORD }}
```

#### Neon DB + Vercel Blob Storage + Vercel Hosting

```yaml
- name: Deploy Application
  with:
    project-id: anclora-app
    database-url: ${{ secrets.DATABASE_URL }}
    blob-token: ${{ secrets.BLOB_STORE_TOKEN }}
```

### Environment Promotion

Secrets and env vars are **automatically promoted**:
- `development` → uses dev DB/services
- `staging` → uses staging DB/services (separate from prod)
- `production` → uses prod DB/services (encrypted, restricted access)

---

## 6. CI/CD Pipeline Standards

### Required Checks for `development`

Every PR to `development` must pass:

```yaml
checks:
  - lint: 0 errors
  - type-check: TypeScript strict mode
  - test: >80% coverage, all tests pass
  - build: successful production build
  - security: no vulnerabilities (npm audit, SAST)
  - format: prettier check
```

### Required Checks for `staging`

Additional checks before `staging`:

```yaml
checks:
  - all development checks
  - e2e-tests: all scenarios pass
  - load-test: response time < 500ms @ 1000 RPS
  - soak-test: 24h stability test
  - security-audit: manual review pass
  - accessibility: WCAG 2.1 AA compliance
```

### Required Checks for `production`

Final checks before `production`:

```yaml
checks:
  - all staging checks
  - smoke-tests: critical paths in prod
  - canary-deployment: 5% traffic test
  - monitoring-alert: all alerting configured
  - incident-response: runbook prepared
```

---

## 7. Stale Branch Management

### Automatic Branch Cleanup

**Policy**: Delete branches that are:
- ✅ Merged to `development` AND
- ✅ Older than 7 days AND
- ✅ Not currently checked out

**Implementation**:
```bash
# Dry-run: preview stale branches
cast clean

# Apply deletion
cast clean --apply

# Weekly automated report
scripts/cast-branch-groomer-schedule.sh
```

**Protected branches (never auto-delete)**:
- `main`, `development`, `staging`, `production`
- Any branch with open PRs
- Any branch currently checked out in a worktree

### Manual Cleanup

For feature branches older than 7 days with no activity:

```bash
# List candidates
git branch --merged development | grep -v "^\*" | grep -v "main\|development\|staging\|production"

# Delete
git branch -d <branch-name>
git push origin --delete <branch-name>
```

---

## 8. Release Management

### Version Numbering (Semantic)

```
v<YYYY>.<MM>.<DD>-<environment>-<patch>
v2026.06.10-nexus-production
v2026.06.10-nexus-production.1  (hotfix)
```

### Release Process

1. **Create Release PR** (development → staging)
   ```bash
   git checkout development
   git pull origin
   npm version minor  # or patch, major
   git push origin development
   ```

2. **Test in Staging** (manual QA)

3. **Promote to Production**
   ```bash
   ./scripts/git-flow/promote-staging-to-production.sh
   ```

4. **Tag Release**
   ```bash
   git tag v2026.06.10-nexus-production
   git push origin v2026.06.10-nexus-production
   ```

5. **Deploy** (auto-trigger)

6. **Validate** (smoke tests, monitoring)

### Hotfix Process (Production Bugs)

```bash
# Create hotfix branch from production
git checkout production
git pull origin
git checkout -b hotfix/critical-bug

# Fix the issue
git commit -m "fix: resolve critical production issue"

# Merge back to production
git push origin hotfix/critical-bug
# Create PR, require 3 approvals
# Merge to production → auto-deploy
# Merge back to development to keep in sync
git checkout development
git pull origin
git merge production
git push origin development
```

---

## 9. Compliance & Monitoring

### Enforcement

- **GitHub Branch Protection**: Enforced at organization level
- **Status Checks**: Fail PR if any check fails
- **Code Owners**: CODEOWNERS file (auto-request review)
- **Commit Signing**: Require signed commits for `production`

### Monitoring

Track per-repo:
- Lead time for changes (commit to production)
- Deployment frequency
- Change failure rate
- Mean time to recovery (MTTR)

See: [WORKFLOW_MONITORING.md](WORKFLOW_MONITORING.md) (to be created)

---

## 10. Multi-Repo Orchestration

### Dependency Management

When multiple repos depend on each other:

1. **Coordinated Release**: Tag simultaneously in dependent repos
2. **Version Pinning**: Use `package.json` version constraints
3. **API Contracts**: Define and validate schema compatibility
4. **Notification**: Publish release notes to dependent teams

Example:
```
anclora-nexus (depends on anclora-syncXML API)
└── Requires anclora-syncXML >= v2026.06.10
    └── Triggers coordinated deployment
```

---

## 11. Checklist: Is Your Repo Ready?

### Initial Setup (Before First Feature)

- [ ] Branch protection configured (main, production, staging, development)
- [ ] GitHub Actions workflows created (lint, test, build, deploy)
- [ ] Environment variables set (dev, staging, prod)
- [ ] CODEOWNERS file created
- [ ] Conventional commits enforced
- [ ] README updated with contribution guide

### Ongoing Maintenance

- [ ] Review stale branches weekly (`cast clean` report)
- [ ] Monitor CI/CD failure rates
- [ ] Track deployment metrics
- [ ] Validate GitHub protection rules monthly
- [ ] Update CHANGELOG.md per release

---

## 12. Examples by Repository

### Example: Nexus (Ideal Model)

```
Branches: main, production, staging, development
Infra: Supabase + Vercel Frontend + Render Backend
Flow: development (PR) → staging (promote) → production (deploy)
Monitoring: Vercel Analytics + Render Logs + Supabase Insights
```

### Example: SyncXML (To Be Standardized)

```
Current: main, production, staging, development + 4 feature branches
Target: Same as Nexus structure, clean feature branches
Action: Merge/close stale branches, standardize CI/CD
```

### Example: Content Generator (Needs Structure)

```
Current: main + 8 feature branches, no staging/production
Target: Add staging and production branches, define deployment
Action: Create branch structure, implement CI/CD
```

---

## 13. Questions & Troubleshooting

**Q: Can I merge to `development` without PR?**  
A: No. All merges require PR + review + status checks.

**Q: What if I accidentally push to `production`?**  
A: Branch protection prevents this. You must go through `staging`.

**Q: How do I revert a bad production deployment?**  
A: Use hotfix process: create hotfix branch, merge to production, deploy.

**Q: How long do I keep feature branches?**  
A: Delete after merge. If needed later, recreate from tag.

**Q: Can I skip CI/CD checks for urgent fixes?**  
A: No. Use hotfix process instead (expedited, not skipped).

---

## Related Documents

- [GITHUB_ACTIONS_TEMPLATES.md](GITHUB_ACTIONS_TEMPLATES.md) — Reusable CI/CD templates
- [WORKFLOW_ORCHESTRATION_GUIDE.md](WORKFLOW_ORCHESTRATION_GUIDE.md) — Automation with agents
- [CAST conventions](../../.claude/rules/) — CAST hook and automation rules
- Git Flow Scripts: `scripts/git-flow/promote-*.sh`

---

**Maintained by**: Anclora Engineering Team  
**Last reviewed**: 2026-06-10  
**Next review**: 2026-07-10 (monthly)
