# Token Reduction Implementation Architecture

**Practical integration guide for centralized agent invocation with automatic token optimization.**

---

## 🏗️ Centralized Wrapper Approach

Instead of modifying each agent, create ONE central `invoke_agent()` wrapper that handles:
- Prompt caching
- Token budgets & enforcement
- Haiku triage for routing
- Token logging & monitoring

```
User Request
    ↓
invoke_agent() [WRAPPER] ← All intelligence here
    ├→ 1. Check budget (can we proceed?)
    ├→ 2. Haiku triage (which agent + model?)
    ├→ 3. Call agent with caching enabled
    ├→ 4. Log tokens used
    └→ Response
```

---

## 📁 File Structure

```
anclora-agents/
├── agents/
│   ├── core/
│   │   ├── __init__.py
│   │   ├── invoke.py                 ← THE WRAPPER (new)
│   │   ├── cache.py                  ← Caching logic
│   │   ├── budget.py                 ← Budget enforcement
│   │   ├── triage.py                 ← Haiku routing
│   │   └── logging.py                ← Token tracking
│   ├── code-reviewer.md
│   ├── backend-architect.md
│   └── [other agents...]
└── config/
    └── token-budgets.yaml
```

---

## 🔧 Implementation: The Wrapper

### File: `agents/core/invoke.py`

```python
from anthropic import Anthropic
from .cache import enable_caching
from .budget import enforce_budget
from .triage import classify_and_route
from .logging import log_token_usage

class AgentInvoker:
    def __init__(self, config_path="config/token-budgets.yaml"):
        self.client = Anthropic()
        self.budget = enforce_budget(config_path)
        self.logger = log_token_usage()

    def invoke(self, user_request: str) -> dict:
        """
        Single entry point for ALL agent invocations.
        Applies: budgeting, triage, caching, logging automatically.
        """
        
        # Step 1: Check if we have budget
        if not self.budget.can_proceed(user_request):
            return {"error": "Token budget exceeded", "status": 429}
        
        # Step 2: Triage to correct agent + model
        agent_name, model = classify_and_route(user_request)
        agent_prompt = self._load_agent(agent_name)
        
        # Step 3: Call with caching + budget limits
        response = self.client.messages.create(
            model=model,
            max_tokens=2048,
            system=[
                {
                    "type": "text",
                    "text": agent_prompt,
                    "cache_control": {"type": "ephemeral"}  # ← CACHING
                }
            ],
            messages=[{"role": "user", "content": user_request}]
        )
        
        # Step 4: Log and return
        tokens_in = response.usage.input_tokens
        tokens_out = response.usage.output_tokens
        self.logger.log_call(agent_name, tokens_in, tokens_out, model)
        self.budget.deduct(tokens_in + tokens_out)
        
        return {
            "agent": agent_name,
            "model": model,
            "response": response.content[0].text,
            "tokens_used": tokens_in + tokens_out,
            "cache_hits": response.usage.cache_read_input_tokens,
            "status": 200
        }

# Global instance for easy access
_invoker = None

def get_invoker():
    global _invoker
    if _invoker is None:
        _invoker = AgentInvoker()
    return _invoker

def invoke_agent(user_request: str) -> dict:
    """Public API: Single function users call."""
    return get_invoker().invoke(user_request)
```

---

## 🔌 Integration with Claude Code / Codex

Users would invoke agents like this:

```python
# In Claude Code or any Python environment
from anclora_agents.core import invoke_agent

# Instead of: agent_instance.invoke(prompt)
# Now: single centralized entry point
response = invoke_agent("Review this Python function for security issues")

print(f"Response: {response['response']}")
print(f"Tokens: {response['tokens_used']}")
print(f"Cache hits: {response['cache_hits']}")
```

---

## 📊 Token Flow (Per Invocation)

```
invoke_agent("Review this code...")
    ├─ Check budget: "Do we have 1,500 tokens?"
    │  └─ YES: proceed | NO: return error
    │
    ├─ Triage with Haiku (100 tokens, cheap):
    │  "This looks like code-review → use Sonnet"
    │
    ├─ Call code-reviewer agent:
    │  ├─ System prompt: 500 tokens (cached from last call)
    │  │  └─ Cache HIT: read_tokens = 500 (cost: 0.1x)
    │  ├─ User input: 400 tokens
    │  └─ Response: 600 tokens (cached on write)
    │
    ├─ Total charged: 100 (triage) + 400 (input) + 600 (output) = 1,100
    │  └─ Savings vs. no-cache: 500 * 0.9 = 450 tokens saved
    │
    ├─ Deduct from budget: monthly_limit -= 1,100
    │
    └─ Log entry: agent=code-reviewer, tokens=1100, model=sonnet, cache_hits=500
```

---

## 🎯 Benefits of Centralized Wrapper

| Aspect | Before | After |
| --------- | --------- | --------- |
| **Token tracking** | Manual per-agent | Automatic, global |
| **Budget enforcement** | None | Built-in, per-team |
| **Caching** | Manual per-agent | Automatic for all |
| **Haiku triage** | None | Automatic routing |
| **Model selection** | Manual | Intelligent (Haiku/Sonnet/Opus) |
| **Token logging** | Scattered | Single CSV file |
| **Agent changes** | Required | None needed |

---

## 🚀 Deployment Steps

### Week 1: Build Wrapper
1. Create `agents/core/invoke.py` (200 lines)
2. Create `agents/core/cache.py` (50 lines)
3. Create `agents/core/budget.py` (100 lines)
4. Create `agents/core/triage.py` (150 lines)
5. Create `agents/core/logging.py` (80 lines)
6. Create `config/token-budgets.yaml`

### Week 2: Test & Validate
1. Unit tests for each module
2. Integration test: invoke 5 different agents
3. Verify caching is working (cache_read_input_tokens > 0)
4. Verify budgets enforce correctly
5. Verify logging is accurate

### Week 3: Rollout
1. Update README to point to `invoke_agent()`
2. Migrate all manual invocations → wrapper
3. Monitor token usage in first week
4. Measure: Actual savings vs. projected (target: 25-30%)

---

## 📈 Metrics to Track

**Per invocation**:
- `tokens_in`, `tokens_out`, `cache_hits`
- Agent used, model chosen
- Budget remaining

**Daily**:
- Total tokens consumed
- Cache hit rate (cache_hits / total_input)
- Budget utilization %
- Cost per agent

**Monthly**:
- Actual savings vs. baseline
- Most expensive agents
- Budget vs. forecast

---

## ⚠️ Edge Cases

### What if budget is exceeded?
```python
if not budget.can_proceed(request):
    return {
        "error": "Token budget exceeded",
        "budget_limit": 50000,
        "used_today": 48900,
        "remaining": 1100,
        "status": 429
    }
```

### What if triage fails?
```python
# Fallback to claude (safest model)
if confidence < 0.7:
    agent_name, model = "claude", "sonnet"
```

### What if caching not supported?
```python
# Graceful fallback for older models
if model not in ["sonnet", "opus", "haiku"]:
    # Don't add cache_control
    response = client.messages.create(...)
else:
    response = client.messages.create(..., system=[{"cache_control": ...}])
```

---

## 🔗 Related Documentation

- [QUICK_START_TOKEN_REDUCTION.md](QUICK_START.md) — For manual setup
- [STRATEGY.md](STRATEGY.md) — Advanced strategies (Hermes integration)
- [config/token-budgets.yaml](../../config/token-budgets.yaml) — Budget configuration

---

**Status**: Ready for implementation
**Effort**: ~500 lines of Python, 1-2 weeks
**ROI**: 25-30% immediate, 55-65% with Hermes integration
