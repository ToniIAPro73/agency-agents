# Product-Specific Examples — Using Agency Agents in Anclora Products

**Purpose**: Real-world examples of how to use agents in each Anclora product  
**Updated**: 2026-06-10  
**Status**: MEDIUM PRIORITY (implement after HIGH PRIORITY features)

---

## Overview

This guide shows concrete examples of how to use Agency Agents for specific Anclora products. Each product has unique requirements; these examples show how agents adapt.

---

## 1. Anclora Nexus — Real-time Conversion Hub

### What Nexus Does
Central platform for converting, coordinating, and supporting product flows.

### Recommended Agents & Workflows

#### Phase 1: Specification (Nexus Features)

**Feature**: Real-time notification system

```markdown
## SPEC.md — Real-time Notifications in Nexus

Use the Product Manager agent:
"Define the specification for a real-time notification system in Nexus.
Include: user notifications, admin broadcasts, delivery guarantees, 
mobile push notifications. Target users: 100K daily active, P95 latency <500ms"

Expected output: SPEC.md with acceptance criteria
```

#### Phase 2: Architecture

**Using Backend Architect + Database Optimizer**

```markdown
Use the Backend Architect agent:
"Design the real-time notification system for Nexus. 
Infrastructure: Vercel frontend, Render backend, Supabase database.
Requirements: 
- 100K concurrent users
- WebSocket for real-time delivery
- Batch email delivery
- Mobile push via Firebase

Include deployment strategy (staging → production)"

Use the Database Optimizer agent:
"Design the notification database schema for Supabase.
Consider: notifications table (100M+), delivery tracking, 
user preferences, batch scheduling"
```

#### Phase 3: Implementation

**Using Frontend Developer + Code Reviewer**

```markdown
Use the Frontend Developer agent:
"Implement the notification UI in Nexus React component.
Requirements: real-time WebSocket connection, 
notification center, preferences modal, 
accessibility (WCAG 2.1 AA)"

Use the Code Reviewer agent (before merge):
"Review this notification implementation against SPEC.
Check: Does it meet all acceptance criteria?"
```

---

## 2. Anclora SyncXML — Document Synchronization Service

### What SyncXML Does
XML document synchronization, ingestion, and processing.

### Recommended Agents & Workflows

#### Phase 1: Data Pipeline Specification

**Feature**: Mineru document ingestion

```markdown
Use the Product Manager agent:
"Specify the Mineru document ingestion feature for SyncXML.
Who: Legal teams, enterprise customers
What: Upload PDFs/documents, extract structured data, 
validate against schema
Requirements: 99.9% accuracy, <5 min processing for 100-page docs"

Use the Backend Architect agent:
"Design the document ingestion pipeline for SyncXML + Mineru.
Consider: async queue (Bull), storage (Vercel Blob), 
webhook callbacks, error recovery"
```

#### Phase 2: API Design

**Using Backend Architect + API Tester**

```markdown
Use the Backend Architect agent:
"Design REST API for document uploads in SyncXML.
Endpoints: POST /documents/upload, GET /documents/{id}/status, 
POST /documents/{id}/validate
Include: webhook callbacks for status updates"

Use the API Tester agent:
"Create comprehensive tests for the document upload API.
Test: valid PDF upload, invalid formats, 
concurrent uploads, webhook delivery"
```

#### Phase 3: Integration with Nexus

**Coordinated with Nexus team**

```markdown
Use the Agents Orchestrator agent:
"Design how SyncXML document ingestion integrates with Nexus 
conversion flows. Include: API contracts, 
error handling, retry logic, status notifications in Nexus UI"
```

---

## 3. Anclora Content Generator — AI-Powered Content Creation

### What It Does
Generate, optimize, and manage content at scale.

### Recommended Agents & Workflows

#### Phase 1: Content Strategy

**Feature**: Multi-language content generation

