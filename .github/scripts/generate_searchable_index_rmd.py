import os
import re
import json
from bs4 import BeautifulSoup

PUBLISH_DIR = "."  # 输出到根目录

def extract_number(s):
    m = re.search(r'(\d+)', s)
    return int(m.group(1)) if m else 999999

def extract_gallery_base(foldername):
    m = re.match(r'(FigureYa\d+)', foldername)
    return m.group(1) if m else None

def get_rmd_preview_content(rmd_path):
    """从Rmd文件中提取预览内容（代码块和注释）"""
    try:
        with open(rmd_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 提取YAML头部信息（如果有）
        yaml_match = re.search(r'^---\s*\n(.*?)\n---\s*\n', content, re.DOTALL)
        title = os.path.basename(rmd_path).replace('.Rmd', '').replace('.rmd', '')
        description = ""
        
        if yaml_match:
            yaml_content = yaml_match.group(1)
            title_match = re.search(r'title:\s*["\']?(.*?)["\']?\s*$', yaml_content, re.MULTILINE)
            if title_match:
                title = title_match.group(1)
            
            # 提取描述信息
            desc_match = re.search(r'description:\s*["\']?(.*?)["\']?\s*$', yaml_content, re.MULTILINE)
            if desc_match:
                description = desc_match.group(1)
        
        # 提取注释和代码块作为预览内容
        preview_lines = []
        lines = content.split('\n')
        
        for line in lines:
            # 提取注释
            if line.strip().startswith('#'):
                preview_lines.append(line.strip())
            # 提取代码块标记
            elif re.match(r'^```\{r.*\}', line.strip()):
                preview_lines.append(line.strip())
        
        return title, description, '\n'.join(preview_lines[:20])  # 返回前20行预览
        
    except Exception as e:
        return "Error reading Rmd", "", f"Could not read Rmd file: {str(e)}"

def get_rmd_content_for_display(rmd_path):
    """获取Rmd文件的完整内容，用于在线显示"""
    try:
        with open(rmd_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 对内容进行基本清理和格式化
        content = content.replace('<', '&lt;').replace('>', '&gt;')
        return content
    except Exception as e:
        return f"Error reading Rmd file: {str(e)}"

def create_rmd_viewer_page(folder, filename, rmd_path):
    """为Rmd文件创建专门的在线查看页面"""
    content = get_rmd_content_for_display(rmd_path)
    safe_filename = filename.replace('.', '_').replace(' ', '_')
    
    # 确保rmd_viewers目录存在（在PUBLISH_DIR下）
    viewers_dir = os.path.join(PUBLISH_DIR, "rmd_viewers")
    os.makedirs(viewers_dir, exist_ok=True)
    
    viewer_path = os.path.join(viewers_dir, f"{folder}_{safe_filename}.html")
    
    # 计算相对路径（从viewer页面回到根目录）
    relative_path_to_root = "../"
    
    viewer_html = f"""
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>View RMD: {filename}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/github.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/highlight.min.js"></script>
    <script>hljs.highlightAll();</script>
    <style>
        body {{ 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; 
            margin: 0; 
            padding: 20px; 
            background: #f8f9fa; 
        }}
        .container {{ 
            max-width: 1200px; 
            margin: 0 auto; 
            background: white; 
            padding: 30px; 
            border-radius: 12px; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
        }}
        .header {{ 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; 
            padding: 25px; 
            border-radius: 8px; 
            margin-bottom: 25px; 
        }}
        .code-container {{ 
            background: #f8f9fa; 
            border: 1px solid #e9ecef; 
            border-radius: 8px; 
            padding: 20px; 
            overflow-x: auto; 
        }}
        pre {{ 
            margin: 0; 
            white-space: pre-wrap; 
            word-wrap: break-word; 
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace; 
            font-size: 14px; 
            line-height: 1.5; 
        }}
        .code-block {{ 
            color: #24292e; 
        }}
        .back-btn {{ 
            margin-bottom: 20px; 
        }}
        .back-btn button {{
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            background: #6c757d;
            color: white;
            cursor: pointer;
            margin-right: 10px;
            font-size: 14px;
        }}
        .back-btn button:hover {{
            background: #5a6268;
        }}
        .action-buttons {{
            margin-top: 15px;
        }}
        .action-buttons a {{
            display: inline-block;
            padding: 8px 16px;
            background: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            margin-right: 10px;
            font-size: 14px;
        }}
        .action-buttons a:hover {{
            background: #218838;
        }}
        .action-buttons a.download {{
            background: #17a2b8;
        }}
        .action-buttons a.download:hover {{
            background: #138496;
        }}
        .file-info {{
            background: rgba(255,255,255,0.1);
            padding: 10px;
            border-radius: 6px;
            margin-top: 10px;
        }}
    </style>
</head>
<body>
    <div class="container">
        <div class="back-btn">
            <button onclick="window.history.back()">← Back</button>
            <button onclick="window.location.href='{relative_path_to_root}index.html'">🏠 Home</button>
        </div>
        
        <div class="header">
            <h1>📄 {filename}</h1>
            <div class="file-info">
                <strong>Folder:</strong> {folder} <br>
                <strong>File:</strong> {filename} <br>
                <strong>Type:</strong> R Markdown Document
            </div>
        </div>
        
        <div class="action-buttons">
            <a href="{relative_path_to_root}{rmd_path}" download class="download">💾 Download RMD</a>
            <a href="#" onclick="window.print(); return false;">🖨️ Print</a>
        </div>
        
        <div class="code-container">
            <pre><code class="language-r">{content}</code></pre>
        </div>
    </div>
</body>
</html>
    """
    
    with open(viewer_path, "w", encoding="utf-8") as f:
        f.write(viewer_html)
    
    print(f"✅ Created viewer: {viewer_path}")

def strip_outputs_and_images(raw_html):
    """清理HTML内容（仅用于HTML文件）"""
    soup = BeautifulSoup(raw_html, "html.parser")
    for img in soup.find_all("img"):
        img.decompose()
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
    return soup.get_text(separator="\n", strip=True)

def get_html_files(base_path, branch_label, chapters_meta):
    folders = [f for f in os.listdir(base_path) if os.path.isdir(os.path.join(base_path, f)) and not f.startswith('.')]
    folders_sorted = sorted(folders, key=extract_number)
    
    # 首先确保rmd_viewers目录存在
    viewers_dir = os.path.join(PUBLISH_DIR, "rmd_viewers")
    os.makedirs(viewers_dir, exist_ok=True)
    print(f"📁 Created directory: {viewers_dir}")
    
    for folder in folders_sorted:
        folder_path = os.path.join(base_path, folder)
        
        # 首先查找HTML文件
        html_files = [f for f in os.listdir(folder_path) if f.endswith('.html')]
        html_files_sorted = sorted(html_files, key=extract_number)
        
        # 查找Rmd文件
        rmd_files = [f for f in os.listdir(folder_path) if f.endswith('.Rmd') or f.endswith('.rmd')]
        rmd_files_sorted = sorted(rmd_files, key=extract_number)
        
        # 优先使用HTML，如果没有则使用Rmd
        target_files = html_files_sorted if html_files_sorted else rmd_files_sorted
        
        if target_files:
            gallery_base = extract_gallery_base(folder)
            thumb_path = f"gallery_compress/{gallery_base}.webp" if gallery_base else None
            if thumb_path and not os.path.isfile(os.path.join(PUBLISH_DIR, thumb_path)):
                thumb_path = None
            
            for fname in target_files:
                file_path = os.path.join(folder_path, fname)
                rel_path = os.path.relpath(file_path, PUBLISH_DIR)
                chap_id = f"{branch_label}_{folder}_{fname}".replace(" ", "_").replace(".html", "").replace(".Rmd", "").replace(".rmd", "")
                
                # 根据文件类型处理内容
                if fname.endswith('.html'):
                    with open(file_path, encoding='utf-8') as f:
                        raw_html = f.read()
                        text = strip_outputs_and_images(raw_html)
                    file_type = "html"
                    title = f"{folder}/{fname}"
                    description = ""
                else:  # Rmd文件
                    title, description, text = get_rmd_preview_content(file_path)
                    file_type = "rmd"
                    # 为Rmd文件创建专门的查看页面
                    create_rmd_viewer_page(folder, fname, file_path)
                
                texts_dir = os.path.join(PUBLISH_DIR, "texts")
                os.makedirs(texts_dir, exist_ok=True)
                text_path = os.path.join("texts", f"{chap_id}.txt")
                abs_text_path = os.path.join(PUBLISH_DIR, text_path)
                
                with open(abs_text_path, "w", encoding="utf-8") as tf:
                    tf.write(text)
                
                chapters_meta.append({
                    "id": chap_id,
                    "title": title,
                    "file": rel_path,
                    "file_type": file_type,
                    "text": text_path,
                    "folder": folder,
                    "thumb": thumb_path,
                    "description": description
                })

# 主执行逻辑
print("🚀 Starting website generation...")
chapters_meta = []
get_html_files(".", "main", chapters_meta)

# 写入chapters.json
with open(os.path.join(PUBLISH_DIR, "chapters.json"), "w", encoding="utf-8") as jf:
    json.dump(chapters_meta, jf, ensure_ascii=False, indent=2)
print("✅ Created chapters.json")

# 生成index.html的HTML内容
html_output = """
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>FigureYa Results Browser</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/fuse.js/6.6.2/fuse.min.js"></script>
  <script>
    // 加载搜索数据
    let fuse;
    let chaptersData = [];

    fetch('chapters.json')
      .then(response => response.json())
      .then(data => {
        chaptersData = data;
        // 为搜索准备文本内容
        return Promise.all(data.map(item => 
          fetch(item.text)
            .then(response => response.text())
            .then(text => {
              item.text_content = text;
              return item;
            })
            .catch(() => {
              item.text_content = '';
              return item;
            })
        ));
      })
      .then(dataWithContent => {
        // 配置Fuse.js进行模糊搜索
        fuse = new Fuse(dataWithContent, {
          keys: ['title', 'text_content', 'description', 'folder'],
          includeScore: true,
          threshold: 0.4,
          ignoreLocation: true,
          minMatchCharLength: 2
        });
        renderTOC();
      });

    function getFileLink(item) {
      if (item.file_type === 'rmd') {
        // 对于Rmd文件，链接到专门的查看页面
        const safeName = item.file.replace('.', '_').replace(' ', '_');
        return `rmd_viewers/${item.folder}_${safeName}.html`;
      }
      return item.file;
    }

    function getLinkText(item) {
      return item.file_type === 'rmd' ? 'View RMD Online' : 'View HTML';
    }

    function doSearch() {
      const query = document.getElementById('searchBox').value.trim();
      const resultsContainer = document.getElementById('searchResults');
      
      if (!query) {
        resultsContainer.innerHTML = '<p>Please enter a search term.</p>';
        return;
      }

      if (!fuse) {
        resultsContainer.innerHTML = '<p>Search index loading...</p>';
        return;
      }

      const results = fuse.search(query);
      
      if (results.length === 0) {
        resultsContainer.innerHTML = '<p>No results found for "' + query + '"</p>';
        return;
      }

      let html = '<h2>Search Results (' + results.length + ' found)</h2>';
      results.slice(0, 20).forEach(result => {
        const item = result.item;
        const highlightedTitle = highlightText(item.title, query);
        const preview = item.text_content ? highlightText(item.text_content.substring(0, 150), query) + '...' : '';
        
        html += `
          <div class="result" style="border: 1px solid #eee; padding: 15px; margin: 10px 0; border-radius: 5px;">
            <div class="result-title" style="font-size: 1.2em; margin-bottom: 8px;">${highlightedTitle}</div>
            ${item.description ? `<div style="color: #666; margin-bottom: 8px;">${item.description}</div>` : ''}
            <div style="color: #888; font-family: monospace; margin-bottom: 10px;">${preview}</div>
            <div>
              <a href="${getFileLink(item)}" target="_blank" style="color: #0066cc; text-decoration: none;">
                ${getLinkText(item)}
              </a> 
              <span style="color: #ccc;">|</span>
              <a href="${item.file}" download style="color: #0066cc; text-decoration: none;">
                Download ${item.file_type.toUpperCase()}
              </a>
              ${item.file_type === 'rmd' ? `<span style="color: #ccc;">|</span>
              <a href="${item.text}" target="_blank" style="color: #0066cc; text-decoration: none;">
                View Text
              </a>` : ''}
            </div>
          </div>
        `;
      });
      
      if (results.length > 20) {
        html += `<p>... and ${results.length - 20} more results</p>`;
      }
      
      resultsContainer.innerHTML = html;
    }

    function highlightText(text, query) {
      if (!text) return '';
      const regex = new RegExp(`(${query.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')})`, 'gi');
      return text.replace(regex, '<span class="highlight" style="background: yellow; padding: 2px 0;">$1</span>');
    }

    function clearSearch() {
      document.getElementById('searchBox').value = '';
      document.getElementById('searchResults').innerHTML = '';
      document.getElementById('tocGrid').style.display = 'flex';
    }

    // 生成目录网格
    function renderTOC() {
      if (!chaptersData.length) return;
      
      const grid = document.getElementById('tocGrid');
      let html = '';
      
      chaptersData.forEach(item => {
        const thumb = item.thumb ? `<img src="${item.thumb}" alt="${item.title}" style="max-height: 100px;">` : 
          `<div style="height:100px; background:#f0f0f0; display:flex; align-items:center; justify-content:center; color:#666; font-size:0.9em;">
            ${item.file_type.toUpperCase()} File
          </div>`;
        
        html += `
          <div class="card">
            ${thumb}
            <div class="card-title">${item.title}</div>
            ${item.description ? `<div style="font-size:0.9em; color:#666; margin:5px 0; text-align:center;">${item.description}</div>` : ''}
            <div class="card-links">
              <a href="${getFileLink(item)}" target="_blank" style="display:block; margin:2px 0;">
                ${getLinkText(item)}
              </a>
              <a href="${item.file}" download style="display:block; margin:2px 0; color:#666;">
                Download
              </a>
            </div>
          </div>
        `;
      });
      
      grid.innerHTML = html;
    }

    // 页面加载完成后
    document.addEventListener('DOMContentLoaded', function() {
      document.getElementById('searchBox').addEventListener('keydown', function(e){
        if (e.key === 'Enter') doSearch();
      });
      
      document.getElementById('searchBox').addEventListener('input', function(e) {
        if (this.value.trim() === '') {
          clearSearch();
        }
      });
    });
  </script>
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; margin: 40px; background: #fafafa; }
    #searchBox { 
      padding: 12px; 
      font-size: 16px; 
      border: 2px solid #ddd; 
      border-radius: 8px; 
      width: 70%; 
      margin-right: 10px;
    }
    button { 
      padding: 12px 20px; 
      font-size: 16px; 
      border: none; 
      border-radius: 8px; 
      cursor: pointer; 
      background: #007bff; 
      color: white; 
    }
    button:hover { background: #0056b3; }
    #searchResults { margin-top: 2em; }
    .grid {
      display: flex;
      flex-wrap: wrap;
      gap: 22px;
      margin: 40px 0;
      padding: 0;
    }
    .card {
      flex: 1 0 250px;
      background: white;
      border-radius: 12px;
      padding: 16px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      transition: transform 0.2s, box-shadow 0.2s;
    }
    .card:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 16px rgba(0,0,0,0.15);
    }
    .card-title {
      font-weight: 600;
      font-size: 1.1em;
      margin: 12px 0;
      text-align: center;
      color: #333;
    }
    .card-links a {
      color: #007bff;
      text-decoration: none;
    }
    .card-links a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div style="max-width: 1000px; margin: 0 auto;">
    <h1 style="text-align: center; color: #333; margin-bottom: 30px;">FigureYa Results Browser</h1>
    
    <div style="text-align: center; margin-bottom: 30px;">
        <input type="text" id="searchBox" placeholder="🔍 Search across all FigureYa reports...">
        <button onclick="doSearch()">Search</button>
        <button onclick="clearSearch()" style="background: #6c757d;">Clear</button>
    </div>

    <div id="searchResults"></div>
    
    <h2 style="margin-top: 40px;">Browse All Reports</h2>
    <div id="tocGrid" class="grid"></div>
</div>

</body>
</html>
"""

# 写入index.html文件
with open(os.path.join(PUBLISH_DIR, "index.html"), "w", encoding="utf-8") as f:
    f.write(html_output)

print("✅ Created index.html")
print("🎉 Website generation completed!")
print("📁 Rmd viewers created in: ./rmd_viewers/")
print("🌐 Open index.html to start browsing")
