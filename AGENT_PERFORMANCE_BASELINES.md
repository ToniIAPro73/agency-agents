# Agent Performance Baselines — Quality Standards for Anclora

**Purpose**: Define expected behavior for each agent category to ensure consistent quality  
**Updated**: 2026-06-10  
**Maintainer**: Anclora Engineering Team  
**Usage**: Use this for agent validation, training, and performance reviews

---

## What This Document Is

**Baselines** define the minimum acceptable behavior for each agent category. They serve as:
- ✅ Quality gates (did the agent meet expectations?)
- ✅ Training criteria (what should this agent do?)
- ✅ Regression detection (has agent quality drifted?)
- ✅ Documentation (what can I expect from this agent?)

Each baseline includes:
- **Core Responsibilities** — what the agent owns
- **Should Always** — non-negotiable behaviors
- **Should Never** — red-line violations
- **Key Deliverables** — output format/structure
- **Example Scenarios** — how to trigger expected behavior

---

## Engineering Division

### Backend Architect

**Core Responsibilities**: API design, database architecture, scalability, system reliability

#### ✅ Should Always
- [ ] Propose multiple options (REST, gRPC, GraphQL) with trade-offs
- [ ] Include database schema design with normalization notes
- [ ] Consider scalability from day 1 (assume 100K+ concurrent users)
- [ ] Document API versioning strategy
- [ ] Mention caching strategies (Redis, CDN, HTTP caching)
- [ ] Address concurrency and race conditions
- [ ] Include error handling and status codes
- [ ] Consider backward compatibility
- [ ] Mention monitoring and observability points

#### ❌ Should Never
- [ ] Recommend monoliths for 1M+ user systems (break into microservices)
- [ ] Ignore database transaction semantics
- [ ] Propose architectures without failover strategy
- [ ] Suggest single points of failure
- [ ] Ignore cost implications at scale
- [ ] Design APIs without rate limiting consideration

#### 📦 Key Deliverables
```
1. Architecture diagram (ASCII or description)
2. API specification (endpoint list + schemas)
3. Database schema (tables + relationships)
4. Scaling assumptions (user count, RPS, data volume)
5. Failure modes and recovery strategies
6. Technology stack recommendation with rationale
```

#### 🎯 Example Scenario
```
Prompt: "Design an API for a real-time chat application with 1M daily active users."

Expected response:
- REST vs WebSocket discussion (WebSocket for real-time)
- Message database design (sharding strategy)
- Presence/typing indicator system
- Rate limiting (prevent spam)
- Archival strategy for old messages
- Monitoring points (latency, error rates, connection drops)
```

**Baseline Quality**: Each response includes 6+ architectural decisions with reasoning.

---

### Frontend Developer

**Core Responsibilities**: React/Vue/Angular implementation, performance, accessibility, UX

#### ✅ Should Always
- [ ] Use functional components + hooks (React 19 patterns)
- [ ] Include accessibility considerations (a11y)
- [ ] Mention performance optimizations (memoization, code splitting, lazy loading)
- [ ] Consider mobile-first responsive design
- [ ] Include error boundaries and error states
- [ ] Document prop interfaces and TypeScript types
- [ ] Mention testing strategy (React Testing Library)
- [ ] Consider state management (Redux, Zustand, Context)
- [ ] Address SEO/meta tags for public pages

#### ❌ Should Never
- [ ] Suggest class components in new code
- [ ] Ignore accessibility (color contrast, ARIA labels, keyboard nav)
- [ ] Propose designs without mobile support
- [ ] Ignore Core Web Vitals (LCP, FID, CLS)
- [ ] Suggest direct DOM manipulation (use React APIs)
- [ ] Design without considering error states

#### 📦 Key Deliverables
```
1. Component architecture (hierarchy + responsibilities)
2. TypeScript interfaces for props
3. State management strategy
4. Performance optimization checklist
5. Accessibility review (WCAG 2.1 AA)
6. Testing strategy (component + integration)
```

#### 🎯 Example Scenario
```
Prompt: "Build a real-time dashboard showing 1000+ data points updating every second."

Expected response:
- Virtual scrolling (only render visible items)
- WebSocket for real-time updates
- React.memo for expensive components
- Canvas/SVG for large datasets instead of DOM
- Debouncing/throttling for updates
- Performance monitoring (Lighthouse, Web Vitals)
```

**Baseline Quality**: Every response includes 5+ performance optimizations specific to scale.

---

### Code Reviewer

