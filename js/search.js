let chapters = [];
let chapterTexts = [];

function highlight(text, terms) {
  let re = new RegExp("(" + terms.map(t => t.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')).join('|') + ")", "gi");
  return text.replace(re, '<span class="highlight">$1</span>');
}

// THIS FUNCTION IS NO LONGER USED FOR RENDERING, BUT MAY BE USED ELSEWHERE.
// WE LEAVE IT FOR NOW TO AVOID BREAKING OTHER PARTS.
function getGalleryBase(folder) {
  // 提取 FigureYa数字 作为图像前缀
  let m = folder.match(/(FigureYa\d+)/);
  return m ? m[1] : null;
}

function renderToc() {
  let tocGrid = document.getElementById("tocGrid");
  if (!tocGrid) {
    let ul = document.querySelector("ul");
    if (ul) {
      tocGrid = document.createElement("div");
      tocGrid.id = "tocGrid";
      tocGrid.className = "grid";
      ul.parentNode.replaceChild(tocGrid, ul);
    }
  }
  if (!tocGrid) return;

  // 1. 按文件夹分组
  let folderMap = {};
  chapters.forEach(item => {
    if (!folderMap[item.folder]) {
      // 在分组时，直接把正确的 thumb 路径存进去
      folderMap[item.folder] = { htmls: [], folder: item.folder, thumb: item.thumb };
    }
    folderMap[item.folder].htmls.push({ name: item.html.split("/").pop(), href: item.html });
  });

  // 2. 渲染
  let html = '';
  Object.values(folderMap).forEach(folderData => {
    // 关键修复：直接使用从 chapters.json 读到的 thumb 路径
    const thumb = folderData.thumb; 
    
    html += `<div class="card">`;
    // 图像
    html += thumb ? `<img src="${thumb}" alt="${folderData.folder}" loading="lazy">`
                  : `<div style="width:100%;height:80px;background:#eee;border-radius:6px;margin-bottom:8px;"></div>`;
    // 文件夹名
    html += `<div class="card-title">${folderData.folder}</div>`;
    // html文件链接
    html += `<div class="card-links">`;
    folderData.htmls.forEach(h =>
      html += `<a href="${h.href}" target="_blank" style="display:inline-block;margin:0 3px 2px 0">${h.name}</a>`
    );
    html += `</div></div>`;
  });
  tocGrid.innerHTML = html;
}

function loadAllChapters(callback) {
  fetch('chapters.json')
    .then(res => res.json())
    .then(list => {
      chapters = list;
      let loaded = 0;
      chapterTexts = [];
      if (!chapters.length) {
        callback();
        return;
      }
      chapters.forEach((chap, i) => {
        fetch(chap.text)
          .then(res => res.text())
          .then(text => {
            chapterTexts[i] = { ...chap, text };
            loaded++;
            if (loaded === chapters.length) callback();
          })
          .catch(() => {
            chapterTexts[i] = { ...chap, text: "[Failed to load text]" };
            loaded++;
            if (loaded === chapters.length) callback();
          });
      });
    })
    .catch(() => {
      document.getElementById("searchResults").innerHTML = "<p style='color:red'>Failed to load chapters.json</p>";
    });
}

let fuse = null;
function buildIndex() {
  fuse = new Fuse(chapterTexts, {
    keys: ["title", "text"],
    includeMatches: true,
    threshold: 0.4,
    minMatchCharLength: 2,
    ignoreLocation: true,
    useExtendedSearch: true,
  });
}

function doSearch() {
  const q = document.getElementById("searchBox").value.trim();
  const resultsDiv = document.getElementById("searchResults");
  if (!q) { resultsDiv.innerHTML = ""; return; }
  const terms = q.split(/\s+/);
  const results = fuse.search(q);
  let html = `<p>${results.length} result${results.length === 1 ? '' : 's'} found:</p>`;
  results.forEach(r => {
    let snippet = r.item.text;
    let idx = snippet.toLowerCase().indexOf(terms[0].toLowerCase());
    if (idx > 30) idx -= 30;
    if (idx < 0) idx = 0;
    snippet = snippet.substr(idx, 120).replace(/\n/g, " ");
    snippet = highlight(snippet, terms);
    html += `<div class="result">
      <div class="result-title"><a href="${r.item.html}" target="_blank">${r.item.title}</a></div>
      <div class="result-snippet">${snippet}...</div>
    </div>`;
  });
  resultsDiv.innerHTML = html;
}

function clearSearch() {
  document.getElementById("searchBox").value = "";
  document.getElementById("searchResults").innerHTML = "";
}

window.onload = function() {
  loadAllChapters(() => {
    buildIndex();
    renderToc();
    // 移除旧的 input 事件监听，避免重复搜索
    // document.getElementById("searchBox").addEventListener("input", doSearch);
  });
};
