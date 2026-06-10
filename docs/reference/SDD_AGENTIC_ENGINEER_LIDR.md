# Agentic Engineer — Spec-Driven Development + IA

**Fuente**: Ebook LIDR 2026 — Álvaro Moya, Fundador de LIDR.co  
**Subtítulo**: ¿La IA te acelera… hasta que revisas el PR?  
**Referencia**: lidr.co | hi@lidr.co

---

> "El impacto más relevante de la IA en desarrollo no es ni mucho menos programar más rápido.
> El coste de hacer buen código ha colapsado, ya no hay excusa para aumentar la calidad, desde
> buenas prácticas y documentación exhaustiva a tests unitarios y E2E automáticos. Ahí está el
> verdadero impacto en productividad a largo plazo."
>
> — Álvaro Moya, Fundador de LIDR.co

---

## Índice

1. [Cómo usar este playbook](#01-cómo-usar-este-playbook)
2. [El problema: la IA te acelera… hasta que revisas el PR](#02-el-problema)
3. [La causa: el trabajo mal definido](#03-la-causa)
4. [Los 3 pilares del uso efectivo de la IA](#04-los-3-pilares)
5. [Context Engineering: la receta perfecta del contexto](#05-context-engineering)
6. [Qué es Spec-Driven Development](#06-qué-es-sdd)
7. [OpenSpec en la práctica](#07-openspec-en-la-práctica)
8. [Casos de éxito](#08-casos-de-éxito)
9. [AI Assessment 2026](#09-ai-assessment-2026)
10. [¿Quieres convertirte en Agentic Engineer?](#10-agentic-engineer)

---

## 01. Cómo usar este playbook

Este playbook no está pensado para leerse de una vez, sino para volver a él en cada avance de
nivel. Los primeros capítulos explican el problema y la causa de una adopción IA inadecuada.
Los centrales te dan el framework y la metodología. Y los últimos son recursos accionables:
**casos de éxito, evaluación de tu nivel y el Máster AI4Devs para quien quiera ir más lejos.**

### El mapa del playbook

| # | Sección | Descripción |
| - | ------- | ----------- |
| 1 | Cómo se usa | Instrucciones básicas de navegación |
| 2 | El problema | Por qué la IA individual no escala y dónde se pierde el impacto real |
| 3 | La causa | El cuello de botella es la falta de definición |
| 4 | Los 3 pilares | Tool, Prompt y Context Engineering: el triángulo que lo sostiene todo |
| 5 | Context Engineering | Cómo construir el contexto que hace que la IA no empiece desde cero |
| 6 | Qué es SDD | Spec-Driven Development: la especificación como contrato ejecutable |
| 7 | OpenSpec en la práctica | El framework LIDR, los comandos del ciclo completo y la demo técnica |
| 8 | Casos de éxito | Mercado Libre, Bdeo e InfoJobs: adopción real con resultados medibles |
| 9 | AI Assessment | Evalúa tu nivel real de adopción de IA en 6 dimensiones. Gratis |
| 10 | Agentic Engineer | El método probado para adoptar el nuevo paradigma |

### Elige tu ruta de lectura

**Quieres resultados rápidos**: Cap 07 → 04 → 05 → 09

**Quieres entender desde la base**: Cap 02 → 03 → 04 → 05 → 06 → 07

**Lideras un equipo de desarrollo**: Empieza por los casos de éxito (Cap 08), luego el framework
y el assessment.

**Quieres medir dónde estás ahora**: Cap 09 → según resultados

> **Una última cosa antes de empezar**: El Cap 07 tiene una demo técnica en vivo y acceso al
> repositorio de OpenSpec. Son los recursos más accionables del playbook. No los dejes para el final.

---

## 02. El Problema

### La IA te acelera… hasta que revisas el PR

Imagina la escena. Lunes, 9 de la mañana. Abres el IDE, le pides a tu copiloto que implemente
la nueva feature, y en 12 minutos tienes el código. ¡Genial! Velocidad. La promesa de la IA
cumplida.

Luego llega el miércoles. El PR lleva 2 días en revisión. Tu compañero senior está encontrando
edge cases que el código no cubre. QA ha rechazado 3 veces la misma funcionalidad porque no
cumple con los criterios de aceptación que nadie había escrito en ningún sitio. Y tú, mientras
tanto, estás reescribiendo lo que la IA generó en 12 minutos… durante 3 días.

**¿Te suena? No es un problema de la IA. Es un problema de método.**

El patrón se repite en equipos de todo tipo y tamaño. La IA genera código más rápido que nunca.
Pero si la entrada es vaga, el output también lo es. **El coste de corrección no desaparece: se
desplaza.** Se mueve del momento de escritura al de revisión, validación, QA y producción.

### Los datos que lo confirman

**La Paradoja de Productividad IA** (Fuente: Faros AI, AI Productivity Paradox Report 2025)

| Métrica | Variación | Tipo |
| ------- | --------- | ---- |
| Tareas completadas | +21% | Ganancia individual |
| PRs mergeados | +98% | Ganancia individual |
| Tiempo de revisión de PR | +91% | Coste del equipo |
| Tamaño medio del PR | +154% | Coste del equipo |
| Bugs por developer | +9% | Coste del equipo |

En 2025, las empresas invirtieron entre 30 y 40 mil millones de dólares en IA generativa.
El 95% de ellas reportó **cero retorno medible**. La tecnología no falla, es que se usa sin
estructura.

El informe AI Productivity Paradox de Faros AI (2025) analizó la telemetría de más de 10.000
developers en 1.255 equipos. **El cuello de botella no desaparece: se desplaza** de quien escribe
código a quien lo revisa.

Datos adicionales:

- Stack Overflow: el **66% de los developers** reporta que su mayor frustración con las
  herramientas de IA es que las soluciones son "casi correctas, pero no del todo"
- El **45% pierde tiempo significativo** debuggeando código generado por IA
- DORA 2024 (Google): la adopción de IA sin estructura → throughput de entrega **−1.5%**,
  estabilidad de entrega **−7.2%**
- METR Lab, julio 2025: en un ensayo controlado con 16 developers y 246 tareas reales, los
  developers **tardaron un 19% más** cuando usaban herramientas de IA que cuando trabajaban
  sin ellas

> Esto no significa que la IA no funcione. Significa que **la IA sin método no funciona como
> equipo.** Las ganancias individuales son reales. El problema es que el sistema entero —review,
> QA, integración, producción— no está preparado para absorberlas.

**La pregunta clave**: ¿Qué pasaría si antes de darle trabajo a la IA, le dieras también el
contexto completo de lo que necesitas, cómo tiene que encajar en el sistema existente y cuáles
son los criterios exactos de éxito? Eso es exactamente lo que resuelve Spec-Driven Development.

---

## 03. La Causa

### El trabajo mal definido

Hay un problema que lleva décadas en los equipos de desarrollo y que la IA no solo no resuelve,
sino que amplifica: **el trabajo llega mal definido a quien lo tiene que ejecutar.**

Ejemplos de trabajo que llega al developer sin especificar qué, por qué, cómo ni cuándo
es suficiente:

- Ticket de Jira: "Crear endpoint para listar usuarios"
- Slack: "Habría que mejorar el performance del dashboard"
- WhatsApp: "Necesitamos que la feature de exportación funcione también en mobile"

### El freno que desaparece con IA

| Sin IA | Con IA |
| ------ | ------ |
| El developer tardaba horas en implementar algo. En ese tiempo solía descubrir los problemas de definición y volver al negocio a aclarar. | Puedes implementar en minutos lo que antes tardabas horas. Y también puedes implementar mal en minutos lo que antes habrías tardado horas en implementar mal. |

### Síntomas del trabajo mal definido con IA

- PRs con comentarios "esto no era lo que pedí"
- La misma feature implementada dos veces de forma distinta
- QA rechaza tickets con requisitos no documentados
- Developer hace suposiciones e implementa todas (o ninguna)
- Code review dura días porque nadie sabe qué se intenta hacer
- Deuda técnica que crece por decisiones sin información suficiente

### Los datos del sistema roto

| Síntoma | Dato |
| ------- | ---- |
| PRs con rework o rechazados | Tasa de aceptación del 32.7% vs. PRs manuales — el 67%+ requiere correcciones |
| IA sin contexto del proyecto | El 65% de developers dice que la IA pierde el contexto relevante en tareas críticas: refactoring, tests o code review |
| Inconsistencia con estándares del equipo | El 44% dice que la IA degrada la calidad del código y atribuye el problema a gaps de contexto |
| PRs bloqueados en revisión | Ciclo medio de 7 días — los PRs permanecen 5 días inactivos. Los PRs de IA esperan 4.6x más antes de ser recogidos |

*Fuentes: LinearB Software Engineering Benchmarks 2025 · Qodo State of AI Code Quality 2025*

> **La solución empieza aquí**: No se trata de frenar la velocidad de la IA. Se trata de
> asegurarse de que la IA **corre en la dirección correcta desde el principio.** Y para eso
> necesitas una especificación: un contrato claro entre el negocio, el producto y la
> implementación técnica.

---

## 04. Los 3 Pilares

### Los 3 pilares del uso efectivo de la IA

Cuando hablamos de usar la IA de forma efectiva en desarrollo de software, hay tres dimensiones
que determinan el 99% de los resultados.

- **Tool**: No todas las herramientas son iguales, y controlar bien cada parámetro es la clave
- **Prompt**: Dado que a través de nuestras instrucciones es como operamos a los copilotos IA,
  es fundamental hacerlo bien
- **Context**: El pilar más importante a día de hoy para asegurar que lo que genera la IA se
  alinea con tu forma de programar y con las directrices del proyecto

### Pilar 1: Tool — La herramienta y su configuración

La herramienta importa, pero menos de lo que crees. Cursor, Windsurf, GitHub Copilot, Claude
Code… todos son capaces de generar código de calidad. **La diferencia está en cómo los
configuras, no en cuál eliges.**

Un copiloto sin configurar es un junior que no sabe nada de tu empresa, tu arquitectura ni tus
estándares. Un copiloto bien configurado es un senior que ya ha pasado un onboarding en tu
proyecto antes de escribir una sola línea.

**Qué configurar como mínimo**:

- Modelo LLM (no siempre el más potente es el mejor para cada tarea)
- Reglas del proyecto (`.cursorrules`, `CLAUDE.md`, `.windsurfrules`)
- Memoria persistente
- MCPs de integración con Jira/Linear, GitHub, bases de datos

**Configuración recomendada del IDE**:

| MCPs | Modelos | Otros |
| ---- | ------- | ----- |
| Contexto: Jira, Context7, Figma (Framelink) | Opus, Codex o Gemini Pro | Privacy mode ON |
| QA: Playwright | En Cursor: composer 1 es muy rápido | Memories ON |
| Errores & Seguridad: Sentry, Snyk | | |

### Pilar 2: Prompt — Cómo le das instrucciones a la IA

El prompt engineering no ha muerto, pero sí ha evolucionado. Los buenos prompts tienen tres
características (como mínimo) que los malos no tienen:

- **Objetivo claro**: Qué tiene que hacer y para qué. Sin ambigüedad
- **Restricciones**: Qué NO tocar, qué estándares respetar
- **Formato de salida**: Código, tests, docs, propuesta en markdown…

**Guía de Prompt Engineering**:

| Técnica | Descripción |
| ------- | ----------- |
| Zero-shot prompting | Respuesta sin ejemplos previos |
| One-shot prompting | Un ejemplo para orientar la respuesta |
| Few-shot prompting | Múltiples ejemplos para afinar la precisión |

**Características de un buen prompt**:

- Instrucción clara
- Estructura lógica y precisión
- Contexto adecuado
- Formato de salida definido
- Tono y estilo adecuados
- Rol asignado cuando sea relevante

**META PROMPT — Convierte cualquier prompt básico en uno estructurado de alta precisión**:

```text
# Instructions
You are an expert in prompt engineering.
Given the following prompt, prepare it using best-practice structure (role, objective, etc.)
and formatting to achieve a precise and comprehensive result. Stick strictly to the
requested objective by carefully analyzing what is asked in the original prompt.

# Original Prompt
[Your prompt here]
```

### Pilar 3: Context — El escalón que la mayoría se salta

Es el pilar más importante y el más ignorado. La razón: **el contexto no da feedback inmediato.**
Un prompt malo lo ves enseguida. Un contexto pobre es traicionero: el output parece razonable,
pero no encaja con tu sistema, no sigue tus convenciones, no tiene en cuenta las decisiones que
ya tomaste. El problema aparece más tarde, en el code review, en el QA, en producción.

> **Sin contexto, la IA inventa. Con contexto, la IA extiende.**

La mayoría de equipos trabajan bien en Tool y en Prompt. **Donde fallan es en Context.**

---

## 05. Context Engineering

### La receta perfecta del contexto

La mayoría de equipos que fracasan con la IA tienen el mismo diagnóstico: **cada developer
trabaja con un contexto diferente.** El resultado es código inconsistente, reviews interminables
y una IA que parece brillante en los demos y mediocre en producción.

**La solución es construir el contexto una sola vez, de forma que toda la organización lo use
igual.**

La receta perfecta del Contexto tiene tres ingredientes:

1. **Especificaciones técnicas** — Cómo es el sistema
2. **Flujo de trabajo** — Cómo funciona el equipo
3. **Compartido y actualizado** — No es un documento. Es un sistema vivo que crece con cada feature

### Especificaciones técnicas

Todo lo que define cómo está construido tu sistema y bajo qué reglas opera. No qué hace — eso
es el negocio — sino **cómo está hecho.**

| Qué documentar | Contenido |
| -------------- | --------- |
| Stack tecnológico | Lenguajes, frameworks, runtime, versiones |
| Setup del entorno | Variables, dependencias, configuración local |
| Arquitectura | Estructura de capas, módulos, responsabilidades |
| Modelo de datos | Entidades, relaciones, constraints |
| Convenciones de código | Naming, patrones acordados por el equipo |
| Diseño de APIs | REST vs RPC, formatos, versionado, autenticación |
| Estructura de tests | Frameworks, mocking, cobertura mínima |
| Git workflow | Branching, commits, PR process |
| Error handling y logging | Estrategia de errores, formato de logs |
| Seguridad | Autenticación, autorización, validación de inputs |

**Cómo lo entrega la IA** — No en Confluence. En ficheros que el copiloto lee directamente:

- `CLAUDE.md` — Contexto general del proyecto
- `.cursorrules` — Reglas de Cursor
- `testing-standards.mdc` — Convenciones de tests
- `frontend-standards.mdc` — Estándares de frontend

Uno por dominio. Todos referenciados desde un archivo base.

**Resultado**: La IA ya sabe cómo trabaja tu equipo antes de que le hagas la primera pregunta.

### Flujo de trabajo

Las especificaciones técnicas le dicen a la IA cómo es el sistema. El flujo de trabajo le dice
cómo funciona el equipo — y qué define que cada entregable es excelente.

| Responsable | Entregable | Qué debe contener | Valor con SDD |
| ----------- | ---------- | ----------------- | -------------- |
| Negocio / PM | User story | PRD con objetivo, usuarios afectados y valor esperado | Evita features que nadie pidió exactamente |
| Tech Lead | Ticket técnico | Especificación con criterios de aceptación, restricciones y tareas | La IA genera el 80% si la user story es buena |
| Developer | Código + tests | Implementación que cumple la spec, con cobertura de casos de error | Con SDD el copiloto ejecuta el contrato |
| QA automático | Testing report | Suite completa: unit, integration, E2E, análisis de seguridad | Se genera junto al código, no después |
| Code review | PR validado | Review contra spec, no contra intuición del revisor | Elimina el "¿esto era lo que pedías?" |

> **Práctica recomendada**: Usa `git worktrees` para cada ticket. Cada rama tiene su propio
> contexto activo sin interferir con el resto del equipo.

### Contexto compartido y actualizado

Este es el elemento diferencial. **El contexto no es un documento que escribes una vez. Es un
sistema vivo**: cada spec completada con SDD se convierte en contexto para la siguiente feature.
Cada decisión de arquitectura documentada evita que la IA la revierta de forma ingenua.

**El flywheel que lo cambia todo**:

1. Feature completada con SDD → Genera documentación automáticamente
2. Documentación → contexto → Para la siguiente feature
3. Cada iteración → El sistema se vuelve más preciso

Sin contexto compartido, cada sesión empieza desde cero. Con él, cada sesión empieza desde
donde lo dejó el equipo.

| Sin contexto compartido | Con Context Engineering |
| ----------------------- | ----------------------- |
| Cada developer usa su propio estilo y reglas | Mismo output independientemente de quién escribe el prompt |
| La IA propone soluciones que rompen la arquitectura | Nuevas features encajan con decisiones ya tomadas |
| La calidad depende del seniority del prompt | El contexto compensa instrucciones imprecisas |
| Un junior genera código fuera de los patrones del equipo | Un junior genera código con patrones de senior desde el día 1 |

*DORA 2024 (Google): La adopción de IA sin estructura mejora los resultados individuales pero
degrada los resultados del equipo. Throughput de entrega: −1.5%. Estabilidad de entrega: −7.2%.*

---

## 06. Qué es SDD

### Spec-Driven Development

Durante décadas, el código ha sido el rey. Las especificaciones eran una estructura provisional
que construíamos y descartábamos en cuanto empezaba el trabajo de programar.

**Spec-Driven Development invierte ese orden de forma deliberada.**

La spec se convierte en la fuente. El source-of-truth. Todo lo demás —el código, los tests,
las migraciones, los endpoints, la documentación— son proyecciones vivas de esa definición.
El developer ya no programa cada detalle: **diseña el contrato que los agentes deben cumplir.**

> **Definición operativa**: Spec-Driven Development es una metodología de ingeniería donde la
> especificación escrita es la fuente de verdad de todo el proceso de desarrollo. La spec es el
> contrato entre el negocio y la implementación. Define qué tiene que hacer el sistema, cómo
> tiene que comportarse, cuáles son los criterios de aceptación y qué decisiones técnicas se han
> tomado. Cuando ese contrato existe, la IA tiene suficiente información para generar código,
> tests y documentación que realmente encajen.

### SDD no es documentación. Es ingeniería de intención

El malentendido más frecuente es confundir SDD con "escribir más documentación". No es eso.
**Documentar el código que ya existe es arqueología. Especificar antes de implementar es
ingeniería.**

Cuando especificas antes de implementar, el proceso de escritura de la spec es en sí mismo una
herramienta de pensamiento. Te obliga a:

- Descubrir los edge cases antes de que estén en producción
- Alinear expectativas antes de que el PR esté abierto
- Tomar decisiones de diseño antes de que sean costosas de cambiar

### Dos niveles de spec: sistema y feature

| Tipo | Propósito | Cuándo se escribe | Quién la mantiene |
| ---- | --------- | ----------------- | ----------------- |
| **Spec de sistema** | Define la arquitectura, convenciones globales, modelo de datos, patrones y decisiones técnicas permanentes del proyecto | Al inicio del proyecto y se actualiza con cada decisión de arquitectura significativa | Tech Lead / CTO |
| **Spec de feature** | Define un cambio concreto dentro del sistema: qué se construye, sus criterios de aceptación, sus restricciones y sus tareas | Antes de cada ciclo de desarrollo, por cada feature o historia de usuario | Developer responsable de la feature |

La spec de sistema le dice a la IA cómo es el mundo en el que vive el proyecto. La spec de
feature le dice a la IA qué tiene que hacer hoy. **Ambas deben estar presentes en el contexto
del agente en cada sesión.**

### Qué incluye una buena spec de feature

Una spec en SDD no es un documento de 50 páginas. Es un documento estructurado, markdown-first,
que incluye los elementos esenciales para que tanto un humano como una IA puedan entender
exactamente qué se quiere construir y por qué.

| Elemento | Qué responde | Ejemplo concreto |
| -------- | ------------ | ---------------- |
| **Objetivo** | ¿Por qué lo hacemos? | Reducir el tiempo de revisión de candidatos un 40% eliminando la navegación manual entre perfiles |
| **Capacidades** | ¿Qué debe hacer el sistema? | El sistema permite filtrar candidatos por estado (activo / descartado / en proceso) y ordenar por score |
| **Criterios de aceptación** | ¿Cómo sabemos que está bien? | Dado un recruiter con 50 candidatos, cuando filtra por estado "en proceso", entonces solo ve los candidatos en ese estado y el contador se actualiza |
| **Restricciones** | ¿Qué no puede hacer? | Sin modificar el modelo de datos existente de candidates. Sin tocar la capa de servicios |
| **Decisiones técnicas** | ¿Cómo lo hacemos? | PATCH en lugar de PUT para actualizaciones parciales. Filtrado en cliente para listas < 500 |
| **Casos de error** | ¿Qué pasa cuando falla? | Si el API devuelve 500, mostrar banner de error no bloqueante |
| **Tareas** | ¿Qué pasos de implementación? | 1. Añadir componente FilterBar con tests unitarios. 2. Integrar en CandidateList. 3. Test E2E de flujo completo |

### El impacto: spec mala vs spec bien escrita

| | Spec incompleta | Spec bien escrita |
| - | -------------- | ----------------- |
| **Requisito** | "Añadir filtros a la lista de candidatos" | "Añadir filtro de estado a CandidateList con comportamiento server-side para listas > 500 registros, sin modificar CandidateService" |
| **Lo que genera la IA** | Filtros en cliente para todos los casos, sin tests de edge case, estructura propia no alineada con el componente existente | Lógica condicional cliente/servidor, tests para ambas ramas, código que extiende el componente existente respetando sus patrones |
| **Dónde explota** | En code review ("esto no era lo que pedí"), en QA (falla con 600 candidatos), en producción (degradación de rendimiento) | PR aprobado en primera revisión. Criterios de aceptación validados automáticamente antes de que llegue al revisor humano |

### Cuando el contrato cambia: gestión del cambio en SDD

> **El principio del cambio en SDD**: Una spec es inmutable una vez archivada. Los cambios
> futuros generan nuevas specs. Esta regla es la que garantiza la trazabilidad completa: cada
> commit puede seguirse hasta el requisito exacto que lo originó, incluso meses después.

| Situación | Protocolo SDD | Qué NO hacer |
| --------- | ------------- | ------------ |
| El requisito cambia antes de ejecutar la spec | Volver a `/enrich_us` con el cambio. El agente actualiza el Proposal antes de ejecutar | Ejecutar `/apply` con la spec anterior y "arreglar después" |
| El requisito cambia mientras `/apply` está en curso | Interrumpir la ejecución. Actualizar la spec de feature. Lanzar `/apply` de nuevo desde el punto de cambio | Continuar la ejecución y parchear el output manualmente |
| Se descubre que la decisión técnica inicial era incorrecta | Documentar el cambio en la spec (sección "Decisiones técnicas revisadas"). Actualizar la spec de sistema si afecta a patrones globales | Cambiar el código sin actualizar la spec |
| El cambio afecta a features ya archivadas | Abrir una nueva spec de feature para el cambio (nunca editar una spec archivada) | Editar specs archivadas, perdiendo la trazabilidad histórica |

### Del SDLC clásico al SDLC automatizado

En el SDLC automatizado, las fases no desaparecen: se comprimen y se interconectan.

- El análisis y el diseño ocurren mientras se escribe la spec
- La implementación, los tests y el despliegue ocurren cuando el agente ejecuta la spec
- El feedback real llega antes porque los criterios de aceptación ya estaban definidos desde
  el principio

Las funcionalidades de los copilotos avanzados permiten orquestar el proceso:

- **Commands**: Ejecutan acciones concretas (refinar la spec, generar código, crear tests,
  ejecutar migraciones). Para ello se apoya en agentes especializados
- **Hooks**: Permiten automatizar acciones en el ciclo de ejecución de Claude de manera
  sistemática
- **Agents**: Agentes especializados que ejecutan tareas basándose en la spec

> **SDD y el Thoughtworks Technology Radar**: En 2025, el Thoughtworks Technology Radar
> incorporó SDD como práctica emergente de alto impacto. No es un experimento de equipo startup.
> Es una práctica que ya está adoptando la ingeniería enterprise.

---

## 07. OpenSpec en la Práctica

### Del framework a la demo técnica

OpenSpec es el framework que usa LIDR para operacionalizar Spec-Driven Development en proyectos
reales. Funciona tanto en proyectos nuevos como en proyectos existentes, se integra con
cualquier copiloto —Cursor, Claude Code, Copilot— y estructura el trabajo en torno a un
principio simple: **la intención primero, la ejecución después.**

### El ciclo en tres pasos: Proposal → Apply → Archive

| Fase | Descripción |
| ---- | ----------- |
| **Proposal** | Conviertes la user story en una spec detallada. Define objetivos, criterios de aceptación y tareas concretas. Es el contrato que ejecutará el agente |
| **Apply** | El agente ejecuta la spec sin improvisar. Genera branch, tests, código, documentación y testing report. Todo en paralelo, todo trazable |
| **Archive** | La spec verificada se archiva como fuente de verdad. No desaparece: se convierte en contexto para la siguiente feature |

### El ciclo no es lineal: cómo gestionar la iteración

Los tres escenarios de iteración más frecuentes son:

1. **Descubrimiento durante /apply**: el agente genera código y detecta que la spec no
   contemplaba un caso de uso del sistema existente. El protocolo correcto es pausar, actualizar
   la spec y relanzar `/apply` desde el punto de cambio. No parchear el código y seguir.

2. **Feedback del code review humano**: el revisor identifica un problema de diseño. Si el
   cambio es menor (renombrar, ajustar lógica), se resuelve en el PR. Si el cambio afecta a la
   intención de la feature, se vuelve a Proposal y se actualiza la spec antes de relanzar.

3. **Cambio de requisito externo**: el PM cambia el scope a mitad del ciclo. El proceso es
   actualizar la spec primero, ejecutar después.

> **La regla de oro de la iteración**: Nunca hay código que no tenga una spec. Si tienes que
> hacer un cambio que no está contemplado en la spec activa, actualiza la spec primero. Aunque
> sea un cambio de dos líneas. La trazabilidad completa vale exactamente ese overhead.

### Ciclo de desarrollo OpenSpec LIDR

```text
User Story
    ↓ /enrich_us
Refined User Story
    ↓ /new + /ff
Proposal Artifacts (Branch + Test + Documentation + Code + Testing Report + Proposal Update)
    ↓ /apply
Feature For PR
    ↓ /code-review + implemented
    ↓ /commit
feature Ready
    ↓ /verify + /archive
Feature Published
```

**Comandos del ciclo**:

| Comando | Fase | Qué hace el sistema |
| ------- | ---- | ------------------- |
| `/enrich_us` | Enriquecer historia | El agente analiza la user story, detecta ambigüedades, formula las preguntas que nadie había hecho, produce una Refined User Story con el contexto técnico necesario para especificar bien |
| `/new + /ff` | Generar Proposal | A partir de la user story refinada, el agente genera los Proposal Artifacts: spec completa con diseño, tareas y criterios de aceptación. Aquí es donde se definen también los casos de error y las restricciones explícitas |
| `/apply` | Ejecutar contrato | El agente ejecuta el contrato. Genera en paralelo: Branch, Tests, Documentation, Code, Testing Report y Proposal Update. Si encuentra ambigüedad, la señala y espera instrucción |
| `/code-review` | Revisión contra spec | El agente hace una primera revisión del código generado contra la spec, detecta inconsistencias y las resuelve antes de que llegue al revisor humano |
| `/commit` | Commit estructurado | El agente genera el mensaje de commit estructurado (Conventional Commits) con referencia a la spec y mueve el trabajo a Feature Ready |
| `/verify + /archive` | Verificar y archivar | Verificación final contra todos los criterios de aceptación de la spec. Si el contrato se cumple, la proposal se integra en specs/ y la feature pasa a Published |

### La granularidad correcta de las tareas

El problema más frecuente al ejecutar `/apply` es que el agente improvisa. La causa es casi
siempre la misma: las tareas en la spec eran demasiado grandes o demasiado vagas.

| Tarea demasiado grande (el agente improvisa) | Tarea bien granularizada (el agente ejecuta) |
| -------------------------------------------- | -------------------------------------------- |
| Implementar el sistema de filtrado de candidatos | Crear componente FilterBar con props: `filters: FilterState`, `onChange: callback`. Incluir tests unitarios para: estado vacío, un filtro activo, múltiples filtros activos |
| Añadir los tests | Test E2E: dado recruiter autenticado en `/positions/123/candidates`, cuando selecciona filtro "en proceso", entonces la URL incluye `?status=in_progress` y la lista muestra solo candidatos con ese estado |
| Documentar los cambios | Actualizar ADR-0042 con la decisión de filtrado client-side vs server-side. Añadir ejemplo de uso de FilterBar en el Storybook existente bajo categoría `Candidates` |

**La regla práctica**: una tarea está bien granularizada cuando puedes escribir su criterio de
éxito en una sola frase. Si necesitas "y" o "además" para describir qué debe hacer, divídela.

### /code-review: qué hace realmente el agente

| El agente valida | El agente NO puede validar |
| ---------------- | -------------------------- |
| Que cada criterio de aceptación de la spec tiene un test que lo cubre | Que el criterio de aceptación captura correctamente la necesidad real de negocio |
| Que el código generado no modifica los módulos marcados como "sin tocar" en Restricciones | Que la restricción era la correcta en primer lugar |
| Que los nombres, patrones y convenciones siguen lo definido en la spec de sistema | Que la arquitectura elegida es la más adecuada para el problema |
| Que todos los casos de error definidos en la spec tienen manejo explícito en el código | Que no existen casos de error que la spec no contemplaba |
| Que la estructura de ficheros sigue la definida en el proyecto | Que el diseño de la spec es técnicamente óptimo |

> **El riesgo de la validación circular**: El riesgo principal del `/code-review` automatizado
> es que la IA genera spec, código y tests del mismo source of truth. Si la spec estaba
> equivocada, el código y los tests serán consistentes entre sí pero incorrectos respecto al
> problema real. **La solución**: los criterios de aceptación deben ser escritos por quien conoce
> el negocio (PM, product owner) y revisados por un humano antes de que el agente ejecute.

### La estructura de ficheros y cómo escala

```text
openspec/
├── specs/                      # Source of truth: el comportamiento del sistema
│   └── <domain>/
│       └── spec.md
├── changes/                    # Una carpeta por cada cambio propuesto
│   └── <change-name>/
│       ├── proposal.md
│       ├── design.md
│       ├── tasks.md
│       └── specs/              # Delta specs: solo lo que cambia
│           └── <domain>/
│               └── spec.md
└── config.yaml                 # Configuración del proyecto (opcional)
```

Convenciones adicionales para equipos grandes:

- **Naming de changes**: prefijo de ticket + descripción corta. Ejemplo: `PROJ-1234-candidate-filters`
- **TTL de proposals activas**: si una feature lleva más de dos semanas en `changes/` sin
  archivar, es deuda
- **Ownership explícito**: cada carpeta en `changes/` tiene un `OWNER.md`
- **Git worktrees por ticket**: cada rama de trabajo tiene su propio contexto activo sin
  interferir con el resto del equipo. **Una spec activa = un worktree = una rama.**

### Lo que genera el ciclo completo automatizado

Cuando el ciclo funciona bien, cada feature produce automáticamente:

- **Tests unitarios** que cubren los criterios de aceptación de la spec, incluyendo los casos
  de error definidos explícitamente
- **Tests E2E** que navegan el producto verificando el comportamiento real desde la perspectiva
  del usuario
- **Pull Request** con descripción estructurada que referencia la spec y los criterios de
  aceptación verificados
- **Primera code review automática** con issues detectados antes de que llegue al revisor humano
- **Documentación actualizada** que refleja los cambios realizados, las decisiones técnicas
  tomadas y los ADRs correspondientes
- **Análisis preventivo de seguridad** sobre el código generado

### Cuatro prácticas que lo hacen funcionar

1. **Empieza siempre por el contrato**: Antes de pedir nada a la IA, define inputs, outputs,
   estados y reglas de negocio. Aunque sea en versión mínima, que quede por escrito y versionado.

2. **Diseña para el error, no solo para el éxito**: No basta con describir el happy path. La IA
   necesita saber cómo manejar errores, límites y estados inválidos. Una spec sin casos de error
   es una spec a medias.

3. **Usa ejemplos concretos**: No solo reglas de formato o convenciones de nombres: incluye
   ejemplos de payloads, respuestas y casos de test completos.

4. **Trata la spec como código**: No es un documento temporal que se pierde en una carpeta. Es
   parte del sistema. Cada commit se puede trazar hasta el requisito que lo originó.

### Frameworks SDD: por dónde empezar

SDD se puede aplicar con cualquier copiloto. Lo importante al elegir un framework es que resuelva
cuatro cosas: facilidad de arranque, buenas prácticas de manejo del contexto, gestión de cambios
en features existentes e integración con tu IDE.

Las opciones actuales más relevantes:

- **SpecKit** — bueno para proyectos greenfield. `github.com/github/spec-kit`
- **BMAD** — muy potente, curva de arranque alta. Para equipos con madurez en el proceso.
  `github.com/bmad-code-org/BMAD-METHOD`
- **OpenSpec** ⭐ — funciona para proyectos nuevos y existentes. Recomendación LIDR para
  empezar. `github.com/Fission-AI/OpenSpec`
- **ai-specs LIDR** — punto de partida si prefieres construir el tuyo.
  `github.com/LIDR-academy/ai-specs`

---

## 08. Casos de Éxito

### Adopción IA en equipos de desarrollo

La metodología funciona en papel. Estos equipos la tienen funcionando en producción. El
denominador común: **la IA como capacidad de equipo, no como herramienta individual.**

### Mercado Libre — E-commerce y fintech · América Latina · +18 países

**El problema**: A pesar de tener acceso a Copilot y ChatGPT, solo el 30% del equipo usaba IA
de forma activa. Sin buenas prácticas compartidas ni métricas de impacto, cada developer
improvisaba su propio método.

**Lo que cambió**: Oscar Urrego (Senior Engineering Manager) implementó AI4Devs con
acompañamiento 1 a 1. El foco era estandarizar el uso de IA en cada fase del ciclo —código,
code reviews y testing.

**Resultados**:

- Adopción activa de IA: 30% → **92%**
- Código generado con IA: **30%** del equipo
- Code reviews asistidas: **30%**

> *"Lo más valioso de AI4Devs fue su enfoque práctico. Desde el primer día pude aplicar lo
> aprendido con mi equipo."*
> — Oscar Urrego, Senior Engineering Manager, Mercado Libre

### Bdeo — Soluciones tech para seguros y movilidad · Scaleup

**El problema**: Resistencia al cambio en equipos técnicos, cuellos de botella manuales en code
reviews y documentación, y ausencia de una metodología clara para medir el impacto real de la IA.

**Lo que cambió**: El CTO y los Heads of Engineering adoptaron Cursor como herramienta principal,
establecieron métricas DORA como estándar de medición y crearon agentes internos para automatizar
procesos críticos.

**Resultados**:

- Velocidad de desarrollo: **+16%**
- Errores en producción: **−25%**
- Tiempo en code reviews: **−30%**

> *"La IA no es solo tecnología; es cambio cultural. Medir, comunicar y acompañar al equipo es
> tan importante como elegir las herramientas."*
> — Rafael Castillo, VP of Technology, Bdeo

### InfoJobs (Adevinta) — Plataforma de empleo · +11M candidatos · Enterprise

**El problema**: Adopción desigual: los juniors usaban IA, los seniors la evitaban. Miedo a la
"caja negra" en sistemas críticos. Ausencia de criterios compartidos.

**Lo que cambió**: Tomás Casquero (Engineering Manager) implementó AI4Devs B2B con enfoque en el
ciclo completo. El equipo creó MCPs conectados a Jira y GitHub para hacer cumplir estándares
automáticamente.

**Resultados**:

- Documentar microservicio: de 1 semana → **1 día**
- Estándares aplicados: **MCPs** automáticos
- Dependencias de conocimiento: **0 dependencias**

> *"Destacaría la naturaleza práctica de la formación. Las sesiones fueron eminentemente
> prácticas, centradas en escenarios reales para distintos perfiles."*
> — Tomás Casquero, Engineering Manager, InfoJobs

---

## 09. AI Assessment 2026

### Descubre tu nivel

El AI Assessment de LIDR es una evaluación gratuita que mide tu nivel real de adopción de IA
y te da un diagnóstico personalizado con comparativa de mercado y recomendaciones de mejora
concretas.

**Qué obtendrás al completar la evaluación**:

- **Diagnóstico en 6 dimensiones**: Uso individual, uso colectivo, liderazgo técnico, contexto
  operativo, mejora continua y resultados
- **Recomendaciones accionables**: Plan de mejora para las áreas con más oportunidad
- **Comparativa con el mercado**: Compara tu perfil con profesionales similares
- **Resultados inmediatos y gratis**: Sin registro obligatorio, sin tarjeta de crédito

**Elige tu evaluación**:

| Assessment | Nivel | Tiempo | Preguntas |
| ---------- | ----- | ------ | --------- |
| AI Assisted Development | Recomendado para empezar | 3-5 min | 12 preguntas |
| AI Maturity Assessment | Avanzado | 8-13 min | 30 preguntas |

> Según el Pluralsight 2026 Tech Forecast, las organizaciones que miden su adopción de IA
> con criterios claros tienen **3.4x más probabilidades** de reportar ROI positivo en los
> 6 meses siguientes.

---

## 10. Agentic Engineer

### ¿Quieres convertirte en Agentic Engineer?

La IA no falla por "alucinar" tanto como falla por **falta de definición, contexto y
validación.** Ser AI-Powered Developer no va de saber prompts: va de convertir la IA en un
sistema repetible y escalable sin perder el control.

### Para quién es AI4Devs

- **Developers mid-senior**: Quieren entrar al mercado con una ventaja diferencial real
- **Tech Leads y Product Owners técnicos**: Quieren multiplicar su impacto y convertirse en
  el referente de IA en su equipo
- **Engineering managers, CEOs y CTOs**: Necesitan llevar la adopción de IA al nivel de equipo
  con método, métricas y estándares

### Qué incluye

- 32 horas de sesiones en vivo
- 36 horas (30 prácticas + 6 labs opcionales)
- Clases presenciales online con demos prácticas y casos de estudio reales
- Programación práctica: código real desde el primer día
- Q&A con mentores TOP
- Certificado final validado por LIDR
- Comunidad exclusiva de expertos

### Lo que dicen los developers

> *"Este máster ha sido una de las mejores decisiones de mi carrera. Me dio la base y las
> prácticas para usar IA en desarrollo de software de forma efectiva y enfocada a negocio.
> Pude crear un MVP funcional en solo un día aplicando prompting, testing y Cursor IDE."*
> — Erik Rodríguez, Full Stack AI Developer

> *"AI4Devs marcó un antes y un después en mi forma de aprender, pensar y construir tecnología.
> Aprendí a integrar IA en mis proyectos de forma natural, automatizando tareas y ampliando la
> calidad del código."*
> — Leandro Alberto García, Líder Técnico

---

## Conclusión

> "Los developers predijeron que la IA reduciría su tiempo un 24%.
> Al terminar, seguían creyendo que les había hecho un 20% más rápidos.
> La realidad era exactamente la opuesta."
>
> — METR Lab, 2025

Empezaste este playbook con una paradoja. **La IA te acelera… hasta que revisas el PR.**

Si has llegado hasta aquí, ya tienes el método para que eso no vuelva a pasar.

---

**Fuente**: LIDR — Escuela de referencia en IA aplicada al desarrollo de software  
**Founder**: Álvaro Moya | CTO · LinkedIn Top Voice | 100.000+ developers formados  
**Contacto**: lidr.co | hi@lidr.co  
**Repositorio OpenSpec**: github.com/Fission-AI/OpenSpec
