# Token Reduction Architecture — Contexto y Propuestas

**Estado**: En diseño activo — documento vivo  
**Fecha**: 2026-06-10  
**Objetivo**: Capturar la situación actual, problemas identificados y propuestas de rediseño

---

## Resumen Ejecutivo

El objetivo del sistema es reducir el coste de tokens un 80-90% enrutando tareas al modelo
más económico que pueda resolverlas correctamente. La arquitectura base (`invoke_agent`) ya
existe en diseño, pero tiene **dos problemas fundamentales** que impiden que funcione en la
práctica.

---

## Arquitectura Actual (Lo Que Existe Hoy)

### Wrapper `invoke_agent` — Diseño Inicial

El fichero [IMPLEMENTATION_ARCHITECTURE.md](IMPLEMENTATION_ARCHITECTURE.md) describe un wrapper
centralizado que enruta tareas a distintos proveedores según complejidad:

```text
Usuario → invoke_agent(task, context?)
              ↓
    1. Analizar complejidad
    2. Verificar presupuesto
    3. Seleccionar modelo óptimo
    4. Llamar proveedor con caché
    5. Registrar coste
              ↓
    {response, model, provider, cost_usd, tokens_used}
```

### Proveedores Disponibles

| Nivel | Proveedor | Modelos | Coste |
| ----- | --------- | ------- | ----- |
| Simple | Ollama (local) | mistral-7b, llama-2-7b | $0 |
| Medium | OpenRouter | mistral-7b-instruct, llama-2-13b | ~$0.00015/token |
| Complex | OpenAI / Anthropic | gpt-4-turbo, claude-opus | $0.01-0.015/1K |

**Hermes** (worker de `anclora-content-generator-ai`) es curador de contenido y usa OpenRouter
como proveedor por defecto.

---

## Problemas Identificados

### Problema 1 — Complejidad Medida por Caracteres (CRÍTICO)

**Estado**: No resuelto

La implementación actual analiza complejidad así:

```python
def _analyze_complexity(self, task: str) -> str:
    word_count = len(task.split())
    if word_count < 100 and any(w in task.lower() for w in ["classify", "extract", "format"]):
        return "simple"
    elif word_count < 500 and any(w in task.lower() for w in ["review", "check", "explain"]):
        return "medium"
    else:
        return "complex"
```

**Por qué esto es incorrecto**:

- `"Fix the bug"` (3 palabras) → clasifica como `complex` porque no tiene keywords de simple/medium
- `"Classify all users into tiers A B C D E F...` (200 palabras) → clasifica como `simple`
- Una tarea corta de seguridad crítica vale lo mismo que un `"format this JSON"`

**Lo que debería medir la complejidad**:

- Dominio: `auth/security` > `code review` > `formatting`
- Razonamiento requerido: multi-step vs single-step
- Número de componentes afectados
- Si tiene implicaciones de seguridad, base de datos, o múltiples servicios
- Ambigüedad de la solicitud

---

### Problema 2 — El Usuario No Debe Especificar `context` (CRÍTICO)

**Estado**: No resuelto

El diseño actual expone `context` al usuario:

```python
# El usuario tendría que hacer esto:
invoke_agent(
    task="Build 2FA authentication",
    context={"task_type": "...", "complexity": "..."}  # ← ¿Qué pongo aquí?
)
```

**Por qué esto es incorrecto**:

- El usuario prompts a Claude Code: `"Añade autenticación 2FA"`
- El usuario no sabe (ni debería saber) qué es `context`
- Rompe el principio de que el agente es inteligente, no el usuario

**Quién debe ser el responsable**:

El agente orquestador (Claude Code, Codex) recibe el prompt del usuario, lo analiza
semánticamente, construye el `context` internamente, y llama `invoke_agent` de forma autónoma.
El usuario nunca toca `context`.

---

### Problema 3 — Desconexión con SDD (PENDIENTE DE DISEÑO)

**Estado**: No existe integración

El flujo SDD define cómo se implementan features en Anclora (ver
[SDD_INTEGRATION_GUIDE.md](../guides/SDD_INTEGRATION_GUIDE.md)):

```text
SPEC.md → PLAN.md → TASKS.md → Implementation → Validation
```

El wrapper `invoke_agent` no sabe nada de SDD. Sin embargo, el `PLAN.md` y `TASKS.md` ya
contienen información de complejidad muy valiosa:

- Tipo de tarea: feature, bugfix, refactor
- Dominios involucrados: auth, db, api, frontend
- Dependencias y componentes afectados
- Criterios de aceptación (indica qué tan compleja es la validación)

