import os, re

def get_html_files(base_path, branch_label):
    toc = []
    for folder in sorted(os.listdir(base_path)):
        folder_path = os.path.join(base_path, folder)
        if os.path.isdir(folder_path) and not folder.startswith('.'):
            html_files = [f for f in os.listdir(folder_path) if f.endswith('.html')]
            if html_files:
                def num_key(name):
                    m = re.match(r'(\d+)', name)
                    return int(m.group(1)) if m else 99999
                html_files_sorted = sorted(html_files, key=num_key)
                toc.append(f"<li><b>{branch_label}/{folder}</b><ul>")
                for fname in html_files_sorted:
                    rel_path = os.path.relpath(os.path.join(folder_path, fname), ".")
                    toc.append(f'<li><a href="{rel_path}">{fname}</a></li>')
                toc.append("</ul></li>")
    return toc

toc_entries = []
toc_entries.extend(get_html_files(".", "main"))
toc_entries.extend(get_html_files("master_dir", "master"))

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

with open("index.html", "w", encoding="utf-8") as f:
    f.write(html_output)
