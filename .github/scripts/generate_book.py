import os
from bs4 import BeautifulSoup

def strip_outputs_and_images(raw_html):
    soup = BeautifulSoup(raw_html, "html.parser")
    # 删除所有图片
    for img in soup.find_all("img"):
        img.decompose()
    # 删除 R Markdown 的输出（以 ## 开头的 <pre><code>）
    for pre in soup.find_all("pre"):
        code = pre.find("code")
        if code and code.text.lstrip().startswith("##"):
            pre.decompose()
    # 删除 Jupyter Notebook 输出区
    for div in soup.find_all("div", class_=lambda x: x and any("output" in c for c in x)):
        div.decompose()
    # 删除 Jupyter Notebook 输出的 <pre>，如果它们在 output_area 内
    for pre in soup.find_all("pre"):
        parent = pre.parent
        while parent:
            if parent.has_attr("class") and any("output" in c for c in parent["class"]):
                pre.decompose()
                break
            parent = parent.parent
    return str(soup)

root_dir = "."
output_file = "FigureYa_searchable.html"
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
                    # 调用strip_outputs_and_images处理每个章节
                    cleaned_html = strip_outputs_and_images(raw_html)
                    chapter_contents.append(cleaned_html)
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
