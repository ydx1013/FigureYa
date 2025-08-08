// chapterList 需由Python脚本输出为JSON（见下方注释），此处为示例
const chapterList = [
  // { id: "chapter1", title: "第一章 绪论" },
  // { id: "chapter2", title: "第二章 数据处理" },
  // ...
];

// 渲染目录
function renderToc() {
  const toc = document.getElementById("toc");
  toc.innerHTML = "";
  chapterList.forEach(chap => {
    const li = document.createElement("li");
    const a = document.createElement("a");
    a.href = `chapters/${chap.id}.html`;
    a.innerText = chap.title;
    li.appendChild(a);
    toc.appendChild(li);
  });
}

// 动态加载所有 txt，构建全文索引
let fuse = null;
let chapterTexts = [];
function loadAllChapters(callback) {
  let loaded = 0;
  chapterTexts = [];
  chapterList.forEach((chap, i) => {
    fetch(`texts/${chap.id}.txt`)
      .then(res => res.text())
      .then(text => {
        chapterTexts[i] = { id: chap.id, title: chap.title, text };
        loaded++;
        if (loaded === chapterList.length) callback();
      });
  });
}

// 初始化 Fuse.js
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

function highlight(text, terms) {
  let re = new RegExp("(" + terms.map(t => t.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')).join('|') + ")", "gi");
  return text.replace(re, '<span class="highlight">$1</span>');
}

// 执行搜索
function doSearch() {
  const q = document.getElementById("searchBox").value.trim();
  const resultsDiv = document.getElementById("searchResults");
  if (!q) { resultsDiv.innerHTML = ""; return; }
  const terms = q.split(/\s+/);
  const results = fuse.search(q, { limit: 25 });
  let html = `<p>共${results.length}条结果：</p>`;
  results.forEach(r => {
    let snippet = r.item.text;
    // 取第一个匹配片段
    let idx = snippet.toLowerCase().indexOf(terms[0].toLowerCase());
    if (idx > 30) idx -= 30;
    snippet = snippet.substr(idx, 120).replace(/\n/g, " ");
    snippet = highlight(snippet, terms);
    html += `<div class="result">
      <div class="result-title"><a href="chapters/${r.item.id}.html" target="_blank">${r.item.title}</a></div>
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
  renderToc();
  loadAllChapters(() => {
    buildIndex();
    document.getElementById("searchBox").addEventListener("input", doSearch);
  });
};