```markdown
Use the Product Manager agent:
"Define the multi-language content generation feature.
Support: English, Spanish, French, German, Portuguese
Requirements: 
- One click translation maintaining tone/brand voice
- SEO optimization per language
- Cultural adaptation (not just translation)
- Delivery: <30 seconds per language"

Use the AI Engineer agent:
"Design the multi-language LLM pipeline.
Approach: Translation model + cultural adaptation + 
brand voice fine-tuning. Consider: cost, latency, quality"
```

#### Phase 2: Implementation

**Using AI Engineer + Frontend Developer**

```markdown
Use the AI Engineer agent:
"Implement the multi-language prompt engineering pipeline.
Use: Claude Sonnet for translation + brand voice alignment,
Ray for distributed processing, caching for common translations"

Use the Frontend Developer agent:
"Build the Content Generator UI for multi-language output.
Show: side-by-side language comparison, 
approval workflow, one-click publish to blog/social"
```

#### Phase 3: SEO/AEO Optimization

**Using AEO Foundations Architect**

```markdown
Use the AEO Foundations Architect agent:
"Optimize generated content for search engines and answer engines.
Per language: keyword research, meta descriptions, 
schema markup, content structure, readability score"
```

---

## 4. Anclora Data Lab — Data Analytics & Experimentation

### What It Does
Data analysis, dashboards, ML experimentation.

### Recommended Agents & Workflows

#### Phase 1: Experiment Design

**Feature**: A/B testing framework

```markdown
Use the Product Manager agent:
"Design the A/B testing framework for Data Lab.
Who: Product managers, data scientists
What: Define experiments, track metrics, statistical significance,
run automated analysis
Requirements: <2min to set up new experiment, 
95%+ statistical rigor"

Use the Backend Architect agent:
"Design the A/B testing system architecture.
Consider: experiment queue, metric tracking, 
statistical engine, realtime dashboards"
```

#### Phase 2: Data Pipeline

**Using Backend Architect + Database Optimizer**

```markdown
Use the Backend Architect agent:
"Design data pipeline for A/B testing.
Source: Event tracking from other Anclora products
Destination: Analysis engine, dashboards, API
Latency requirement: <5min end-to-end"

Use the Database Optimizer agent:
"Design the metrics database schema.
Consider: 1B+ events/day, efficient aggregation, 
time-series optimization"
```

#### Phase 3: QA & Performance

**Using API Tester + Performance Benchmarker**

```markdown
Use the API Tester agent:
"Test the A/B testing API.
Test scenarios: define experiment, track events, 
get results, handle errors"

Use the Performance Benchmarker agent:
"Benchmark the A/B testing system at scale.
Simulate: 1M concurrent events, real-time aggregation, 
dashboard query performance"
```

---

## 5. Anclora EnergyScan — Energy Analysis

### What It Does
Energy efficiency analysis and reporting for buildings.

### Recommended Agents & Workflows

#### Phase 1: Analysis Engine Spec

**Feature**: AI-powered energy recommendations

```markdown
Use the AI Engineer agent:
"Specify the AI recommendation engine for EnergyScan.
Inputs: building energy data, weather, occupancy patterns
Output: Automated recommendations to reduce consumption 15-30%
Requirements: Explainable AI (why this recommendation?), 
validated against real buildings"

Use the Backend Architect agent:
"Design the real-time energy analysis pipeline.
Source: IoT sensors, utility APIs
Processing: ML model inference, anomaly detection
Output: Dashboard + API for recommendations"
```

#### Phase 2: ML Model Development

**Using AI Engineer + Data Engineer**

```markdown
Use the AI Engineer agent:
"Design the ML model for energy recommendations.
Approach: Time-series forecasting + clustering + explainability
Libraries: PyTorch, SHAP for explanations
Validate against: historical energy audit data"

Use the Data Engineer agent (if available):
"Build the data pipeline for training the model.
Source: 1000+ buildings, 2+ years energy data
Output: Training dataset with ground truth (audit results)"
```

#### Phase 3: Validation

