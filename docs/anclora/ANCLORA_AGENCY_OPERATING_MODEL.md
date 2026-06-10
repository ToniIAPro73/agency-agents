# Anclora Group — Agency Agents Operating Model

## 1. Propósito

Este repositorio adapta The Agency / agency-agents para el ecosistema de Anclora Group.

Su objetivo es disponer de una agencia modular de agentes IA especializados que ayuden en:

- arquitectura de software
- desarrollo frontend/backend
- integración de IA
- seguridad y privacidad
- testing y QA
- documentación técnica
- producto y UX
- marketing técnico, SEO, AEO y GEO
- operaciones y reporting

La agencia no sustituye la decisión humana. Funciona como sistema de apoyo para acelerar análisis,
implementación, revisión y documentación.

## 2. Herramientas operativas autorizadas

Anclora Group usa únicamente:

- Claude Code
- Codex

Gemini CLI queda excluido del flujo operativo.

Esto significa que no deben ejecutarse comandos de instalación, conversión ni uso de agentes para
Gemini CLI.

## 3. Herramientas no utilizadas

No forman parte de esta configuración operativa:

- Gemini CLI
- Qwen
- Cursor
- Aider
- Windsurf
- OpenCode
- Kimi
- Antigravity
- GitHub Copilot como runtime principal de agentes

Pueden existir carpetas o documentación upstream sobre estas herramientas porque forman parte del
repositorio original, pero Anclora no las usa como runtime operativo.

## 4. Instalación activa

Claude Code:

    ~/.claude/agents/

Codex:

    ~/.codex/agents/

Gemini CLI:

    no instalado

Verificación usada:

    find ~/.claude/agents -type f | wc -l
    find ~/.codex/agents -type f | wc -l
    test ! -d ~/.gemini/agents && echo "OK: Gemini CLI no instalado"

Resultado actual:

    Claude Code: 93 agentes detectados
    Codex: 65 agentes detectados
    Gemini CLI: no instalado

## 5. Lista de agentes Anclora

La lista final de agentes seleccionados está en:

    anclora-agents.txt

La lista inicial solicitada está en:

    anclora-agents.requested.txt

La selección prioriza agentes útiles para el ecosistema Anclora:

- Anclora Nexus
- Anclora SyncXML
- Anclora Content Generator AI
- Anclora EnergyScan
- Anclora Data Lab
- Anclora Synergi
- Anclora Advisor AI
- Anclora Private Estates
- Anclora Press UI
- futuros productos bajo Anclora Group

## 6. Uso recomendado por fase

### Fase 1 — Discovery y definición

Agentes recomendados:

- product-manager
- business-strategist
- ux-researcher
- workflow-architect
- feedback-synthesizer

Uso típico:

- definir problema
- aclarar usuarios
- crear PRD
- priorizar MVP
- detectar riesgos funcionales

### Fase 2 — Arquitectura

Agentes recomendados:

- software-architect
- backend-architect
- database-optimizer
- security-architect
- multi-agent-systems-architect
- mcp-builder
- ai-engineer

Uso típico:

- diseñar arquitectura
- definir APIs
- modelar datos
- preparar integraciones IA
- revisar privacidad y seguridad

### Fase 3 — Construcción

Agentes recomendados:

- frontend-developer
- senior-developer
- backend-architect
- ai-engineer
- minimal-change-engineer
- devops-automator
- prompt-engineer

Uso típico:

- implementar features
- hacer cambios mínimos controlados
- integrar modelos IA
- mejorar prompts
- preparar CI/CD

### Fase 4 — QA y hardening

Agentes recomendados:

- code-reviewer
- api-tester
- performance-benchmarker
- accessibility-auditor
- security-architect
- test-results-analyzer
- tool-evaluator

Uso típico:

- revisar código
- probar APIs
- auditar accesibilidad
- validar rendimiento
- revisar seguridad
- analizar fallos de tests

### Fase 5 — Documentación y lanzamiento

Agentes recomendados:

- technical-writer
- content-creator
- brand-guardian
- aeo-foundations-architect
- agentic-search-optimizer
- analytics-reporter

Uso típico:

- crear documentación
- preparar copys de producto
- revisar consistencia de marca
- mejorar visibilidad SEO/AEO/GEO
- preparar materiales de lanzamiento

### Fase 6 — Operación

Agentes recomendados:

- sre-site-reliability-engineer
- infrastructure-maintainer
- operations-manager
- customer-success-manager
- automation-governance-architect
- zk-steward

Uso típico:

- mantener estabilidad
- revisar logs
- documentar incidentes
- mejorar automatizaciones
- consolidar conocimiento

## 7. Uso con Claude Code

