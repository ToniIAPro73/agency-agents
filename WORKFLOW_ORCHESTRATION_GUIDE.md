# Workflow Orchestration Guide — Using Agency Agents for GitHub Automation

**Purpose**: How to use AI agents to manage, optimize, and troubleshoot Anclora's GitHub workflow automation  
**Updated**: 2026-06-10  
**For**: Engineering leads, DevOps, automation specialists

---

## Overview

Managing GitHub workflows across 13+ Anclora products is complex. This guide shows how to use **Agency Agents** to:

- 🤖 Automate branch management and cleanup
- 🔄 Orchestrate multi-step deployments
- 🔍 Debug workflow failures
- 📊 Analyze and optimize CI/CD metrics
- 🛡️ Ensure compliance with standards

---

## The 5 Agents for Workflow Orchestration

### 1. DevOps Automator
**When**: Setting up new CI/CD pipelines, automating infrastructure

```
Use the DevOps Automator agent to:
- Design GitHub Actions workflows for [repo name]
- Recommend infrastructure as code (Terraform, CloudFormation)
- Optimize container deployments
- Automate environment promotion (dev → staging → production)
```

**Example**:
```
"Use the DevOps Automator agent to design a complete CI/CD pipeline for Nexus 
that includes linting, testing, building, and deploying to Vercel + Render."
```

### 2. Agents Orchestrator
**When**: Coordinating complex, multi-step workflows across repos

```
Use the Agents Orchestrator agent to:
- Coordinate deployments across multiple services
- Manage release coordination for dependent repos
- Design complex workflow pipelines
- Troubleshoot multi-service deployment failures
```

**Example**:
```
"Use the Agents Orchestrator agent to design a workflow for promoting 
development → staging → production across Nexus and SyncXML simultaneously, 
ensuring database migrations complete before application deployment."
```

### 3. Infrastructure Maintainer
**When**: Operational issues, monitoring, reliability

```
Use the Infrastructure Maintainer agent to:
- Design monitoring and alerting for CI/CD pipelines
- Implement SLOs and error budgets
- Automate toil reduction in deployment processes
- Optimize infrastructure costs
```

**Example**:
```
"Use the Infrastructure Maintainer agent to implement monitoring and alerting 
for our production deployments, including deployment failure detection and 
automatic rollback."
```

### 4. Automation Governance Architect
**When**: Planning automation at scale, ensuring maintainability

```
Use the Automation Governance Architect agent to:
- Audit automation for maintainability and risk
- Design governance rules for CI/CD pipelines
- Recommend automation best practices
- Identify automation failures and root causes
```

**Example**:
```
"Use the Automation Governance Architect agent to audit our current GitHub 
workflows and recommend improvements for reliability, maintainability, and cost."
```

### 5. Backend Architect (for API/service design)
**When**: Designing APIs and services for automated deployments

```
Use the Backend Architect agent to:
- Design APIs for deployment automation
- Plan database migration strategies
- Design service dependencies and deployment order
- Optimize for zero-downtime deployments
```

**Example**:
```
"Use the Backend Architect agent to design a strategy for deploying breaking 
database schema changes to production with zero downtime."
```

---

## Common Workflows (Prompts Ready to Use)

### Workflow 1: Setup Complete CI/CD for New Repository

**Context**: You're creating a new Anclora product (e.g., `anclora-awesome-feature`)

**Agent**: DevOps Automator + Backend Architect

```
Use the DevOps Automator agent to:

1. Design a complete GitHub Actions CI/CD pipeline for a new Anclora product
2. Assume: Vercel frontend, Render backend, Supabase database
3. Include: Lint, type-check, test, build, preview deploy, staging deploy, 
   production deploy
4. Ensure: Branch protection rules, required checks, approval gates
5. Add: Database migration automation
6. Include: Monitoring and alerting configuration

Provide:
- GitHub Actions workflow files (.github/workflows/*.yml)
- GitHub Secrets checklist
- Branch protection configuration
- Environment variables template
- Deployment procedure documentation
```

### Workflow 2: Standardize Existing Repository

**Context**: SyncXML has 4 stale feature branches; needs to match Nexus standard

**Agent**: Automation Governance Architect + DevOps Automator

```
Use the Automation Governance Architect agent to:

1. Audit anclora-syncXML against Anclora GitHub Workflow Standards
2. Identify: Branch structure gaps, missing CI/CD checks, stale branches
3. Recommend: Prioritized improvements

Then use the DevOps Automator agent to:

1. Create GitHub Actions workflows matching anclora-nexus
2. Design branch cleanup strategy (which branches to keep/delete)
3. Provide: Migration steps to move SyncXML from current state to standard state

Deliverable: Migration plan (1 week to standardize)
```

### Workflow 3: Implement Automated Deployment Promotion

**Context**: Manually promote development → staging → production; want to automate

**Agent**: Agents Orchestrator + DevOps Automator

