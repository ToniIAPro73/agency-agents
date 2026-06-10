# AGENTS.md — Anclora Group Agency Agents

## Propósito

Este repositorio adapta The Agency / agency-agents para el ecosistema de Anclora Group.

La finalidad es disponer de una agencia de agentes IA especializada para apoyar tareas de:

- arquitectura de software
- desarrollo frontend/backend
- integración de IA
- seguridad y privacidad
- testing y QA
- documentación
- producto y UX
- marketing técnico, SEO, AEO y GEO
- operaciones y reporting

La agencia ayuda a acelerar análisis, implementación, revisión y documentación, pero no sustituye la validación humana.

## Herramientas autorizadas

Anclora Group usa únicamente:

- Claude Code
- Codex

Gemini CLI no forma parte del flujo operativo de Anclora Group.

## Herramientas no autorizadas en este flujo

No usar para esta configuración:

- Gemini CLI
- Qwen
- Cursor
- Aider
- Windsurf
- OpenCode
- Kimi
- Antigravity
- GitHub Copilot como runtime principal de agentes

Pueden existir referencias upstream a estas herramientas porque forman parte del repositorio original, pero no son parte del flujo operativo Anclora.

## Comandos permitidos

Instalar agentes para Claude Code:

    ./scripts/install.sh --tool claude-code --agents-file anclora-agents.txt

Convertir agentes para Codex:

    ./scripts/convert.sh --tool codex --parallel

Instalar agentes para Codex:

    ./scripts/install.sh --tool codex --agents-file anclora-agents.txt

Eliminar cualquier resto local de Gemini CLI:

    rm -rf ~/.gemini/agents

## Comandos prohibidos

No ejecutar:

    ./scripts/install.sh --tool all
    ./scripts/convert.sh --tool gemini-cli
    ./scripts/install.sh --tool gemini-cli

Motivo: esos comandos pueden instalar o regenerar agentes para herramientas fuera del flujo operativo de Anclora.

## Archivos Anclora principales

- `AGENTS.md`: instrucciones operativas para agentes IA que trabajen sobre este repo.
- `README_ANCLORA.md`: resumen de configuración Anclora.
- `ANCLORA_AGENCY_OPERATING_MODEL.md`: modelo operativo de la agencia de agentes.
- `ANCLORA_AGENT_MEMORY.md`: memoria operativa común para Claude Code y Codex.
- `anclora-agents.txt`: lista final de agentes seleccionados.
- `anclora-agents.requested.txt`: lista inicial solicitada.

## Memoria operativa de agentes

La memoria de los agentes no debe depender de editar individualmente los 65 agentes seleccionados.

La memoria común de Anclora debe mantenerse en archivos versionados, especialmente:

- `AGENTS.md`
- `README_ANCLORA.md`
- `ANCLORA_AGENCY_OPERATING_MODEL.md`
- `ANCLORA_AGENT_MEMORY.md`
- `anclora-agents.txt`
- `anclora-agents.requested.txt`

Cualquier agente IA que trabaje sobre este repositorio debe tratar estos archivos como fuente de contexto operativo antes de proponer o ejecutar cambios.

Las secciones internas de “Memory”, “Learning & Memory” o equivalentes dentro de agentes originales son guías de comportamiento, no garantía de memoria persistente real entre sesiones.

## Criterio de modificación

Mantener el repositorio lo más cercano posible al upstream original.

Las adaptaciones Anclora deben concentrarse en:

- documentación propia
- selección de agentes
- configuración operativa
- playbooks específicos
- memoria operativa común

Evitar modificar agentes originales salvo que haya una razón clara y documentada.

No borrar carpetas, integraciones o documentación upstream salvo instrucción explícita.

## Regla de trabajo con Git

No trabajar directamente en `main` para cambios nuevos, salvo documentación menor y controlada ya validada por el usuario.

Para cambios nuevos, usar ramas con nombres claros:

