# :book: FigureYa Contents
Explore the full contents and browse online at:  
[https://ying-ge.github.io/FigureYa/](https://ying-ge.github.io/FigureYa/)

On this webpage, you can see thumbnails and HTML links for each FigureYa folder.  
Click any HTML link to open and browse the content directly in your browser.  
Each FigureYa folder may contain one or more HTML files, all accessible and viewable online.

If you want the input or output files, you can browse them online by navigating to the `@ying-ge/FigureYa/` directory and opening the folders starting with `FigureYa`.  
Alternatively, you can download the corresponding zip package for offline use (see the next section for zip file details).

# 📦 Downloading Individual FigureYa Folders
All FigureYa folders are compressed as individual zip files for convenient downloading.  
To download a specific FigureYa folder:

1. Navigate to the [`@ying-ge/FigureYa/compressed`](./@ying-ge/FigureYa/compressed) directory in this repository on GitHub.
2. Find the zip file with the name corresponding to the folder you want (e.g., `FigureYa123.zip`).
3. Click on the zip file to open its details page.
4. Click the **Download** or **Raw** button to download the zip file to your computer.

You can then extract the contents of the zip file locally.

# :file_folder: Structure of a FigureYa Directory
Each `FigureYa` directory includes:
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

# :+1: Citation
This manuscript is under review. Citation information will be updated upon acceptance.
