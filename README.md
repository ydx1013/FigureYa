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

All FigureYa modules are available as individually compressed zip files for convenient offline use. To download a specific module:

1.  Navigate to the [`/compressed`](https://github.com/ying-ge/FigureYa/tree/main/compressed) directory in this repository.
2.  Locate the zip file corresponding to the module you need (e.g., `FigureYa123mutVSexpr.zip`).
3.  Click on the file, then select the **Download** button.

**Note on File Availability:**
- The file `Auto_Knit_Online.txt` contains a list of FigureYa modules with all of the files.
- If a particular module is not listed in `Auto_Knit_Online.txt`, this indicates that its input files exceed GitHub's file size limitations.
- For these larger files, please visit our [`Baidu Cloud`](https://pan.baidu.com) storage. To access the download links, join the group: **967269198**.

### 2. Browse Online on GitHub
If you want to view the code, input or output files directly, you can browse them in the file browser at the top of this repository's main page.

---

## :file_folder: Structure of a FigureYa Directory
Each `FigureYa` directory follows a consistent structure:

1. **Core Files**
   - `*.Rmd`: The R Markdown script, containing the main analysis and plotting code.
   - `*.html`: The knitted report generated from the R Markdown file.
   - `install_dependencies.R`: A script automatically run by the .Rmd file to set up the required environment.
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
├── install_dependencies.R           # Automatic dependency installer
├── FigureYa59volcanoV2.html         # HTML report
├── easy_input_limma.csv             # Input data
├── easy_input_selected.csv          # Input data
├── Volcano_classic.pdf              # Vector graphic (PDF)
├── Volcano_advanced.pdf             # Vector graphic (PDF)
└── example.png                      # Style reference for plots
```

---

## ✍️ Usage and Citation

This project is built upon research that has been accepted for publication. We encourage its use under the following guidelines for licensing and academic citation.

### License and Commercial Use

This software is licensed under the **[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/)**.

This means you are free to share and adapt the code for **non-commercial purposes**, provided you give appropriate credit and distribute any adaptations under the same license.

For all commercial use cases (including but not limited to integration into proprietary software, use in a commercial service, or as an internal corporate tool), a separate commercial license is required. Please contact **geying.tju@gmail.com** to discuss a commercial license.

### Academic Citation

If you use this code in your work or research, **in addition to complying with the license**, we kindly request that you cite our publication:

> Xiaofan Lu, et al. (2025). *FigureYa: A Standardized Visualization Framework for Enhancing Biomedical Data Interpretation and Research Efficiency*. iMetaMed. [https://doi.org/10.1002/imm3.70005](https://doi.org/10.1002/imm3.70005)

---
*A pre-formatted BibTeX entry will be added here upon final publication.*
