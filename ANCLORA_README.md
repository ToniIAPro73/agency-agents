# 🎯 Agency Agents for Anclora — Master Documentation Index

**Welcome to the Agency Agents repository, customized for Anclora Group.**

This repository contains 65 specialized AI agents optimized for Claude Code and Codex workflows. Choose your path below based on your needs.

---

## 🚀 I Want to...

### Start Using Agents Right Now (5 minutes)
→ Read **[QUICK_START.md](QUICK_START.md)**
- Install agents (already done? verify here)
- Use the 5 most useful agents
- See workflow examples
- Get pro tips

### Install Agents Properly (10 minutes)
→ Read **[README_ANCLORA.md](README_ANCLORA.md)**
- Step-by-step installation
- Verify installation with checklist
- Understand Anclora's tooling strategy (Codex + Claude Code only, no Gemini CLI)
- Troubleshoot issues

### Integrate Agents Into My Workflow (30 minutes)
→ Read **[INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md)**
- Which agents to use by project phase (spec → ops)
- Detailed workflows for each phase
- Cross-project agent patterns
- Anclora-specific patterns (Nexus, Content Generator, EnergyScan)

### Understand Agent Capabilities (20 minutes)
→ Read **[AGENTS.md](AGENTS.md)**
- Complete catalog of 65 agents
- Agent descriptions and specialties
- When to use each agent
- Organized by division (engineering, marketing, sales, security, etc.)

### Validate Installation Post-Install (10 minutes)
→ Read **[VALIDATION.md](VALIDATION.md)**
- Pre-installation checklist
- Post-installation verification steps
- Functional testing
- Troubleshooting quick reference

### Get Quality Standards (Agent Expectations)
→ Read **[AGENT_PERFORMANCE_BASELINES.md](AGENT_PERFORMANCE_BASELINES.md)**
- What you should expect from each agent category
- Quality gates for agent outputs
- Regression detection process
- Examples of excellent agent responses

