# Anclora Group — Agency Agents Setup

## Estado

Anclora Group utiliza este repositorio como base para instalar una agencia de agentes especializada en desarrollo, arquitectura, producto, seguridad, testing, documentación, marketing técnico y operaciones.

## Herramientas operativas

Solo se usan estas herramientas:

- Claude Code
- Codex

Gemini CLI no forma parte del flujo operativo de Anclora Group.

## Instalación activa

Claude Code:

    ~/.claude/agents/

Codex:

    ~/.codex/agents/

Gemini CLI:

    No instalado en el flujo operativo de Anclora.

## Comandos de instalación usados

    chmod +x scripts/install.sh scripts/convert.sh

    ./scripts/convert.sh --tool codex --parallel
    ./scripts/install.sh --tool claude-code --agents-file anclora-agents.txt
    ./scripts/install.sh --tool codex --agents-file anclora-agents.txt

    rm -rf ~/.gemini/agents

## Comandos que no deben usarse en Anclora

    ./scripts/install.sh --tool all
    ./scripts/convert.sh --tool gemini-cli
    ./scripts/install.sh --tool gemini-cli

## Agentes seleccionados

La lista final de agentes Anclora está en:

    anclora-agents.txt

La lista inicial solicitada está en:

    anclora-agents.requested.txt

## Memoria y contexto

La memoria operativa no depende de Gemini CLI.

Para Anclora Group, el contexto persistente debe mantenerse mediante:

- AGENTS.md
- CLAUDE.md
- README_ANCLORA.md
- knowledge-vault/
- contratos canónicos
- playbooks
- ADRs
- MCP Memory, si se configura explícitamente

## Criterio operativo

El repositorio base debe mantenerse lo más cercano posible al upstream original.

La adaptación Anclora debe concentrarse en:

- documentación propia
- selección de agentes
- configuración operativa para Claude Code y Codex

## Estado actual verificado

Claude Code:

    93 agentes detectados

Codex:

    65 agentes detectados

Gemini CLI:

    no instalado
