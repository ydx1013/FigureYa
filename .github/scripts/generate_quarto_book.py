import os, re, shutil, subprocess
from bs4 import BeautifulSoup

REPO = "https://github.com/ying-ge/FigureYa.git"
CLONE_BASE = "FigureYa_tmp"
BRANCHES = ["main", "master"]
BOOK_DIR = "quarto_book"

def get_numeric_key(filename):
    nums = re.findall(r'\d+', filename)
    return int(nums[0]) if nums else float('inf')

def html_to_quarto_section(html_path):
    with open(html_path, encoding='utf-8') as f:
        html = f.read()
    soup = BeautifulSoup(html, 'html.parser')
    body = soup.body if soup.body else soup
    return str(body)

def collect_chapters(repo_dir, prefix):
    chapters = []
    for folder in sorted(os.listdir(repo_dir)):
        folder_path = os.path.join(repo_dir, folder)
        if os.path.isdir(folder_path) and not folder.startswith('.'):
            html_files = [f for f in os.listdir(folder_path) if f.endswith('.html')]
            html_files.sort(key=get_numeric_key)
            sections = []
            for fname in html_files:
                section_title = os.path.splitext(fname)[0]
                section_content = html_to_quarto_section(os.path.join(folder_path, fname))
                sections.append((section_title, section_content))
            if sections:
                chapters.append({
                    "chapter_id": f"{prefix}_{folder}",
                    "title": folder,
                    "sections": sections
                })
    return chapters

def main():
    if os.path.exists(CLONE_BASE):
        shutil.rmtree(CLONE_BASE)
    if os.path.exists(BOOK_DIR):
        shutil.rmtree(BOOK_DIR)
    os.makedirs(BOOK_DIR, exist_ok=True)

    all_chapters = []
    for branch in BRANCHES:
        branch_dir = os.path.join(CLONE_BASE, branch)
        subprocess.run([
            "git", "clone", "--depth", "1", "--branch", branch, REPO, branch_dir
        ], check=True)
        all_chapters += collect_chapters(branch_dir, branch)

    seen = set()
    uniq_chapters = []
    for chap in all_chapters:
        if chap['chapter_id'] not in seen:
            uniq_chapters.append(chap)
            seen.add(chap['chapter_id'])

    toc_entries = []
    for chap in uniq_chapters:
        qmd_name = f"{chap['chapter_id']}.qmd"
        with open(os.path.join(BOOK_DIR, qmd_name), "w", encoding="utf-8") as f:
            f.write(f"# {chap['title']}\n\n")
            for section_title, section_content in chap["sections"]:
                f.write(f"## {section_title}\n\n")
                f.write(section_content + "\n\n")
        toc_entries.append({"file": qmd_name, "title": chap['title']})

    with open(os.path.join(BOOK_DIR, "_toc.yml"), "w", encoding="utf-8") as f:
        f.write("format: html\n")
        f.write("root: index.md\n")
        f.write("chapters:\n")
        f.write("  - file: index.md\n")
        for entry in toc_entries:
            f.write(f"  - file: {entry['file']}\n")

    with open(os.path.join(BOOK_DIR, "_quarto.yml"), "w", encoding="utf-8") as f:
        f.write("project:\n  type: book\nbook:\n  title: \"FigureYa 电子书\"\n  author: \"@ying-ge\"\n  search: true\n")

    src_index = None
    for name in ["index.md", "index.qmd"]:
        if os.path.exists(name):
            src_index = name
            break
    if src_index:
        shutil.copy(src_index, os.path.join(BOOK_DIR, src_index))
    else:
        with open(os.path.join(BOOK_DIR, "index.md"), "w", encoding="utf-8") as f:
            f.write("# FigureYa 电子书\n\n本电子书由 @ying-ge/FigureYa (main/master分支) 自动生成。")

if __name__ == "__main__":
    main()
