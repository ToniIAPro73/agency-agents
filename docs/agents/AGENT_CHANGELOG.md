# Agent Changelog — Version History & Changes

**Tracking**: Agent personality changes, improvements, deprecations, and breaking changes
**Last Updated**: 2026-06-10
**For**: Teams that depend on stable agent behavior

---

## Overview

This changelog documents changes to agent behavior, personality, and capabilities. It helps teams:

- 🔔 Track improvements and new features in agents
- ⚠️ Be notified of breaking changes
- 📦 Plan migrations when agent behavior changes
- 📊 Understand the evolution of agent capabilities

---

## Changelog Format

### Entry Structure

```markdown

## [Date]

### [Agent Name] — [Status: NEW | ENHANCED | DEPRECATED | BREAKING CHANGE | FIXED]

**Summary**: One-line description of the change

**Details**:

- What changed
- Why it changed
- Impact on existing workflows

**Migration** (if breaking): How to adapt existing code/prompts

**Related agents**: Other agents affected by this change (if any)

```text

### Status Levels

- **NEW** — New agent added
- **ENHANCED** — Improved capability, no breaking changes
- **FIXED** — Bug fix or correction
- **DEPRECATED** — Agent still works but being phased out; prefer alternative
- **BREAKING CHANGE** — Incompatible change; existing prompts may need adjustment
- **SUNSETTING** — Agent will be removed in future version

---

## [2026-06-10] — Anclora Integration v1.0

### Agency Agents Library — NEW

**Summary**: Complete 65-agent library integrated into Anclora with documentation and validation

**Details**:

- 65 specialized agents across 16 categories
- Full Anclora-specific documentation suite
- GitHub Actions validation workflow
- Agent Performance Baselines defined
- Workspace integration complete

**Installation**:

```bash
./scripts/install.sh --tool claude-code --agents-file anclora-agents.txt
./scripts/install.sh --tool codex --agents-file anclora-agents.txt

```text

**Related docs**: README_ANCLORA.md, INTEGRATION_GUIDE.md, VALIDATION.md

---

## [2026-06-XX] — Future Changes (Template)

### [Agent Name] — [Status]

**Summary**: [One line]

**Details**:

- [What changed]
- [Why]
- [Impact]

**Migration** (if applicable):

```text

Old prompt: "..."
New prompt: "..."

```text

**Related agents**: [List other agents affected]

---

## Breaking Changes Log

### Since Anclora Integration (2026-06-10)

None. Initial release has full backward compatibility with upstream `msitarzewski/agency-agents`.

---

## Deprecated Agents

None currently. All 65 agents are active and recommended for use.

### Deprecation Process

When an agent reaches end-of-life:

1. Agent marked as DEPRECATED in this changelog (3-month notice)
2. Recommended alternative agent listed
3. Migration guide provided
4. At end of notice period, agent removed from anclora-agents.txt
5. Agent file archived to `/deprecated/` for reference

---

## Frequently Changed Agents

### Code Reviewer

- **Change frequency**: Monthly (improvements to security checks, test coverage detection)
- **Last updated**: 2026-06-10 (added accessibility audits)
- **Breaking**: No recent breaking changes

### Backend Architect

- **Change frequency**: Quarterly (new framework versions, cloud service updates)
- **Last updated**: 2026-06-10 (initial Anclora integration)
- **Watching**: gRPC/REST/GraphQL guidance (may change as standards evolve)

### Frontend Developer

- **Change frequency**: Quarterly (React, Vue, Angular updates)
- **Last updated**: 2026-06-10 (React 19 patterns)
- **Watching**: Core Web Vitals guidance (may update as metrics evolve)

### Security Architect

- **Change frequency**: As-needed (new vulnerabilities, compliance updates)
- **Last updated**: 2026-06-10 (initial Anclora integration)
- **Watching**: OWASP Top 10 updates, supply chain attack patterns

---

## How to Stay Updated

### Automatic

1. **GitHub Notifications**: Watch this repo for CHANGELOG updates
2. **CI/CD Pipelines**: GitHub Actions validate agent compatibility

### Manual

1. **Monthly Review**: Check this file for changes
2. **Agent Performance Baselines**: Review any baseline changes that indicate agent evolution

---

## Reporting Agent Issues

If you notice unexpected agent behavior:

1. **Test the baseline**: Does the agent meet AGENT_PERFORMANCE_BASELINES.md?
2. **Document the issue**: Save the prompt and output for reference
3. **File an issue** (if public) or message the team
4. **Include**:
   - Agent name
   - Exact prompt you used
   - Expected behavior
   - Actual behavior
   - Agent category (if known)

Example issue title: `Code Reviewer agent missing SQL injection warnings on parameterized queries`

---

## Version History Reference

 | Version | Date | Key Changes | Status |
 | --- | --- | --- | --- |
 | 1.0 | 2026-06-10 | Initial Anclora integration, 65 agents, full documentation | ✅ Current |

---

## Agent Categories

For quick reference, agents are organized by:

- **Academic** (research, paper writing, citation management)
- **Design** (UI/UX, design systems, visual design)
- **Engineering** (backend, frontend, DevOps, AI/ML, mobile)
- **Finance** (analysis, modeling, risk assessment)
- **Sales** (pipeline, discovery, proposals, negotiation)
- **Marketing** (content, SEO, growth, social media)
- **Paid Media** (ad copy, bidding, audience targeting)
- **Product** (management, roadmapping, prioritization)
- **Project Management** (planning, execution, agile/waterfall)
- **Security** (threat modeling, code review, compliance)
- **Spatial Computing** (AR/VR, 3D, spatial design)
- **Specialized** (niche domains, unique skills)
- **Strategy** (business, competitive, organizational)
- **Support** (customer success, onboarding, retention)
- **Testing** (QA, automation, performance, load)
- **Game Development** (game design, mechanics, engines)
- **GIS/Spatial** (geography, mapping, geospatial analysis)
- **Integrations** (APIs, webhooks, third-party services)

---

## Questions

- **"Will this agent change?"** → Check this changelog monthly
- **"How do I know if I'm using an outdated agent?"** → Compare agent output to
AGENT_PERFORMANCE_BASELINES.md
- **"Where do I report an issue?"** → See "Reporting Agent Issues" section above
- **"How are agent changes decided?"** → Via MEMANTO decisions and team consensus

---

## Appendix: Migration Checklist

Use this when a breaking change is announced:

- [ ] Read the breaking change entry in this changelog
- [ ] Review the migration guide provided
- [ ] Update your prompts with the new format
- [ ] Test with the updated agent
- [ ] Document the change in your project
- [ ] Notify your team of the migration
- [ ] Update any automation that uses the agent

---

**Maintained by**: Anclora Engineering Team
**Report issues to**: See GitHub Issues or contact team lead
**Next scheduled review**: 2026-07-10