**Using API Tester + Performance Benchmarker**

```markdown
Use the API Tester agent:
"Test the energy recommendation API.
Scenarios: single building, batch recommendations, 
error handling (sensor failures)"

Use the Performance Benchmarker agent:
"Benchmark recommendations at scale.
Latency requirement: <2s per building
Throughput: 1000 buildings/minute"
```

---

## 6. Anclora Talent — Talent Management

### What It Does
Talent acquisition, management, and development.

### Recommended Agents & Workflows

#### Phase 1: Feature Design

**Feature**: AI-powered skill gap analysis

```markdown
Use the Product Manager agent:
"Define AI-powered skill gap analysis for Talent.
Who: HR managers, employees
What: Compare employee skills vs. role requirements, 
suggest training, identify promotions
Requirements: 90%+ accuracy in skill matching"

Use the Backend Architect agent:
"Design the skill gap analysis system.
Components: skill taxonomy, employee assessment, 
role requirements, ML matching, recommendations"
```

#### Phase 2: ML Model

**Using AI Engineer**

```markdown
Use the AI Engineer agent:
"Design the skill matching ML model.
Approach: Natural language processing + semantic similarity
Training data: job descriptions + employee profiles + historical promotions
Validation: Does model predict actual career progressions?"
```

---

## 7. Anclora Advisor AI — Financial Advisory

### What It Does
Financial advice and portfolio management.

### Recommended Agents & Workflows

#### Phase 1: Specification

**Feature**: Risk-adjusted portfolio recommendations

```markdown
Use the Backend Architect agent:
"Design the portfolio recommendation engine for Advisor.
Inputs: client risk profile, goals, constraints
Output: Diversified recommendations, compliance-checked
Requirements: Regulatory compliance (FINRA/SEC), 
explainability (why this allocation?)"

Use the Security Architect agent:
"Threat-model the financial advisor system.
Risks: unauthorized access, fraud, regulatory violation
Mitigations: Encryption, audit trails, approval workflows"
```

#### Phase 2: Implementation

**Using Backend Architect + Code Reviewer**

```markdown
Use the Backend Architect agent:
"Design the portfolio calculation engine.
Requirements: Real-time price updates, 
regulatory constraint checking, client preference weighting"

Use the Code Reviewer agent:
"Review the recommendation algorithm for 
correctness and regulatory compliance"
```

---

## 8. Anclora Private Estates — Luxury Property Management

### What It Does
Exclusive property listings and management.

### Recommended Agents & Workflows

#### Phase 1: UX Design

**Feature**: AI-powered property matching

```markdown
Use the Frontend Developer agent:
"Design the property matching interface for Private Estates.
Requirements: Filter by luxury features (wine cellar, 
smart home, etc), view 360° tours, schedule viewings,
AI recommendations based on viewing history"

Use the Product Manager agent:
"Define property matching algorithm.
Who: High-net-worth buyers
Goal: Find perfect property in <10 interactions
Metrics: match quality, conversion to viewing, sales"
```

#### Phase 2: Backend

**Using Backend Architect + AI Engineer**

```markdown
Use the Backend Architect agent:
"Design the property data structure and search API.
Support: complex filtering, recommendations, 
viewing scheduling, client relationship tracking"

Use the AI Engineer agent:
"Design the personalized property matching model.
Factors: past viewings, stated preferences, 
market trends, price sensitivity"
```

---

## 9. Anclora Impulso — Growth Acceleration

### What It Does
Growth hacking and momentum tracking.

### Recommended Agents & Workflows

#### Phase 1: Metrics & Analytics

**Feature**: Growth forecasting

```markdown
Use the Analytics Reporter agent (if available):
"Design the growth metrics dashboard for Impulso.
Metrics: MoM growth rate, conversion funnel, 
CAC, LTV, churn, retention cohorts"

Use the Backend Architect agent:
"Design the analytics pipeline.
Source: event tracking from all Anclora products
Output: Real-time dashboards, ML forecasts, alerts"
```

