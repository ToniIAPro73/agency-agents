# OpenSpec Workflow — Ecosistema Anclora

**Propósito**: Guía práctica para adoptar OpenSpec como motor de cambios estructurados en todos
los repos Anclora. Consolida el ciclo del ebook LIDR (Cap 07) con las buenas prácticas del
ecosistema.

**Referencia teórica**: [SDD_AGENTIC_ENGINEER_LIDR.md](../reference/SDD_AGENTIC_ENGINEER_LIDR.md)
Cap 07 — OpenSpec en la práctica.

---

## 1. Instalación

### Requisitos

- Node.js 18+
- Git
- Claude Code o Cursor (o ambos)

### Instalación global

```bash
npm install -g fission-ai/openspec@latest
```

### Inicialización en un repo

```bash
# Interactivo — detecta herramientas instaladas
cd tu-repo
openspec init

# No interactivo — para Claude Code y Cursor (recomendado para Anclora)
openspec init --tools claude,cursor

# Para todos los tools soportados
openspec init --tools all
```

Esto crea:

- `openspec/config.yaml` — configuración del proyecto
- `openspec/specs/` — estado actual de los módulos del sistema
- `openspec/changes/` — cambios en curso
- `.claude/skills/` — skills OpenSpec para Claude Code
- `.cursor/skills/` — skills para Cursor

### Actualizar tras upgrade

```bash
openspec update
```

---

## 2. Estructura de ficheros

```text
openspec/
├── config.yaml                     # Configuración: schema, tools, doc paths
├── specs/                          # Source of truth: estado actual del sistema
│   └── <modulo>/
│       └── spec.md                 # Spec del módulo (inmutable una vez archivada)
└── changes/                        # Unidades de trabajo activas
    ├── <nombre-del-change>/
    │   ├── .openspec.yaml          # Metadatos: schema, iniciativa, owner
    │   ├── proposal.md             # Qué se quiere conseguir y por qué
    │   ├── design.md               # Decisiones técnicas (para cambios complejos)
    │   ├── tasks.md                # Checklist de implementación para el agente
    │   └── specs/                  # Delta specs: solo lo que cambia
    │       └── <modulo>/
    │           └── spec.md
    └── archive/
        └── YYYY-MM-DD-<nombre>/    # Changes completados y desplegados
```

### Convenciones de naming

- **Changes**: prefijo de ticket + descripción corta: `TICKET-42-candidate-filters`
- **Ownership**: cada carpeta de change tiene un `OWNER.md` con el responsable
- **TTL**: un change activo más de 2 semanas sin archivar es deuda técnica

---

## 3. Ciclo completo paso a paso

### Paso 1: Crear el change

```bash
# Interactivo
openspec new change add-password-reset

# Con metadatos
openspec new change add-password-reset \
  --description "Añade flujo de recuperación de contraseña por email" \
  --areas auth,email

# Vinculado a una iniciativa cross-repo
openspec new change add-billing-api \
  --initiative billing-launch \
  --store platform
```

### Paso 2: Ver estado del change

```bash
openspec status --change add-password-reset
# Output:
# Change: add-password-reset
# Schema: spec-driven
# Progress: 2/4 artifacts complete
# [x] proposal
# [ ] design
# [x] specs
# [-] tasks (blocked by: design)
```

### Paso 3: Obtener instrucciones para el agente

```bash
# Instrucciones completas del change
openspec instructions --change add-password-reset

# Instrucciones para artefacto concreto
openspec instructions design --change add-password-reset

# Instrucciones de implementación (apply) en JSON
openspec instructions apply --change add-password-reset --json
```

### Paso 4: Implementar las tareas

El agente sigue el `tasks.md` marcando cada tarea como completada **solo tras ejecutar y
verificar todos sus tests**. Ver sección 6 para las reglas obligatorias.

### Paso 5: Archivar tras despliegue

```bash
openspec archive --change add-password-reset
# Mueve a: openspec/changes/archive/2026-06-10-add-password-reset/
```

Si el cambio afecta capacidades del sistema, antes del archive actualiza las specs en
`openspec/specs/` para reflejar el nuevo estado real.

---

## 4. Artefactos por change

### `proposal.md` — El contrato

```markdown
# Add Dark Mode

## Summary
Implement system-level dark mode with manual toggle.

## Why
Users request dark mode; reduces eye strain for evening use.

## Proposed Behavior
- Detect system preference via `prefers-color-scheme`
- Manual toggle stored in user preferences
- All surfaces use CSS custom properties (--color-bg, --color-surface...)

## Success Criteria
- [ ] Theme toggle works in header
- [ ] Preference persists across sessions
- [ ] All WCAG AA contrast ratios maintained in dark mode
```