### Understand Spec-Driven Development (SDD)
→ Read **[SDD_INTEGRATION_GUIDE.md](SDD_INTEGRATION_GUIDE.md)**
- How SDD integrates with GitHub workflows and agents
- SPEC → PLAN → TASKS → Implementation flow
- Using agents to enforce SDD at each phase
- Reference: [SDD NotebookLM](https://notebooklm.google.com/notebook/94462119-4635-4039-827d-e46042428871)

### Track Agent Changes & Breaking News
→ Read **[AGENT_CHANGELOG.md](AGENT_CHANGELOG.md)**
- Version history
- Breaking changes and migrations
- Deprecation notices
- Frequently changed agents
- Issue reporting process

### Understand the Workspace Architecture
→ Read **[WORKSPACE_STRUCTURE.md](WORKSPACE_STRUCTURE.md)**
- Why we have [Tools] prefixes
- Products vs. Infrastructure
- Folder organization rules
- When to add new folders

### See the Big Picture (Architecture & Roadmap)
→ Read **[ANCLORA_ASSESSMENT.md](ANCLORA_ASSESSMENT.md)**
- Integration assessment (9.2/10)
- What works well (strengths)
- Recommended improvements (HIGH/MEDIUM/LOW priority)
- Implementation roadmap
- Risk assessment
- Success metrics

### Understand How to Maintain This Repo
→ Read **[ANCLORA_AGENCY_OPERATING_MODEL.md](ANCLORA_AGENCY_OPERATING_MODEL.md)**
- Operating principles (upstream-first, Anclora-specific in isolated files)
- Installation and verification procedures
- Maintenance rules and criteria for success
- Recommended and prohibited commands

### Understand the Operating Model & Memory
→ Read **[ANCLORA_AGENT_MEMORY.md](ANCLORA_AGENT_MEMORY.md)**
- How agents should behave in Anclora context
- Memory and learning expectations
- Integration with MEMANTO (shared memory system)

---

## 📚 Documentation Map

```
START HERE
    ↓
QUICK_START.md ────────────────→ [Use an agent in 2 minutes]
    ↓
    ├─→ README_ANCLORA.md ─────→ [Setup & installation details]
    │
    ├─→ INTEGRATION_GUIDE.md ──→ [Workflow patterns by phase]
    │
    ├─→ AGENTS.md ────────────→ [Full catalog of 65 agents]
    │
    ├─→ SDD_INTEGRATION_GUIDE.md → [Spec-Driven Development workflow]
    │
    └─→ VALIDATION.md ────────→ [Verify your installation]

WORKFLOWS & INFRASTRUCTURE
    ├─→ GITHUB_WORKFLOW_STANDARDS.md ──→ [Branch strategy & CI/CD]
    ├─→ GITHUB_ACTIONS_TEMPLATES.md ───→ [Reusable workflows]
    └─→ WORKFLOW_ORCHESTRATION_GUIDE.md → [Agent automation for workflows]

DEEP DIVES
    ├─→ AGENT_PERFORMANCE_BASELINES.md ─→ [Quality standards]
    ├─→ AGENT_CHANGELOG.md ────────────→ [Changes & deprecations]
    ├─→ ANCLORA_ASSESSMENT.md ─────────→ [Architecture & roadmap]
    ├─→ ANCLORA_AGENCY_OPERATING_MODEL.md → [Maintenance rules]
    ├─→ ANCLORA_AGENT_MEMORY.md ───────→ [Agent behavior spec]
    └─→ WORKSPACE_STRUCTURE.md ────────→ [Workspace organization]
```

---

## 🎯 Quick Reference by Role

### Developer / Engineer
**Install**: README_ANCLORA.md → VALIDATION.md  
**Use**: QUICK_START.md → INTEGRATION_GUIDE.md  
**Troubleshoot**: AGENT_PERFORMANCE_BASELINES.md → AGENT_CHANGELOG.md

### Team Lead / Manager
**Overview**: ANCLORA_ASSESSMENT.md → WORKSPACE_STRUCTURE.md  
**Operations**: ANCLORA_AGENCY_OPERATING_MODEL.md → AGENT_CHANGELOG.md  
**Quality**: AGENT_PERFORMANCE_BASELINES.md

### New Contributor
**Start**: QUICK_START.md (5 min)  
**Install**: README_ANCLORA.md (10 min)  
**Learn**: INTEGRATION_GUIDE.md (30 min)  
**Reference**: AGENTS.md (bookmarked)

### DevOps / Infrastructure
**Setup**: README_ANCLORA.md → VALIDATION.md  
**CI/CD**: GitHub Actions workflow in `.github/workflows/validate-agents.yml`  
**Monitoring**: AGENT_CHANGELOG.md for breaking changes

---

## 🔥 The 5 Most Important Docs (Read These First)

1. **[QUICK_START.md](QUICK_START.md)** — Get up and running in 5 minutes
2. **[README_ANCLORA.md](README_ANCLORA.md)** — Understand the setup and Anclora's choices
3. **[AGENTS.md](AGENTS.md)** — Know what agents are available
4. **[SDD_INTEGRATION_GUIDE.md](SDD_INTEGRATION_GUIDE.md)** — Understand Spec-Driven Development workflow
5. **[GITHUB_WORKFLOW_STANDARDS.md](GITHUB_WORKFLOW_STANDARDS.md)** — Understand Git flow and branch strategy

**Also bookmark**:
- **[AGENT_PERFORMANCE_BASELINES.md](AGENT_PERFORMANCE_BASELINES.md)** — Know what to expect from agents
- **[INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md)** — Use agents effectively in your workflow

---

## 📊 Documentation Stats

| Document | Lines | Purpose |
| --- | --- | --- |
| QUICK_START.md | 200+ | 5-min onboarding |
| README_ANCLORA.md | 200+ | Setup & maintenance |
| INTEGRATION_GUIDE.md | 300+ | Workflow patterns |
| AGENTS.md | 400+ | Agent catalog |
| VALIDATION.md | 250+ | Post-install checklist |
| AGENT_PERFORMANCE_BASELINES.md | 450+ | Quality standards |
| AGENT_CHANGELOG.md | 300+ | Version history |
| ANCLORA_ASSESSMENT.md | 300+ | Architecture & roadmap |
| WORKSPACE_STRUCTURE.md | 250+ | Workspace organization |
| ANCLORA_AGENCY_OPERATING_MODEL.md | 200+ | Operating principles |
| ANCLORA_AGENT_MEMORY.md | 100+ | Behavior specification |

**Total**: ~3,000 lines of documentation for enterprise-grade quality

---

## ✅ Quick Checklist: Getting Started

- [ ] Read QUICK_START.md (5 min)
- [ ] Verify installation: `find ~/.claude/agents -name "*.md" | wc -l` (should be 93+)
- [ ] Try your first agent: "Use the Code Reviewer agent to review this code."
- [ ] Bookmark AGENTS.md for reference
- [ ] Join the team and ask questions
- [ ] Report issues to: [GitHub Issues](https://github.com/ToniIAPro73/agency-agents/issues)

---

## 🆘 Common Questions

**Q: How do I install agents?**  
A: See README_ANCLORA.md — Installation section

**Q: Which agent should I use?**  
A: See QUICK_START.md — The 5 Most Useful Agents section, or AGENTS.md for full catalog

**Q: Why is Gemini CLI not available?**  
A: Anclora uses Claude Code and Codex. See README_ANCLORA.md — Herramientas Operativas Autorizadas

**Q: How do I know if agents are working correctly?**  
A: Check AGENT_PERFORMANCE_BASELINES.md for expected behavior

**Q: What changed in the agents recently?**  
A: See AGENT_CHANGELOG.md

**Q: How do I report an issue?**  
A: See AGENT_CHANGELOG.md — Reporting Agent Issues section

**Q: Can I customize an agent?**  
A: Advanced users can edit agent files in ~/.claude/agents/. See INTEGRATION_GUIDE.md for safer approaches.

---

## 🎓 Learning Path (Recommended Order)

### Day 1: Get Started (30 minutes)
1. QUICK_START.md
2. Verify installation with VALIDATION.md
3. Use your first agent

### Week 1: Build Confidence (2-3 hours)
1. AGENTS.md (bookmark it)
2. INTEGRATION_GUIDE.md (workflow patterns)
3. AGENT_PERFORMANCE_BASELINES.md (know what to expect)

### Month 1: Master the System (4-5 hours)
1. ANCLORA_ASSESSMENT.md (understand the roadmap)
2. AGENT_CHANGELOG.md (stay updated)
3. ANCLORA_AGENCY_OPERATING_MODEL.md (understand the principles)

---

## 🚀 Next Level: Advanced Usage

Once you're comfortable with agents:
- **Chain agents**: Use output from one agent as input to another
- **Customize prompts**: Provide more context for better results
- **Track agent feedback**: Suggest improvements to agent behavior
- **Contribute**: Help improve agent instructions or documentation

See INTEGRATION_GUIDE.md — Advanced Patterns section

---

## 📞 Support & Feedback

- **Installation issues**: See VALIDATION.md → Troubleshooting
- **Agent quality concerns**: See AGENT_PERFORMANCE_BASELINES.md → Regression Detection
- **Feature requests**: Open GitHub issue with `[Feature]` prefix
- **Bug reports**: Open GitHub issue with `[Bug]` prefix
- **General feedback**: Message the team or create a discussion

---

## 🔗 Related Links

- **Agency Repository**: [GitHub](https://github.com/ToniIAPro73/agency-agents)
- **Upstream Source**: [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents)
- **Anclora Workspace**: Available in VS Code as `Anclora.code-workspace`
- **Anclora Memory**: `.anclora-agents/MEMORY.md` (shared team context)

---

## 📝 Version Info

- **Agency Agents Version**: Anclora Integration v1.0 (2026-06-10)
- **Total Agents**: 65 (Claude Code: 93, Codex: 65)
- **Documentation Status**: ✅ Complete and current
- **Last Updated**: 2026-06-10

---

## 🎉 Welcome Aboard!

You now have access to a world-class team of AI specialists. Use them wisely, share feedback, and help us improve the system for everyone.

**Start with QUICK_START.md. You'll be productive in 5 minutes.** ⚡

---

*Maintained by Anclora Engineering Team*  
*Questions? See the appropriate doc above or contact your team lead.*
