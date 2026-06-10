# Markdown Conventions for Anclora Agency Agents

**Purpose**: Prevent linting warnings and ensure consistent documentation style
**Applies to**: All `.md` files in this repository
**Last Updated**: 2026-06-10

---

## Golden Rule

**All Markdown files MUST:**

1. Have blank lines around code blocks (MD031)
2. Use language identifiers on all code blocks
3. Keep lines ≤ 100 characters (except URLs, tables, code)
4. Use consistent heading hierarchy (no skipped levels)
5. Use semantic HTML when needed for complex layouts

---

## Code Blocks (MD031: Blanks Around Fences)

### ❌ WRONG: No blank line before code block

```markdown

### Example

```python
def hello():
    print("world")

```text

```text

### ✅ CORRECT: Blank line before and after

```markdown

### Example

```python
def hello():
    print("world")

```text

More text here...

```text

### Rule

```text

[paragraph or heading]
[BLANK LINE] ← REQUIRED

```[language]
[code content]

```text

[BLANK LINE] ← REQUIRED
[next paragraph or heading]

```text

---

## Language Identifiers on Code Blocks

### Supported Languages

Use these identifiers for code blocks:

```yaml
Common:

  - python    # Python code
  - bash      # Shell/Bash scripts
  - yaml      # YAML/configuration
  - json      # JSON data
  - javascript
  - typescript
  - html
  - css
  - markdown  # Markdown examples
  - sql       # SQL queries

Data/Config:

  - toml      # TOML configuration
  - ini       # INI configuration
  - env       # Environment variables

Special:

  - text      # Plain text, ASCII art
  - diff      # Diff/patch output
  - console   # Terminal output

```text

### Examples

#### ✅ Python code

```python
def example():
    return "formatted"

```text

#### ✅ Shell commands

```bash
#!/bin/bash
echo "Hello World"

```text

#### ✅ YAML configuration

```yaml
config:
  key: value
  nested:
    item: 1

```text

#### ✅ Plain text / ASCII art

```text
   OPUS
 (Complex)
  2,500 tokens

```text

#### ✅ Terminal output

```console
$ python script.py
Output line 1
Output line 2

```text

#### ✅ JSON example

```json
{
  "key": "value",
  "nested": {
    "item": 1
  }
}

```text

### ❌ WRONG: Missing language identifier

```text

def hello():
    print("world")

```text

### ✅ CORRECT: With language identifier

```python
def hello():
    print("world")

```text

---

## Line Length (≤ 100 characters)

### Exceptions (lines CAN exceed 100 chars)

1. **URLs**: `https://example.com/very/long/path/that/exceeds/100/chars`
2. **Markdown tables**: Table rows can exceed 100 chars
3. **Code blocks**: Code inside fences is not constrained (but keep <120)
4. **Links**: `[text](path/to/very/long/url/that/exceeds/100/characters)`

### ✅ CORRECT: Wrapped text

```markdown
This is a long explanation that would normally exceed 100 characters, so I
break it into multiple lines to keep readability and linting compliance across
different editors.

```text

### Rule

Check with:

```bash
awk 'length > 100 && !/^https:/ && !/^[|]/ && !/@test/ {print NR": " $0}' file.md

```text

---

## Heading Hierarchy

### ❌ WRONG: Skipped levels

```markdown

# Main Title

### Subsection (skipped ## level)

```text

### ✅ CORRECT: Consistent hierarchy

```markdown

# Main Title

## Section

### Subsection

#### Details

```text

### Rule

```text

# H1 ← Only ONE per document (the title)

## H2 ← Major sections

### H3 ← Subsections

#### H4 ← Details (avoid going deeper)

```text

**Never**:

- Skip heading levels (H1 → H3 is wrong)
- Use multiple H1 headings
- Go deeper than H4 (use bold text instead)

---

## Lists

### ✅ Ordered Lists

```markdown

1. First item
2. Second item
3. Third item

   Continuation of item 3 with proper indentation

```text

### ✅ Unordered Lists

```markdown

- Item 1
- Item 2
  - Nested item 2a
  - Nested item 2b
- Item 3

```text

### ❌ WRONG: Inconsistent list markers

```markdown

- Item 1
* Item 2 (mixing - and *)
+ Item 3

```text

### ✅ CORRECT: Consistent markers

```markdown

- Item 1
- Item 2
- Item 3

```text

---

## Tables

### ✅ Well-formatted Table

```markdown
 | Column 1 | Column 2 | Column 3 |
 | ---------- | ---------- | ---------- |
 | Content | Content | Content |
 | Item A | Item B | Item C |

```text

### Rules

- Align columns with pipes `|`
- Use at least 3 dashes per column: `---`
- Blank line before and after table
- Can exceed 100 character line length

### ❌ WRONG: Misaligned

```markdown
 | Col 1 | Col 2 |
 | --- | --- |
 | A | B |

```text

### ✅ CORRECT: Aligned

```markdown
 | Col 1 | Col 2 |
 | ------- | ------- |
 | A | B |

```text

---

## Links

### ✅ Relative Links (for navigation within repo)

```markdown
[See this document](ANCLORA_TOKEN_REDUCTION_STRATEGY.md)
[See a subsection](#token-savings-calculation)

```text

### ✅ Absolute URLs

```markdown
[Visit Anthropic](https://anthropic.com)
[GitHub Repo](https://github.com/ToniIAPro73/agency-agents)

```text