- feat/anclora-...
- docs/anclora-...
- chore/anclora-...
- fix/anclora-...

Antes de hacer commit:

    git status
    git diff

Después de cambios relevantes:

    git add .
    git commit -m "tipo: descripción clara"
    git push

Los commits deben ser pequeños, trazables y reversibles.

## Reglas para agentes IA

Cuando un agente IA trabaje en este repositorio debe leer primero:

- `AGENTS.md`
- `README_ANCLORA.md`
- `ANCLORA_AGENCY_OPERATING_MODEL.md`
- `ANCLORA_AGENT_MEMORY.md`
- `anclora-agents.txt`
- `anclora-agents.requested.txt`

Además, debe respetar estas reglas:

1. No instalar Gemini CLI.

2. No usar `--tool all`.

3. No ejecutar estos comandos:

    - ./scripts/install.sh --tool all
    - ./scripts/convert.sh --tool gemini-cli
    - ./scripts/install.sh --tool gemini-cli

4. No borrar carpetas upstream salvo instrucción explícita.

5. No modificar agentes originales sin justificarlo.

6. Proponer cambios mínimos y revisables.

7. Documentar cualquier decisión relevante.

8. Mantener compatibilidad con upstream.

9. Evitar cambios destructivos.

10. Pedir confirmación humana antes de operaciones sensibles.

11. Mantener el flujo operativo limitado a Claude Code y Codex.

12. No asumir que Gemini CLI forma parte de la instalación de Anclora aunque exista documentación upstream relacionada.

## Uso recomendado por tipo de tarea

### Arquitectura

Usar agentes como:

- `software-architect`
- `backend-architect`
- `database-optimizer`
- `security-architect`
- `multi-agent-systems-architect`
- `mcp-builder`
- `ai-engineer`

Casos de uso:

- diseño de arquitectura
- revisión de decisiones técnicas
- modelado de datos
- definición de APIs
- integración de IA
- evaluación de riesgos técnicos

### Desarrollo

Usar agentes como:

- `frontend-developer`
- `senior-developer`
- `backend-architect`
- `ai-engineer`
- `minimal-change-engineer`
- `devops-automator`
- `prompt-engineer`

Casos de uso:

- implementación de features
- refactors controlados
- corrección de errores
- integración de modelos IA
- mejora de prompts
- automatización de tareas técnicas

### QA y revisión

Usar agentes como:

- `code-reviewer`
- `api-tester`
- `performance-benchmarker`
- `accessibility-auditor`
- `test-results-analyzer`
- `tool-evaluator`

Casos de uso:

- revisión de PRs
- generación de tests
- validación de APIs
- análisis de resultados de CI
- revisión de accesibilidad
- benchmarking de rendimiento

### Seguridad, privacidad y cumplimiento

Usar agentes como:

- `security-architect`
- `senior-secops-engineer`
- `data-privacy-officer`
- `legal-compliance-checker`
- `incident-responder`
- `evidence-collector`

Casos de uso:

- threat modeling
- revisión de secretos
- privacidad de datos
- cumplimiento regulatorio
- análisis de incidentes
- generación de evidencias

### Producto y UX

Usar agentes como:

- `product-manager`
- `ux-architect`
- `ux-researcher`
- `ui-designer`
- `persona-walkthrough-specialist`
- `feedback-synthesizer`

Casos de uso:

- definición de MVP
- priorización de roadmap
- análisis de usuario
- revisión de flujos
- mejora de experiencia
- síntesis de feedback

### Marketing técnico y visibilidad

Usar agentes como:

- `brand-guardian`
- `content-creator`
- `aeo-foundations-architect`
- `agentic-search-optimizer`
- `analytics-reporter`
- `growth-hacker`

Casos de uso:

- revisión de marca
- copy técnico
- SEO
- AEO
- GEO
- analítica
- posicionamiento de producto

### Operaciones

