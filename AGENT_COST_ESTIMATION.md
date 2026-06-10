# Agent Cost Estimation & Budget Forecasting

**Purpose**: Estimate per-agent costs, forecast budgets, optimize spending  
**Updated**: 2026-06-10  
**Status**: MEDIUM PRIORITY (implement after HIGH PRIORITY features)

---

## Why Cost Tracking Matters

Teams need to:
- 💰 Budget for Claude API usage (Sonnet/Opus per M tokens)
- 📊 Track which agents are expensive
- 🎯 Optimize without sacrificing quality
- 📈 Forecast costs as team scales
- 🔍 Identify runaway usage

---

## Baseline Cost Data

### Token Consumption by Agent Category

| Agent | Model | Avg Tokens/Response | Cost/Response |
| --- | --- | --- | --- |
| **Backend Architect** | Sonnet | 1,200 | $0.0036 |
| **Frontend Developer** | Sonnet | 900 | $0.0027 |
| **Code Reviewer** | Sonnet | 1,600 | $0.0048 |
| **Product Manager** | Sonnet | 800 | $0.0024 |
| **Security Architect** | Sonnet | 2,000 | $0.0060 |
| **API Tester** | Sonnet | 1,400 | $0.0042 |
| **Technical Writer** | Sonnet | 1,100 | $0.0033 |
| **Software Architect** | Opus | 2,500 | $0.0075 |
| **AI Engineer** | Opus | 3,000 | $0.0090 |

**Note**: Prices based on Claude Sonnet $3/M input tokens, Opus $9/M

---

## Cost Calculator

### Per-Use Cost Formula

```
Cost = (Input Tokens + Output Tokens) / 1,000,000 × Rate
     = Tokens/Response × (1/1M) × Rate
```

**Example: Backend Architect (Sonnet)**
```
Tokens: 1,200
Cost per response: 1,200 × ($3/1M) = $0.0036
Monthly (20 uses): $0.0036 × 20 = $0.072
```

### Team Cost Forecasting

```
Team Size: 5 developers
Agents per dev per day: 2 (architecture review + code review)
Team agents per day: 10

Daily cost: 10 × $0.0036 (backend-architect avg) = $0.036
Monthly cost: $0.036 × 22 working days = $0.79
Yearly cost: $0.79 × 12 = $9.50 per developer
```

**For 5-person team**: ~$50/year in agent costs (negligible)

---

## Agent Cost Tiers

### Low Cost (< $0.003/response)

```markdown
- Product Manager: $0.0024
- Frontend Developer: $0.0027

Use freely. Minimal budget impact.
```

### Medium Cost ($0.003 - $0.006)

```markdown
- Backend Architect: $0.0036
- Code Reviewer: $0.0048
- API Tester: $0.0042
- Technical Writer: $0.0033
- Security Architect: $0.0060 (edge of medium)

Budget ~$50-100/month for 5-person team active usage
```

### High Cost (> $0.006/response)

```markdown
- Software Architect (Opus): $0.0075
- AI Engineer (Opus): $0.0090

Reserve for complex tasks. Monitor usage.
Use Sonnet version if available.
```

---

## Usage Tracking Template

Add to AGENT_CHANGELOG.md or separate file:

```yaml
# Agent Cost History (Monthly)

2026-06:
  team_size: 5
  active_users: 3
  
  usage:
    backend-architect:
      calls: 24
      avg_tokens: 1200
      cost: $0.086
    
    code-reviewer:
      calls: 40
      avg_tokens: 1600
      cost: $0.192
    
    frontend-developer:
      calls: 18
      avg_tokens: 900
      cost: $0.049
  
  total_cost: $0.327
  cost_per_developer: $0.065
  cost_per_call: $0.0041 (average)

trends:
  - code-reviewer usage trending up (+50% vs May)
  - backend-architect stable
  - token count decreasing (agents improving efficiency)
```

---

## Cost Optimization Strategies

### 1. Use Sonnet over Opus (When Possible)

```
Opus: $0.015/M input tokens
Sonnet: $0.003/M input tokens
= 5x cheaper

Recommendation: Use Sonnet for most tasks, Opus only for:
- Complex system architecture (Software Architect)
- Challenging ML/AI design (AI Engineer)
```

### 2. Batch Requests (When Possible)

```markdown
## Instead of:
codex ask --agent "code-reviewer" "Review function A"
codex ask --agent "code-reviewer" "Review function B"
codex ask --agent "code-reviewer" "Review function C"

## Do this:
codex ask --agent "code-reviewer" "Review these 3 functions: A, B, C"

Savings: ~40% tokens (less repetition of instructions)
```

### 3. Use Baseline Versions (Not Cutting Edge)

```markdown
- v3.0.0-beta might be 20% more tokens (testing new features)
- v3.0.0 (stable) is 5% more efficient than v2.5.0
- v2.5.0 (old) is cheapest but missing features

Recommendation: Use latest stable MINOR version for cost + features balance
```

### 4. Cache Common Prompts

GitHub Actions with cached instructions:

```yaml
- name: Code Review (Cached)
  run: |
    # Reusable prompt cached, tokens saved on repetition
    codex ask --agent "code-reviewer" \
      "--cache" \
      "Review PR following ANCLORA standards"
```

---

## Monthly Budget Template

### For Small Team (2-5 developers)

