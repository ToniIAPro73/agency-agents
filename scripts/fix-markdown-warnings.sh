#!/bin/bash
# Fix Markdown warnings automatically
# Fixes MD031 (blanks around fences) and other common issues

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

fix_md031_blanks_around_fences() {
    local file="$1"
    local temp_file="${file}.tmp"

    # Use Python to safely handle multiline replacements
    python3 << 'PYTHON_EOF'
import sys
import re

file_path = sys.argv[1]
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Fix MD031: Ensure blank lines before code fence opening
# Pattern: non-blank line followed by ```
content = re.sub(r'([^\n])\n(```)', r'\1\n\n\2', content)

# Fix MD031: Ensure blank lines after code fence closing
# Pattern: ``` followed by non-blank line
content = re.sub(r'(```)\n([^\n`])', r'\1\n\n\2', content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print(f"✓ Fixed MD031 in {file_path}")
PYTHON_EOF

    python3 - "$file" << 'PYTHON_EOF'
import sys
file_path = sys.argv[1]
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

import re

# Fix MD031: Ensure blank lines before code fence opening
content = re.sub(r'([^\n])\n(```)', r'\1\n\n\2', content)

# Fix MD031: Ensure blank lines after code fence closing
content = re.sub(r'(```)\n([^\n`])', r'\1\n\n\2', content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print(f"✓ Fixed MD031 in {file_path}")
PYTHON_EOF
}

fix_line_length() {
    local file="$1"
    local max_length=100

    python3 << 'PYTHON_EOF'
import sys
file_path = sys.argv[1]
max_length = int(sys.argv[2]) if len(sys.argv) > 2 else 100

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

long_lines = []
for i, line in enumerate(lines, 1):
    # Don't count markdown tables, links, code blocks
    if line.rstrip().startswith('|') or '```' in line or line.startswith('http'):
        continue
    if len(line.rstrip()) > max_length:
        long_lines.append((i, len(line.rstrip()), line.rstrip()))

if long_lines:
    print(f"⚠️  Lines > {max_length} chars in {file_path}:")
    for line_no, length, content in long_lines[:5]:
        print(f"  Line {line_no} ({length} chars): {content[:80]}...")
else:
    print(f"✓ All lines ≤ {max_length} chars in {file_path}")
PYTHON_EOF

    python3 - "$file" "$max_length" << 'PYTHON_EOF'
import sys
file_path = sys.argv[1]
max_length = int(sys.argv[2]) if len(sys.argv) > 2 else 100

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

long_lines = []
for i, line in enumerate(lines, 1):
    if line.rstrip().startswith('|') or '```' in line or line.startswith('http'):
        continue
    if len(line.rstrip()) > max_length:
        long_lines.append((i, len(line.rstrip()), line.rstrip()))

if long_lines:
    print(f"⚠️  Lines > {max_length} chars in {file_path}:")
    for line_no, length, content in long_lines[:5]:
        print(f"  Line {line_no} ({length} chars): {content[:80]}...")
else:
    print(f"✓ All lines ≤ {max_length} chars in {file_path}")
PYTHON_EOF
}

check_code_blocks() {
    local file="$1"

    python3 << 'PYTHON_EOF'
import sys
file_path = sys.argv[1]

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

import re

# Find all code blocks
code_blocks = re.findall(r'```(\w*)', content)
labeled = sum(1 for b in code_blocks if b)
unlabeled = sum(1 for b in code_blocks if not b)
total = len(code_blocks) // 2  # Opening and closing pairs

if total > 0:
    print(f"📊 Code blocks in {file_path}:")
    print(f"  Total pairs: {total}")
    print(f"  With language: {labeled // 2}")
    print(f"  Without language: {unlabeled // 2}")
    if unlabeled > 0:
        print(f"  ⚠️  Consider adding language to unlabeled blocks (text, bash, python, yaml, etc.)")
PYTHON_EOF

    python3 - "$file" << 'PYTHON_EOF'
import sys
file_path = sys.argv[1]

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

import re

code_blocks = re.findall(r'```(\w*)', content)
labeled = sum(1 for b in code_blocks if b)
unlabeled = sum(1 for b in code_blocks if not b)
total = len(code_blocks) // 2

if total > 0:
    print(f"📊 Code blocks in {file_path}:")
    print(f"  Total pairs: {total}")
    print(f"  With language: {labeled // 2}")
    print(f"  Without language: {unlabeled // 2}")
    if unlabeled > 0:
        print(f"  ⚠️  Consider adding language to unlabeled blocks")
PYTHON_EOF
}

main() {
    echo "🔧 Cleaning Markdown warnings..."
    echo ""

    cd "$PROJECT_ROOT"

    # Find all markdown files
    markdown_files=$(find . -maxdepth 1 -name "*.md" -type f | grep -v node_modules)

    for file in $markdown_files; do
        echo "Processing: $file"
        fix_md031_blanks_around_fences "$file" 2>/dev/null || true
        fix_line_length "$file" 2>/dev/null || true
        check_code_blocks "$file" 2>/dev/null || true
        echo ""
    done

    echo "✅ Markdown cleanup complete!"
}

main "$@"