```
Use the Agents Orchestrator agent to:

1. Design automated promotion workflow for: development → staging → production
2. Handle: Database migrations, environment variable switching, health checks
3. Include: Rollback strategy if deployment fails
4. Ensure: Zero downtime for critical services

Then use the DevOps Automator agent to:

1. Implement promotion as GitHub Actions workflow
2. Use: promote-staging-to-production.sh existing script as reference
3. Add: Integration with Supabase migrations
4. Add: Monitoring/alerting for deployment success/failure

Deliverable: Automated promotion workflow ready to merge
```

### Workflow 4: Setup Multi-Service Coordinated Deployments

**Context**: Nexus (frontend + backend) and SyncXML need coordinated deployments

**Agent**: Agents Orchestrator + Backend Architect

```
Use the Agents Orchestrator agent to:

1. Design coordinated deployment for Nexus + SyncXML
2. Ensure: Database migrations (SyncXML) complete before Nexus API calls
3. Handle: Rollback if either service fails
4. Plan: Deployment order and dependencies

Use the Backend Architect agent to:

1. Design API contracts between services
2. Ensure: Backward-compatible API changes during multi-service deployments
3. Plan: Graceful degradation if dependent service is down

Deliverable: Coordinated deployment workflow
```

### Workflow 5: Optimize CI/CD Performance & Cost

**Context**: GitHub Actions minutes are expensive; some workflows are slow

**Agent**: Infrastructure Maintainer + DevOps Automator

```
Use the Infrastructure Maintainer agent to:

1. Analyze: Current GitHub Actions workflow costs and performance
2. Identify: Long-running steps, inefficient caching, redundant jobs
3. Recommend: Cost-saving measures (caching, parallelization, runner optimization)
4. Estimate: Monthly savings with optimizations

Use the DevOps Automator agent to:

1. Implement: Recommended optimizations
2. Add: npm cache, Docker layer caching, job parallelization
3. Reorganize: Workflow steps to fail fast
4. Test: Optimized workflow performance

Deliverable: Optimized workflows with 20-40% cost reduction
```

### Workflow 6: Debug Workflow Failure (Specific Repo)

**Context**: Production deployment failed; need root cause

**Agent**: DevOps Automator + Automation Governance Architect

```
Use the Automation Governance Architect agent to:

1. Analyze: GitHub Actions run logs for anclora-nexus production deployment
2. Identify: Why deployment failed (Vercel error? Render error? Supabase issue?)
3. Root cause: Specific step, error message, context

Use the DevOps Automator agent to:

1. Propose: Fix for the specific failure
2. Recommend: Changes to prevent recurrence
3. Suggest: Additional monitoring/alerting

Provide the workflow logs as context.
```

### Workflow 7: Implement Monitoring & Alerting

**Context**: Production deployments fail silently; need visibility

**Agent**: Infrastructure Maintainer + DevOps Automator

```
Use the Infrastructure Maintainer agent to:

1. Design: SLOs and error budgets for CI/CD
2. Define: Key metrics (deployment frequency, lead time, failure rate, MTTR)
3. Plan: Alerting strategy (what triggers alerts?)

Use the DevOps Automator agent to:

1. Implement: GitHub Actions job for post-deployment monitoring
2. Add: Health checks, error rate thresholds, automated rollback triggers
3. Integrate: Slack notifications for deployment events
4. Setup: Grafana/Datadog dashboard for CI/CD metrics

Deliverable: Complete monitoring solution
```

---

## Step-by-Step: Standardize All Anclora Repos to Workflow Standards

### Phase 1: Assessment (Week 1)

**Agent**: Automation Governance Architect

```
Use the Automation Governance Architect agent to audit each Anclora repo:

Repos to audit:
- anclora-nexus (reference, already good)
- anclora-syncXML
- anclora-content-generator-ai
- anclora-data-lab
- anclora-advisor-ai
- anclora-linguo-cam
- anclora-talent
- anclora-impulso
- anclora-energyscan
- anclora-private-estates
- anclora-private-estates-landing
- anclora-synergi
- anclora-impulso

For each repo, provide:
1. Current branch structure
2. Current CI/CD pipeline (if exists)
3. Infrastructure pattern (Vercel/Render/Supabase/Neon/etc.)
4. Gaps vs. Anclora standards
5. Priority (P1/P2/P3)

Output: Audit report with migration plan
```

### Phase 2: Template Selection (Week 1)

**Determine** which template to use:
- Pattern A: Vercel + Render + Supabase (most repos)
- Pattern B: Vercel serverless + Neon (content generator)
- Pattern C: Self-hosted (data lab)

### Phase 3: Implementation (Week 2-4)

**Per repo**, use:

