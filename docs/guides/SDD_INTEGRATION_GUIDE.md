# SDD Integration Guide — Spec-Driven Development in Anclora Ecosystem

**Purpose**: How Spec-Driven Development (SDD) integrates with GitHub workflows, Agency Agents, and
Anclora development process
**Updated**: 2026-06-10
**Reference**: [SDD NotebookLM](https://notebooklm.google.com/notebook/94462119-4635-4039-827d-e46042428871)

---

## What is SDD

**Spec-Driven Development** is Anclora's mandatory architecture for how we:

- Define requirements (Spec)
- Plan implementation (Plan)
- Execute with clarity (Dev)
- Validate delivery (Test)

SDD ensures every feature, every service, every product has:

- ✅ Clear specification (written before code)
- ✅ Detailed plan (architecture, database, API contracts)
- ✅ Task breakdown (granular, testable units)
- ✅ Quality gates (validation before merge)

---

## Where is SDD Documented

 | Location | Purpose | When to Use |
 | --- | --- | --- |
 | **anclora-template/docs/sdd/** | Template base for new projects | Starting new product |
 | **Bóveda-Anclora/docs/sdd/** | Canonical reference, all specs | Deep questions about SDD |
 | **anclora-command-center** | Dashboard & visualization | Visual reference, progress tracking |
 | **[NotebookLM](https://notebooklm.google.com/notebook/94462119-4635-4039-827d-e46042428871)** | Interactive Q&A reference | When you have questions |

**Bookmark the NotebookLM** — it's the fastest way to get SDD answers.

---

## SDD Workflow in Anclora

### Phase 1: Specification (Week 1)

**Who**: Product Manager + Architect + Tech Lead
**Deliverable**: `SPEC.md` document

```text

What goes in SPEC.md:
✅ Problem statement
✅ User personas and jobs-to-be-done
✅ Acceptance criteria (testable)
✅ Non-functional requirements (performance, security, scale)
✅ API contracts (if applicable)
✅ Database schema (if applicable)
✅ External dependencies
✅ Risks and mitigations

```text

**Using Agency Agents**:

```text

Use the Product Manager agent to validate the SPEC:
"Review this SPEC for completeness, clarity, and alignment with Anclora standards."

Use the Backend Architect agent for technical spec:
"Review the API and database schema in this SPEC."

Use the Security Architect agent:
"Threat-model this SPEC and identify security concerns."

```text

---

### Phase 2: Planning (Week 1-2)

**Who**: Tech Lead + Architect
**Deliverable**: `PLAN.md` document + Task breakdown

```text

What goes in PLAN.md:
✅ Architecture diagram (high-level system design)
✅ Implementation strategy (phased approach)
✅ Database migrations
✅ Infrastructure requirements
✅ Deployment strategy
✅ Rollback plan
✅ Success metrics
✅ Timeline and dependencies

```text

**Using Agency Agents**:

```text

Use the Software Architect agent:
"Design the architecture for this feature. Create a plan that covers:

 - System design and components
 - Database design with scaling assumptions
 - Deployment strategy (dev → staging → production)
 - Rollback and failure recovery"

Use the Agents Orchestrator agent for complex features:
"Orchestrate this feature across Nexus + SyncXML services.
 Design deployment order and ensure API compatibility."

```text

---

### Phase 3: Task Breakdown (Week 2)

**Who**: Tech Lead
**Deliverable**: `TASKS.md` + GitHub Issues

```text

What goes in TASKS.md:
✅ Feature broken into 1-2 week sprints
✅ Each task is independent and testable
✅ Clear definition of done (DoD)
✅ Dependencies identified
✅ Risk mitigation tasks
✅ Documentation tasks

```text

**Example task structure**:

```markdown

## Sprint 1: Foundation (Week 1)

### Task 1.1: Database Schema

- [ ] Create migrations
- [ ] Test locally with sample data
- [ ] Code review: @architect

### Task 1.2: API Foundation

- [ ] Create endpoints (stubs)
- [ ] Write API tests
- [ ] Code review: @backend-architect

### Task 1.3: Frontend Component

- [ ] Create component structure
- [ ] Write unit tests
- [ ] Code review: @frontend-developer

```text

**Using Agency Agents**:

```text

Use the Workflow Architect agent:
"Break down this feature into testable tasks (1-2 weeks each).
 Identify dependencies and risk mitigation tasks.
 Format as TASKS.md file ready to commit."

```text

---

### Phase 4: Implementation (Week 3-4+)

**Who**: Development team
**Branch**: `feature/sdd-feature-name`
**Commits**: One per task, conventional commit format

```text

Example commit:
feat(auth): implement two-factor authentication

Task 1.2 from SPEC.md: User account security

- Add TOTP generation and validation
- Create backup code generation
- Add email verification flow

Tests: 42 new tests, 100% coverage for auth module

Closes #456

```text

**Branch workflow**:

```text

development
  └── feature/sdd-user-auth (from SPEC + PLAN + TASKS)
      ├── Commit 1: feat(db): create auth schema
      ├── Commit 2: feat(api): implement auth endpoints
      ├── Commit 3: feat(frontend): create login form
      └── PR → development (requires SPEC/PLAN/TASKS approval)

```text

**GitHub Actions Validation**:

- ✅ Lint checks
- ✅ Type checks
- ✅ Test coverage >80%
- ✅ Build succeeds
- ✅ Security scan passes
- ✅ References SPEC/PLAN/TASKS in PR

**Using Agency Agents**:

```text

Use the Code Writer agent:
"Implement task 1.2 from PLAN.md:

 - Use SPEC.md for API contracts
 - Use PLAN.md for architecture
 - Write tests first (TDD approach)
 - Reference SPEC acceptance criteria"

Use the Code Reviewer agent (before merge):
"Review this PR against the SPEC and PLAN.
 Check: Do implementation and tests match spec requirements?"

```text

---

### Phase 5: Deployment (Week 5+)

**Who**: DevOps + Tech Lead
**Stages**: Development → Staging → Production

```text

development branch
  ↓ (all tests pass)
staging branch
  ↓ (manual QA + load tests)
production branch
  ↓ (live)

```text

**SDD Validation at Each Stage**:

- ✅ Staging: Verify all acceptance criteria from SPEC pass
- ✅ Production: Verify success metrics from PLAN are tracking

---

## SDD + GitHub Workflow Integration

### GitHub PR Template (Must Include)

Every PR to `development` MUST link to:

1. SPEC.md (what are we building?)
2. PLAN.md (how are we building it?)
3. TASKS.md (which task does this PR complete?)

```markdown

## SDD Reference

**SPEC**: [Link to SPEC.md or GitHub discussion]
**PLAN**: [Link to PLAN.md]
**TASKS**: [Link to TASKS.md / GitHub issue]

## Task Completed

This PR completes: **Task 1.2 — API Foundation**

## Acceptance Criteria (from SPEC)

- [ ] Endpoint accepts valid requests
- [ ] Returns correct status codes
- [ ] Validates input properly
- [ ] Error handling works

## Testing

- [ ] Unit tests: 15 new tests, 100% coverage
- [ ] Integration tests: API tests pass
- [ ] Manual testing: [describe steps]

```text

---

## SDD + Agency Agents Integration

### Agents That Enforce SDD

#### 1. Product Manager (Spec Validation)

```text

"Use the Product Manager agent to validate this SPEC.md:

 - Are acceptance criteria testable?
 - Is scope clear and bounded?
 - Are dependencies documented?
 - Are success metrics defined?"

```text

#### 2. Software Architect (Plan Validation)

```text

"Use the Software Architect agent to validate this PLAN.md:

 - Is architecture clear and scalable?
 - Are database design and API contracts detailed?
 - Is deployment strategy sound?
 - Are risks identified and mitigated?"

```text

#### 3. Workflow Architect (Task Breakdown)

```text

"Use the Workflow Architect agent to create TASKS.md:

 - Break this feature into 1-2 week tasks
 - Each task should be testable and independent
 - Identify dependencies and risks
 - Create GitHub issues for each task"

```text

#### 4. Code Reviewer (Implementation Validation)

```text

"Use the Code Reviewer agent to validate implementation:

 - Does code match SPEC requirements?
 - Are all acceptance criteria tested?
 - Are tests aligned with PLAN architecture?
 - Does this complete the task in TASKS.md?"

```text

#### 5. Backend Architect (API & DB Validation)

```text

"Use the Backend Architect agent to validate:

 - Do API contracts match SPEC?
 - Is database schema in PLAN correctly implemented?
 - Are migrations safe and tested?
 - Is performance aligned with PLAN requirements?"

```text

---

## SDD Checklist Before Merging to Production

### Pre-Merge Checklist (MANDATORY)

- [ ] SPEC.md exists and is approved
- [ ] PLAN.md exists and is approved
- [ ] TASKS.md exists with all tasks completed
- [ ] All acceptance criteria from SPEC pass tests
- [ ] Code review against PLAN passed
- [ ] Security audit completed
- [ ] Performance testing matches PLAN targets
- [ ] Deployment plan is documented
- [ ] Rollback plan is documented
- [ ] All success metrics from PLAN are tracked

### Branch Protection Rule (GitHub)

Every `production` PR MUST satisfy:

```yaml

- Require SPEC reference in PR description
- Require PLAN reference in PR description
- Require Code Reviewer approval (verifies against SPEC)
- Require 3 minimum approvals
- Require all tests passing
- Require security check passing

```text

---

## Common SDD + Development Patterns

### Pattern 1: New Feature (Nexus Example)

```text

Project: Add real-time notifications

Week 1 (Spec + Plan):
├── SPEC.md: Notification requirements, API contracts
├── PLAN.md: WebSocket architecture, database design, deployment
└── TASKS.md: 5 tasks across 2 sprints

Week 2-3 (Sprint 1):
├── Task 1.1: Database schema (migrations)
├── Task 1.2: WebSocket server (endpoint)
└── Task 1.3: Frontend component (subscribe logic)

Week 4 (Sprint 2):
├── Task 2.1: Notification service integration
├── Task 2.2: E2E tests
└── Task 2.3: Documentation + deployment

Week 5 (Deployment):
├── Staging validation (all SPEC criteria pass)
├── Production rollout (canary → full)
└── Monitor success metrics from PLAN

```text

### Pattern 2: Bug Fix (Quick Fix)

```text

For bugs, create minimal SPEC/PLAN:

SPEC.md:

- Issue description
- Root cause (if known)
- Acceptance criteria (bug is fixed)

PLAN.md:

- Fix approach
- Testing strategy
- Risk assessment

TASKS.md:

- Single task if small
- Multiple tasks if complex

Then proceed with normal flow.

```text

### Pattern 3: Refactoring (Backend Code Quality)

```text

SPEC.md:

- Technical debt description
- Performance targets
- Quality metrics

PLAN.md:

- Refactoring approach (module by module)
- Migration strategy (blue-green deployment)
- Backward compatibility plan

TASKS.md:

- One task per module
- Test coverage maintained or improved
- No behavior changes

```text

---

## Linking SDD to NotebookLM for Help

When you have a question about SDD:

1. **First**: Check [NotebookLM SDD Cuaderno](https://notebooklm.google.com/notebook/94462119-4635-4039-827d-e46042428871)
   - Ask directly: "What should go in a SPEC.md?"
   - Get interactive answers with examples

2. **Second**: Refer to canonical docs in Bóveda-Anclora/docs/sdd/

3. **Third**: Ask agents:

```text

   Use the Product Manager agent:
   "Help me write a SPEC.md for [feature].
    Use SDD standards from Anclora."

```text

---

## SDD Metrics & Tracking

### Track These Metrics (Compliance)

 | Metric | Target | Tool |
 | --- | --- | --- |
 | **Spec completeness** | 100% specs before dev | GitHub issue checklist |
 | **Plan approval** | All plans reviewed | Pull request approvals |
 | **Task breakdown** | All features have TASKS.md | GitHub issues |
 | **Acceptance criteria pass rate** | >95% | GitHub Actions |
 | **Time from spec to production** | <4 weeks | GitHub milestone tracking |

### Dashboard Tracking

Use **anclora-command-center** dashboard to:

- Track SPEC → PLAN → TASKS → Implementation progress
- Identify bottlenecks
- Monitor compliance

---

## SDD in Different Repo Patterns

### Pattern A: Monolithic App (Nexus)

```text

nexus/
├── SPEC.md (overall product spec)
├── docs/
│   ├── feature-1/
│   │   ├── SPEC.md
│   │   ├── PLAN.md
│   │   └── TASKS.md
│   └── feature-2/
│       ├── SPEC.md
│       ├── PLAN.md
│       └── TASKS.md
└── [implementation]

```text

### Pattern B: Microservices (Nexus + SyncXML)

```text

nexus/ (frontend + backend):
├── docs/sdd/
│   ├── real-time-features/
│   │   ├── SPEC.md
│   │   ├── PLAN.md (includes SyncXML integration)
│   │   └── TASKS.md
│
syncxml/ (data service):
├── docs/sdd/
│   ├── document-ingestion/
│   │   ├── SPEC.md
│   │   ├── PLAN.md (API contracts with Nexus)
│   │   └── TASKS.md

```text

### Pattern C: Serverless (Content Generator)

```text

content-generator/ (full-stack Vercel):
├── docs/sdd/
│   ├── ai-content-generation/
│   │   ├── SPEC.md
│   │   ├── PLAN.md (serverless deployment)
│   │   └── TASKS.md

```text

---

## Quick Reference: SDD Command Using Agents

### "I'm starting a feature"

```bash
codex ask --agent product-manager \
  "Help me write SPEC.md for [feature description]"

```text

### "I have a spec, need to plan"

```bash
codex ask --agent software-architect \
  "Create PLAN.md from this SPEC. Include architecture, database design,
   and deployment strategy."

```text

### "I need to break down tasks"

```bash
codex ask --agent workflow-architect \
  "Create TASKS.md breaking this feature into 1-2 week tasks."

```text

### "Reviewing code against SDD"

```bash
codex ask --agent code-reviewer \
  "Does this PR implementation match the SPEC and PLAN?
   Are all acceptance criteria tested?"

```text

---

## Related Documents

- [GITHUB_WORKFLOW_STANDARDS.md](GITHUB_WORKFLOW_STANDARDS.md) — Git flow and branch strategy
- [WORKFLOW_ORCHESTRATION_GUIDE.md](WORKFLOW_ORCHESTRATION_GUIDE.md) — Automating with agents
- [AGENT_PERFORMANCE_BASELINES.md](AGENT_PERFORMANCE_BASELINES.md) — What agents should do
- **[SDD NotebookLM](https://notebooklm.google.com/notebook/94462119-4635-4039-827d-e46042428871)** — Interactive SDD Q&A

---

## Summary

**SDD is mandatory** for all Anclora development:

1. **Every feature** starts with SPEC.md (what?)
2. **Every spec** gets a PLAN.md (how?)
3. **Every plan** breaks into TASKS.md (tasks?)
4. **Every task** becomes a PR (implement)
5. **Every PR** validates against SPEC (does it match?)
6. **Every deployment** verifies success metrics (did it work?)

**With Agency Agents**: Every step is supported by specialized agents who understand SDD and
Anclora standards.

---

**Maintained by**: Anclora Engineering Team
**Last updated**: 2026-06-10
**Reference**: [SDD NotebookLM](https://notebooklm.google.com/notebook/94462119-4635-4039-827d-e46042428871)
**Status**: Mandatory for all development