Claude Code debe usarse para trabajo interactivo, planificación, revisión y ejecución guiada.

Ejemplos:

    Use the Software Architect agent to review this architecture.
    Use the Backend Architect agent to design the API and database schema.
    Use the Security Architect agent to threat-model this feature.
    Use the Code Reviewer agent to review this pull request.
    Use the Agents Orchestrator agent to coordinate this delivery.

## 8. Uso con Codex

Codex debe usarse para cambios controlados en código, refactors, tests y tareas de implementación.

Ejemplos:

    codex ask --agent "minimal-change-engineer" "Apply the smallest safe change to fix this issue."
    codex ask --agent "code-reviewer" "Review this PR for regressions."
    codex ask --agent "backend-architect" "Design the API schema for this feature."
    codex ask --agent "api-tester" "Create API tests for this endpoint."

## 9. Memoria y contexto

La memoria operativa no depende de Gemini CLI.

La memoria útil para Anclora debe estar en archivos versionados o sistemas explícitos:

- AGENTS.md
- CLAUDE.md
- README_ANCLORA.md
- ANCLORA_AGENCY_OPERATING_MODEL.md
- knowledge-vault/
- contratos canónicos
- playbooks
- ADRs
- documentación de producto
- MCP Memory, si se configura explícitamente

Los agentes pueden tener secciones internas de "Memory" o "Learning & Memory", pero eso no
garantiza memoria persistente real entre sesiones.

## 10. Reglas de mantenimiento

No usar:

    ./scripts/install.sh --tool all
    ./scripts/convert.sh --tool gemini-cli
    ./scripts/install.sh --tool gemini-cli

Usar:

    ./scripts/convert.sh --tool codex --parallel
    ./scripts/install.sh --tool claude-code --agents-file anclora-agents.txt
    ./scripts/install.sh --tool codex --agents-file anclora-agents.txt

Mantener el fork lo más cercano posible al upstream original.

Las adaptaciones Anclora deben concentrarse en:

- documentación propia
- selección de agentes
- configuración operativa
- playbooks específicos

## 11. Criterio de éxito

La configuración se considera válida si:

- Claude Code detecta agentes instalados
- Codex detecta los 65 agentes seleccionados
- Gemini CLI no está instalado
- `anclora-agents.txt` existe
- `README_ANCLORA.md` existe
- este documento existe
- no se ha modificado innecesariamente el repo base

---

## 12. Modelo de 4 planos del ecosistema

El ecosistema Anclora opera en cuatro planos con responsabilidades bien definidas. Mezclarlos
es la causa principal de spec split-brain, drift documental y coste de tokens innecesario.

| Plano | Repos | Responde a la pregunta |
| ----- | ----- | ---------------------- |
| **Gobernanza canónica** | Bóveda-Anclora | ¿Qué está permitido? ¿Qué familia es esta app? ¿Qué contrato aplica? |
| **Entrega** | Repo de producto + SDD artifacts del repo | ¿Qué construimos ahora? ¿Cuáles son los criterios de aceptación? |
| **Orquestación** | OpenSpec + agency-agents + Specboot | ¿Cómo organizamos el trabajo? ¿Qué rol de agente usar? |
| **Inteligencia personal** | Odysseus + NotebookLM | ¿Qué hemos investigado? ¿Qué decisiones tomamos antes? |

### Plano 1: Gobernanza canónica — Bóveda

La Bóveda es la **autoridad máxima** del ecosistema. Aquí vive:

- Arquitectura transversal (`ANCLORA_ECOSYSTEM_ARCHITECTURE_CONTRACT.md`)
- Clasificación de apps y familias (`APPLICATION_FAMILY_MAP.md`)
- Baseline AI Act y cumplimiento (`ANCLORA_AI_ACT_COMPLIANCE_BASELINE.md`)
- Branding, naming, copy, SEO/GEO (`ANCLORA_BRAND_IDENTITY_AND_SEO_GEO_CONTRACT.md`)
- Playbook de nueva app (onboarding de repos nuevos)
- Revisión semanal de gobernanza

**Regla**: si la pregunta es de ecosistema, la respuesta viene de aquí primero.

### Plano 2: Entrega — Repo de producto

El repo de producto (ACG, Nexus, EnergyScan, Talent…) contiene:

- Feature specs (`sdd/` o `docs/sdd/`)
- Artifacts activos: `SPEC.md`, `PLAN.md`, `TASKS.md` del change en curso
- Implementación, tests, CI/CD

**Regla**: el contexto de implementación debe limitarse al change activo + spec del módulo.
Nunca cargar el repo completo ni el ecosistema completo.

### Plano 3: Orquestación — OpenSpec + agency-agents + Specboot

