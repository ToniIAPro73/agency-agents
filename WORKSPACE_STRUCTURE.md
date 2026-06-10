# Anclora Workspace Structure

**File**: `Anclora.code-workspace`
**Updated**: 2026-06-10
**Purpose**: Document the logical organization of the Anclora ecosystem in VS Code

---

## Overview

The Anclora workspace contains **18 folders** organized into two categories:

1. **ANCLORA PRODUCTS** (13) — Actual applications and services
2. **TOOLING & INFRASTRUCTURE** (5) — Libraries, templates, skills, and agents

This separation makes it clear which repos are production deliverables vs. operational
infrastructure.

---

## ANCLORA PRODUCTS (13)

These are customer-facing or internal business applications:

 | Name | Path | Purpose |
 | --- | --- | --- |
 | **Anclora Group** | `anclora-group` | Main Anclora Group hub and ecosystem entry point |
 | **Advisor AI** | `anclora-advisor-ai` | Financial/business advisory AI assistant |
 | **Linguo Cam** | `anclora-linguo-cam` | Language learning and camera-based translation |
 | **Talent** | `anclora-talent` | Talent management and recruitment platform |
 | **Impulso** | `anclora-impulso` | Growth acceleration and momentum tracking |
 | **SyncXML** | `anclora-syncXML` | XML document synchronization service |
 | **Nexus** | `anclora-nexus` | Central coordination and conversion platform |
 | **EnergyScan** | `anclora-energyscan` | Energy analysis and reporting system |
 | **Content Generator** | `anclora-content-generator-ai` | AI-powered content creation and curation |
 | **Data Lab** | `anclora-data-lab` | Data analytics and experimentation platform |
 | **Private Estates** | `anclora-private-estates` | Property management and exclusive listings |
 | **Private Estates Landing** | `anclora-private-estates-landing` | Marketing landing page for Private Estates |
 | **Synergi** | `anclora-synergi` | Synergy and collaboration platform |

---

## TOOLING & INFRASTRUCTURE (5)

These are operational, enabling repositories that support development across all products:

### 🧠 [Tools] Global Agent Memory

- **Path**: `.anclora-agents`
- **Purpose**: Shared memory and context for all Anclora agents (MEMANTO sync)
- **Key Files**: `MEMORY.md` (auto-synced)
- **Users**: All Claude Code agents and developers
- **When to use**: Understanding prior decisions, team context, cross-product memory

### 📋 [Tools] SDD Template

- **Path**: `anclora-template`
- **Purpose**: Standard Spec-Driven Development (SDD) template for new Anclora projects
- **Key Files**: `README.md`, `docs/sdd/`, CLAUDE.md patterns
- **Users**: New project starters, template maintenance team
- **When to use**: Starting a new Anclora product or feature

### 🎯 [Tools] Awesome Skills Catalog

- **Path**: `anclora-awesome-skills`
- **Purpose**: Community curated catalog of AI skills and agents
- **Key Files**: `CATALOG.md` (450K+), `/apps/`, `/docs/`
- **Users**: Developers looking for ready-made skills
- **When to use**: Finding existing skills before building new ones

### 🔧 [Tools] Agent Skills & MCP

- **Path**: `anclora-agent-skills`
- **Purpose**: Modular Claude Code skills and MCP servers for Anclora workflows
- **Key Files**: `/skills/`, `.mcp.json`, `README.md`
- **Users**: All Claude Code sessions
- **When to use**: Extending agent capabilities, adding domain-specific skills

### 🤖 [Tools] Agency Agents Library

- **Path**: `agency-agents`
- **Purpose**: 65 specialized AI agents optimized for Anclora (from upstream
`msitarzewski/agency-agents`)
- **Key Files**: `AGENTS.md`, `README_ANCLORA.md`, `INTEGRATION_GUIDE.md`, agent files in `/*/`
- **Users**: All developers, all phases of work
- **When to use**: Everyday—spec → architecture → build → QA → launch → ops

---

## Folder Organization Rules

### Visual Hierarchy in VS Code

The workspace appears in this order in the file explorer:

```text

Anclora/
├── [Tools] Global Agent Memory         ← Operational memory
├── Anclora Group
├── Advisor AI
├── Linguo Cam
├── Talent
├── Impulso
├── SyncXML
├── Nexus
├── EnergyScan
├── Content Generator
├── Data Lab
├── Private Estates
├── Private Estates Landing
├── Synergi
├── [Tools] SDD Template                ← Tooling (grouped at end for clarity)
├── [Tools] Awesome Skills Catalog
├── [Tools] Agent Skills & MCP
└── [Tools] Agency Agents Library

```text

