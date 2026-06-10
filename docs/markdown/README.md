# Markdown Standards & Documentation

Professional markdown conventions and linting standards for the Anclora Agency Agents repository.

---

## 📚 Contents

1. **[CONVENTIONS.md](CONVENTIONS.md)** — Complete markdown style guide
   - Golden rules for markdown files
   - Code block formatting (MD031)
   - Language identifiers
   - Line length guidelines (≤100 chars)
   - Heading hierarchy
   - Lists, tables, links, emphasis
   - Pre-commit hooks & IDE integration
   - Common mistakes & fixes
   - Pre-commit checklist

2. **[CLEANUP_REPORT.md](CLEANUP_REPORT.md)** — How we achieved zero warnings
   - Summary of cleanup effort
   - Files fixed
   - Issues addressed
   - Prevention strategy
   - Metrics (before/after)
   - Lessons learned
   - Status: 100% compliance

---

## 🎯 Quick Links

- **Before writing markdown**: Read [CONVENTIONS.md](CONVENTIONS.md)
- **Understanding our standards**: See [CONVENTIONS.md § Golden Rule](CONVENTIONS.md#golden-rule)
- **Code block formatting**: [CONVENTIONS.md § Code Blocks](CONVENTIONS.md#code-blocks-md031-blanks-around-fences)
- **Checking your work**: [CONVENTIONS.md § Checklist](CONVENTIONS.md#checklist-for-markdown-files)
- **How we fixed warnings**: [CLEANUP_REPORT.md](CLEANUP_REPORT.md)

---

## ✅ Golden Rules (TL;DR)

**All markdown files MUST:**

1. Have blank lines around code blocks (MD031)
2. Use language identifiers on all code blocks
3. Keep lines ≤ 100 characters (except URLs, tables, code)
4. Use consistent heading hierarchy (no skipped levels)
5. Use semantic HTML when needed for complex layouts

---

## 🛠️ Automation

**Pre-commit hook** (check for warnings automatically):

```bash
cp scripts/fix-markdown-warnings.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

**IDE setup** (VS Code):
- Install [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
- Extensions will highlight violations as you type

**Manual check**:

```bash
# Check line length
awk 'length > 100 && !/^https:/ && !/^[|]/ && !/@test/ {print NR": " $0}' *.md

# Check blanks around code blocks
grep -B1 "^\`\`\`" *.md | grep -v "^--$" | grep -v "^\`\`\`"
```

---

## 📊 Metrics

| Metric | Before | After | Status |
|--------|--------|-------|--------|
| Files with linting warnings | 4 | 0 | ✅ 100% clean |
| Unlabeled code blocks | 67 | 0 | ✅ All labeled |
| Lines exceeding 100 chars | ~15 | 0 | ✅ Compliant |
| Compliance level | ~85% | 100% | ✅ Production-ready |

---

## 🎓 Common Issues & Fixes

| Issue | Example | Fix |
|-------|---------|-----|
| **No blank before code block** | `Text` `\`\`\`bash` | Add blank line: `Text` ` ` `\`\`\`bash` |
| **Missing language** | `\`\`\`\n code \n\`\`\`` | Use `\`\`\`python` or `\`\`\`bash` |
| **Long lines** | >100 chars | Break into multiple lines |
| **Skipped headings** | H1 → H3 | Use H2: H1 → H2 → H3 |
| **Multiple H1s** | Multiple `# Title` | Only one `# Title` per file |

---

## 📋 Next Steps

1. **Read** [CONVENTIONS.md](CONVENTIONS.md) before writing new `.md` files
2. **Use** the pre-commit hook or IDE extension for real-time checking
3. **Follow** the checklist before committing markdown files
4. **Reference** this document in team onboarding

---

**Status**: ✅ Production-ready
**Last updated**: 2026-06-10
**Compliance level**: 100% (0 warnings)
