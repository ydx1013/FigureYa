import os
import re

def get_html_files(base_dir, branch_name):
    toc = []
    branch_path = os.path.join(base_dir, branch_name)
    if not os.path.isdir(branch_path):
        return toc
    for folder in sorted(os.listdir(branch_path)):
        folder_path = os.path.join(branch_path, folder)
        if os.path.isdir(folder_path) and not folder.startswith('.'):
            html_files = [f for f in os.listdir(folder_path) if f.endswith('.html')]
            if html_files:
                # 提取文件名前的数字进行排序
                def num_key(name):
                    m = re.match(r'(\d+)', name)
                    return int(m.group(1)) if m else 99999
                html_files_sorted = sorted(html_files, key=num_key)
                toc.append(f"<li><b>{branch_name}/{folder}</b><ul>")
                for fname in html_files_sorted:
                    rel_path = f"{branch_name}/{folder}/{fname}"
                    toc.append(f'<li><a href="{rel_path}">{fname}</a></li>')
                toc.append("</ul></li>")
    return toc

branches = ["main_dir", "master_dir"]
branch_names = ["main", "master"]

toc_entries = []
for branch_dir, branch_name in zip(branches, branch_names):
    toc_entries.extend(get_html_files(".", branch_dir))

html_output = f"""
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>目录 contents</title>
  <style>
    body {{ font-family: Arial, sans-serif; }}
    ul {{ list-style-type: none; }}
    li > ul {{ margin-left: 2em; }}
  </style>
</head>
<body>
<h1>目录 contents (main & master)</h1>
<ul>
  {''.join(toc_entries)}
</ul>
</body>
</html>
"""

with open("contents.html", "w", encoding="utf-8") as f:
    f.write(html_output)