### Naming Convention

- **Products**: Plain name, no prefix
  - `anclora-group`, `anclora-nexus`, etc.

- **Tooling**: `[Tools]` prefix for visibility
  - `[Tools] SDD Template`
  - `[Tools] Agency Agents Library`
  - etc.

### Benefits of This Structure

✅ **Clear distinction** between products (what we ship) and tools (what helps us build)
✅ **Easy onboarding** — new developers immediately understand the ecosystem
✅ **Scalability** — add new products or tools following the same pattern
✅ **Maintenance** — tools grouped together, easier to manage dependencies
✅ **Search** — `[Tools]` prefix makes them findable in workspace search

---

## When to Add a New Folder

### New Anclora Product

1. Create repo following `anclora-*` naming
2. Add to workspace **without** `[Tools]` prefix
3. Add in the **PRODUCTS** section (before tooling section)
4. Update this document

**Example**:

```json
{
  "path": "anclora-new-product",
  "name": "New Product Name"
}

```text

### New Tool/Library

1. Create repo (name reflects purpose)
2. Add to workspace **with** `[Tools]` prefix
3. Add in the **TOOLING & INFRASTRUCTURE** section (at end)
4. Update this document

**Example**:

```json
{
  "path": "anclora-new-tool",
  "name": "[Tools] New Tool Description"
}

```text

---

## Configuration & Settings

### Shared Settings (Anclora-wide)

```json
"settings": {
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "[markdown]": {
    "editor.wordWrap": "on"
  }
}

```text

### TypeScript Configuration

```json
"typescript.tsdk": "Nexus/node_modules/typescript/lib"

```text

> Points to Nexus because it's the main full-stack app with TypeScript

### Excluded Patterns

- `**/node_modules` — package managers
- `**/.next` — build artifacts
- `**/dist`, `**/build` — compiled output
- `**/.turbo`, `**/.turbopack` — monorepo cache
- `**/.git` — version control metadata
- `**/coverage` — test coverage reports

---

## Recommended Extensions

The workspace recommends:

```json
"extensions": {
  "recommendations": [
    "esbenp.prettier-vscode",        // Code formatter
    "dbaeumer.vscode-eslint",        // Linter
    "ms-vscode.vscode-typescript-next", // TypeScript
    "bradlc.vscode-tailwindcss",     // Tailwind CSS
    "GitHub.copilot"                 // GitHub Copilot
  ]
}

```text

---

## Quick Reference: Which Folder

 | Question | Answer | Folder |
 | --- | --- | --- |
 | "I'm building a new feature for Nexus" | Product development | `anclora-nexus` |
 | "I want to use existing skills" | Find/extend skills | `[Tools] Awesome Skills Catalog` |
 | "I need a custom Claude Code skill" | Create skill | `[Tools] Agent Skills & MCP` |
 | "I'm starting a new product" | Template reference | `[Tools] SDD Template` |
 | "I need a specialized agent" | Pick from roster | `[Tools] Agency Agents Library` |
 | "I need shared team memory" | Store memory | `[Tools] Global Agent Memory` |

---

## File Locations Reference

 | Purpose | Location |
 | --- | --- |
 | **Shared memory** | `.anclora-agents/MEMORY.md` |
 | **SDD template** | `anclora-template/docs/sdd/` |
 | **Skills catalog** | `anclora-awesome-skills/CATALOG.md` |
 | **MCP servers** | `anclora-agent-skills/.mcp.json` |
 | **Agent guides** | `agency-agents/AGENTS.md`, `INTEGRATION_GUIDE.md` |
 | **Anclora rules** | `~/.claude/CLAUDE.md`, `/rules/` |

---

## Maintenance

### When Workspaces Drift

If the workspace file gets out of sync:

```bash

# Re-open the workspace file

# VS Code will automatically reload and sync

# File is not git-tracked (local to your machine)

```text

### Testing Workspace Load

```bash

# Verify workspace loads without errors

code --list-extensions  # See all installed extensions

```text

### Updating This Document

After adding/removing folders, update this markdown file to keep it current.

---

**Last verified**: 2026-06-10
**Total folders**: 18 (13 products + 5 tools)
**Status**: ✅ Current and consistent
