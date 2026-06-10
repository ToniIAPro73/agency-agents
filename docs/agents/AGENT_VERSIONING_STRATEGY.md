# Agent Versioning & Semantic Versioning Strategy

**Purpose**: Track agent behavior changes, breaking changes, and improvements with clarity
**Updated**: 2026-06-10
**Status**: MEDIUM PRIORITY (implement after HIGH PRIORITY features)

---

## Why Agent Versioning Matters

Agents are **living specifications**. They:

- ✅ Change with new capabilities
- ✅ Improve with feedback
- ⚠️ May introduce breaking changes (different output format)
- 📊 Need to be compared across time

**Without versioning**: Teams don't know when an agent changes unexpectedly

---

## Semantic Versioning for Agents

### Version Format

```text

agent-<name>@<MAJOR>.<MINOR>.<PATCH>

Examples:

- backend-architect@2.1.0
- code-reviewer@1.5.3
- product-manager@3.0.0

```text

### Rules

 | Level | When | Example |
 | --- | --- | --- |
 | **MAJOR** | Breaking change (output format, API contracts) | `1.0.0 → 2.0.0` = Agent now outputs JSON instead of markdown |
 | **MINOR** | New capability (backward compatible) | `1.0.0 → 1.1.0` = Agent adds accessibility review |
 | **PATCH** | Bug fix or improvement (no behavior change) | `1.0.0 → 1.0.1` = Agent catches one more edge case |

---

## Agent Metadata File

Every agent should include metadata:

```yaml

# backend-architect.md

---
name: "Backend Architect"
agent_id: "backend-architect"
version: "2.1.0"
introduced: "2026-01-15"
last_updated: "2026-06-10"

capabilities:

  - api-design
  - database-architecture
  - scaling-strategy
  - security-review

breaking_changes:

  - version: "2.0.0"

    date: "2026-05-01"
    change: "Now outputs API schema in OpenAPI format instead of markdown"
    migration: "See AGENT_CHANGELOG.md for migration guide"

compatible_agents:

  - frontend-developer: ">=1.0.0"
  - database-optimizer: ">=1.5.0"

performance_baseline:
  coverage: "95%"
  accuracy: "90%"
  latency: "<2s per response"
---

```text

---

## Versioning in AGENT_CHANGELOG.md

Update format to include versions:

```markdown

## [2026-06-10] — v2.1.0

### Backend Architect — MINOR (New Capability)

**Version**: 1.5.0 → 2.1.0

**Summary**: Added security-aware API design + cost estimation

**Changes**:

- NEW: Considers OWASP Top 10 in API design
- NEW: Estimates infrastructure costs for proposed architecture
- IMPROVED: Better guidance on database sharding
- FIXED: Edge case handling for circular dependencies

**Migration**: No breaking changes. Existing prompts work unchanged.

**Examples**:

```text

Use the Backend Architect (v2.1.0) to design an API with:

- Security constraints (OWASP compliance)
- Cost estimation for Vercel + Render + Supabase

```text

---

## Version Pinning in Teams

### In INTEGRATION_GUIDE.md

Specify agent versions for guaranteed behavior:

```markdown

## Recommended Agent Versions (as of 2026-06-10)

- backend-architect@2.1.0 — Latest, adds cost estimation
- frontend-developer@1.8.0 — Stable, React 19 support
- code-reviewer@3.2.0 — Latest, includes accessibility
- product-manager@2.0.0 — Latest, simplified spec writing

```text

### In GitHub Actions

Pin agents in workflows:

```yaml

- name: Code Review

  run: |
    codex ask --agent "code-reviewer@3.2.0" \
      "Review this PR for security issues"

```text

### In TASKS.md

Specify when creating tasks:

```markdown

## Task 1.2: Backend API Implementation

**Using agents**:

- Backend Architect (v2.1.0): "Design the API"
- API Tester (v2.0.0): "Create API tests"

**Why these versions?**:

- v2.1.0 includes cost estimation (new requirement)
- v2.0.0 has improved error case coverage

```text

---

## Breaking Change Procedures

### Announcing a Breaking Change (3-month notice)

**Month 1: Announce**

```markdown

## Code Reviewer v3.0.0 (Coming July 10, 2026)

**Breaking Change**: Output format changes from markdown to JSON

### What's changing

```json
// OLD (v2.x)
{
  "issues": "Found 3 security issues...",
  "recommendations": "Use parameterized queries..."
}

// NEW (v3.0)
{
  "findings": [
    {
      "type": "security",
      "severity": "high",
      "message": "SQL injection risk detected",
      "recommendation": "Use parameterized queries"
    }
  ]
}

```text

### Migration path

1. July 10: v3.0.0 released
2. Your code must be updated to parse JSON instead of markdown
3. August 10: v2.x receives security updates only
4. September 10: v2.x is deprecated (no new features)

```text

**Month 2: Feature branch**

- v3.0.0-beta available for testing
- Users can opt-in: `--agent "code-reviewer@3.0.0-beta"`

**Month 3: Release**

- v3.0.0 becomes default
- v2.x still available: `--agent "code-reviewer@2.x"`

### Migration Checklist (for users)

```markdown

## Migrating to Code Reviewer v3.0.0

- [ ] Read the breaking change announcement
- [ ] Test v3.0.0-beta in non-production
- [ ] Update your code to parse JSON output
- [ ] Update TASKS.md to specify v3.0.0
- [ ] Update GitHub Actions to use v3.0.0
- [ ] Test in staging environment
- [ ] Deploy to production
- [ ] Delete old v2.x references

```text

---

## Backward Compatibility Policy

### Promise

- **MAJOR version**: No guarantees (breaking changes expected)
- **MINOR version**: Backward compatible (new features, no changes)
- **PATCH version**: Bug fixes only (no behavior change)

### Example

```text

If you use: code-reviewer@3.0.0

- ✅ 3.0.1 is safe (just fixes)
- ✅ 3.1.0 is safe (new features, old features unchanged)
- ⚠️ 4.0.0 may break (breaking changes expected)

```text

---

## Version Deprecation Timeline

### When an Agent Version Ages

**After 6 months of new major version**:

- Mark as deprecated in AGENT_CHANGELOG.md
- Add warning badge: ⚠️ Deprecated

**After 12 months**:

- Move to `/archive/` directory
- Still accessible: `--agent "code-reviewer@2.5.0"`
- No longer gets updates

**After 18 months**:

- Remove from default agent list
- Still accessible by explicit version
- Not recommended for new projects

---

## Cost of Versioning

### What We Track

```yaml
agent:
  name: "Backend Architect"
  version: "2.1.0"
  tokens_per_response:
    min: 800
    avg: 1200
    max: 2000
  cost_per_response:
    claude_opus: "$0.012"  # min-max range
    claude_sonnet: "$0.003"

```text

### Version Comparison

```markdown

## Agent Cost History

 | Version | Model | Avg Tokens | Cost/Response |
 | --- | --- | --- | --- |
 | 1.0.0 | Sonnet | 1500 | $0.0045 |
 | 1.5.0 | Sonnet | 1200 | $0.0036 |
 | 2.0.0 | Sonnet | 1800 | $0.0054 |
 | 2.1.0 | Sonnet | 1600 | $0.0048 |

**Takeaway**: v2.1.0 is cheapest with most features

```text

---

## Agent Compatibility Matrix

### Which agents work well together

Create a matrix:

```yaml
compatibility:
  backend-architect:

    - database-optimizer: "2.0+ recommended"
    - frontend-developer: "1.0+ compatible"
    - security-architect: "2.0+ required for threat modeling"

  code-reviewer:

    - all-agents: "Works with any version"
    - backend-architect: "Better analysis with v2.0+"

```text

### In INTEGRATION_GUIDE.md

```markdown

## Coordinated Versioning

**Recommended versions for full-stack development**:

