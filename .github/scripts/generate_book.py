import os
from bs4 import BeautifulSoup

root_dir = "."
output_file = "FigureYa_contents.html"
chapter_template = """
<section id="{chapter_id}">
  <h2>{chapter_title}</h2>
  {chapter_content}
</section>
"""

toc_entries = []
chapters_html = []

for folder in sorted(os.listdir(root_dir)):
    if os.path.isdir(folder) and not folder.startswith('.'):
        html_files = [f for f in sorted(os.listdir(folder)) if f.endswith('.html')]
        if html_files:
            chapter_id = folder.replace(' ', '_')
            toc_entries.append(f'<li><a href="#{chapter_id}">{folder}</a></li>')
            chapter_contents = []
            for fname in html_files:
                with open(os.path.join(folder, fname), encoding='utf-8') as f:
                    raw_html = f.read()
                    # 用BeautifulSoup处理，去除所有<img>标签
                    soup = BeautifulSoup(raw_html, "html.parser")
                    for img in soup.find_all("img"):
                        img.decompose()
                    chapter_contents.append(str(soup))
            chapters_html.append(chapter_template.format(
                chapter_id=chapter_id,
                chapter_title=folder,
                chapter_content='\n'.join(chapter_contents)
            ))

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
