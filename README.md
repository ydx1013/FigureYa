# :book: FigureYa Contents
Document featuring thumbnails and citation links:
https://drive.google.com/file/d/1cO-3Tmz45sH60BkZsLSrT4_BOvfX-L9I/view?usp=drive_link

FigureYa221-323 are in the master branch, other FigureYas are in the main branch.

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
