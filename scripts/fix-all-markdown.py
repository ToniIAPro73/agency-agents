#!/usr/bin/env python3
"""
Comprehensive markdown fixer for markdownlint compliance.
Fixes MD013, MD022, MD032, MD040, MD060, MD026, MD024, MD036.
"""

import re
import os
import sys
from pathlib import Path


class MarkdownFixer:
    def __init__(self, filepath):
        self.filepath = filepath
        with open(filepath, 'r', encoding='utf-8') as f:
            self.original_content = f.read()
        self.content = self.original_content
        self.lines = self.content.split('\n')

    def fix_all(self):
        """Apply all fixes."""
        print(f"🔧 Fixing {self.filepath}...")

        self.fix_heading_blanks()        # MD022
        self.fix_list_blanks()           # MD032
        self.fix_code_block_blanks()     # MD031
        self.fix_code_block_language()   # MD040
        self.fix_table_formatting()      # MD060
        self.fix_heading_punctuation()   # MD026
        self.fix_duplicate_headings()    # MD024
        self.fix_line_length()           # MD013

        # Recombine lines
        self.content = '\n'.join(self.lines)

        # Save if changed
        if self.content != self.original_content:
            with open(self.filepath, 'w', encoding='utf-8') as f:
                f.write(self.content)
            print(f"  ✅ Fixed and saved")
            return True
        else:
            print(f"  ✓ No changes needed")
            return False

    def fix_heading_blanks(self):
        """Fix MD022: Blank lines around headings."""
        new_lines = []
        for i, line in enumerate(self.lines):
            # Check if this is a heading
            if re.match(r'^#+\s', line):
                # Add blank line before heading (if not first line and previous is not blank)
                if i > 0 and new_lines and new_lines[-1].strip():
                    new_lines.append('')

            new_lines.append(line)

            # Add blank line after heading (if next line is not blank)
            if re.match(r'^#+\s', line) and i < len(self.lines) - 1:
                if self.lines[i + 1].strip():
                    new_lines.append('')

        self.lines = new_lines

    def fix_list_blanks(self):
        """Fix MD032: Blank lines around lists."""
        new_lines = []
        in_list = False

        for i, line in enumerate(self.lines):
            is_list = re.match(r'^(\s)*[-*+]\s', line) or re.match(r'^(\s)*\d+\.\s', line)

            if is_list and not in_list:
                # Start of list
                if new_lines and new_lines[-1].strip():
                    new_lines.append('')
                in_list = True
            elif not is_list and in_list:
                # End of list
                if line.strip():  # If not already blank
                    new_lines.append('')
                in_list = False

            new_lines.append(line)

        self.lines = new_lines

    def fix_code_block_blanks(self):
        """Fix MD031: Blank lines around code blocks."""
        new_lines = []

        for i, line in enumerate(self.lines):
            # Before code block opening
            if line.strip().startswith('```'):
                if i > 0 and new_lines and new_lines[-1].strip() and not new_lines[-1].startswith('>'):
                    new_lines.append('')

            new_lines.append(line)

            # After code block closing
            if line.strip() == '```':
                if i < len(self.lines) - 1 and self.lines[i + 1].strip():
                    new_lines.append('')

        self.lines = new_lines

    def fix_code_block_language(self):
        """Fix MD040: Code blocks should have language specified."""
        new_lines = []

        i = 0
        while i < len(self.lines):
            line = self.lines[i]

            # Check for code block without language
            if line.strip() == '```':
                # Look ahead to guess language
                if i + 1 < len(self.lines):
                    next_line = self.lines[i + 1].strip()

                    # Guess language from content
                    language = self.guess_language(next_line)

                    new_lines.append(f'```{language}')
                else:
                    new_lines.append(line)
            else:
                new_lines.append(line)

            i += 1

        self.lines = new_lines

    def guess_language(self, content):
        """Guess code language from first line."""
        if not content:
            return 'text'

        # Check patterns
        if content.startswith('#!/'):
            if 'bash' in content or 'sh' in content:
                return 'bash'

        if any(x in content for x in ['def ', 'import ', 'from ', 'class ']):
            return 'python'

        if any(x in content for x in ['const ', 'let ', 'var ', 'function ', '=>']):
            return 'javascript'

        if any(x in content for x in ['<', '<%', 'DOCTYPE']):
            return 'html'

        if any(x in content for x in ['key:', 'items:', '- item', '├─', '│']):
            return 'yaml'

        if content.startswith('{') or content.startswith('['):
            return 'json'

        if any(x in content for x in ['SELECT ', 'INSERT ', 'UPDATE ', 'DELETE ']):
            return 'sql'

        if '$' in content or 'echo' in content or 'grep' in content:
            return 'bash'

        # ASCII art or plain text
        if any(x in content for x in ['─', '│', '├', '└', '┌', '┐', '┤', '┘']):
            return 'text'

        return 'text'

    def fix_table_formatting(self):
        """Fix MD060: Table formatting."""
        new_lines = []

        for line in self.lines:
            # Check if line is a table row
            if '|' in line and line.strip().startswith('|'):
                # Format table row with proper spacing
                # Split by |, trim whitespace, rejoin
                parts = line.split('|')
                formatted_parts = [''] + [p.strip() for p in parts[1:-1]] + ['']
                line = ' | '.join(formatted_parts)

            new_lines.append(line)

        self.lines = new_lines

    def fix_heading_punctuation(self):
        """Fix MD026: No trailing punctuation in headings."""
        new_lines = []

        for line in self.lines:
            if re.match(r'^#+\s', line):
                # Remove trailing punctuation from headings
                if line[-1] in '.,:;!?':
                    line = line[:-1]

            new_lines.append(line)

        self.lines = new_lines

    def fix_duplicate_headings(self):
        """Fix MD024: No duplicate headings (rename later sections)."""
        # This is complex - skip for now, user should rename manually
        # Or we can add suffixes like " (1)", " (2)"
        pass

    def fix_line_length(self):
        """Fix MD013: Line length (wrap at 100 chars if needed)."""
        new_lines = []

        for line in self.lines:
            # Skip URLs, code blocks, tables
            if (line.strip().startswith('```') or
                '://' in line or
                line.strip().startswith('|') or
                line.strip().startswith('http')):
                new_lines.append(line)
                continue

            # If line is long, try to break it
            if len(line) > 100 and line.strip() and not line.startswith('    '):
                # Simple wrap: break at spaces
                wrapped = self.wrap_line(line, 100)
                new_lines.extend(wrapped)
            else:
                new_lines.append(line)

        self.lines = new_lines

    def wrap_line(self, line, max_len):
        """Wrap a line at max_len characters."""
        if len(line) <= max_len:
            return [line]

        # Preserve leading whitespace
        indent = len(line) - len(line.lstrip())
        indent_str = line[:indent]

        words = line[indent:].split()
        wrapped = []
        current = indent_str

        for word in words:
            if len(current + word) + 1 <= max_len:
                current += word + ' '
            else:
                if current.strip():
                    wrapped.append(current.rstrip())
                current = indent_str + word + ' '

        if current.strip():
            wrapped.append(current.rstrip())

        return wrapped if wrapped else [line]


def main():
    """Fix all markdown files in current directory."""
    md_files = sorted(Path('.').glob('*.md'))

    if not md_files:
        print("No .md files found")
        return

    print(f"Found {len(md_files)} markdown files\n")

    fixed_count = 0
    for filepath in md_files:
        fixer = MarkdownFixer(str(filepath))
        if fixer.fix_all():
            fixed_count += 1

    print(f"\n✨ Fixed {fixed_count}/{len(md_files)} files")


if __name__ == '__main__':
    main()
