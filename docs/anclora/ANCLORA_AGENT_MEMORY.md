# Anclora Group — Agent Operational Memory

## Estado actual del fork

Este repositorio es el fork limpio de `agency-agents` usado por Anclora Group.

Fork Anclora:

    https://github.com/ToniIAPro73/agency-agents.git

Repositorio original upstream:

    https://github.com/msitarzewski/agency-agents.git

El remoto `origin` debe apuntar al fork de Anclora.

El remoto `upstream` debe apuntar al repositorio original.

## Flujo operativo autorizado

Anclora Group usa únicamente:

- Claude Code
- Codex

Gemini CLI queda excluido del flujo operativo.

## Instalación validada

Estado verificado:

    ~/.claude/agents/ -> 93 agentes
    ~/.codex/agents/  -> 65 agentes
    ~/.gemini/agents  -> no existe

## Archivos Anclora relevantes

Los agentes deben consultar estos archivos antes de actuar:

- `AGENTS.md`
- `README_ANCLORA.md`
- `ANCLORA_AGENCY_OPERATING_MODEL.md`
- `ANCLORA_AGENT_MEMORY.md`
- `anclora-agents.txt`
- `anclora-agents.requested.txt`

## Reglas críticas

No ejecutar:

    ./scripts/install.sh --tool all
    ./scripts/convert.sh --tool gemini-cli
    ./scripts/install.sh --tool gemini-cli

Usar únicamente:

    ./scripts/convert.sh --tool codex --parallel
    ./scripts/install.sh --tool claude-code --agents-file anclora-agents.txt
    ./scripts/install.sh --tool codex --agents-file anclora-agents.txt

## Criterio de mantenimiento

El fork debe mantenerse lo más cercano posible al upstream original.

Las adaptaciones Anclora deben limitarse a:

- documentación propia
- selección de agentes
- configuración operativa
- playbooks específicos
- memoria operativa común

No modificar agentes originales salvo necesidad clara y documentada.

## Contexto Anclora

Esta agencia de agentes sirve al ecosistema Anclora Group, incluyendo entre otros:

- Anclora Nexus
- Anclora SyncXML
- Anclora Content Generator AI
- Anclora EnergyScan
- Anclora Data Lab
- Anclora Synergi
- Anclora Advisor AI
- Anclora Private Estates
- Anclora Press UI

## Uso esperado de los agentes

Los agentes deben actuar como especialistas de apoyo.

No sustituyen la decisión humana.

Deben:

- proponer cambios mínimos
- evitar operaciones destructivas
- pedir confirmación antes de cambios críticos
- documentar decisiones relevantes
- mantener compatibilidad con upstream
- respetar el flujo Claude Code + Codex