Usar agentes como:

- `operations-manager`
- `sre-site-reliability-engineer`
- `infrastructure-maintainer`
- `automation-governance-architect`
- `report-distribution-agent`
- `chief-of-staff`

Casos de uso:

- seguimiento operativo
- mantenimiento de infraestructura
- reporting
- gobernanza de automatizaciones
- coordinación de entregas
- gestión de riesgos

## Contexto Anclora Group

Esta agencia de agentes sirve al ecosistema Anclora Group.

Productos y líneas que puede apoyar:

- Anclora Group como matriz.
- Anclora Nexus.
- Anclora SyncXML.
- Anclora Content Generator AI.
- Anclora EnergyScan.
- Anclora Data Lab.
- Anclora Synergi.
- Anclora Advisor AI.
- Anclora Private Estates.
- Anclora Private Estates Landing.
- Anclora Press UI.
- Anclora Linguo Cam.
- Anclora Talent.
- Anclora Impulso.

Anclora Talent y Anclora Impulso pueden tener relación de marca con Anclora Group, pero no deben asumirse como parte directa del mismo ecosistema técnico salvo que el usuario lo indique.

## Modelo operativo

Los agentes deben actuar como especialistas de apoyo.

No sustituyen:

- decisión estratégica humana
- validación legal
- validación fiscal
- validación regulatoria
- revisión final de seguridad
- aprobación de despliegues
- aprobación de cambios destructivos

El trabajo de los agentes debe orientarse a:

- reducir incertidumbre
- acelerar implementación
- mejorar calidad
- documentar decisiones
- detectar riesgos
- proponer alternativas
- mantener trazabilidad

## Principios técnicos

Priorizar:

- cambios mínimos
- claridad
- mantenibilidad
- seguridad
- privacidad
- trazabilidad
- compatibilidad con upstream
- documentación suficiente
- pruebas antes de merge
- rollback sencillo

Evitar:

- sobreingeniería
- cambios masivos innecesarios
- dependencias no justificadas
- modificaciones silenciosas
- hardcoding de secretos
- acoplamiento innecesario
- mezclar configuración Anclora con lógica upstream

## Instalación operativa validada

Estado de referencia:

- ~/.claude/agents/ -> 93 agentes
- ~/.codex/agents/ -> 65 agentes
- ~/.gemini/agents -> no existe

Comprobaciones recomendadas:

    find ~/.claude/agents -type f | wc -l
    find ~/.codex/agents -type f | wc -l
    test ! -d ~/.gemini/agents && echo "OK: Gemini CLI no instalado"

## Sincronización con upstream

El remoto `origin` debe apuntar al fork Anclora:

    https://github.com/ToniIAPro73/agency-agents.git

El remoto `upstream` debe apuntar al repo original:

    https://github.com/msitarzewski/agency-agents.git

Verificación:

    git remote -v

Antes de traer cambios de upstream:

    git checkout main
    git status
    git fetch upstream
    git log --oneline --decorate --graph --all -10

No mezclar actualizaciones upstream con cambios Anclora no relacionados en el mismo commit.

## Criterio de éxito

La configuración es válida si:

- Claude Code tiene agentes instalados.
- Codex tiene los agentes seleccionados instalados.
- Gemini CLI no está instalado.
- `AGENTS.md` existe.
- `README_ANCLORA.md` existe.
- `ANCLORA_AGENCY_OPERATING_MODEL.md` existe.
- `ANCLORA_AGENT_MEMORY.md` existe.
- `anclora-agents.txt` existe.
- `anclora-agents.requested.txt` existe.
- El repo se mantiene cercano al upstream original.
- Las adaptaciones Anclora están documentadas y versionadas.
- Los agentes tienen una memoria operativa común sin modificar individualmente los agentes upstream.

## Regla final

Ante duda, el agente debe detenerse, explicar el riesgo y pedir confirmación antes de ejecutar cambios.