**Oportunidad**: Si el agente lee el SDD context antes de llamar `invoke_agent`, la
clasificación de complejidad puede ser mucho más precisa.

---

## Propuestas de Rediseño

### Propuesta 1 — Análisis Semántico de Complejidad

Reemplazar el análisis por conteo de palabras con un sistema de scoring por factores:

```python
class SemanticComplexityAnalyzer:
    """Analiza complejidad por contenido semántico, no por longitud."""

    COMPLEXITY_SIGNALS = {
        "simple": {
            "task_types": ["classify", "format", "extract", "translate", "summarize"],
            "scope": "single_file",
            "domains": ["text", "data_transform", "formatting"],
            "reasoning": "single_step"
        },
        "medium": {
            "task_types": ["review", "explain", "document", "test", "refactor_small"],
            "scope": "single_module",
            "domains": ["code_review", "documentation", "testing"],
            "reasoning": "multi_step"
        },
        "complex": {
            "task_types": ["design", "architect", "implement_feature", "security_audit"],
            "scope": "multi_component",
            "domains": ["auth", "security", "database", "infrastructure", "api_design"],
            "reasoning": "deep_reasoning",
            "indicators": ["migration", "breaking_change", "multiple_services"]
        }
    }

    def analyze(self, task: str, sdd_context: dict = None) -> ComplexityResult:
        """
        Scoring multi-factor. Retorna nivel + confianza + justificación.
        """
        score = ComplexityScore()

        # Factor 1: Dominio de la tarea
        score.add(self._score_domain(task))

        # Factor 2: Tipo de operación
        score.add(self._score_operation_type(task))

        # Factor 3: Alcance estimado (cuántos sistemas afecta)
        score.add(self._score_scope(task))

        # Factor 4: Indicadores de seguridad/criticidad
        score.add(self._score_criticality(task))

        # Factor 5 (opcional): Contexto SDD si está disponible
        if sdd_context:
            score.add(self._score_from_sdd(sdd_context))

        return score.resolve()  # "simple" | "medium" | "complex" + confidence
```

**Criterios de clasificación**:

| Factor | Simple | Medium | Complex |
| ------ | ------ | ------ | ------- |
| Dominio | text, formatting | code review, docs | auth, security, DB, infrastructure |
| Operación | classify, format | review, explain | design, implement, migrate |
| Alcance | 1 archivo | 1 módulo | múltiples servicios |
| Seguridad | no | indirecta | directa |
| SDD task type | bugfix pequeño | feature pequeña | feature grande, refactor |

---

### Propuesta 2 — Agente como Orquestador Autónomo

El flujo correcto: el agente construye `context` internamente, el usuario nunca lo ve.

```text
Usuario: "Implementa 2FA con TOTP y backup codes"
    ↓
Claude Code / Codex recibe el prompt
    ↓
Agente analiza autónomamente:
    ├─ ¿Qué tipo de tarea es? → feature_implementation
    ├─ ¿Qué dominio? → authentication, security
    ├─ ¿Cuántos componentes? → API + DB + Frontend = 3+
    ├─ ¿Es crítico? → SÍ (seguridad)
    └─ ¿SDD disponible? → lee SPEC.md si existe
    ↓
Internamente llama:
    invoke_agent(
        task="Implement 2FA with TOTP...",
        analysis={                         # ← construido por el agente
            "task_type": "feature_implementation",
            "domains": ["auth", "security", "database"],
            "scope": "multi_component",
            "security_critical": True,
            "complexity": "complex"        # ← deducido, no input del usuario
        }
    )
    ↓
Modelo seleccionado: Claude Opus / GPT-4
```

**Lo que ve el usuario**: Solo el resultado. Cero configuración de `context`.

---

### Propuesta 3 — Integración SDD → Complejidad

Cuando hay un `PLAN.md` o `TASKS.md` disponible en el repositorio, el agente puede leerlo
para determinar complejidad con mucha más precisión:

```python
def build_context_from_sdd(self, task: str, repo_path: str) -> dict:
    """
    Lee SDD docs del repo para enriquecer el análisis de complejidad.
    """
    sdd_context = {}

    # Busca SPEC, PLAN, TASKS en el repo
    spec = self._find_sdd_doc(repo_path, "SPEC.md")
    plan = self._find_sdd_doc(repo_path, "PLAN.md")

    if plan:
        sdd_context["affected_components"] = self._extract_components(plan)
        sdd_context["task_type"] = self._extract_task_type(plan)
        sdd_context["has_migration"] = "migration" in plan.lower()
        sdd_context["has_security"] = "security" in plan.lower() or "auth" in plan.lower()

    return sdd_context
```

