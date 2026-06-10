# Integration Guide — Using Agency Agents in Anclora Projects

**For**: Developers integrating Agency Agents into Anclora applications
**Updated**: 2026-06-10

---

## Overview

Agency Agents provides 65+ specialized AI agents for Anclora Group workflows. This guide shows
**how to use them in your daily work** across Anclora projects.

---

## 1. Quick Reference by Project Phase

### Phase 1: Specification & Requirements

**Use these agents**: product-manager, business-strategist, ux-researcher, workflow-architect

**Example prompts**:

```bash

# In Claude Code, reference the agent

"Use the Product Manager agent to review this PRD and identify risks."

# Or in Codex

codex ask --agent product-manager "What questions should we ask about this feature request?"

```text

### Phase 2: Architecture & Design

**Use these agents**: software-architect, backend-architect, database-optimizer,
security-architect, ai-engineer

**Example prompts**:

```bash

# Claude Code

"Use the Backend Architect agent to design the API for this feature."

# Codex

codex ask --agent backend-architect "Design a REST API for user authentication."

```text

### Phase 3: Implementation

**Use these agents**: frontend-developer, backend-architect, code-writer, ai-engineer,
minimal-change-engineer

**Example prompts**:

```bash

# Claude Code

"Use the Frontend Developer agent to implement this React component."

# Codex

codex ask --agent frontend-developer "Build a responsive card component in React 19."

```text

### Phase 4: Testing & Security

**Use these agents**: code-reviewer, api-tester, accessibility-auditor, security-architect,
performance-benchmarker

**Example prompts**:

```bash

# Claude Code

"Use the Code Reviewer agent to audit this PR for security issues."

# Codex

codex ask --agent api-tester "Create comprehensive tests for this REST endpoint."

```text

### Phase 5: Documentation & Launch

**Use these agents**: technical-writer, content-creator, aeo-foundations-architect, brand-guardian

**Example prompts**:

```bash

# Claude Code

"Use the Technical Writer agent to document this API."

# Codex

codex ask --agent aeo-foundations-architect "Optimize this README for search engines."

```text

### Phase 6: Operations & Maintenance

**Use these agents**: sre-site-reliability-engineer, infrastructure-maintainer, operations-manager,
automation-governance-architect

**Example prompts**:

```bash

# Claude Code

"Use the SRE agent to review our monitoring strategy for this service."

# Codex

codex ask --agent infrastructure-maintainer "Audit our Docker setup for security."

```text

---

## 2. Claude Code Integration

### Activating an Agent

In any Claude Code session, reference an agent by name:

```text

Use the Backend Architect agent to design the database schema for user accounts.

```text

Claude Code will load the agent's personality, processes, and constraints automatically.

### Common Workflows

#### Code Review

```text

Use the Code Reviewer agent to review this PR for:

- Logic errors and edge cases
- Performance issues
- Security vulnerabilities
- Test coverage gaps

```text

#### Architecture Validation

```text

Use the Software Architect agent to review this architecture for:

- Scalability concerns
- Failure modes
- Dependency risks
- Cost efficiency

```text

#### Documentation

```text

Use the Technical Writer agent to:

1. Audit this README for clarity
2. Add usage examples
3. Improve SEO for searchability

```text

---

## 3. Codex Integration

### Command Syntax

```bash
codex ask --agent <agent-name> "<prompt>"

```text

### Examples by Agent

#### Code Writer Agent

```bash
codex ask --agent code-writer "Add a validation function for email addresses."

```text

#### Minimal Change Engineer

```bash
codex ask --agent minimal-change-engineer "Fix this bug with the smallest safe change."

```text

#### Test Writer

```bash
codex ask --agent test-writer "Write comprehensive tests for the UserService class."

```text

#### API Tester

```bash
codex ask --agent api-tester "Create tests for GET /api/users/{id} endpoint."

```text

---

## 4. Cross-Project Agent Patterns

### Pattern: Feature Specification to Shipping

1. **Spec Phase** (product-manager, ux-researcher)
   - "Use the Product Manager agent to write a PRD for this feature."

2. **Architecture Phase** (software-architect, backend-architect)
   - "Use the Backend Architect agent to design the API."

3. **Implementation Phase** (frontend-developer, code-writer)
   - "Use the Frontend Developer agent to implement the UI."

4. **Testing Phase** (code-reviewer, api-tester, accessibility-auditor)
   - "Use the Code Reviewer agent to audit the implementation."

5. **Documentation Phase** (technical-writer, aeo-foundations-architect)
   - "Use the Technical Writer agent to document the feature."

### Pattern: Security Hardening

1. **Threat Modeling** (security-architect)
   - "Use the Security Architect agent to threat-model this feature."

2. **Code Security Audit** (code-reviewer, security-architect)
   - "Use the Code Reviewer agent to find security vulnerabilities."

3. **Dependency Audit** (security-architect)
   - "Use the Security Architect agent to audit our dependencies."

