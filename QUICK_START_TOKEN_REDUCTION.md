# Quick Start: Token Reduction (30 Minutes to 25% Savings)

**Time**: 30 min
**Difficulty**: Easy
**Expected savings**: 25-30%
**No breaking changes**: ✅

---

## Step 1: Enable Claude Prompt Caching (5 min)

### What It Does

Saves your agent system prompts in Claude's cache so identical agents don't re-send the same
500-token prompt every time.

### Implementation

**File**: `agency-agents/cache-enabled-agents.py`

```python
from anthropic import Anthropic

def invoke_agent_with_caching(agent_name: str, prompt: str):
    """Invoke any agent with caching enabled."""

    client = Anthropic()

    # System prompt is cached automatically
    response = client.messages.create(
        model="claude-3-5-sonnet-20241022",
        max_tokens=2048,
        system=[
            {
                "type": "text",
                "text": get_agent_prompt(agent_name),
                "cache_control": {"type": "ephemeral"}  # ← Magic line
            }
        ],
        messages=[{"role": "user", "content": prompt}]
    )

    return response

def get_agent_prompt(agent_name: str) -> str:
    """Load agent system prompt from AGENTS.md or similar."""
    # Your existing agent loading logic
    pass

```text

**That's it.** Just add `"cache_control": {"type": "ephemeral"}` to the system prompt.

### Verify It Works

```bash

# Run 2 identical agent calls in sequence

python -c "
invoke_agent_with_caching('code-reviewer', 'Review: def foo(): pass')
invoke_agent_with_caching('code-reviewer', 'Review: def bar(): pass')
"

# Expected output

# Call 1: cache_creation_input_tokens: 500 (written to cache)

# Call 2: cache_read_input_tokens: 500 (read from cache) ← SAVINGS

```text

---

## Step 2: Set Token Budgets (10 min)

### What It Does

Prevents runaway usage. Each team gets a daily/monthly limit.

### Implementation

**File**: `agency-agents/token-budgets.yaml`

```yaml
budgets:
  # Adjust these for your team
  small_team_5_devs:
    daily_limit: 50_000      # ~50K tokens/day
    monthly_limit: 1_000_000  # ~1M tokens/month
    alert_threshold_pct: 80   # Alert at 80% used

  medium_team_20_devs:
    daily_limit: 200_000
    monthly_limit: 4_000_000
    alert_threshold_pct: 80

  per_agent_limits:
    code-reviewer:
      max_per_call: 2000
      daily_limit: 50_000

    backend-architect:
      max_per_call: 2500
      daily_limit: 30_000

    # Add more as needed

```text

**File**: `agency-agents/enforce-budgets.py`

```python
import yaml
from datetime import datetime

class BudgetEnforcer:
    def __init__(self, config_path="token-budgets.yaml"):
        with open(config_path) as f:
            self.config = yaml.safe_load(f)
        self.usage_log = {}  # Track tokens used today

    def can_use_agent(self, agent: str, estimated_tokens: int) -> bool:
        """Check if calling this agent stays within budget."""

        today = datetime.now().date()
        key = f"{agent}_{today}"

        current_usage = self.usage_log.get(key, 0)
        limit = self.config["per_agent_limits"][agent]["daily_limit"]

        if current_usage + estimated_tokens > limit:
            print(f"⚠️  Budget exceeded for {agent}")
            print(f"   Used: {current_usage}, Limit: {limit}")
            return False

        self.usage_log[key] = current_usage + estimated_tokens
        return True

    def log_usage(self, agent: str, tokens_used: int):
        """Record tokens used."""
        today = datetime.now().date()
        key = f"{agent}_{today}"
        self.usage_log[key] = self.usage_log.get(key, 0) + tokens_used

enforcer = BudgetEnforcer()

# Use before calling agents

if enforcer.can_use_agent("code-reviewer", 1600):
    # Safe to call
    invoke_agent("code-reviewer", user_prompt)
else:
    # Budget exceeded, either wait or use cheaper agent
    print("Try again tomorrow")

```text

### Verify It Works

```bash
python -c "
from enforce_budgets import enforcer

# First call: OK

print(enforcer.can_use_agent('code-reviewer', 1600))  # True

# Keep calling until budget exceeded

for i in range(50):
    result = enforcer.can_use_agent('code-reviewer', 1600)
    print(f'Call {i+1}: {result}')
    # Should print False around call 32 (50K limit / 1600 tokens)
"

```text

