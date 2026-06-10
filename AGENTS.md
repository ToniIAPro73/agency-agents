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

- `README_ANCLORA.md`: resumen de configuración Anclora.
- `ANCLORA_AGENCY_OPERATING_MODEL.md`: modelo operativo de la agencia de agentes.
- `anclora-agents.txt`: lista final de agentes seleccionados.
- `anclora-agents.requested.txt`: lista inicial solicitada.
- `AGENTS.md`: instrucciones operativas para agentes IA que trabajen sobre este repo.

## Criterio de modificación

Mantener el repositorio lo más cercano posible al upstream original.

Las adaptaciones Anclora deben concentrarse en:

- documentación propia
- selección de agentes
- configuración operativa
- playbooks específicos

Evitar modificar agentes originales salvo que haya una razón clara y documentada.

## Regla de trabajo con Git

No trabajar directamente en `main` para cambios nuevos.

Usar ramas con nombres claros:

    feat/anclora-...
    docs/anclora-...
    chore/anclora-...
    fix/anclora-...

Antes de hacer commit:

    git status
    git diff

Después de cambios relevantes:

    git add .
    git commit -m "tipo: descripción clara"
    git push

## Reglas para agentes IA

Cuando un agente IA trabaje en este repositorio debe:

1. Leer primero:
   - `AGENTS.md`
   - `README_ANCLORA.md`
   - `ANCLORA_AGENCY_OPERATING_MODEL.md`
   - `anclora-agents.txt`

2. No instalar Gemini CLI.

3. No usar `--tool all`.

4. No borrar carpetas upstream salvo instrucción explícita.

5. No modificar agentes originales sin justificarlo.

6. Proponer cambios mínimos y revisables.

7. Documentar cualquier decisión relevante.

8. Mantener compatibilidad con upstream.

## Uso recomendado por tipo de tarea

### Arquitectura

Usar agentes como:

- software-architect
- backend-architect
- database-optimizer
- security-architect
- multi-agent-systems-architect

### Desarrollo

Usar agentes como:

- frontend-developer
- senior-developer
- ai-engineer
- minimal-change-engineer
- devops-automator

### QA y revisión

Usar agentes como:

- code-reviewer
- api-tester
- performance-benchmarker
- accessibility-auditor
- test-results-analyzer

### Producto y UX

Usar agentes como:

- product-manager
- ux-architect
- ux-researcher
- ui-designer
- feedback-synthesizer

### Marketing técnico y visibilidad

Usar agentes como:

- brand-guardian
- content-creator
- aeo-foundations-architect
- agentic-search-optimizer
- analytics-reporter

## Memoria y contexto

La memoria persistente no depende de Gemini CLI.

El contexto de Anclora debe mantenerse en archivos versionados y sistemas explícitos:

- `AGENTS.md`
- `README_ANCLORA.md`
- `ANCLORA_AGENCY_OPERATING_MODEL.md`
- `knowledge-vault/`, si existe
- contratos canónicos
- playbooks
- ADRs
- documentación de producto
- MCP Memory, si se configura explícitamente

Las secciones internas de “Memory” o “Learning & Memory” dentro de agentes son guías de comportamiento, no garantía de memoria persistente real.

## Criterio de éxito

La configuración es válida si:

- Claude Code tiene agentes instalados.
- Codex tiene los agentes seleccionados instalados.
- Gemini CLI no está instalado.
- `anclora-agents.txt` existe.
- `README_ANCLORA.md` existe.
- `ANCLORA_AGENCY_OPERATING_MODEL.md` existe.
- Este `AGENTS.md` existe.
- El repo se mantiene cercano al upstream original.