#### Phase 2: Forecasting

**Using AI Engineer**

```markdown
Use the AI Engineer agent:
"Design the growth forecasting model.
Approach: Time-series + external factors (seasonality, marketing spend)
Output: Growth scenarios (conservative, base, optimistic)"
```

---

## Cross-Product Workflow Example

### Feature: Integrated Customer Analytics (Spans Multiple Products)

```markdown
## Using Agency Agents Across Products

### Specification Phase
Use Product Manager: "Define integrated customer analytics across Nexus, 
SyncXML, Content Generator, Data Lab, Talent"

### Architecture Phase
Use Agents Orchestrator: "Design how 5 services expose customer data 
to central analytics. Include: API contracts, data consistency, 
privacy (PII redaction)"

### Implementation Phase
Use Backend Architect: "Design customer analytics APIs for each service"
Use Code Reviewer: "Review for consistency across services"

### Deployment Phase
Use Infrastructure Maintainer: "Plan coordinated deployment across 5 services"

### Monitoring Phase
Use SRE (if available): "Monitor cross-service analytics pipeline 
for latency, data quality, completeness"
```

---

## Quick Reference: Which Agent for Which Product?

| Product | Primary Agents | Use Case |
| --- | --- | --- |
| **Nexus** | Backend Architect, Code Reviewer | System design, coordination |
| **SyncXML** | Backend Architect, Database Optimizer | Document processing, async queues |
| **Content Generator** | AI Engineer, Frontend Developer | ML pipelines, content UX |
| **Data Lab** | AI Engineer, Backend Architect | ML models, data pipelines |
| **EnergyScan** | AI Engineer, Backend Architect | ML models, real-time processing |
| **Talent** | Product Manager, AI Engineer | Feature design, skill matching |
| **Advisor** | Backend Architect, Security Architect | Financial systems, compliance |
| **Private Estates** | Frontend Developer, Backend Architect | UX, property data systems |
| **Impulso** | Backend Architect, AI Engineer | Analytics, forecasting |

---

## Template for Product Teams

Use this template for your product feature:

```markdown
# Feature: [Feature Name]

## Phase 1: Specification
Use the Product Manager agent:
"[Clear feature description including who, what, requirements]"

## Phase 2: Architecture
Use the [Architect Name] agent:
"[Architecture questions specific to your stack]"

## Phase 3: Tasks
Use the Workflow Architect agent:
"[Break into testable tasks, 1-2 weeks each]"

## Phase 4: Implementation
Use [Implementation Agents]:
"[Code implementation prompts]"

## Phase 5: Quality
Use the Code Reviewer agent:
"[Review against spec and plan]"

## Phase 6: Deployment
Use the [DevOps/SRE] agent:
"[Deployment and monitoring setup]"
```

---

## Tips for Product Teams

1. **Bookmark the agents** that apply to your product
2. **Use the SDD workflow** (SPEC → PLAN → TASKS)
3. **Reference your product's tech stack** in prompts
4. **Pin agent versions** that work well for your product
5. **Share successful prompts** with your team
6. **Measure time savings** to track agent ROI

---

## Success Metrics

Track for each product:
- **Time to feature**: Spec → Production
- **Code quality**: Test coverage, security issues
- **Team velocity**: Features shipped per sprint
- **Team satisfaction**: Ease of using agents

Example:
```markdown
## Nexus Team Metrics (with agents)

Before agents:
- Feature time: 4 weeks
- Test coverage: 60%
- Velocity: 8 points/sprint

After agents (3 months in):
- Feature time: 2.5 weeks (-37%)
- Test coverage: 92% (+32%)
- Velocity: 14 points/sprint (+75%)
```

---

**Next step**: Pick your product, choose an upcoming feature, and try the workflow with agents.

---

**Status**: Ready to use immediately  
**Timeline**: Start with any feature  
**Impact**: 2-5 weeks faster time-to-market per feature