### ❌ WRONG: file:// protocol (not valid in static docs)

```markdown
[file://home/user/document.md](file://home/user/document.md) ← BAD

```text

### ✅ CORRECT: Use relative paths

```markdown
[ANCLORA_TOKEN_REDUCTION_STRATEGY.md](ANCLORA_TOKEN_REDUCTION_STRATEGY.md)

```text

---

## Emphasis and Strong

### ✅ CORRECT

```markdown
*italic text* or _italic text_
**bold text** or __bold text__
***bold and italic***

```text

### ❌ WRONG: Mixing styles

```markdown
**bold and _italic*

```text

### ✅ CORRECT: Nested properly

```markdown
**bold with *italic* inside**

```text

---

## Special Formatting

### Blockquotes

```markdown
> This is a blockquote
> that continues on the next line
>
> And has a paragraph break
```text

### Horizontal Rules

```markdown
Use three dashes: ---
Or three asterisks: ***
Or three underscores: ___

```text

### Inline Code

```markdown
Use backticks: `function_name()` or `variable`

```text

---

## Checklist for Markdown Files

Before committing:

- [ ] All code blocks have blank lines before and after (MD031)
- [ ] All code blocks have language identifier (python, bash, yaml, text, etc.)
- [ ] No line exceeds 100 chars (except URLs, tables, code)
- [ ] Heading hierarchy is consistent (no skipped levels)
- [ ] Only ONE H1 heading per document
- [ ] All links use relative paths or full HTTPS URLs (no file://)
- [ ] Tables are properly aligned
- [ ] List markers are consistent (all `-` or all `*`, not mixed)
- [ ] No trailing whitespace on lines

### Quick Check

Run these commands:

```bash

# Check for blanks around code blocks (MD031)

grep -n "^[^ ]" file.md | grep -B1 "\`\`\`"

# Check line length

awk 'length > 100 && !/^https:/ && !/^[|]/ {print NR": " length($0) " chars"}' file.md | head -5

# Check for file:// links

grep -n 'file://' file.md

# Check code block language identifiers

grep -n '^\`\`\`$' file.md

```text

---

## Pre-commit Hook (Automatic Checking)

Add to `.git/hooks/pre-commit`:

```bash
#!/bin/bash
for file in $(git diff --cached --name-only | grep '\.md$'); do
  # Check for unclosed code blocks
  if ! awk '/^```/{count++} END {exit count%2}' "$file"; then
    echo "❌ Unclosed code block in $file"
    exit 1
  fi

  # Check for file:// links
  if grep -q 'file://' "$file"; then
    echo "❌ Invalid file:// link in $file"
    exit 1
  fi
done

```text

---

## Auto-fix Script

Use the provided script to automatically fix common issues:

```bash
bash scripts/fix-markdown-warnings.sh

```text

This fixes:

- MD031 (blanks around code blocks)
- Line length warnings
- Missing language identifiers (reports only, manual fix needed)

---

## IDE Integration

### VS Code

Install **markdownlint** extension:

```json
// .vscode/settings.json
{
  "markdownlint.config": {
    "MD031": true,  // Blanks around fences
    "MD033": false, // Allow inline HTML
    "MD013": {
      "line_length": 100,
      "code_blocks": true,
      "code_fence": false,
      "url": false
    }
  }
}

```text

### Pre-commit Framework

```yaml

# .pre-commit-config.yaml

repos:

  - repo: https://github.com/igorshubovych/markdownlint-cli

    rev: v0.32.1
    hooks:

      - id: markdownlint

        args: [--fix, --disable=MD033]

```text

---

## Common Mistakes & Fixes

 | Mistake | Fix | Example |
 | --------- | ----- | --------- |
 | No blank before ``` | Add blank line | [before code] [blank] [```] |
 | No blank after ``` | Add blank line | [```] [blank] [next text] |
 | Missing language | Add language ID | ```python not just ``` |
 | Line too long | Break into multiple | Use multiple lines ≤100 chars |
 | Skipped heading | Use proper level | Use ## before ### |
 | file:// URLs | Use relative paths | [text](file.md) not file:// |
 | Mixed list markers | Use consistent marker | All `-` or all `*` |

---

## Template for New Documents

```markdown

# Document Title

**Purpose**: One-line description
**Last Updated**: YYYY-MM-DD
**Applies to**: [Scope]

---

## Section

Content with proper formatting.

### Subsection

More details here.

---

## References

- [Link 1](document1.md)
- [Link 2](https://example.com)

---

**Status**: DRAFT | READY | DEPRECATED
**Owner**: Name

```text

---

## Summary

**The 5-Minute Check:**

```bash

# 1. Check blanks around code blocks

grep -n "^[^ ]" *.md | grep -B1 "\`\`\`"

# 2. Check line length

awk 'length > 100 && !/^http/ && !/^|/ {print NR": " length($0)}' *.md

# 3. Check file:// links

grep -n 'file://' *.md

# 4. Check heading levels

grep '^#' *.md

# 5. Check unclosed code blocks

awk '/^```/{count++} END {if(count%2) print "UNCLOSED"}' *.md

```text

---

## When to Apply

- **Immediately**: Before every commit
- **Automatically**: With pre-commit hook or IDE extension
- **Cleanup**: Run `scripts/fix-markdown-warnings.sh` monthly

---

**Status**: FINAL
**Enforced**: Yes (CI/CD gate recommended)
**Last Review**: 2026-06-10