Phase 2 - Architecture:

- backend-architect@2.1.0 (cost estimation)
- database-optimizer@1.5.0 (compatible with v2.1.0)
- frontend-developer@1.8.0 (modern patterns)

These versions are tested together.

```text

---

## Release Checklist

When releasing a new agent version:

```markdown

## Release Checklist: Backend Architect v2.2.0

### Pre-Release

- [ ] Update version in agent metadata
- [ ] Update AGENT_CHANGELOG.md
- [ ] Verify AGENT_PERFORMANCE_BASELINES still met
- [ ] Document breaking changes (if any)
- [ ] Create migration guide (if breaking)

### Testing

- [ ] Agent meets all baselines
- [ ] Tested with related agents (database-optimizer, frontend-developer)
- [ ] Token usage acceptable (<2000 avg)
- [ ] Cost within budget

### Communication

- [ ] Add entry to AGENT_CHANGELOG.md
- [ ] Notify teams via email/Slack
- [ ] Update documentation
- [ ] Post release notes on repo

### Monitoring

- [ ] Track usage rate (new version adoption)
- [ ] Monitor error rates
- [ ] Collect user feedback
- [ ] Plan next release (2-3 months out)

```text

---

## Versioning in Code Examples

### README.md

```markdown

## Quick Start (Using Latest Agents)

For reproducible results, pin agent versions:

```bash

# Latest versions (recommended for new projects)

codex ask --agent "backend-architect" "Design an API"

# Specific version (for critical projects)

codex ask --agent "backend-architect@2.1.0" "Design an API"

# Legacy version (not recommended, but supported)

codex ask --agent "backend-architect@1.5.0" "Design an API"

```text

```text

### In TASKS.md

```markdown

## Task 1.2: Backend API Design

**Agent**: Backend Architect (v2.1.0)

Why v2.1.0?

- Includes cost estimation (we need this for the proposal)
- Stable and well-tested
- Compatible with database-optimizer@1.5.0

**Prompt**:

```text

Use the Backend Architect (v2.1.0) to design an API for real-time notifications.
Include cost estimation for Vercel + Render + Supabase deployment.

```text

```text

---

## Future: Automatic Version Selection

### Smart Version Picker (Future Feature)

```bash

# Auto-select best version for this task

codex ask --agent "backend-architect:best" "Design an API for $$$"

# → Selects v2.1.0 (best cost/capability ratio)

# Auto-select fastest version

codex ask --agent "code-reviewer:fastest" "Review this PR"

# → Selects v3.1.0 (fastest output generation)

# Auto-select most comprehensive

codex ask --agent "code-reviewer:comprehensive" "Review this PR"

# → Selects v3.0.0 (most thorough analysis)

```text

---

## Summary Table

 | Aspect | Details |
 | --- | --- |
 | **Version Format** | `agent-<name>@<MAJOR>.<MINOR>.<PATCH>` |
 | **Breaking Changes** | MAJOR version bump + 3-month notice |
 | **Backward Compat** | MINOR & PATCH preserve previous behavior |
 | **Deprecation** | 6 months for MINOR, 18 months total |
 | **Tracking** | AGENT_CHANGELOG.md + agent metadata files |
 | **Pinning** | Specify in TASKS.md + GitHub Actions |
 | **Release Cycle** | Every 4-6 weeks (MINOR/PATCH), 3-6 months (MAJOR) |

---

## Questions

**"Which version should I use?"**
→ Use latest MINOR/PATCH (backward compatible). Pin MAJOR if you need stability.

**"Will my code break?"**
→ Only MAJOR versions break. MINOR and PATCH are always safe.

**"How do I migrate?"**
→ See AGENT_CHANGELOG.md for breaking change + migration guide.

**"How do I report a version issue?"**
→ File issue with: agent name, version, your prompt, expected vs actual output.

---

**Status**: Ready to implement
**Timeline**: Implement alongside agent improvements
**Impact**: Clear expectations, easier debugging, confident upgrades