**SDD ya tiene la complejidad definida**. No hay que inferirla del prompt si el PLAN.md dice
que es una feature grande con migración de base de datos.

---

## Flujo Completo Propuesto

```text
┌─────────────────────────────────────────────────────────────────┐
│  USUARIO                                                        │
│  "Añade autenticación 2FA con TOTP"                             │
└─────────────────────────┬───────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────────┐
│  AGENTE ORQUESTADOR (Claude Code / Codex)                       │
│                                                                 │
│  1. Leer SDD del repo (si existe SPEC/PLAN/TASKS)               │
│  2. Analizar prompt semánticamente                              │
│  3. Combinar ambos análisis → ComplexityResult                  │
│  4. Construir analysis dict internamente                        │
│  5. Llamar invoke_agent con analysis                            │
└─────────────────────────┬───────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────────┐
│  invoke_agent(task, analysis)                                   │
│                                                                 │
│  analysis = {                                                   │
│      "task_type": "feature_implementation",                     │
│      "domains": ["auth", "security", "database"],              │
│      "complexity": "complex",                                   │
│      "security_critical": True,                                 │
│      "sdd_phase": "implementation",                             │
│      "affected_components": 4                                   │
│  }                                                              │
└─────────────────────────┬───────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────────┐
│  MODEL SELECTOR                                                 │
│                                                                 │
│  complex + security_critical → Claude Opus / GPT-4             │
│  (no Ollama, no OpenRouter para tareas críticas de seguridad)  │
└─────────────────────────┬───────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────────┐
│  RESULTADO AL USUARIO                                           │
│  {response, model_used, cost_usd, tokens_used}                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Estado de Implementación

| Componente | Estado | Fichero |
| ---------- | ------ | ------- |
| `invoke_agent` wrapper (diseño base) | Diseñado, no implementado | `agents/core/invoke.py` |
| Proveedores: Ollama, OpenRouter, OpenAI, Anthropic | Diseñados, no implementados | `agents/core/providers/` |
| `BudgetManager` (control de gasto) | Diseñado, no implementado | `agents/core/budget.py` |
| `CacheLayer` (caché de prompts) | Diseñado, no implementado | `agents/core/cache.py` |
| `ComplexityAnalyzer` (análisis semántico) | **NO EXISTE — Propuesta 1** | TBD |
| `SmartInvoker` (agente autónomo) | **NO EXISTE — Propuesta 2** | TBD |
| SDD context reader | **NO EXISTE — Propuesta 3** | TBD |

---

## Próximos Pasos Recomendados

### Paso 1 — Decidir el enfoque de complejidad (1 día)

Antes de implementar nada, definir:

- ¿Scoring por heurísticas (sin LLM, determinista)?
- ¿Mini-LLM local para clasificar (Ollama con phi-3)?
- ¿Reglas + SDD context como fallback?

**Recomendación**: Empezar con heurísticas deterministas (más rápido, sin coste extra) y añadir
mini-LLM classification en v2 si las heurísticas no son suficientes.

### Paso 2 — Implementar `SemanticComplexityAnalyzer` (2-3 días)

Reemplazar `_analyze_complexity` en `invoke.py` con el nuevo sistema de scoring.

### Paso 3 — Integrar SDD reader (1 día)

Añadir `build_context_from_sdd()` que lee SPEC/PLAN del repo antes de invocar.

### Paso 4 — Documentar el contrato del agente (1 día)

Escribir la guía definitiva de cómo Claude Code/Codex deben llamar `invoke_agent`
de forma autónoma.

---

## Relación con Otros Documentos

- [IMPLEMENTATION_ARCHITECTURE.md](IMPLEMENTATION_ARCHITECTURE.md) — Diseño técnico base (a actualizar)
- [SDD_INTEGRATION_GUIDE.md](../guides/SDD_INTEGRATION_GUIDE.md) — SDD workflow de Anclora
- [STRATEGY.md](STRATEGY.md) — Estrategias de alto nivel para reducción de tokens
- [QUICK_START.md](QUICK_START.md) — Guía de implementación rápida

---

**Última actualización**: 2026-06-10  
**Autor**: Claude Code  
**Revisión pendiente**: Propuesta 1 (enfoque complejidad) necesita decisión del arquitecto
