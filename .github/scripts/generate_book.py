import os
import re

def sorted_folders_by_number(folder_list):
    def folder_key(name):
        m = re.search(r'(\d+)', name)
        return int(m.group(1)) if m else float('inf')
    return sorted(folder_list, key=folder_key)

def collect_html_sections(base_dir, branch_name):
    sections = []
    toc = []
    folders = [f for f in os.listdir(base_dir) if os.path.isdir(os.path.join(base_dir, f)) and not f.startswith('.')]
    folders = sorted_folders_by_number(folders)
    for folder in folders:
        folder_path = os.path.join(base_dir, folder)
        html_files = [f for f in sorted(os.listdir(folder_path)) if f.endswith('.html')]
        if html_files:
            chapter_id = f"{branch_name}_{folder.replace(' ', '_')}"
            toc.append(f'<li><a href="#{chapter_id}">{branch_name}: {folder}</a></li>')
            chapter_contents = []
            for fname in html_files:
                with open(os.path.join(folder_path, fname), encoding='utf-8') as f:
                    chapter_contents.append(f.read())
            sections.append(f"""
<section id="{chapter_id}">
  <h2>{branch_name}: {folder}</h2>
  {''.join(chapter_contents)}
</section>
""")
    return toc, sections

output_file = "FigureYa_contents.html"
toc_entries = []
chapters_html = []

# main 分支内容在前
main_toc, main_sections = collect_html_sections("main_dir", "main")
toc_entries += main_toc
chapters_html += main_sections

# master 分支内容在后
master_toc, master_sections = collect_html_sections("master_dir", "master")
toc_entries += master_toc
chapters_html += master_sections

html_output = f"""
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>FigureYa contents</title>
</head>
<body>
<h1>FigureYa contents</h1>
<nav>
  <h2>目录</h2>
  <ul>
    {''.join(toc_entries)}
  </ul>
</nav>
{''.join(chapters_html)}
</body>
</html>
"""

with open(output_file, "w", encoding='utf-8') as f:
    f.write(html_output)