```
Use the DevOps Automator agent to implement GitHub Actions for [repo]:

1. Create .github/workflows/ directory
2. Add: ci-development.yml (based on pattern X)
3. Add: deploy-staging.yml
4. Add: deploy-production.yml
5. Add: branch-cleanup.yml (weekly stale branch cleanup)
6. Configure: GitHub Secrets and protection rules
7. Test: Trigger workflow on development branch
8. Validate: All checks pass

Then use the Automation Governance Architect agent to:

1. Review: Implementation against standards
2. Identify: Any gaps or issues
3. Recommend: Final improvements before merge

Deliverable: Pull request with complete CI/CD setup
```

### Phase 4: Branch Cleanup (Week 3-4)

**Agent**: DevOps Automator (or use scripts directly)

```
For each repo with stale branches:

Use the DevOps Automator agent to:

1. Identify: Which branches are stale (>7 days, merged, no PRs)
2. Plan: Deletion order (don't delete if other work depends on it)
3. Execute: Delete stale branches
4. Document: Deleted branches in changelog

Use: cast clean --apply
```

### Phase 5: Testing & Validation (Week 4)

**Run** all workflows:
- Create test PR to development
- Promote to staging (manual trigger)
- Promote to production (manual trigger)
- Validate deployments succeed

---

## Agent-Driven Automation: GitHub Actions + Codex

### Scenario: Automatic Hotfix Deployment

**Goal**: When a hotfix is merged to `production`, automatically deploy it

**Setup**:
```
1. Create hotfix branch from production
2. Merge to production (requires 3 approvals)
3. GitHub Actions trigger automatically
4. Deploy to production
5. Slack notification sent
```

**Codex Command** (for developers):
```bash
# Ask the DevOps Automator agent to create hotfix workflow
codex ask --agent devops-automator \
  "Create a GitHub Actions hotfix deployment workflow that deploys immediately 
   when code is merged to production branch, with automatic health checks and 
   rollback if deployment fails."
```

---

## Monitoring & Observability

### Metrics to Track (Use Infrastructure Maintainer)

**CI/CD Metrics**:
- Deployment frequency (target: daily)
- Lead time for changes (target: <1 day)
- Change failure rate (target: <15%)
- Mean time to recovery (target: <1 hour)

**Workflow Health**:
- Job success rate (target: >95%)
- Average job duration (identify slow jobs)
- Action marketplace updates (security)

```
Use the Infrastructure Maintainer agent to:

1. Design: Dashboard for CI/CD metrics
2. Implement: Automated metrics collection
3. Set: Alerting thresholds
4. Create: Weekly metrics report
```

---

## Governance & Compliance

### Rules (Enforce with GitHub)

Every repo MUST have:

- ✅ Branch protection on main, production, staging, development
- ✅ GitHub Actions workflows for lint, test, build
- ✅ Automated deployment to staging and production
- ✅ Approval gates (2 for staging, 3 for production)
- ✅ Signed commits enforced for production
- ✅ Status checks required

### Audit (Use Automation Governance Architect)

```
"Use the Automation Governance Architect agent to audit all Anclora repos 
for GitHub Workflow Standards compliance. Report any gaps and remediation steps."
```

---

## Quick Reference: Agents by Use Case

| Use Case | Agent | Time |
| --- | --- | --- |
| Setup new CI/CD | DevOps Automator | 2-3 hours |
| Fix workflow failure | DevOps Automator + Automation Governance | 1-2 hours |
| Implement promotion automation | Agents Orchestrator | 4-6 hours |
| Multi-service coordination | Agents Orchestrator + Backend Architect | 6-8 hours |
| Optimize costs | Infrastructure Maintainer | 3-4 hours |
| Audit compliance | Automation Governance Architect | 2-3 hours |
| Monitor production | Infrastructure Maintainer | 4-5 hours |

---

## Related Documents

- [GITHUB_WORKFLOW_STANDARDS.md](GITHUB_WORKFLOW_STANDARDS.md) — Standards and rules
- [GITHUB_ACTIONS_TEMPLATES.md](GITHUB_ACTIONS_TEMPLATES.md) — Ready-to-use templates
- [AGENTS.md](AGENTS.md) — Full agent catalog
- [INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md) — How to use agents

---

## Example: Complete Migration (Codex-driven)

```bash
# 1. Ask DevOps Automator to audit repo
codex ask --agent devops-automator \
  "Audit anclora-syncXML and recommend GitHub Actions workflows 
   to match anclora-nexus standard."

# 2. Ask to create workflows
codex ask --agent devops-automator \
  "Create GitHub Actions workflows for anclora-syncXML: 
   ci-development.yml, deploy-staging.yml, deploy-production.yml"

# 3. Ask to clean stale branches
codex ask --agent devops-automator \
  "Identify stale branches in anclora-syncXML (>7 days, merged) 
   and plan deletion order."

# 4. Ask for validation
codex ask --agent automation-governance-architect \
  "Review the GitHub workflows for anclora-syncXML against 
   Anclora Workflow Standards."
```

---

**Maintained by**: Anclora Engineering Team  
**Last updated**: 2026-06-10  
**Next review**: 2026-07-10
