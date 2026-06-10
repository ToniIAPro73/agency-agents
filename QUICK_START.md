# Quick Start — Using Agency Agents in Anclora

**For**: Developers who want to start using agents immediately  
**Time**: 5-10 minutes  
**Level**: All experience levels

---

## 30-Second Overview

You now have access to **65 specialized AI agents** for software development.

- **Claude Code**: Use agents to brainstorm, review, plan, and guide development
- **Codex**: Use agents to execute concrete tasks (write code, test, document)

Think of it as having a team of experts available instantly.

---

## Installation (Already Done? Skip This)

If agents aren't installed:

```bash
cd /home/toni/projects/agency-agents

# Install for Claude Code
./scripts/install.sh --tool claude-code --agents-file anclora-agents.txt

# Install for Codex
./scripts/install.sh --tool codex --agents-file anclora-agents.txt
```

Verify installation:
```bash
find ~/.claude/agents -name "*.md" | wc -l    # Should be 93+
find ~/.codex/agents -name "*.md" | wc -l     # Should be 65
```

---

## Using Agents in Claude Code

In any Claude Code session, reference an agent like this:

```
Use the Backend Architect agent to design a REST API for user authentication.
```

Claude Code will activate the agent's personality and expertise.

### Common Use Cases

**Planning a feature**:
```
Use the Product Manager agent to validate this feature idea.
```

**Designing architecture**:
```
Use the Software Architect agent to review this system design for scalability issues.
```

**Reviewing code**:
```
Use the Code Reviewer agent to audit this PR for security vulnerabilities.
```

**Writing documentation**:
```
Use the Technical Writer agent to improve this README.
```

---

## Using Agents in Codex

In your terminal:

```bash
# Ask an agent a question
codex ask --agent backend-architect "Design an API for real-time notifications"

# Get specific help
codex ask --agent code-reviewer "Review this function for bugs"
codex ask --agent frontend-developer "Create a React form component"
```

---

## The 5 Most Useful Agents (Start Here)

### 1️⃣ Code Reviewer
```
Use the Code Reviewer agent to review this code for security, performance, and test coverage.
```
**When**: Before committing code  
**Saves**: Hours of review time  

### 2️⃣ Backend Architect
```
Use the Backend Architect agent to design the API for this feature.
```
**When**: Designing APIs, databases, or system architecture  
**Saves**: Weeks of architectural rework  

### 3️⃣ Frontend Developer
```
Use the Frontend Developer agent to implement this UI component with accessibility and performance.
```
**When**: Building React/Vue/Angular components  
**Saves**: Time on responsive design, performance optimization  

### 4️⃣ Product Manager
```
Use the Product Manager agent to validate this feature request.
```
**When**: Unsure if a feature is worth building  
**Saves**: Prevents building the wrong thing  

### 5️⃣ Security Architect
```
Use the Security Architect agent to threat-model this feature.
```
**When**: Before shipping security-sensitive features  
**Saves**: Prevents security breaches

---

## Workflow Examples

### Build a Feature (Start to Finish)

1. **Spec Phase** (Product Manager)
   ```
   Use the Product Manager agent to validate the requirements for this feature.
   ```

2. **Architecture Phase** (Backend Architect)
   ```
   Use the Backend Architect agent to design the API and database schema.
   ```

3. **Build Phase** (Frontend Developer + Code Writer)
   ```
   Use the Frontend Developer agent to implement the UI component.
   ```

4. **Review Phase** (Code Reviewer)
   ```
   Use the Code Reviewer agent to audit the code for bugs and security issues.
   ```

5. **Documentation Phase** (Technical Writer)
   ```
   Use the Technical Writer agent to document the feature.
   ```

### Review a Pull Request

```
Use the Code Reviewer agent to check this PR for:
- Logic bugs and edge cases
- Security vulnerabilities (OWASP Top 10)
- Performance issues
- Missing test coverage
- Code duplication
```

### Debug a Complex Issue

1. **Analyze** (Code Reviewer)
   ```
   Use the Code Reviewer agent to analyze why this test is failing.
   ```

2. **Design solution** (Software Architect)
   ```
   Use the Software Architect agent to propose a fix.
   ```

3. **Implement** (Code Writer)
   ```
   Use the Code Writer agent to implement the fix.
   ```

---

## Pro Tips

### 1. Be Specific
❌ Bad: `Use the Backend Architect agent to design an API.`  
✅ Good: `Use the Backend Architect agent to design a REST API for a real-time chat with 100K concurrent users.`

### 2. Provide Context
```
Here's the current architecture: [paste architecture doc]
Use the Backend Architect agent to design the API for syncing data to Supabase.
```

### 3. Ask for Multiple Options
```
Use the Backend Architect agent to propose 3 different architectures for this feature, 
with trade-offs for each.
```

### 4. Chain Agents
Use output from one agent as input to the next:
```
[Get output from Product Manager on requirements]
Use the Backend Architect agent to design the API based on these requirements.
[Get output from Backend Architect]
Use the Frontend Developer agent to implement the UI based on this API design.
```

### 5. Test, Then Trust
First time using an agent? Verify the output with a quick test before committing.

---

## Agent Categories (Find What You Need)

| Need | Agent | Category |
| --- | --- | --- |
| **Plan a feature** | Product Manager | Product |
| **Design architecture** | Software/Backend Architect | Engineering |
| **Build React** | Frontend Developer | Engineering |
| **Build APIs** | Backend Architect | Engineering |
| **Write code** | Code Writer | Engineering |
| **Review code** | Code Reviewer | Engineering |
| **Test APIs** | API Tester | Testing |
| **Audit security** | Security Architect | Security |
| **Optimize performance** | Performance Benchmarker | Engineering |
| **Write docs** | Technical Writer | Documentation |

See `AGENTS.md` for the complete catalog.

---

## Troubleshooting

**Q: "Agent not found"**  
A: Reinstall agents:
```bash
./scripts/install.sh --tool claude-code --agents-file anclora-agents.txt
```

**Q: "Can I use multiple agents in one prompt?"**  
A: Yes, but reference them sequentially:
```
First, use the Product Manager agent to validate this feature.
Then, use the Backend Architect agent to design the API.
```

**Q: "Can I customize an agent?"**  
A: Modify the agent file in `~/.claude/agents/` (advanced).  
Better: Ask the agent to adapt — agents are flexible!

**Q: "Are agents always correct?"**  
A: No. Agents are guides, not gospel.  
Always review agent output, test it, and validate with your domain knowledge.

**Q: "How much does this cost?"**  
A: Free if using Claude Code. Codex pricing depends on your setup.

---

## Next Steps

### Ready to Go Deeper?

- **[INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md)** — Detailed workflows by project phase
- **[AGENT_PERFORMANCE_BASELINES.md](AGENT_PERFORMANCE_BASELINES.md)** — What to expect from each agent
- **[AGENTS.md](AGENTS.md)** — Complete agent catalog with descriptions
- **[README_ANCLORA.md](README_ANCLORA.md)** — Setup, maintenance, and architecture

### Report an Issue

If an agent isn't working as expected, see [AGENT_CHANGELOG.md](AGENT_CHANGELOG.md#reporting-agent-issues).

---

## Keyboard Shortcut (Claude Code)

After installing agents, you can use them instantly:

```
⌘ + K (Mac) / Ctrl + K (Windows)  →  Type agent name or prompt  →  Enter
```

---

**That's it!** Start with the 5 agents above, then explore `AGENTS.md` for specialized agents as you need them.

Happy building! 🚀