- **agency-agents**: catálogo de roles de agentes por fase. No es donde vive la verdad de negocio
- **OpenSpec**: motor de cambios (`openspec/changes/`, iniciativas, workspaces)
- **Specboot**: estándares de desarrollo y reglas de ejecución para todos los copilots

**Regla**: este plano define **cómo se trabaja**, no qué es verdad.

### Plano 4: Inteligencia personal — Odysseus + NotebookLM

- **Odysseus**: memoria persistente, RAG local, investigación profunda, integraciones privadas
- **NotebookLM**: Q&A y síntesis rápida sobre material SDD/research

**Regla**: información que sale de este plano debe promoverse a Bóveda o SDD del repo antes de
ser operativa. No es fuente canónica directa.

---

## 13. Boundaries de herramientas

Conocer qué NO debe hacer cada herramienta evita el role confusion que multiplica el coste.

| Herramienta | Es | No es |
| ----------- | -- | ----- |
| **Hermes** | Gate de calidad para copy público, curation, SEO/GEO brand-fit | Orquestador general, gestor de tenancy, publicador |
| **Odysseus** | Memoria personal, RAG local, investigación, integraciones privadas | Repositorio de contratos de producto, datos productivos de clientes |
| **agency-agents** | Catálogo de roles y doctrina operativa | Almacén de verdad de negocio ni de specs de features |
| **OpenSpec** | Motor de cambios estructurados y coordinación cross-repo | Sustituto de SDD del repo ni de los contratos de Bóveda |
| **NotebookLM** | Síntesis interactiva y explicación rápida | Fuente canónica (sus respuestas deben validarse contra Bóveda/SDD) |

### Cuándo usar Hermes

- Cualquier cambio que afecte **copy público** → ejecutar Hermes Copy Curator + SEOGeo
- Adjuntar el informe al PR antes de merge
- No es obligatorio para cambios internos sin impacto en texto visible

---

## 14. Riesgos sistémicos identificados

### Spec split-brain

El mismo cambio puede existir en cinco lugares: Bóveda SDD, repo-local `sdd/`, OpenSpec
`changes/`, MEMORY.md / Memanto, Odysseus memory. Solo uno puede ser canónico. Si más de uno
lo reclama, el ecosistema paga dos veces: en tokens y en drift.

**Solución**: declarar ownership explícito. Para features de un repo → `sdd/` del repo es
canónico. Para decisiones de ecosistema → Bóveda. Para coordinación cross-repo → OpenSpec.

### Drift documental

Cuando README, AGENTS.md, ficheros de estado e implementación no coinciden en stack y
responsabilidades, cada sesión de planificación gasta tokens resolviendo la contradicción
antes de hacer trabajo útil. Es exactamente el coste que CONTEXT.md intenta eliminar con
el `SemanticComplexityAnalyzer`.

**Ejemplo activo**: ACG tiene drift entre README (Next.js 15 + Better Auth + Neon + Drizzle)
y AGENTS.md (menciona Supabase — stack antiguo). Prioridad de limpieza: alta.

### Mega-workspace como entorno por defecto

Abrir el workspace de 18 carpetas para cada sesión de implementación carga modelos de contexto
que nunca se usan. El workspace amplio sirve para overview y gobernanza, no para ejecución.

**Solución**: usar workspaces de iniciativa (OpenSpec `openspec workspace setup`) con solo los
repos que el change activo necesita.

---

## 15. Regla de contexto mínimo

Para maximizar calidad y minimizar coste en cada sesión de agente:

**Fase de planning** (high-reasoning obligatorio):

- Cargar: ficha del repo (Bóveda), spec activa, PLAN.md, contratos de Bóveda aplicables
- No cargar: repo completo, historial de chat, otros repos

**Fase de implementación de tarea**:

- Cargar: tarea activa de `TASKS.md` + ficheros exactos que toca
- No cargar: spec completa, plan completo, otros módulos

**Resetear contexto** entre spec y entre cada tarea grande. Persistir resúmenes fuera de la
ventana activa (MEMORY.md, Memanto, Odysseus).

---

## 16. Documentos relacionados

- [SDD_INTEGRATION_GUIDE.md](../guides/SDD_INTEGRATION_GUIDE.md) — Workflow SDD con ciclo OpenSpec
- [OPENSPEC_WORKFLOW.md](../guides/OPENSPEC_WORKFLOW.md) — Guía práctica OpenSpec
- [CONTEXT.md](../token-reduction/CONTEXT.md) — Arquitectura de reducción de tokens
- [SDD_AGENTIC_ENGINEER_LIDR.md](../reference/SDD_AGENTIC_ENGINEER_LIDR.md) — Ebook LIDR (referencia)