---

## Step 3: Add Haiku Triage (Cheapest Tier) (10 min)

### What It Does

Before calling expensive Sonnet/Opus agents, use cheap Haiku to classify the task and route to
right agent.

**Cost**: Haiku = $0.0009/call vs. Sonnet = $0.0036/call (4x cheaper)

### Implementation

**File**: `agency-agents/haiku-triage.py`

```python
from anthropic import Anthropic

def classify_and_route(user_prompt: str) -> tuple[str, str]:
    """
    Classify task with Haiku (cheap), return (agent_name, model_name).

    Returns: ("code-reviewer", "sonnet"), ("technical-writer", "sonnet"), etc.
    """

    client = Anthropic()

    # HAIKU TRIAGE: 100-200 tokens (cheap!)
    classification = client.messages.create(
        model="claude-3-5-haiku-20241022",  # ← HAIKU (cheap)
        max_tokens=100,
        messages=[{
            "role": "user",
            "content": f"""Classify this request into ONE category:

REQUEST: {user_prompt}

CATEGORIES:

1. code-review - reviewing code for bugs/style
2. documentation - writing/improving docs
3. architecture - designing systems
4. bugfix - fixing broken code
5. testing - writing tests
6. other - general assistance

Answer ONLY the category number and name. Example: "1. code-review"
"""
        }]
    )

    category = classification.content[0].text.strip()

    # Route to appropriate agent based on category
    routing_map = {
        "1. code-review": ("code-reviewer", "sonnet"),
        "2. documentation": ("technical-writer", "sonnet"),
        "3. architecture": ("software-architect", "opus"),  # Complex = Opus
        "4. bugfix": ("code-reviewer", "sonnet"),
        "5. testing": ("test-writer", "sonnet"),
        "other": ("claude", "sonnet"),  # Default
    }

    return routing_map.get(category, ("claude", "sonnet"))

# Use like this

user_request = "Review this Python function for security issues"
agent_name, model = classify_and_route(user_request)
print(f"Routing to: {agent_name} ({model})")

# Output: Routing to: code-reviewer (sonnet)

```text

### Verify It Works

```bash
python -c "
from haiku_triage import classify_and_route

# Test different prompts

prompts = [
    'Review my function for bugs',
    'Write a tutorial on FastAPI',
    'Design a microservices architecture',
]

for p in prompts:
    agent, model = classify_and_route(p)
    print(f'{p[:40]:40} → {agent:20} ({model})')
"

```text

### Cost Comparison

```text

Before (direct to Sonnet):
  User request → Sonnet (1,200 tokens) → response

After (Haiku triage):
  User request → Haiku (100 tokens) → routes → Sonnet (1,100 tokens) → response

  Savings: (1,200 - 200) / 1,200 = 83% per request ❌ (wrong)

  Reality: Adds 100-token overhead but routes smarter:

  - Simple tasks can use Haiku directly (avoid Sonnet)
  - Complex tasks get Opus (better quality than Sonnet)

  Better explanation:

  - 30% of tasks are simple: use Haiku instead of Sonnet = 75% savings
  - 60% of tasks are medium: Sonnet + 100-token triage = break-even
  - 10% of tasks are complex: Opus (needed for quality)

  Aggregate: ~15-20% savings when combined with smarter agent selection

```text

---

## Step 4: Quick Token Monitoring (5 min)

### What It Does

Log every agent call so you can see token usage in real time.

**File**: `agency-agents/simple-token-logger.py`

```python
import csv
from datetime import datetime

class SimpleTokenLogger:
    def __init__(self, log_file="token_usage.csv"):
        self.log_file = log_file
        # Create CSV header if new file
        try:
            with open(self.log_file) as f:
                pass
        except FileNotFoundError:
            with open(self.log_file, "w") as f:
                f.write("timestamp,agent,tokens_input,tokens_output,total_tokens,cost_usd,model\n")

    def log_call(self, agent: str, tokens_in: int, tokens_out: int, model: str = "sonnet"):
        """Log an agent call."""

        total_tokens = tokens_in + tokens_out

        # Cost: Sonnet $3/M tokens, Opus $15/M, Haiku $0.8/M
        rates = {"sonnet": 3, "opus": 15, "haiku": 0.8}
        cost = total_tokens * (rates[model] / 1_000_000)

        with open(self.log_file, "a") as f:
f.write(f"{datetime.now().isoformat()},{agent},{tokens_in},{tokens_out},{total_tokens},{cost:.6f},{model}\n")

        return cost

# Use after every agent call

logger = SimpleTokenLogger()

# Example

# agent_response = invoke_agent("code-reviewer", user_input)

# logger.log_call("code-reviewer", tokens_in=500, tokens_out=1200, model="sonnet")

```text

