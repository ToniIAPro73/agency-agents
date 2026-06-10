# Anclora Group — Agency Agents Setup & Integration

**Última actualización**: 2026-06-10  
**Responsable**: Anclora Engineering Team

---

## 📍 Estado Actual

Anclora Group utiliza este repositorio como base para instalar una agencia de agentes especializados en:
- Desarrollo y arquitectura de software
- Seguridad y privacidad
- Testing y QA
- Documentación técnica
- Producto y UX
- Marketing técnico (SEO, AEO, GEO)
- Operaciones y reporting

### Herramientas Operativas Autorizadas

✅ **Claude Code** — instalado en `~/.claude/agents/`

✅ **Codex** — instalado en `~/.codex/agents/`

❌ **Gemini CLI** — NO autorizado ni instalado

> El README.md upstream puede mencionar otras herramientas (Gemini CLI, Cursor, Aider, Windsurf, etc.). **Anclora no las usa**. Mantener el README.md original sin cambios facilita sincronización con upstream; esta guía documenta lo que SÍ es válido para Anclora.

---

## 🔧 Instalación

### Comando único para Anclora

```bash
cd /home/toni/projects/agency-agents

# Convertir agentes para Codex (sin Gemini CLI)
./scripts/convert.sh --tool codex --parallel

# Instalar para Claude Code usando lista Anclora
./scripts/install.sh --tool claude-code --agents-file anclora-agents.txt

# Instalar para Codex usando lista Anclora
./scripts/install.sh --tool codex --agents-file anclora-agents.txt
```

### Verificación Post-Instalación

```bash
# Claude Code: debe mostrar 93+ agentes
find ~/.claude/agents -type f | wc -l

# Codex: debe mostrar 65 agentes
find ~/.codex/agents -type f | wc -l

# Gemini CLI: debe estar vacío o no existir
test ! -d ~/.gemini/agents && echo "✓ Gemini CLI not present (OK)" || echo "⚠ Gemini CLI directory exists"
```

### Comandos PROHIBIDOS en Anclora

```bash
./scripts/install.sh --tool all                 # ✗ instalaría Gemini CLI
./scripts/convert.sh --tool gemini-cli          # ✗ no usar
./scripts/install.sh --tool gemini-cli          # ✗ no usar
./scripts/install.sh --tool all                 # ✗ no usar
```

---

## 📦 Agentes Seleccionados

| Fuente | Archivo | Descripción |
| --- | --- | --- |
| **Final** | `anclora-agents.txt` | 65 agentes validados para Claude Code + Codex |
| **Inicial** | `anclora-agents.requested.txt` | Solicitud original (histórico) |
| **Documentación** | [AGENTS.md](AGENTS.md) | Catálogo completo con rutas y fases de uso |

### Uso Recomendado por Fase

- **Fase 1 (Discovery)**: product-manager, business-strategist, ux-researcher
- **Fase 2 (Architecture)**: software-architect, backend-architect, security-architect
- **Fase 3 (Build)**: frontend-developer, backend-architect, ai-engineer
- **Fase 4 (QA)**: code-reviewer, api-tester, accessibility-auditor
- **Fase 5 (Launch)**: technical-writer, content-creator, aeo-foundations-architect
- **Fase 6 (Ops)**: sre-site-reliability-engineer, infrastructure-maintainer

Ver [ANCLORA_AGENCY_OPERATING_MODEL.md](ANCLORA_AGENCY_OPERATING_MODEL.md) para detalles completos.

---

## 🔐 Contexto y Memoria

La memoria operativa para Anclora **NO depende de Gemini CLI**.

### Sistemas de Contexto Vigentes

| Sistema | Ubicación | Propósito |
| --- | --- | --- |
| **Archivo de reglas** | `AGENTS.md` | Catálogo y guía de fases |
| **Modelo operativo** | `ANCLORA_AGENCY_OPERATING_MODEL.md` | Decisiones arquitectónicas |
| **Memoria de agentes** | `ANCLORA_AGENT_MEMORY.md` | Comportamiento esperado |
| **Workspace** | `Anclora.code-workspace` | Integración en VS Code |
| **Contratos** | `Boveda-Anclora/docs/contracts/` | SDD, guardrails, playbooks |
| **Playbooks** | `Boveda-Anclora/playbooks/` | Flujos operativos |

---

## 🏗️ Integración en el Workspace

Agency-agents está registrado en `Anclora.code-workspace` como:

```json
{
  "path": "agency-agents",
  "name": "[Tools] Agency Agents"
}
```

Visibilidad: Los agentes están accesibles desde Claude Code y Codex dentro del workspace de Anclora.

---

## 📋 Criterio de Mantenimiento

### Principios

1. **Upstream-first**: Mantener el fork lo más sincronizado posible con `github.com/msitarzewski/agency-agents`
2. **No modificar README.md**: El README upstream puede mencionar otras herramientas; lo aclaramos en esta guía (README_ANCLORA.md)
3. **Aislamiento de cambios**: Las adaptaciones Anclora están en archivos específicos (README_ANCLORA.md, ANCLORA_*.md, anclora-agents.txt)
4. **Versionado**: Cualquier cambio en lista de agentes se registra en MEMORY.md de cada repo

### Archivos Anclora (No Tocar Upstream)

- `README_ANCLORA.md` ← Esta guía
- `ANCLORA_AGENCY_OPERATING_MODEL.md` ← Decisiones arquitectónicas
- `ANCLORA_AGENT_MEMORY.md` ← Comportamientos esperados
- `anclora-agents.txt` ← Lista final de agentes
- `anclora-agents.requested.txt` ← Solicitud inicial (histórico)

### Sincronización con Upstream

```bash
# Traer cambios upstream
git remote add upstream https://github.com/msitarzewski/agency-agents.git
git fetch upstream
git merge upstream/main

# Resolver conflictos SOLO en archivos Anclora, mantener README.md original
```

---

## ✅ Checklist de Validación

Anclora está correctamente configurado si:

- [ ] Claude Code detecta 93+ agentes instalados
- [ ] Codex detecta 65 agentes instalados
- [ ] `~/.gemini/agents` no existe o está vacío
- [ ] `anclora-agents.txt` existe en el repo
- [ ] `README_ANCLORA.md` existe y es accesible
- [ ] `ANCLORA_AGENCY_OPERATING_MODEL.md` documentado
- [ ] Workspace integrado en `Anclora.code-workspace`
- [ ] Memoria sincronizada en MEMORY.md respectivos

---

## 🆘 Troubleshooting

### "Agent not found after installation"

```bash
# Verificar ruta de instalación
find ~/.claude/agents -name "*.md" | head -5

# Reinstalar limpio
rm -rf ~/.claude/agents
./scripts/install.sh --tool claude-code --agents-file anclora-agents.txt
```

### "Gemini CLI agents appearing"

```bash
# Limpiar
rm -rf ~/.gemini/agents

# Verificar que no fue instalado
./scripts/install.sh --tool codex --agents-file anclora-agents.txt
```

### "Script permission denied"

```bash
chmod +x scripts/install.sh scripts/convert.sh
```

---

## 📖 Referencias

- **Upstream**: [github.com/msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents)
- **Anclora Workspace**: `~/projects/Anclora.code-workspace`
- **Bóveda Anclora**: `/mnt/c/Users/.../Boveda-Anclora/`
- **Agent Memory**: [ANCLORA_AGENT_MEMORY.md](ANCLORA_AGENT_MEMORY.md)