**Core Responsibilities**: Code quality, security, performance, test coverage, maintainability

#### ✅ Should Always
- [ ] Check for logic errors and edge cases
- [ ] Identify security vulnerabilities (OWASP Top 10)
- [ ] Review test coverage (line + branch coverage)
- [ ] Assess performance implications
- [ ] Check for code duplication (DRY principle)
- [ ] Verify error handling
- [ ] Review naming clarity
- [ ] Check for type safety (TypeScript)
- [ ] Mention documentation gaps

#### ❌ Should Never
- [ ] Approve code without checking for null pointer exceptions
- [ ] Miss SQL injection vulnerabilities
- [ ] Ignore missing error handling
- [ ] Approve code without test coverage
- [ ] Allow code with hardcoded secrets or credentials
- [ ] Miss race conditions or concurrency bugs
- [ ] Approve code that breaks existing tests

#### 📦 Key Deliverables
```
1. Summary of findings (high/medium/low severity)
2. Security issues with CVSS scores
3. Performance concerns with impact assessment
4. Test coverage gaps with recommendations
5. Code quality issues (duplication, naming, complexity)
6. Specific line-by-line feedback
```

#### 🎯 Example Scenario
```
Prompt: "Review this login endpoint implementation."

Expected response:
- SQL injection risk if using string concatenation (use parameterized queries)
- Missing password hashing validation
- Missing rate limiting on login attempts
- Missing logging for security audits
- Test coverage for success + failure cases
- Timing attack vulnerability if not using constant-time comparison
```

**Baseline Quality**: Every code review includes 5+ specific, actionable issues.

---

### AI Engineer

**Core Responsibilities**: ML model integration, prompt engineering, LLM deployment, RAG systems

#### ✅ Should Always
- [ ] Include prompt engineering best practices (chain-of-thought, few-shot)
- [ ] Discuss token budgets and cost implications
- [ ] Address model selection (Opus/Sonnet/Haiku trade-offs)
- [ ] Include fallback strategies for API failures
- [ ] Document RAG/retrieval strategy
- [ ] Mention safety guardrails (jailbreak prevention)
- [ ] Include evaluation metrics for model quality
- [ ] Address latency and throughput requirements
- [ ] Mention fine-tuning vs. prompt engineering trade-offs

#### ❌ Should Never
- [ ] Ignore token costs in deployment
- [ ] Deploy without fallback mechanisms
- [ ] Suggest overly complex prompts without justification
- [ ] Ignore hallucination risks
- [ ] Deploy without testing adversarial inputs
- [ ] Miss context window limitations

#### 📦 Key Deliverables
```
1. Model recommendation with trade-offs
2. Prompt templates (chain-of-thought, few-shot examples)
3. Token budget analysis
4. Cost estimation ($/1000 tokens × expected volume)
5. Evaluation strategy (accuracy, latency, hallucination rate)
6. Fallback and error recovery approach
```

#### 🎯 Example Scenario
```
Prompt: "Integrate Claude into our customer support system for 10K queries/day."

Expected response:
- Model choice: Opus for quality vs Sonnet for cost/speed
- Prompt: System message + few-shot examples + user query structure
- Token budget: ~500 tokens per response × 10K queries × ~$0.003 = ~$15/day
- Fallback: Escalate to human if confidence < 0.8
- Evaluation: Track resolution rate, customer satisfaction, hallucination rate
```

**Baseline Quality**: Includes cost analysis, prompt engineering, and evaluation strategy.

---

## Security Division

### Security Architect

**Core Responsibilities**: Threat modeling, secure architecture, compliance, vulnerability assessment

#### ✅ Should Always
- [ ] Create threat models (STRIDE, PASTA, or similar)
- [ ] Identify attack vectors and probability/impact
- [ ] Document defense mechanisms for each threat
- [ ] Address authentication and authorization
- [ ] Include encryption requirements (at-rest, in-transit)
- [ ] Consider compliance requirements (GDPR, CCPA, SOC 2)
- [ ] Mention supply chain risks
- [ ] Include incident response procedures
- [ ] Address secrets management

#### ❌ Should Never
- [ ] Ignore privilege escalation paths
- [ ] Miss injection attack vectors (SQL, command, XSS)
- [ ] Suggest security-by-obscurity
- [ ] Ignore authentication bypass opportunities
- [ ] Skip encryption for sensitive data
- [ ] Overlook API authentication gaps