### `design.md` — Decisiones técnicas (cambios complejos)

Para cambios simples puede omitirse. Para cambios que afectan arquitectura:

```markdown
# Design: Add Dark Mode

## Technical Decisions
- **CSS tokens**: usar custom properties en `:root`, no CSS-in-JS
- **Storage**: localStorage para preferencia manual, matchMedia para sistema
- **Scope**: solo aplicar a componentes bajo `[data-theme="dark"]`

## Trade-offs considerados
| Opción | Pros | Contras | Decisión |
|--------|------|---------|----------|
| CSS custom properties | Nativo, sin runtime | Menos dinámico | ✅ Elegida |
| CSS-in-JS theming | Dinámico | Bundle más grande | ❌ Descartada |
```

### `tasks.md` — Checklist de implementación

```markdown
# Implementation Tasks: Add Dark Mode

## 1. CSS Token Layer
- [ ] 1.1 Add dark mode variables to design tokens
- [ ] 1.2 Implement [data-theme="dark"] overrides
- [ ] 1.3 Verify WCAG contrast ratios in dark mode

## 2. Toggle Component
- [ ] 2.1 Create ThemeToggle component
- [ ] 2.2 Wire to user preferences store
- [ ] 2.3 Add to Header layout

## 3. Testing (MANDATORY — ver sección 6)
- [ ] 3.1 Unit tests for ThemeToggle (90% coverage)
- [ ] 3.2 E2E test: toggle persists on reload
- [ ] 3.3 Visual regression: dark mode screenshots
```

---

## 5. Escenarios comunes

### Nueva feature

```text
Usuario: "Añadir filtrado de candidatos por estado"
→ Leer specs/candidate-list/spec.md
→ Revisar changes/ por cambios de candidates pendientes
→ openspec new change add-candidate-filters
→ Esperar aprobación del proposal antes de implementar
→ /apply → /code-review → /commit → /verify + /archive
```

### Bug fix

```text
Usuario: "Error null cuando la bio del usuario está vacía"
→ Comprobar si spec dice que bio es opcional
  → Si SÍ: fix directo (es un bug, no un cambio de comportamiento)
  → Si NO: crear change proposal (es un cambio de comportamiento)
```

### Infraestructura / tooling (sin spec necesaria)

```text
Usuario: "Configurar ESLint y Prettier"
→ Crear change proposal para la configuración
→ Implementar ficheros de config
→ Marcar tareas completadas
→ Archivar (sin actualizar specs — es tooling, no capacidad del sistema)
```

### Cambio de requisito a mitad del ciclo

```text
PM cambia el scope mientras /apply está en curso:
→ Interrumpir la ejecución
→ Actualizar la spec del change
→ Relanzar /apply desde el punto de cambio
→ NUNCA: continuar y parchear el output manualmente
```

---

## 6. Reglas obligatorias en tasks.md

El agente **debe ejecutar él mismo todos los tests** — nunca pedir al usuario que corra curls,
tests E2E ni validaciones manuales. Estas secciones son obligatorias para backend:

```markdown
## 9. Backend Unit Tests (MANDATORY)
- [ ] 9.1 Capture pre-test database baseline
- [ ] 9.2 Run targeted unit tests for changed modules
- [ ] 9.3 Run broader unit test suite
- [ ] 9.4 Verify post-test database state and restore if needed
- [ ] 9.5 Create report: specs/<change>/reports/YYYY-MM-DD-step-N-unit-tests.md

## 10. Backend Manual Endpoint Testing with curl (MANDATORY — AGENT MUST EXECUTE)
- [ ] 10.1 Ensure backend server is running (agent starts it if needed)
- [ ] 10.2 Test GET endpoints and verify responses
- [ ] 10.3 Test POST/PUT/DELETE endpoints, verify, restore DB state
- [ ] 10.4 Test error cases (validation, 404, etc.)
- [ ] 10.5 Document all curl commands and responses

## 11. Frontend E2E Testing with Playwright (MANDATORY if applicable)
- [ ] 11.1 Ensure both servers are running
- [ ] 11.2 Execute complete user workflow via Playwright
- [ ] 11.3 Test error scenarios and validation
- [ ] 11.4 Restore test environment and database state
- [ ] 11.5 Document test scenarios and outcomes
```

**Una tarea solo se puede marcar `[x]` completada después de ejecutar y verificar sus tests.**

---

## 7. Archivado e historial

### Qué significa archivar

Al archivar, el change:

1. Se mueve de `changes/<nombre>/` a `changes/archive/YYYY-MM-DD-<nombre>/`
2. Las spec deltas se integran en `specs/<modulo>/spec.md` (nueva spec del módulo)
3. La spec archivada es inmutable — nunca se edita

