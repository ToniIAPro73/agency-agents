# Validation Checklist — Agency Agents for Anclora

**Purpose**: Ensure Agency Agents is correctly installed and integrated in your Anclora environment
**Last Updated**: 2026-06-10
**Maintainer**: Anclora Engineering Team

---

## Pre-Installation Checklist

- [ ] You are in `/home/toni/projects/agency-agents`
- [ ] Git remote is set to upstream: `git remote -v | grep upstream`
- [ ] No uncommitted changes: `git status` shows clean working tree
- [ ] You have `~/.claude` and `~/.codex` directories

---

## Installation Checklist

### 1. Prepare Scripts

```bash
cd /home/toni/projects/agency-agents

# Mark scripts as executable

chmod +x scripts/install.sh scripts/convert.sh

# Verify

ls -l scripts/install.sh scripts/convert.sh

```text

**Validation**: Both files show `-rwxr-xr-x` (executable)

- [ ] `scripts/install.sh` is executable
- [ ] `scripts/convert.sh` is executable

### 2. Convert for Codex

```bash
./scripts/convert.sh --tool codex --parallel

```text

**Validation**: No errors, output includes "✓ codex" or "Completed"

- [ ] Conversion completed without errors
- [ ] Codex agent files created in `./codex/` or similar

### 3. Install for Claude Code

```bash
./scripts/install.sh --tool claude-code --agents-file anclora-agents.txt

```text

**Validation**: Output shows installation path and agent count

- [ ] Installation completed
- [ ] Output confirms agents installed to `~/.claude/agents/`

### 4. Install for Codex

```bash
./scripts/install.sh --tool codex --agents-file anclora-agents.txt

```text

**Validation**: Output shows Codex installation path

- [ ] Installation completed
- [ ] Output confirms agents installed to `~/.codex/agents/`

---

## Post-Installation Verification

### Claude Code Agents

```bash

# Count installed agents

find ~/.claude/agents -type f -name "*.md" | wc -l

```text

**Expected**: 93+ agents (not 65, because Claude Code has more agents than Codex)

- [ ] `find ~/.claude/agents` returns 93+

### Codex Agents

```bash

# Count installed agents

find ~/.codex/agents -type f -name "*.md" | wc -l

```text

**Expected**: 65 agents (the Anclora-selected subset)

- [ ] `find ~/.codex/agents` returns 65

### Gemini CLI Validation

```bash

# Verify Gemini CLI is NOT installed

test ! -d ~/.gemini/agents && echo "✓ Gemini CLI not present" || echo "⚠ WARNING: Gemini CLI
directory exists"

```text

**Expected**: Output shows "✓ Gemini CLI not present"

- [ ] Gemini CLI directory does not exist or is empty

### Agent Files Integrity

```bash

# Sample: Check a few critical agents exist

for agent in backend-architect code-reviewer frontend-developer technical-writer; do
  [ -f ~/.claude/agents/*$agent* ] && echo "✓ $agent found" || echo "✗ $agent missing"
done

```text

**Expected**: All agents show "✓ found"

- [ ] backend-architect agent exists
- [ ] code-reviewer agent exists
- [ ] frontend-developer agent exists
- [ ] technical-writer agent exists

---

## Integration Checklist

### Anclora Workspace Registration

```bash

# Check that agency-agents is in the workspace

grep -A2 '"path": "agency-agents"' /home/toni/projects/Anclora.code-workspace

```text

**Expected Output**:

```json
"path": "agency-agents",
"name": "[Tools] Agency Agents"

```text

- [ ] agency-agents is registered in `Anclora.code-workspace`
- [ ] Folder name is `[Tools] Agency Agents` (or similar)

### Configuration Files

```bash

# Verify Anclora-specific files exist

cd /home/toni/projects/agency-agents

ls -1 README_ANCLORA.md ANCLORA_AGENCY_OPERATING_MODEL.md ANCLORA_AGENT_MEMORY.md anclora-agents.txt

```text

**Expected**: All files listed

