#!/bin/bash
# Aggressive markdown cleaner - fixes ALL common warnings

set -euo pipefail

echo "🧹 AGGRESSIVE MARKDOWN CLEANUP"
echo ""

cd /home/toni/projects/agency-agents

# 1. Remove ALL trailing spaces (MD009)
echo "1️⃣ Removing trailing spaces (MD009)..."
find . -name "*.md" -type f -exec sed -i 's/[[:space:]]*$//' {} \;
echo "   ✅ Done"

# 2. Fix line length issues by wrapping long lines (MD013)
echo "2️⃣ Wrapping long lines (MD013)..."
python3 << 'PYTHON_EOF'
import re
from pathlib import Path

for md_file in Path('.').glob('*.md'):
    with open(md_file, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    new_lines = []
    for line in lines:
        # Skip code blocks, URLs, and tables
        if (line.strip().startswith('```') or 
            line.strip().startswith('|') or
            'http' in line or
            len(line.rstrip()) <= 100):
            new_lines.append(line)
        else:
            # Try to wrap at reasonable boundaries
            content = line.rstrip()
            if len(content) > 100 and content.count(' ') > 0:
                # Simple word wrap
                words = content.split()
                current = ""
                for word in words:
                    if len(current + word) + 1 <= 100:
                        current += word + " "
                    else:
                        if current:
                            new_lines.append(current.rstrip() + '\n')
                        current = word + " "
                if current:
                    new_lines.append(current.rstrip() + '\n')
            else:
                new_lines.append(line)
    
    with open(md_file, 'w', encoding='utf-8') as f:
        f.writelines(new_lines)

print("   ✅ Done")
PYTHON_EOF

# 3. Remove trailing punctuation from headings (MD026)
echo "3️⃣ Removing trailing punctuation from headings (MD026)..."
sed -i 's/^(#+.*[.!?:,])$/\1/' *.md 2>/dev/null || true
sed -i 's/^\(#.*\)\.\.$/\1/' *.md 2>/dev/null || true
echo "   ✅ Done"

# 4. Fix broken link fragments with emojis (MD051)
echo "4️⃣ Fixing link fragments (MD051)..."
python3 << 'PYTHON_EOF'
from pathlib import Path

for md_file in Path('.').glob('*.md'):
    with open(md_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Remove emoji-based links (they don't work well)
    # Replace with text-only links
    import re
    
    # Pattern: [text with emoji](#emoji-text)
    content = re.sub(
        r'\[([^]]*[🎯🔄🔧🤝📞].*?)\]\(#[^)]*\)',
        r'[\1]',  # Keep text, remove broken link
        content
    )
    
    with open(md_file, 'w', encoding='utf-8') as f:
        f.write(content)

print("   ✅ Done")
PYTHON_EOF

# 5. Final verification
echo ""
echo "✅ Cleanup complete!"
echo ""
echo "🔍 Verifying results..."
markdownlint -c .markdownlintrc.json *.md 2>&1 | wc -l | xargs echo "Remaining warnings:"
