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

La agencia no sustituye la decisión humana. Funciona como sistema de apoyo para acelerar análisis, implementación, revisión y documentación.

## 2. Herramientas operativas autorizadas

Anclora Group usa únicamente:

- Claude Code
- Codex

Gemini CLI queda excluido del flujo operativo.

Esto significa que no deben ejecutarse comandos de instalación, conversión ni uso de agentes para Gemini CLI.

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

Pueden existir carpetas o documentación upstream sobre estas herramientas porque forman parte del repositorio original, pero Anclora no las usa como runtime operativo.

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

Los agentes pueden tener secciones internas de "Memory" o "Learning & Memory", pero eso no garantiza memoria persistente real entre sesiones.

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