- [ ] `README_ANCLORA.md` exists
- [ ] `ANCLORA_AGENCY_OPERATING_MODEL.md` exists
- [ ] `ANCLORA_AGENT_MEMORY.md` exists
- [ ] `anclora-agents.txt` exists

### Documentation Availability

```bash

# Test documentation is readable

head -5 /home/toni/projects/agency-agents/README_ANCLORA.md

```text

**Expected**: Markdown header visible

- [ ] Documentation is readable and accessible

---

## Functional Testing

### Test 1: List Agents

```bash

# In Claude Code, try this prompt

# "List the available agents from the Agency repository."

```text

**Expected**: Claude Code lists 50+ agents

- [ ] Claude Code recognizes agents

### Test 2: Use an Agent

```bash

# In Claude Code

# "Use the Backend Architect agent to explain the purpose of a REST API."

```text

**Expected**: Agent responds with architectural guidance

- [ ] Claude Code agent invocation works

### Test 3: Codex Agent

```bash

# In terminal

codex ask --agent backend-architect "What are ACID principles in databases?"

```text

**Expected**: Codex returns architectural guidance from backend-architect agent

- [ ] Codex agent invocation works

### Test 4: Agent Personality

```bash

# In Claude Code

# "Use the Minimal Change Engineer agent to explain their philosophy."

```text

**Expected**: Agent describes their focus on minimal, safe changes

- [ ] Agent personalities are intact

---

## Repository State Checklist

### Upstream Sync

```bash

# Verify upstream is configured

git remote -v | grep upstream

```text

**Expected**: Shows upstream as github.com/msitarzewski/agency-agents.git

- [ ] Upstream remote is configured

### Local Changes

```bash

# Check git status

git status

```text

**Expected**: Working tree clean (no modifications to core files)

- [ ] Only Anclora-specific files are modified
- [ ] No accidental changes to upstream files

### Documentation Consistency

```bash

# Verify key docs exist and are consistent

grep -q "Claude Code" README_ANCLORA.md && echo "✓ Claude Code mentioned"
grep -q "Codex" README_ANCLORA.md && echo "✓ Codex mentioned"
grep -q "Gemini CLI" README_ANCLORA.md && grep -q "NOT" README_ANCLORA.md && echo "✓ Gemini CLI
correctly marked as not used"

```text

**Expected**: All three confirmations

- [ ] Claude Code documentation present
- [ ] Codex documentation present
- [ ] Gemini CLI correctly documented as not used

---

## Troubleshooting Quick Reference

 | Issue | Diagnosis | Fix |
 | --- | --- | --- |
 | "Agents not found" | `find ~/.claude/agents \ | wc -l` returns <50 | Reinstall: `./scripts/install.sh --tool claude-code --agents-file anclora-agents.txt` |
 | "Permission denied" | `ls -l scripts/install.sh` shows no `x` | `chmod +x scripts/install.sh scripts/convert.sh` |
 | "Codex agents not found" | `find ~/.codex/agents \ | wc -l` returns <50 | Reinstall: `./scripts/install.sh --tool codex --agents-file anclora-agents.txt` |
 | "Gemini CLI present" | `test -d ~/.gemini/agents && echo found` | `rm -rf ~/.gemini/agents` |
 | "Wrong agent count" | Count doesn't match (93 for Claude, 65 for Codex) | Check agent files: `find ~/.claude/agents -name "*.md" \ | head -5` |

---

## Sign-Off

When all checkboxes are complete, Agency Agents is ready for use in Anclora projects.

```bash

# Final confirmation

echo "✓ Agency Agents installation validated for Anclora"
date

```text

**Validated By**: ________________
**Date**: ________________
**Notes**: ________________________________________________

---

**Next Steps**:

1. Read [INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md) to start using agents
2. Review [AGENTS.md](AGENTS.md) to see the full catalog
3. Check [ANCLORA_AGENCY_OPERATING_MODEL.md](ANCLORA_AGENCY_OPERATING_MODEL.md) for architectural
context