```markdown
## Q3 2026 Agent Budget Forecast

Agents Used:
- Product Manager: 10 calls/month × $0.0024 = $0.024
- Backend Architect: 15 calls/month × $0.0036 = $0.054
- Code Reviewer: 30 calls/month × $0.0048 = $0.144
- Frontend Developer: 10 calls/month × $0.0027 = $0.027

Monthly budget: $0.25
Quarterly budget: $0.75
Annual budget: $3.00

Cost per developer: $0.60/year (negligible)
Cost as % of Claude subscription: <0.1%
```

### For Medium Team (5-20 developers)

```markdown
## Annual Agent Cost Forecast

Team: 10 developers, 3 projects active

Monthly usage estimate:
- 100 agent calls/month (average team)
- Average cost/call: $0.004

Monthly: 100 × $0.004 = $0.40
Annual: $0.40 × 12 = $4.80

Cost per developer: $0.48/year (negligible)
Optimization potential: Switch 30% from Opus to Sonnet = $1.44/year savings
```

---

## Cost Anomaly Detection

### Red Flags (Investigate These)

```yaml
anomalies:
  high_token_count: "Agent using >3000 tokens consistently"
  high_error_rate: "Many requests returning errors (wasted tokens)"
  beta_agent_surge: "v3.0.0-beta using 50% more tokens than stable"
  
response:
  1. Verify agent version (may need downgrade)
  2. Check prompt length (may be too verbose)
  3. Monitor next week (may be temporary spike)
  4. Report to team (update agent or strategy)
```

### Example

```markdown
## June 2026 Anomaly Report

**Alert**: Security Architect token usage 40% higher than normal

Root Cause: Updated v2.5.0 → v3.0.0-beta (new features)

Action:
- Revert to v2.5.0 until v3.0.0 stable released
- Saves: $0.015/call × 20 calls = $0.30/month
```

---

## Optimization Checklist

### Quarterly Review

- [ ] Calculate actual vs. forecasted costs
- [ ] Identify high-cost agents
- [ ] Check for agent version upgrades that increased tokens
- [ ] Review team usage patterns
- [ ] Update cost forecast for next quarter
- [ ] Identify optimization opportunities

### Monthly Monitoring

- [ ] Track agent calls per developer
- [ ] Monitor for anomalies (>20% deviation)
- [ ] Check for agents with low ROI (rarely used, expensive)
- [ ] Confirm budget tracking is accurate

---

## Cost-Benefit Analysis

### Example: Should we use Software Architect (Opus)?

```markdown
## Cost-Benefit: Software Architect (Opus)

**Cost**: $0.0075 per response
**Benefit**: Prevents $50K+ architecture mistakes

**Example**: One team prevented a wrong database choice by using agent
- Without agent: 2 weeks wasted rework = $2K
- With agent: 1 hour to get expert architecture = $0.0075
- ROI: 250x

**Conclusion**: Always worth it for major architecture decisions
```

---

## Billing Integration

### If using Claude API Billing

Track in your invoicing:

```yaml
# Monthly Invoice Line Item

Service: Agency Agents (Development Tools)
Unit: 1M tokens processed
Volume: 2.5M tokens used by team
Rate: $3/M tokens (Sonnet average)
Amount: $7.50

Detail:
  - Backend Architect: 1.2M tokens
  - Code Reviewer: 0.8M tokens
  - Other agents: 0.5M tokens
```

---

## Cost Forecasting Template

```markdown
# FY2027 Agent Cost Forecast

## Assumptions
- Team grows from 5 to 10 developers (June 2027)
- Agent adoption increases 20% per quarter
- Average cost per call: $0.004 (Sonnet mix)

## Quarterly Forecast

Q1 2027: 400 calls × $0.004 = $1.60
Q2 2027: 480 calls × $0.004 = $1.92 (team grows)
Q3 2027: 550 calls × $0.004 = $2.20 (higher adoption)
Q4 2027: 650 calls × $0.004 = $2.60 (holiday productivity)

**Annual 2027 Total**: $8.32

**Per Developer** (10 dev average): $0.83/year
**As % of Claude subscription**: 0.02%

## Optimization Opportunities
- Switch 40% usage to Sonnet (save $1.50/year)
- Batch requests more aggressively (save $0.80/year)
- **Total potential savings**: $2.30/year (28% reduction)
```

---

## Transparency & Team Communication

### Share with Team

```markdown
## Transparency Report: Agent Costs

**The good news**: Agent usage is extremely cheap!

Monthly cost for team: ~$0.50
Cost per developer: ~$0.10 (coffee money)
Cost as % of Claude subscription: <0.1%

**Optimize, but don't worry**: 
- Use agents freely; costs are negligible
- Prefer Sonnet over Opus when possible
- Batch similar requests
- Report anomalies

No budget concerns with current usage patterns.
```

---

## Related Documents

- [AGENT_PERFORMANCE_BASELINES.md](AGENT_PERFORMANCE_BASELINES.md) — Quality standards
- [AGENT_CHANGELOG.md](AGENT_CHANGELOG.md) — Version history (tokens tracked per version)
- [AGENT_VERSIONING_STRATEGY.md](AGENT_VERSIONING_STRATEGY.md) — Version cost comparison

---

## Summary

| Metric | Value |
| --- | --- |
| **Avg cost/response** | $0.004 (Sonnet) |
| **Cost per developer/year** | <$1 |
| **Team of 5/year** | ~$3-5 |
| **Optimization potential** | 20-30% |
| **Billing complexity** | Minimal (negligible line item) |
| **Budget concern level** | Very low ✅ |

**Bottom line**: Agents are so cheap that cost optimization is secondary to quality and productivity.

---

**Status**: Ready to implement  
**Timeline**: Implement for tracking + transparency  
**Impact**: Budget predictability, cost awareness, optimization opportunities