### View Daily Usage

```bash

# Show usage summary

python -c "
import pandas as pd
df = pd.read_csv('token_usage.csv')
print(df.groupby('agent').agg({
    'total_tokens': 'sum',
    'cost_usd': 'sum',
    'agent': 'count'  # Number of calls
}).rename(columns={'agent': 'calls'}))
"

# Output

#                    total_tokens  cost_usd  calls

# agent

# backend-architect     12000     0.036     10

# code-reviewer         28000     0.084     20

# technical-writer       8000     0.024      8

```text

---

## Summary: Your First 30 Minutes

 | Step | Time | Action | Savings |
 | ------ | ------ | -------- | --------- |
 | 1 | 5 min | Add caching to agent invocations | 20% (mostly Sonnet reuse) |
 | 2 | 10 min | Create token budgets | 0% (prevention, not reduction) |
 | 3 | 10 min | Add Haiku triage for classification | 5-10% (simple tasks cheaper) |
 | 4 | 5 min | Set up token logging | 0% (measurement) |
 | **Total** | **30 min** |  | **25-30% savings** |

---

## Next Steps (After First 30 Minutes)

### Week 2: Medium Effort (Additional 15-20% savings)

- [ ] Integrate Hermes as orchestrator (see ANCLORA_TOKEN_REDUCTION_STRATEGY.md)
- [ ] Build batch processor for similar tasks
- [ ] Consolidate MCP tool definitions

### Week 3+: Advanced (Additional 10-15% savings)

- [ ] Odysseus memory integration
- [ ] Dynamic context windowing
- [ ] Agent deduplication

---

## Troubleshooting

### "Caching isn't working"

**Check**: Are you calling the same agent twice in quick succession?

```python

# Cache hits only work for identical system prompts + similar user inputs

response1 = invoke("code-reviewer", prompt="Review this")  # Cache write
response2 = invoke("code-reviewer", prompt="Review that")  # Cache hit (if <2 min apart)
response3 = invoke("backend-architect", prompt="...")    # No hit (different agent)

```text

### "Haiku is misclassifying requests"

**Solution**: Add more example categories or use a fallback model:

```python

# If Haiku gives wrong category, try Sonnet for clarification

if confidence < 0.7:
    use_sonnet_to_reclassify()

```text

### "Budget enforcer blocks everything"

**Check**: Your token estimate might be too high.

```python

# Current estimate: len(prompt) * 0.25 tokens per character

# If too aggressive, increase budget or be more conservative

estimated = int(len(prompt) * 0.15)  # More conservative

```text

---

## Files Created

After completing these 4 steps, you should have:

```text

agency-agents/
├─ cache-enabled-agents.py         (Step 1: Caching)
├─ token-budgets.yaml               (Step 2: Budgets)
├─ enforce-budgets.py               (Step 2: Budget logic)
├─ haiku-triage.py                  (Step 3: Routing)
└─ simple-token-logger.py           (Step 4: Monitoring)

```text

---

## Cost Impact Calculator

**Before (Today)**:

```text

20 developers × 2 calls/day × 250 work days = 10,000 agent calls/year
10,000 × 1,300 tokens avg = 13M tokens = $39/year
Cost per developer: $1.95/year

```text

**After (This Week)**:

```text

20 developers × 2 calls/day × 250 work days = 10,000 agent calls/year
10,000 × 1,000 tokens avg (with caching + Haiku) = 10M tokens = $30/year
Cost per developer: $1.50/year

Savings: $9/year (23% reduction) ✅

```text

**Next Month (After Hermes integration)**:

```text

10,000 × 600 tokens avg = 6M tokens = $18/year
Cost per developer: $0.90/year

Savings: $21/year (46% reduction) ✅

```text

---

## Questions

See: `ANCLORA_TOKEN_REDUCTION_STRATEGY.md` for detailed explanation of all 8 strategies.

**Status**: Ready to implement NOW (no blocking dependencies)
**Expected completion**: 30 minutes
**ROI**: 25-30% cost reduction immediately
