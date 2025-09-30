

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-LRSBGK4Q35"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LRSBGK4Q35');
</script>

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">
    <meta property="og:title" content="estimate source: R/filterCommonGenes.R" />
    
      <meta name="description" content="R/filterCommonGenes.R defines the following functions: ">
      <meta property="og:description" content="R/filterCommonGenes.R defines the following functions: "/>
    

    <link rel="icon" href="/favicon.ico">

    <link rel="canonical" href="https://rdrr.io/rforge/estimate/src/R/filterCommonGenes.R" />

    <link rel="search" type="application/opensearchdescription+xml" title="R Package Documentation" href="/opensearch.xml" />

    <!-- Hello from sg3  -->

    <title>estimate source: R/filterCommonGenes.R</title>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    
      
      
<link rel="stylesheet" href="/static/CACHE/css/dd7eaddf7db3.css" type="text/css" />

    

    
  <style>
    .hll { background-color: #ffffcc }
.pyg-c { color: #408080; font-style: italic } /* Comment */
.pyg-err { border: 1px solid #FF0000 } /* Error */
.pyg-k { color: #008000; font-weight: bold } /* Keyword */
.pyg-o { color: #666666 } /* Operator */
.pyg-ch { color: #408080; font-style: italic } /* Comment.Hashbang */
.pyg-cm { color: #408080; font-style: italic } /* Comment.Multiline */
.pyg-cp { color: #BC7A00 } /* Comment.Preproc */
.pyg-cpf { color: #408080; font-style: italic } /* Comment.PreprocFile */
.pyg-c1 { color: #408080; font-style: italic } /* Comment.Single */
.pyg-cs { color: #408080; font-style: italic } /* Comment.Special */
.pyg-gd { color: #A00000 } /* Generic.Deleted */
.pyg-ge { font-style: italic } /* Generic.Emph */
.pyg-gr { color: #FF0000 } /* Generic.Error */
.pyg-gh { color: #000080; font-weight: bold } /* Generic.Heading */
.pyg-gi { color: #00A000 } /* Generic.Inserted */
.pyg-go { color: #888888 } /* Generic.Output */
.pyg-gp { color: #000080; font-weight: bold } /* Generic.Prompt */
.pyg-gs { font-weight: bold } /* Generic.Strong */
.pyg-gu { color: #800080; font-weight: bold } /* Generic.Subheading */
.pyg-gt { color: #0044DD } /* Generic.Traceback */
.pyg-kc { color: #008000; font-weight: bold } /* Keyword.Constant */
.pyg-kd { color: #008000; font-weight: bold } /* Keyword.Declaration */
.pyg-kn { color: #008000; font-weight: bold } /* Keyword.Namespace */
.pyg-kp { color: #008000 } /* Keyword.Pseudo */
.pyg-kr { color: #008000; font-weight: bold } /* Keyword.Reserved */
.pyg-kt { color: #B00040 } /* Keyword.Type */
.pyg-m { color: #666666 } /* Literal.Number */
.pyg-s { color: #BA2121 } /* Literal.String */
.pyg-na { color: #7D9029 } /* Name.Attribute */
.pyg-nb { color: #008000 } /* Name.Builtin */
.pyg-nc { color: #0000FF; font-weight: bold } /* Name.Class */
.pyg-no { color: #880000 } /* Name.Constant */
.pyg-nd { color: #AA22FF } /* Name.Decorator */
.pyg-ni { color: #999999; font-weight: bold } /* Name.Entity */
.pyg-ne { color: #D2413A; font-weight: bold } /* Name.Exception */
.pyg-nf { color: #0000FF } /* Name.Function */
.pyg-nl { color: #A0A000 } /* Name.Label */
.pyg-nn { color: #0000FF; font-weight: bold } /* Name.Namespace */
.pyg-nt { color: #008000; font-weight: bold } /* Name.Tag */
.pyg-nv { color: #19177C } /* Name.Variable */
.pyg-ow { color: #AA22FF; font-weight: bold } /* Operator.Word */
.pyg-w { color: #bbbbbb } /* Text.Whitespace */
.pyg-mb { color: #666666 } /* Literal.Number.Bin */
.pyg-mf { color: #666666 } /* Literal.Number.Float */
.pyg-mh { color: #666666 } /* Literal.Number.Hex */
.pyg-mi { color: #666666 } /* Literal.Number.Integer */
.pyg-mo { color: #666666 } /* Literal.Number.Oct */
.pyg-sa { color: #BA2121 } /* Literal.String.Affix */
.pyg-sb { color: #BA2121 } /* Literal.String.Backtick */
.pyg-sc { color: #BA2121 } /* Literal.String.Char */
.pyg-dl { color: #BA2121 } /* Literal.String.Delimiter */
.pyg-sd { color: #BA2121; font-style: italic } /* Literal.String.Doc */
.pyg-s2 { color: #BA2121 } /* Literal.String.Double */
.pyg-se { color: #BB6622; font-weight: bold } /* Literal.String.Escape */
.pyg-sh { color: #BA2121 } /* Literal.String.Heredoc */
.pyg-si { color: #BB6688; font-weight: bold } /* Literal.String.Interpol */
.pyg-sx { color: #008000 } /* Literal.String.Other */
.pyg-sr { color: #BB6688 } /* Literal.String.Regex */
.pyg-s1 { color: #BA2121 } /* Literal.String.Single */
.pyg-ss { color: #19177C } /* Literal.String.Symbol */
.pyg-bp { color: #008000 } /* Name.Builtin.Pseudo */
.pyg-fm { color: #0000FF } /* Name.Function.Magic */
.pyg-vc { color: #19177C } /* Name.Variable.Class */
.pyg-vg { color: #19177C } /* Name.Variable.Global */
.pyg-vi { color: #19177C } /* Name.Variable.Instance */
.pyg-vm { color: #19177C } /* Name.Variable.Magic */
.pyg-il { color: #666666 } /* Literal.Number.Integer.Long */
  </style>


    
  </head>

  <body>
    <div class="ui darkblue top fixed inverted menu" role="navigation" itemscope itemtype="http://www.schema.org/SiteNavigationElement" style="height: 40px; z-index: 1000;">
      <a class="ui header item " href="/">rdrr.io<!-- <small>R Package Documentation</small>--></a>
      <a class='ui item ' href="/find/" itemprop="url"><i class='search icon'></i><span itemprop="name">Find an R package</span></a>
      <a class='ui item ' href="/r/" itemprop="url"><i class='file text outline icon'></i> <span itemprop="name">R language docs</span></a>
      <a class='ui item ' href="/snippets/" itemprop="url"><i class='play icon'></i> <span itemprop="name">Run R in your browser</span></a>

      <div class='right menu'>
        <form class='item' method='GET' action='/search'>
          <div class='ui right action input'>
            <input type='text' placeholder='packages, doc text, code...' size='24' name='q'>
            <button type="submit" class="ui green icon button"><i class='search icon'></i></button>
          </div>
        </form>
      </div>
    </div>

    
  



<div style='width: 280px; top: 24px; position: absolute;' class='ui vertical menu only-desktop bg-grey'>
  <a class='header  item' href='/rforge/estimate/' style='padding-bottom: 4px'>
    <h3 class='ui header' style='margin-bottom: 4px'>
      estimate
      <div class='sub header'>Estimate of Stromal and Immune Cells in Malignant Tumor Tissues from Expression Data</div>
    </h3>
    <small style='padding: 0 0 16px 0px' class='fakelink'>Package index</small>
  </a>

  <form class='item' method='GET' action='/search'>
    <div class='sub header' style='margin-bottom: 4px'>Search the estimate package</div>
    <div class='ui action input' style='padding-right: 32px'>
      <input type='hidden' name='package' value='estimate'>
      <input type='hidden' name='repo' value='rforge'>
      <input type='text' placeholder='' name='q'>
      <button type="submit" class="ui green icon button">
        <i class="search icon"></i>
      </button>
    </div>
  </form>

  
    <div class='header item' style='padding-bottom: 7px'>Vignettes</div>
    <small>
      <ul class='fakelist'>
        
          <li>
            <a href='/rforge/estimate/f/inst/doc/ESTIMATE_Vignette.pdf' target='_blank' rel='noopener'>
              Using ESTIMATE
              
                <i class='pdf file outline icon'></i>
              
            </a>
          </li>
        
      </ul>
    </small>
  

  <div class='ui floating dropdown item finder '>
  <b><a href='/rforge/estimate/api/'>Functions</a></b> <div class='ui blue label'>9</div>
  <i class='caret right icon'></i>
  
  
  
</div>

  <div class='ui floating dropdown item finder '>
  <b><a href='/rforge/estimate/f/'>Source code</a></b> <div class='ui blue label'>7</div>
  <i class='caret right icon'></i>
  
  
  
</div>

  <div class='ui floating dropdown item finder '>
  <b><a href='/rforge/estimate/man/'>Man pages</a></b> <div class='ui blue label'>8</div>
  <i class='caret right icon'></i>
  
    <small>
      <ul style='list-style-type: none; margin: 12px auto 0; line-height: 2.0; padding-left: 0px; padding-bottom: 8px;'>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/rforge/estimate/man/e00-estimate-package.html'><b>e00-estimate-package: </b>ESTIMATE</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/rforge/estimate/man/e50-estimateScore.html'><b>e50-estimateScore: </b>Calculation of stromal, immune, and ESTIMATE scores</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/rforge/estimate/man/e50-filterCommonGenes.html'><b>e50-filterCommonGenes: </b>Intersect input data with 10,412 common genes</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/rforge/estimate/man/e50-outputGCT.html'><b>e50-outputGCT: </b>Write gene expression data in GCT format</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/rforge/estimate/man/e50-plotPurity.html'><b>e50-plotPurity: </b>Plot tumor purity</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/rforge/estimate/man/e90-common_genes-data.html'><b>e90-common_genes-data: </b>10,412 common genes</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/rforge/estimate/man/e90-PurityDataAffy-data.html'><b>e90-PurityDataAffy-data: </b>Affymetrix data</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/rforge/estimate/man/e90-SI_geneset-data.html'><b>e90-SI_geneset-data: </b>two signatures for estimate</a></li>
        
        <li style='padding-top: 4px; padding-bottom: 0;'><a href='/rforge/estimate/man/'><b>Browse all...</b></a></li>
      </ul>
    </small>
  
  
  
</div>


  

  
</div>



  <div class='desktop-pad' id='body-content'>
    <div class='ui fluid container bc-row'>
      <div class='ui breadcrumb' itemscope itemtype="http://schema.org/BreadcrumbList">
        <a class='section' href="/">Home</a>

        <div class='divider'> / </div>

        <span itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
          <a class='section' itemscope itemtype="http://schema.org/Thing" itemprop="item" id="https://rdrr.io/all/rforge/" href="/all/rforge/">
            <span itemprop="name">R-Forge</span>
          </a>
          <meta itemprop="position" content="1" />
        </span>

        <div class='divider'> / </div>

        <span itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
          <a class='section' itemscope itemtype="http://schema.org/Thing" itemprop="item" id="https://rdrr.io/rforge/estimate/" href="/rforge/estimate/">
            <span itemprop="name">estimate</span>
          </a>
          <meta itemprop="position" content="2" />
        </span>

        <div class='divider'> / </div>

        <span itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" class="active section">
          <a class='active section' itemscope itemtype="http://schema.org/Thing" itemprop="item" id="https://rdrr.io/rforge/estimate/src/R/filterCommonGenes.R" href="https://rdrr.io/rforge/estimate/src/R/filterCommonGenes.R">
            <span itemprop="name">R/filterCommonGenes.R</span>
          </a>
          <meta itemprop="position" content="3" />
        </span>
      </div>
    </div>

    <div class="ui fluid container" style='padding: 0px 16px'>
      
        <div class='only-desktop' style='float: right; width: 300px; height: 600px;'><ins class="adsbygoogle"
style="display:block;min-width:120px;max-width:300px;width:100%;height:600px"
data-ad-client="ca-pub-6535703173049909"
data-ad-slot="9724778181"
data-ad-format="vertical"></ins></div>
      
      <h1 class='ui block header fit-content'>R/filterCommonGenes.R
        <div class='sub header'>In <a href='/rforge/estimate/'>estimate: Estimate of Stromal and Immune Cells in Malignant Tumor Tissues from Expression Data</a>
      </h1>

      

      

      <div class="highlight"><pre style="word-wrap: break-word; white-space: pre-wrap;"><span></span><span class="pyg-c1">###</span>
<span class="pyg-c1">### $Id: filterCommonGenes.R 21 2016-10-04 21:13:08Z proebuck $</span>
<span class="pyg-c1">###</span>


<span class="pyg-c1">##-----------------------------------------------------------------------------</span>
<span class="pyg-n"><a id="sym-filterCommonGenes" class="mini-popup" href="/rforge/estimate/man/e50-filterCommonGenes.html" data-mini-url="/rforge/estimate/man/e50-filterCommonGenes.minihtml">filterCommonGenes</a></span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-function" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml">function</a></span><span class="pyg-p">(</span><span class="pyg-n">input.f</span><span class="pyg-p">,</span>
                              <span class="pyg-n">output.f</span><span class="pyg-p">,</span>
                              <span class="pyg-n">id</span><span class="pyg-o">=</span><span class="pyg-nf"><a id="sym-c" class="mini-popup" href="/r/base/c.html" data-mini-url="/r/base/c.minihtml">c</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;GeneSymbol&quot;</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;EntrezID&quot;</span><span class="pyg-p">))</span> <span class="pyg-p">{</span>

    <span class="pyg-c1">## Check arguments</span>
    <span class="pyg-nf"><a id="sym-stopifnot" class="mini-popup" href="/r/base/stopifnot.html" data-mini-url="/r/base/stopifnot.minihtml">stopifnot</a></span><span class="pyg-p">((</span><span class="pyg-nf"><a id="sym-is.character" class="mini-popup" href="/r/base/character.html" data-mini-url="/r/base/character.minihtml">is.character</a></span><span class="pyg-p">(</span><span class="pyg-n">input.f</span><span class="pyg-p">)</span> <span class="pyg-o">&amp;&amp;</span> <span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-p">(</span><span class="pyg-n">input.f</span><span class="pyg-p">)</span> <span class="pyg-o">==</span> <span class="pyg-m">1</span> <span class="pyg-o">&amp;&amp;</span> <span class="pyg-nf"><a id="sym-nzchar" class="mini-popup" href="/r/base/nchar.html" data-mini-url="/r/base/nchar.minihtml">nzchar</a></span><span class="pyg-p">(</span><span class="pyg-n">input.f</span><span class="pyg-p">))</span> <span class="pyg-o">||</span>
              <span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-inherits" class="mini-popup" href="/r/base/class.html" data-mini-url="/r/base/class.minihtml">inherits</a></span><span class="pyg-p">(</span><span class="pyg-n">input.f</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;connection&quot;</span><span class="pyg-p">)</span> <span class="pyg-o">&amp;&amp;</span> <span class="pyg-nf"><a id="sym-isOpen" class="mini-popup" href="/r/base/connections.html" data-mini-url="/r/base/connections.minihtml">isOpen</a></span><span class="pyg-p">(</span><span class="pyg-n">input.f</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;r&quot;</span><span class="pyg-p">)))</span>
    <span class="pyg-nf"><a id="sym-stopifnot" class="mini-popup" href="/r/base/stopifnot.html" data-mini-url="/r/base/stopifnot.minihtml">stopifnot</a></span><span class="pyg-p">((</span><span class="pyg-nf"><a id="sym-is.character" class="mini-popup" href="/r/base/character.html" data-mini-url="/r/base/character.minihtml">is.character</a></span><span class="pyg-p">(</span><span class="pyg-n">output.f</span><span class="pyg-p">)</span> <span class="pyg-o">&amp;&amp;</span> <span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-p">(</span><span class="pyg-n">output.f</span><span class="pyg-p">)</span> <span class="pyg-o">==</span> <span class="pyg-m">1</span> <span class="pyg-o">&amp;&amp;</span> <span class="pyg-nf"><a id="sym-nzchar" class="mini-popup" href="/r/base/nchar.html" data-mini-url="/r/base/nchar.minihtml">nzchar</a></span><span class="pyg-p">(</span><span class="pyg-n">output.f</span><span class="pyg-p">)))</span>
    <span class="pyg-n">id</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-match.arg" class="mini-popup" href="/r/base/match.arg.html" data-mini-url="/r/base/match.arg.minihtml">match.arg</a></span><span class="pyg-p">(</span><span class="pyg-n">id</span><span class="pyg-p">)</span>   
     
    <span class="pyg-c1">## Read input data</span>
    <span class="pyg-n">input.df</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-read.table" class="mini-popup" href="/r/utils/read.table.html" data-mini-url="/r/utils/read.table.minihtml">read.table</a></span><span class="pyg-p">(</span><span class="pyg-n">input.f</span><span class="pyg-p">,</span>
                           <span class="pyg-n">header</span><span class="pyg-o">=</span><span class="pyg-kc"><a id="sym-TRUE" class="mini-popup" href="/r/base/logical.html" data-mini-url="/r/base/logical.minihtml">TRUE</a></span><span class="pyg-p">,</span>
                           <span class="pyg-n"><a id="sym-row.names" class="mini-popup" href="/r/base/row.names.html" data-mini-url="/r/base/row.names.minihtml">row.names</a></span><span class="pyg-o">=</span><span class="pyg-m">1</span><span class="pyg-p">,</span>
                           <span class="pyg-n">sep</span><span class="pyg-o">=</span><span class="pyg-s">&quot;\t&quot;</span><span class="pyg-p">,</span> 
                           <span class="pyg-n"><a id="sym-quote" class="mini-popup" href="/r/base/substitute.html" data-mini-url="/r/base/substitute.minihtml">quote</a></span><span class="pyg-o">=</span><span class="pyg-s">&quot;&quot;</span><span class="pyg-p">,</span>
                           <span class="pyg-n">stringsAsFactors</span><span class="pyg-o">=</span><span class="pyg-kc"><a id="sym-FALSE" class="mini-popup" href="/r/base/logical.html" data-mini-url="/r/base/logical.minihtml">FALSE</a></span><span class="pyg-p">)</span>
     
    <span class="pyg-n">merged.df</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-merge" class="mini-popup" href="/r/base/merge.html" data-mini-url="/r/base/merge.minihtml">merge</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-common_genes" class="mini-popup" href="/rforge/estimate/man/e90-common_genes-data.html" data-mini-url="/rforge/estimate/man/e90-common_genes-data.minihtml">common_genes</a></span><span class="pyg-p">,</span> <span class="pyg-n">input.df</span><span class="pyg-p">,</span> <span class="pyg-n">by.x</span><span class="pyg-o">=</span><span class="pyg-n">id</span><span class="pyg-p">,</span> <span class="pyg-n">by.y</span><span class="pyg-o">=</span><span class="pyg-s">&quot;row.names&quot;</span><span class="pyg-p">)</span>
    <span class="pyg-nf"><a id="sym-rownames" class="mini-popup" href="/r/base/colnames.html" data-mini-url="/r/base/colnames.minihtml">rownames</a></span><span class="pyg-p">(</span><span class="pyg-n">merged.df</span><span class="pyg-p">)</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">merged.df</span><span class="pyg-o">$</span><span class="pyg-n">GeneSymbol</span>
    <span class="pyg-n">merged.df</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">merged.df<a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml">[</a></span><span class="pyg-p">,</span> <span class="pyg-m">-1</span><span class="pyg-o">:-</span><span class="pyg-nf"><a id="sym-ncol" class="mini-popup" href="/r/base/nrow.html" data-mini-url="/r/base/nrow.minihtml">ncol</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-common_genes" class="mini-popup" href="/rforge/estimate/man/e90-common_genes-data.html" data-mini-url="/rforge/estimate/man/e90-common_genes-data.minihtml">common_genes</a></span><span class="pyg-p">)</span><span class="pyg-n">]</span>
    <span class="pyg-nf"><a id="sym-print" class="mini-popup" href="/r/base/print.html" data-mini-url="/r/base/print.minihtml">print</a></span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-sprintf" class="mini-popup" href="/r/base/sprintf.html" data-mini-url="/r/base/sprintf.minihtml">sprintf</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;Merged dataset includes %d genes (%d mismatched).&quot;</span><span class="pyg-p">,</span>
                  <span class="pyg-nf"><a id="sym-nrow" class="mini-popup" href="/r/base/nrow.html" data-mini-url="/r/base/nrow.minihtml">nrow</a></span><span class="pyg-p">(</span><span class="pyg-n">merged.df</span><span class="pyg-p">),</span>
                  <span class="pyg-nf"><a id="sym-nrow" class="mini-popup" href="/r/base/nrow.html" data-mini-url="/r/base/nrow.minihtml">nrow</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-common_genes" class="mini-popup" href="/rforge/estimate/man/e90-common_genes-data.html" data-mini-url="/rforge/estimate/man/e90-common_genes-data.minihtml">common_genes</a></span><span class="pyg-p">)</span> <span class="pyg-o">-</span> <span class="pyg-nf"><a id="sym-nrow" class="mini-popup" href="/r/base/nrow.html" data-mini-url="/r/base/nrow.minihtml">nrow</a></span><span class="pyg-p">(</span><span class="pyg-n">merged.df</span><span class="pyg-p">)))</span>
    <span class="pyg-nf"><a id="sym-outputGCT" class="mini-popup" href="/rforge/estimate/man/e50-outputGCT.html" data-mini-url="/rforge/estimate/man/e50-outputGCT.minihtml">outputGCT</a></span><span class="pyg-p">(</span><span class="pyg-n">merged.df</span><span class="pyg-p">,</span> <span class="pyg-n">output.f</span><span class="pyg-p">)</span>
<span class="pyg-p">}</span>
</pre></div>


      <div class='ui only-mobile fluid container' style='width: 320px; height: 100px;'><!-- rdrr-mobile-responsive -->
<ins class="adsbygoogle"
    style="display:block"
    data-ad-client="ca-pub-6535703173049909"
    data-ad-slot="4915028187"
    data-ad-format="auto"></ins></div>

      
  <h2 class='ui header'>Try the <a href="/rforge/estimate/">estimate</a> package in your browser</h2>

  <div class='ui form'>
    <div class='field'>
      <textarea class="mousetrap snip-input" id="snip" rows='10' cols='80' style='width: 100%; font-size: 13px; font-family: Menlo,Monaco,Consolas,"Courier New",monospace !important' data-tag='snrub'>library(estimate)

help(estimate)</textarea>
    </div>
  </div>

  <div class='ui container'>
    <div class='column'>
      <button class='ui huge green fluid button snip-run' data-tag='snrub' type="button" id="run">Run</button>
    </div>
    <div class='column'>
      <p><strong>Any scripts or data that you put into this service are public.</strong></p>
    </div>

    <div class='ui icon warning message snip-spinner hidden' data-tag='snrub'>
      <i class='notched circle loading icon'></i>
      <div class='content'>
        <div class='header snip-status' data-tag='snrub'>Nothing</div>
      </div>
    </div>

    <pre class='highlight hidden snip-output' data-tag='snrub'></pre>
    <div class='snip-images hidden' data-tag='snrub'></div>
  </div>


      <small><a href="/rforge/estimate/">estimate documentation</a> built on May 2, 2019, 4:38 p.m.</small>

    </div>
    
    
<div class="ui inverted darkblue vertical footer segment" style='margin-top: 16px; padding: 32px;'>
  <div class="ui center aligned container">
    <div class="ui stackable inverted divided three column centered grid">
      <div class="five wide column">
        <h4 class="ui inverted header">R Package Documentation</h4>
        <div class='ui inverted link list'>
          <a class='item' href='/'>rdrr.io home</a>
          <a class='item' href='/r/'>R language documentation</a>
          <a class='item' href='/snippets/'>Run R code online</a>
        </div>
      </div>
      <div class="five wide column">
        <h4 class="ui inverted header">Browse R Packages</h4>
        <div class='ui inverted link list'>
          <a class='item' href='/all/cran/'>CRAN packages</a>
          <a class='item' href='/all/bioc/'>Bioconductor packages</a>
          <a class='item' href='/all/rforge/'>R-Forge packages</a>
          <a class='item' href='/all/github/'>GitHub packages</a>
        </div>
      </div>
      <div class="five wide column">
        <h4 class="ui inverted header">We want your feedback!</h4>
        <small>Note that we can't provide technical support on individual packages. You should contact the package authors for that.</small>
        <div class='ui inverted link list'>
          <a class='item' href="https://twitter.com/intent/tweet?screen_name=rdrrHQ">
            <div class='ui large icon label twitter-button-colour'>
              <i class='whiteish twitter icon'></i> Tweet to @rdrrHQ
            </div>
          </a>

          <a class='item' href="https://github.com/rdrr-io/rdrr-issues/issues">
            <div class='ui large icon label github-button-colour'>
              <i class='whiteish github icon'></i> GitHub issue tracker
            </div>
          </a>

          <a class='item' href="mailto:ian@mutexlabs.com">
            <div class='ui teal large icon label'>
              <i class='whiteish mail outline icon'></i> ian@mutexlabs.com
            </div>
          </a>

          <a class='item' href="https://ianhowson.com">
            <div class='ui inverted large image label'>
              <img class='ui avatar image' src='/static/images/ianhowson32.png'> <span class='whiteish'>Personal blog</span>
            </div>
          </a>
        </div>
      </div>
    </div>
  </div>

  
  <br />
  <div class='only-mobile' style='min-height: 120px'>
    &nbsp;
  </div>
</div>

  </div>


    <!-- suggestions button -->
    <div style='position: fixed; bottom: 2%; right: 2%; z-index: 1000;'>
      <div class="ui raised segment surveyPopup" style='display:none'>
  <div class="ui large header">What can we improve?</div>

  <div class='content'>
    <div class="ui form">
      <div class="field">
        <button class='ui fluid button surveyReasonButton'>The page or its content looks wrong</button>
      </div>

      <div class="field">
        <button class='ui fluid button surveyReasonButton'>I can't find what I'm looking for</button>
      </div>

      <div class="field">
        <button class='ui fluid button surveyReasonButton'>I have a suggestion</button>
      </div>

      <div class="field">
        <button class='ui fluid button surveyReasonButton'>Other</button>
      </div>

      <div class="field">
        <label>Extra info (optional)</label>
        <textarea class='surveyText' rows='3' placeholder="Please enter more detail, if you like. Leave your email address if you'd like us to get in contact with you."></textarea>
      </div>

      <div class='ui error message surveyError' style='display: none'></div>

      <button class='ui large fluid green disabled button surveySubmitButton'>Submit</button>
    </div>
  </div>
</div>

      <button class='ui blue labeled icon button surveyButton only-desktop' style='display: none; float: right;'><i class="comment icon"></i> Improve this page</button>
      
    </div>

    
      <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
    

    
  


    <div class="ui modal snippetsModal">
  <div class="header">
    Embedding an R snippet on your website
  </div>
  <div class="content">
    <div class="description">
      <p>Add the following code to your website.</p>

      <p>
        <textarea class='codearea snippetEmbedCode' rows='5' style="font-family: Consolas,Monaco,'Andale Mono',monospace;">REMOVE THIS</textarea>
        <button class='ui blue button copyButton' data-clipboard-target='.snippetEmbedCode'>Copy to clipboard</button>
      </p>

      <p>For more information on customizing the embed code, read <a href='/snippets/embedding/'>Embedding Snippets</a>.</p>
    </div>
  </div>
  <div class="actions">
    <div class="ui button">Close</div>
  </div>
</div>

    
    <script type="text/javascript" src="/static/CACHE/js/73d0b6f91493.js"></script>

    
    <script type="text/javascript" src="/static/CACHE/js/484b2a9a799d.js"></script>

    
    <script type="text/javascript" src="/static/CACHE/js/4f8010c72628.js"></script>

    
  

<script type="text/javascript">$(document).ready(function(){$('.snip-run').click(runClicked);var key='ctrl+enter';var txt=' (Ctrl-Enter)';if(navigator&&navigator.platform&&navigator.platform.startsWith&&navigator.platform.startsWith('Mac')){key='command+enter';txt=' (Cmd-Enter)';}
$('.snip-run').text('Run '+txt);Mousetrap.bind(key,function(e){if($('.snip-run').hasClass('disabled')){return;}
var faketarget=$('.snip-run')[0]
runClicked({currentTarget:faketarget});});});</script>



    
  
<link rel="stylesheet" href="/static/CACHE/css/dd7eaddf7db3.css" type="text/css" />



    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:400,400italic,600,600italic,800,800italic">
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Oswald:400,300,700">
  </body>
</html>