#### 📦 Key Deliverables
```
1. Threat model (threats × likelihood × impact)
2. Attack surface analysis
3. Mitigation strategies for top-N risks
4. Compliance checklist
5. Incident response plan
6. Secrets management strategy
```

#### 🎯 Example Scenario
```
Prompt: "Threat model this API that handles payment data."

Expected response:
- PCI DSS compliance requirements
- Man-in-the-middle attacks (require TLS 1.3)
- Injection attacks (parameterized queries, input validation)
- Insider threats (audit logging, access controls)
- Data exposure (encryption, secure storage)
- DDoS mitigation (rate limiting, WAF)
- Supply chain risk (dependency scanning)
```

**Baseline Quality**: Addresses 8+ threat categories with specific mitigations.

---

## Product Division

### Product Manager

**Core Responsibilities**: Requirements validation, prioritization, roadmapping, stakeholder alignment

#### ✅ Should Always
- [ ] Ask clarifying questions about the problem
- [ ] Identify user personas and jobs-to-be-done
- [ ] Validate assumptions (don't assume you know the problem)
- [ ] Propose MVP scope (minimum viable product)
- [ ] Consider dependencies and sequencing
- [ ] Include success metrics and KPIs
- [ ] Address competitive positioning
- [ ] Mention risks (technical, market, execution)
- [ ] Document trade-offs with reasoning

#### ❌ Should Never
- [ ] Accept vague requirements without clarification
- [ ] Propose features without understanding user needs
- [ ] Ignore technical constraints
- [ ] Suggest unlimited scope
- [ ] Skip competitor analysis
- [ ] Ignore market validation

#### 📦 Key Deliverables
```
1. Problem statement (what are we solving?)
2. User personas and jobs-to-be-done
3. MVP definition (1-2 week sprint)
4. Success metrics (engagement, retention, NPS)
5. Competitive landscape
6. Risks and mitigation
7. Roadmap (phases, timeline, dependencies)
```

#### 🎯 Example Scenario
```
Prompt: "We want to build a productivity app for teams. What questions do you have?"

Expected response:
- Who is the user? (solo founders, 10-person teams, enterprises?)
- What specific problem are we solving? (task management, time tracking, collaboration?)
- Why existing tools (Asana, Monday, Notion)? What gap are we filling?
- What's the go-to-market? (B2B, B2C, SMB, enterprise?)
- What's the MVP? (task creation + sharing? or full collaboration?)
- Success metrics? (DAU, retention, NPS?)
- Competitive risks? (existing players, feature parity?)
```

**Baseline Quality**: Asks 5+ clarifying questions before proposing solution.

---

## Testing Division

### API Tester

**Core Responsibilities**: API validation, performance testing, integration testing, compliance

#### ✅ Should Always
- [ ] Test happy path (successful requests)
- [ ] Test error cases (400, 401, 403, 404, 500, etc.)
- [ ] Test edge cases (empty input, max input, null, special chars)
- [ ] Validate response schema (types, required fields)
- [ ] Check status codes and error messages
- [ ] Test rate limiting
- [ ] Test authentication and authorization
- [ ] Performance testing (latency, throughput under load)
- [ ] Test API versioning and backward compatibility

#### ❌ Should Never
- [ ] Test only the happy path
- [ ] Ignore error states
- [ ] Skip authentication testing
- [ ] Test without load testing
- [ ] Ignore response validation
- [ ] Test without documenting expected behavior

#### 📦 Key Deliverables
```
1. Test plan (happy path, error cases, edge cases)
2. API test suite (Happy path, HTTP status codes, error messages)
3. Performance benchmarks (latency, throughput, concurrency)
4. Load test results (behavior under stress)
5. Security test results (auth, rate limiting, input validation)
6. Test coverage report
```

#### 🎯 Example Scenario
```
Prompt: "Create tests for GET /api/users/{id}"

Expected response:
- 200: Valid user ID returns correct user object
- 404: Invalid user ID returns 404 with error message
- 401: Unauthenticated request returns 401
- 403: User without permission returns 403
- 400: Invalid ID format returns 400
- Performance: P95 latency < 100ms under 1000 req/s
- Rate limiting: 5000 req/hour per API key
- Response schema validation
```

**Baseline Quality**: Tests 8+ scenarios including happy path, errors, edge cases, and performance.

---

## Documentation Division

### Technical Writer

**Core Responsibilities**: API documentation, README clarity, code examples, runbook creation

#### ✅ Should Always
- [ ] Document API endpoints (path, method, params, response)
- [ ] Include code examples for every major feature
- [ ] Provide setup/installation instructions
- [ ] Document error codes and what to do
- [ ] Include architecture diagrams
- [ ] Write clear variable/function descriptions
- [ ] Provide troubleshooting sections
- [ ] Include FAQ for common questions
- [ ] Document breaking changes

#### ❌ Should Never
- [ ] Document without examples
- [ ] Use jargon without explanation
- [ ] Write overly long paragraphs (max 3 sentences)
- [ ] Ignore version compatibility
- [ ] Skip prerequisite documentation
- [ ] Document without audience in mind

#### 📦 Key Deliverables
```
1. API reference (every endpoint documented)
2. Getting started guide (5-min quickstart)
3. Architecture documentation (system design)
4. Code examples (copy-paste ready)
5. Troubleshooting section
6. FAQ section
7. Breaking changes log
```

#### 🎯 Example Scenario
```
Prompt: "Document this GraphQL API"

Expected response:
- Overview (what can you do with this API?)
- Authentication (how do I authenticate?)
- Getting started (5-min example query)
- Mutation examples (create, update, delete)
- Error handling (what errors can occur?)
- Rate limiting (what are the limits?)
- Pagination (how to paginate results?)
- Subscriptions (if applicable)
- Changelog (what changed recently?)
```

**Baseline Quality**: Includes 5+ code examples with actual syntax highlighting.

---

## Quality Gate Checklist

Use this to validate if an agent response meets baseline standards:

### For ANY Agent Response, Check:
- [ ] **Specificity**: Response is specific to the problem, not generic
- [ ] **Actionability**: I can take action immediately, not just read theory
- [ ] **Examples**: Includes concrete code/output examples
- [ ] **Trade-offs**: Acknowledges trade-offs and constraints
- [ ] **Completeness**: Addresses the core question fully
- [ ] **Clarity**: Uses plain language, avoids unnecessary jargon
- [ ] **Structure**: Organized with headers/lists for scannability
- [ ] **Correctness**: Technical accuracy (verify with docs if unsure)

### Agent-Specific Quality Checks:
- **Backend Architect**: Includes 3+ architectural options with trade-offs?
- **Frontend Developer**: Addresses performance and accessibility?
- **Code Reviewer**: Identifies 5+ specific issues with solutions?
- **AI Engineer**: Includes cost analysis and evaluation metrics?
- **Security Architect**: Identifies threats and mitigations?
- **Product Manager**: Asks clarifying questions before proposing solution?
- **API Tester**: Tests happy path, errors, edge cases, and performance?
- **Technical Writer**: Includes code examples and troubleshooting?

---

## Regression Detection

If an agent's response is notably worse than baseline, investigate:

1. **Prompt quality**: Is the prompt too vague or missing context?
2. **Agent drift**: Has the agent description changed unintentionally?
3. **System state**: Are there system-level issues (API failures, rate limits)?
4. **Knowledge gaps**: Has the agent's training data become stale?

**Recovery process**:
```bash
1. Document the issue with example inputs/outputs
2. Review agent definition in /*/agent-name.md
3. Test with clarified prompt
4. If still failing, consider agent refresh/retraining
5. Update AGENT_CHANGELOG.md with findings
```

---

## Continuous Improvement

### Monthly Review Cycle

1. **Week 1**: Collect agent usage metrics and feedback
2. **Week 2**: Identify agents with quality drift
3. **Week 3**: Update baselines if standards changed
4. **Week 4**: Publish improvements and communicate to team

### Annual Audit

Every 12 months:
- Review all agent baselines for accuracy
- Update based on new tools/standards in industry
- Test all agents against latest baselines
- Publish Agent Performance Report

---

## Related Documents

- [AGENTS.md](AGENTS.md) — Agent catalog and descriptions
- [INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md) — How to use agents
- [ANCLORA_ASSESSMENT.md](ANCLORA_ASSESSMENT.md) — Integration assessment
- [VALIDATION.md](VALIDATION.md) — Installation validation checklist

---

## Questions?

- **"How do I use this?"** → Use the Quality Gate Checklist for every agent interaction
- **"Can I modify these baselines?"** → Yes, but document changes in AGENT_CHANGELOG.md
- **"What if an agent fails the baseline?"** → File an issue with the problem scenario + expected behavior

---

**Document maintained**: Anclora Engineering Team  
**Last updated**: 2026-06-10  
**Next review**: 2027-06-10 (annual audit)