### Regla del cambio inmutable

> Una spec es inmutable una vez archivada. Los cambios futuros generan nuevas specs.
> Esta regla garantiza trazabilidad completa: cada commit puede seguirse hasta el requisito
> que lo originó, incluso meses después.

### Para cambios a features ya archivadas

```bash
# CORRECTO: abrir nuevo change
openspec new change update-filter-behavior \
  --description "Actualiza comportamiento del filtro — antes era client-side, ahora server-side"

# INCORRECTO: editar la spec archivada
# → pierde trazabilidad histórica
```

---

## 8. Integración con Bóveda SDD

### Qué vive en openspec/ vs qué vive en sdd/

| Contenido | Ubicación correcta |
| --------- | ------------------ |
| Features activas (en desarrollo) | `openspec/changes/<nombre>/` |
| Estado actual de módulos del sistema | `openspec/specs/<modulo>/spec.md` |
| Decisiones de arquitectura de ecosistema | Bóveda `docs/sdd/` |
| Contratos transversales (branding, AI Act) | Bóveda `contracts/` |
| Coordinación cross-repo | `openspec/changes/` con `--store platform` |
| Specs históricas archivadas | `openspec/changes/archive/` |

### Flujo cross-repo con workspace

```bash
# Crear workspace multi-repo para una iniciativa
openspec workspace setup \
  --name billing-launch \
  --link ../anclora-nexus \
  --link ../anclora-syncxml \
  --tools claude,cursor

# Ver workspaces disponibles
openspec workspace list

# Abrir workspace en agente
openspec workspace open billing-launch
```

**Regla**: hacer trabajo de implementación en workspaces de iniciativa, no en el
mega-workspace de 18 carpetas. El workspace de iniciativa carga solo los repos que el
change activo necesita.

---

## 9. Comandos de referencia rápida

```bash
# Setup
openspec init                                       # Inicializar (interactivo)
openspec init --tools claude,cursor                 # No interactivo
openspec update                                     # Actualizar archivos tras upgrade

# Changes
openspec new change <nombre>                        # Crear nuevo change
openspec set change <nombre> --initiative <id>      # Vincular a iniciativa
openspec status --change <nombre>                   # Ver progreso
openspec instructions --change <nombre>             # Instrucciones para agente
openspec instructions apply --change <nombre>       # Instrucciones de implementación
openspec archive --change <nombre>                  # Archivar tras despliegue

# Workspace (beta)
openspec workspace setup                            # Crear workspace multi-repo
openspec workspace list                             # Listar workspaces
openspec workspace open <nombre>                    # Abrir workspace
openspec workspace doctor                           # Diagnóstico

# Inspección
openspec templates                                  # Ver plantillas del schema activo
```

---

## 10. Adopción en repos Anclora existentes

### Checklist de inicio de sesión

Antes de comenzar cualquier sesión de desarrollo:

- [ ] ¿Hay changes activos en `openspec/changes/` del repo destino? → revisarlos primero
- [ ] ¿El cambio afecta contratos de Bóveda? → codificar allí primero
- [ ] ¿Tienes el agente correcto de agency-agents para la fase?
- [ ] ¿El repo destino tiene su `AGENTS.md` / `MEMORY.md` leído?
- [ ] ¿Se necesita worktree aislado? → `git worktree add`
- [ ] ¿El cambio afecta copy/SEO? → planificar ejecución de Hermes al final
- [ ] ¿Hay tasks en `tasks.md` marcadas como incompletas de sesiones anteriores?

### Repos pendientes de instalación

| Repo | Estado | Prioridad |
| ---- | ------ | --------- |
| anclora-energyscan | Sin OpenSpec | Alta |
| anclora-nexus | Sin OpenSpec | Alta |
| anclora-talent | Sin OpenSpec | Media |
| anclora-content-generator-ai | Sin OpenSpec | Alta |
| anclora-group | Sin OpenSpec | Media |

---

## Related Documents

- [SDD_INTEGRATION_GUIDE.md](SDD_INTEGRATION_GUIDE.md) — SDD workflow con ciclo OpenSpec completo
- [ANCLORA_AGENCY_OPERATING_MODEL.md](../anclora/ANCLORA_AGENCY_OPERATING_MODEL.md) — Modelo de 4 planos
- [SDD_AGENTIC_ENGINEER_LIDR.md](../reference/SDD_AGENTIC_ENGINEER_LIDR.md) — Ebook LIDR, Cap 07

---

**Autor**: Claude Code
**Fuentes**: LIDR Ebook SDD 2026 (Cap 07) + Perplexity Best Practices 2026
**Última actualización**: 2026-06-10
**Repositorio OpenSpec**: github.com/Fission-AI/OpenSpec