4. **Penetration Testing** (security-architect)
   - "Use the Security Architect agent to design a penetration test plan."

---

## 5. Anclora-Specific Patterns

### Anclora Nexus Workflow

```bash

# Phase 1: Spec

"Use the Product Manager agent to validate this feature against Anclora's requirements."

# Phase 2: Architecture

"Use the Backend Architect agent to design how this integrates with Nexus."

# Phase 3: Implementation

"Use the Frontend Developer agent to implement this in the Nexus dashboard."

# Phase 4: Testing

"Use the Code Reviewer agent to review for Nexus compliance."

```text

### Anclora Content Generator Workflow

```bash

# Phase 1: Strategy

"Use the Content Creator agent to plan the content strategy."

# Phase 2: SEO

"Use the AEO Foundations Architect agent to optimize for search engines."

# Phase 3: Implementation

"Use the Content Creator agent to write and format the content."

# Phase 4: Review

"Use the Code Reviewer agent to audit the output."

```text

### Anclora EnergyScan Workflow

```bash

# Phase 1: Data Architecture

"Use the Database Optimizer agent to design the energy data schema."

# Phase 2: Analysis Pipeline

"Use the AI Engineer agent to design the ML pipeline."

# Phase 3: Implementation

"Use the Backend Architect agent to implement the API."

```text

---

## 6. Context & Memory for Agents

### What Agents Know About Anclora

Each agent has been initialized with:

- Anclora's tech stack and conventions
- Product names and relationships
- Security and compliance requirements
- Design system and branding guidelines
- Team structure and workflows

### How to Provide Additional Context

If an agent needs more context, provide it in your prompt:

```bash

# Good: Specific context

"Use the Backend Architect agent to design an API for syncing XML documents to Supabase,
maintaining ACID compliance and supporting batch imports of 10K+ records."

# Avoid: Vague

"Design an API for syncing."

```text

### Persisting Important Context

For multi-session work, document context in:

- `README.md` or project docs
- Anclora [MEMORY.md](https://github.com/anclora/anclora-nexus/blob/main/MEMORY.md)
- Decision records in `docs/ADRs/`
- Design documents in `docs/`

---

## 7. Troubleshooting

### Agent Not Found

```bash

# Check installation

find ~/.claude/agents -type f | wc -l  # Should be 93+

# Reinstall if needed

cd /home/toni/projects/agency-agents
./scripts/install.sh --tool claude-code --agents-file anclora-agents.txt

```text

### Codex Agent Not Working

```bash

# Check Codex installation

find ~/.codex/agents -type f | wc -l  # Should be 65

# Reinstall

cd /home/toni/projects/agency-agents
./scripts/install.sh --tool codex --agents-file anclora-agents.txt

```text

### Agent Giving Generic Responses

1. **Provide more context** in your prompt
2. **Reference Anclora-specific requirements**: tech stack, frameworks, standards
3. **Give examples**: "Here's an example of what I'm looking for..."

---

## 8. Best Practices

### ✅ Do

- Use agents for specialized tasks (they excel at their domain)
- Provide Anclora context in prompts
- Reference specific files or code when needed
- Chain agents (one output feeds the next agent)
- Document important decisions in Anclora MEMORY.md

### ❌ Don't

- Use `--tool all` or `--tool gemini-cli` (not supported in Anclora)
- Ask agents to guess context (be specific)
- Treat agent output as final without review
- Skip security review even with a Security Architect agent
- Forget to test agent outputs (they're guides, not gospel)

---

## 9. Agent Hall of Fame

**Most Useful for Anclora Projects**:

 | Agent | Best For | Frequency |
 | --- | --- | --- |
 | **Backend Architect** | API design, database architecture | Daily |
 | **Code Reviewer** | Quality gates, security audits | Daily |
 | **Product Manager** | Requirement validation, roadmap | Weekly |
 | **Technical Writer** | Documentation, API specs | Weekly |
 | **Security Architect** | Threat modeling, compliance | Monthly |
 | **Frontend Developer** | UI implementation, performance | Daily |
 | **AI Engineer** | LLM integration, ML features | Weekly |

---

## 10. Getting Help

 | Question | Where to Look |
 | --- | --- |
 | "Which agent should I use?" | See section 1 (Quick Reference by Phase) |
 | "How do I install agents?" | [README_ANCLORA.md](README_ANCLORA.md#-instalación) |
 | "What's the agent's personality?" | [AGENTS.md](AGENTS.md) or agent `.md` file directly |
 | "Why is Gemini CLI not available?" | [README_ANCLORA.md](README_ANCLORA.md#herramientas-operativas-autorizadas) |
 | "How do I add a new agent?" | [CONTRIBUTING.md](CONTRIBUTING.md) |

---

**Next**: See [ANCLORA_AGENCY_OPERATING_MODEL.md](ANCLORA_AGENCY_OPERATING_MODEL.md) for
architectural decisions and [AGENTS.md](AGENTS.md) for the full agent catalog.
