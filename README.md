# FigureYa: A Standardized Visualization Framework for Enhancing Biomedical Data Interpretation and Research Efficiency

This repository provides the complete set of input files, analysis code, and results from the FigureYa manuscript.

## 🔎 Interactive Results Browser

All generated reports are hosted on a dedicated webpage, featuring a powerful full-text search.

**[https://ying-ge.github.io/FigureYa/](https://ying-ge.github.io/FigureYa/)**

**Note:** The initial page load may be slow depending on your network. Please allow a few seconds for the content to appear.

### Using the Search
The primary feature is the **search box** at the top of the page. You can use it to perform a full-text search across all HTML reports. The search results will display:
*   A snippet of **context** showing where your keyword appears.
*   A direct **link** to the specific FigureYa report containing the term.

This allows you to quickly pinpoint relevant information (e.g., a specific function name, R package, analysis title, or figure) across all FigureYa files.

### Manual Browsing
Alternatively, you can manually browse the reports by clicking on the thumbnails and HTML links for each FigureYa folder listed on the page.

---

## 📦 Getting the Code and Data

You have two options for accessing the files.

### 1. Download for Offline Use
All FigureYa folders are compressed as individual zip files for convenient downloading. To download a specific folder:

1.  Navigate to the [`/compressed`](https://github.com/ying-ge/FigureYa/tree/main/compressed) directory.
2.  Find the zip file with the name corresponding to the folder you want (e.g., `FigureYa123mutVSexpr.zip`).
3.  Click on the zip file, then click the **Download** button.

### 2. Browse Online on GitHub
If you want to view the raw input or output files directly, you can browse them in the file browser at the top of this repository's main page.

---

## :file_folder: Structure of a FigureYa Directory
Each `FigureYa` directory follows a consistent structure:

1. **Core Files**
   - `*.Rmd`: R Markdown script (main analysis/plotting code)  
   - `*.html`: The knitted report generated from the R Markdown file.  
2. **Input Files**  
   - `easy_input_*`: Primary data/parameters (e.g., `easy_input_data.csv`)  
   - `example.png`: Reference image specifying plot requirements (style/layout)  
3. **Output Files**  
   - `*.pdf`: Vector graphic results (editable, publication-ready)  
   - `output_*`: Text/tables (e.g., `output_results.txt`)  

**Example (`FigureYa59volcanoV2`)**  
```plaintext
FigureYa59volcanoV2/
├── FigureYa59volcanoV2.Rmd          # Main analysis script
├── FigureYa59volcanoV2.html         # HTML report
├── easy_input_limma.csv             # Input data
├── easy_input_selected.csv          # Input data
├── Volcano_classic.pdf              # Vector graphic (PDF)
├── Volcano_advanced.pdf             # Vector graphic (PDF)
└── example.png                      # Style reference for plots
```  

## ✍️ Citation
This manuscript is accepted by iMetaMed. [https://doi.org/10.1002/imm3.70005](https://doi.org/10.1002/imm3.70005)

Citation information will be updated later.
