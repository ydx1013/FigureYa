import os
from bs4 import BeautifulSoup

root_dir = "."
chapters_dir = "chapters"
texts_dir = "texts"

os.makedirs(chapters_dir, exist_ok=True)
os.makedirs(texts_dir, exist_ok=True)

chapter_files = []

for folder in sorted(os.listdir(root_dir)):
    if os.path.isdir(folder) and not folder.startswith('.'):
        html_files = [f for f in sorted(os.listdir(folder)) if f.endswith('.html')]
        for fname in html_files:
            chapter_id = f"{folder}_{fname}".replace(" ", "_").replace(".html", "")
            with open(os.path.join(folder, fname), encoding='utf-8') as f:
                raw_html = f.read()
                soup = BeautifulSoup(raw_html, "html.parser")
                # 删除图片
                for img in soup.find_all("img"):
                    img.decompose()
                # 删除所有pre/code输出（R Markdown输出、Jupyter输出）
                for pre in soup.find_all("pre"):
                    code = pre.find("code")
                    if code and code.text.lstrip().startswith("##"):
                        pre.decompose()
                for div in soup.find_all("div", class_=lambda x: x and any("output" in c for c in x)):
                    div.decompose()
                for pre in soup.find_all("pre"):
                    parent = pre.parent
                    while parent:
                        if parent.has_attr("class") and any("output" in c for c in parent["class"]):
                            pre.decompose()
                            break
                        parent = parent.parent
                # 保存章节HTML
                html_path = os.path.join(chapters_dir, f"{chapter_id}.html")
                with open(html_path, "w", encoding="utf-8") as out_html:
                    out_html.write(str(soup))
                # 保存章节纯文本
                text_path = os.path.join(texts_dir, f"{chapter_id}.txt")
                with open(text_path, "w", encoding="utf-8") as out_txt:
                    text = soup.get_text(separator="\n", strip=True)
                    out_txt.write(text)
                chapter_files.append({"id": chapter_id, "title": f"{folder} / {fname}"})