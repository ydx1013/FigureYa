

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
    <meta property="og:title" content="estimate source: R/estimateScore.R" />
    
      <meta name="description" content="R/estimateScore.R defines the following functions: ">
      <meta property="og:description" content="R/estimateScore.R defines the following functions: "/>
    

    <link rel="icon" href="/favicon.ico">

    <link rel="canonical" href="https://rdrr.io/rforge/estimate/src/R/estimateScore.R" />

    <link rel="search" type="application/opensearchdescription+xml" title="R Package Documentation" href="/opensearch.xml" />

    <!-- Hello from sg3  -->

    <title>estimate source: R/estimateScore.R</title>

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

  <div class='ui floating dropdown item finder active'>
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
          <a class='active section' itemscope itemtype="http://schema.org/Thing" itemprop="item" id="https://rdrr.io/rforge/estimate/src/R/estimateScore.R" href="https://rdrr.io/rforge/estimate/src/R/estimateScore.R">
            <span itemprop="name">R/estimateScore.R</span>
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
      
      <h1 class='ui block header fit-content'>R/estimateScore.R
        <div class='sub header'>In <a href='/rforge/estimate/'>estimate: Estimate of Stromal and Immune Cells in Malignant Tumor Tissues from Expression Data</a>
      </h1>

      

      

      <div class="highlight"><pre style="word-wrap: break-word; white-space: pre-wrap;"><span></span><span class="pyg-c1">###</span>
<span class="pyg-c1">### $Id: estimateScore.R 13 2016-09-28 19:32:16Z proebuck $</span>
<span class="pyg-c1">###</span>


<span class="pyg-c1">##-----------------------------------------------------------------------------</span>
<span class="pyg-n"><a id="sym-estimateScore" class="mini-popup" href="/rforge/estimate/man/e50-estimateScore.html" data-mini-url="/rforge/estimate/man/e50-estimateScore.minihtml">estimateScore</a></span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-function" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml">function</a></span><span class="pyg-p">(</span><span class="pyg-n">input.ds</span><span class="pyg-p">,</span>
                          <span class="pyg-n">output.ds</span><span class="pyg-p">,</span>
                          <span class="pyg-n">platform</span><span class="pyg-o">=</span><span class="pyg-nf"><a id="sym-c" class="mini-popup" href="/r/base/c.html" data-mini-url="/r/base/c.minihtml">c</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;affymetrix&quot;</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;agilent&quot;</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;illumina&quot;</span><span class="pyg-p">))</span> <span class="pyg-p">{</span>

    <span class="pyg-c1">## Check arguments</span>
    <span class="pyg-nf"><a id="sym-stopifnot" class="mini-popup" href="/r/base/stopifnot.html" data-mini-url="/r/base/stopifnot.minihtml">stopifnot</a></span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-is.character" class="mini-popup" href="/r/base/character.html" data-mini-url="/r/base/character.minihtml">is.character</a></span><span class="pyg-p">(</span><span class="pyg-n">input.ds</span><span class="pyg-p">)</span> <span class="pyg-o">&amp;&amp;</span> <span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-p">(</span><span class="pyg-n">input.ds</span><span class="pyg-p">)</span> <span class="pyg-o">==</span> <span class="pyg-m">1</span> <span class="pyg-o">&amp;&amp;</span> <span class="pyg-nf"><a id="sym-nzchar" class="mini-popup" href="/r/base/nchar.html" data-mini-url="/r/base/nchar.minihtml">nzchar</a></span><span class="pyg-p">(</span><span class="pyg-n">input.ds</span><span class="pyg-p">))</span>
    <span class="pyg-nf"><a id="sym-stopifnot" class="mini-popup" href="/r/base/stopifnot.html" data-mini-url="/r/base/stopifnot.minihtml">stopifnot</a></span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-is.character" class="mini-popup" href="/r/base/character.html" data-mini-url="/r/base/character.minihtml">is.character</a></span><span class="pyg-p">(</span><span class="pyg-n">output.ds</span><span class="pyg-p">)</span> <span class="pyg-o">&amp;&amp;</span> <span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-p">(</span><span class="pyg-n">output.ds</span><span class="pyg-p">)</span> <span class="pyg-o">==</span> <span class="pyg-m">1</span> <span class="pyg-o">&amp;&amp;</span> <span class="pyg-nf"><a id="sym-nzchar" class="mini-popup" href="/r/base/nchar.html" data-mini-url="/r/base/nchar.minihtml">nzchar</a></span><span class="pyg-p">(</span><span class="pyg-n">output.ds</span><span class="pyg-p">))</span>
    <span class="pyg-n">platform</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-match.arg" class="mini-popup" href="/r/base/match.arg.html" data-mini-url="/r/base/match.arg.minihtml">match.arg</a></span><span class="pyg-p">(</span><span class="pyg-n">platform</span><span class="pyg-p">)</span>   
   
    <span class="pyg-c1">## Read input dataset(GCT format)</span>
    <span class="pyg-n">ds</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-read.delim" class="mini-popup" href="/r/utils/read.table.html" data-mini-url="/r/utils/read.table.minihtml">read.delim</a></span><span class="pyg-p">(</span><span class="pyg-n">input.ds</span><span class="pyg-p">,</span>
                     <span class="pyg-n">header</span><span class="pyg-o">=</span><span class="pyg-kc"><a id="sym-TRUE" class="mini-popup" href="/r/base/logical.html" data-mini-url="/r/base/logical.minihtml">TRUE</a></span><span class="pyg-p">,</span>
                     <span class="pyg-n">sep</span><span class="pyg-o">=</span><span class="pyg-s">&quot;\t&quot;</span><span class="pyg-p">,</span>
                     <span class="pyg-n">skip</span><span class="pyg-o">=</span><span class="pyg-m">2</span><span class="pyg-p">,</span>
                     <span class="pyg-n"><a id="sym-row.names" class="mini-popup" href="/r/base/row.names.html" data-mini-url="/r/base/row.names.minihtml">row.names</a></span><span class="pyg-o">=</span><span class="pyg-m">1</span><span class="pyg-p">,</span>
                     <span class="pyg-n">blank.lines.skip</span><span class="pyg-o">=</span><span class="pyg-kc"><a id="sym-TRUE" class="mini-popup" href="/r/base/logical.html" data-mini-url="/r/base/logical.minihtml">TRUE</a></span><span class="pyg-p">,</span>
                     <span class="pyg-n">as.is</span><span class="pyg-o">=</span><span class="pyg-kc"><a id="sym-TRUE" class="mini-popup" href="/r/base/logical.html" data-mini-url="/r/base/logical.minihtml">TRUE</a></span><span class="pyg-p">,</span>
                     <span class="pyg-n">na.strings</span><span class="pyg-o">=</span><span class="pyg-s">&quot;&quot;</span><span class="pyg-p">)</span>
    <span class="pyg-n">descs</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">ds<a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml">[</a></span><span class="pyg-p">,</span> <span class="pyg-m">1</span><span class="pyg-n">]</span>
    <span class="pyg-n">ds</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">ds<a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml">[</a></span><span class="pyg-m">-1</span><span class="pyg-n">]</span>
    <span class="pyg-n"><a id="sym-row.names" class="mini-popup" href="/r/base/row.names.html" data-mini-url="/r/base/row.names.minihtml">row.names</a></span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-row.names" class="mini-popup" href="/r/base/row.names.html" data-mini-url="/r/base/row.names.minihtml">row.names</a></span><span class="pyg-p">(</span><span class="pyg-n">ds</span><span class="pyg-p">)</span>
    <span class="pyg-n"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml">names</a></span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml">names</a></span><span class="pyg-p">(</span><span class="pyg-n">ds</span><span class="pyg-p">)</span>
    <span class="pyg-n">dataset</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-list" class="mini-popup" href="/r/base/list.html" data-mini-url="/r/base/list.minihtml">list</a></span><span class="pyg-p">(</span><span class="pyg-n">ds</span><span class="pyg-o">=</span><span class="pyg-n">ds</span><span class="pyg-p">,</span>
                    <span class="pyg-n"><a id="sym-row.names" class="mini-popup" href="/r/base/row.names.html" data-mini-url="/r/base/row.names.minihtml">row.names</a></span><span class="pyg-o">=</span><span class="pyg-n"><a id="sym-row.names" class="mini-popup" href="/r/base/row.names.html" data-mini-url="/r/base/row.names.minihtml">row.names</a></span><span class="pyg-p">,</span>
                    <span class="pyg-n">descs</span><span class="pyg-o">=</span><span class="pyg-n">descs</span><span class="pyg-p">,</span>
                    <span class="pyg-n"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml">names</a></span><span class="pyg-o">=</span><span class="pyg-n"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml">names</a></span><span class="pyg-p">)</span>

    <span class="pyg-n">m</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-data.matrix" class="mini-popup" href="/r/base/data.matrix.html" data-mini-url="/r/base/data.matrix.minihtml">data.matrix</a></span><span class="pyg-p">(</span><span class="pyg-n">dataset</span><span class="pyg-o">$</span><span class="pyg-n">ds</span><span class="pyg-p">)</span>
    <span class="pyg-n">gene.names</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">dataset</span><span class="pyg-o">$</span><span class="pyg-n"><a id="sym-row.names" class="mini-popup" href="/r/base/row.names.html" data-mini-url="/r/base/row.names.minihtml">row.names</a></span>
    <span class="pyg-n">sample.names</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">dataset</span><span class="pyg-o">$</span><span class="pyg-n"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml">names</a></span>
    <span class="pyg-n">Ns</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-p">(</span><span class="pyg-n">m[1</span><span class="pyg-p">,</span> <span class="pyg-n">]</span><span class="pyg-p">)</span> <span class="pyg-c1"># Number of genes</span>
    <span class="pyg-n">Ng</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-p">(</span><span class="pyg-n">m<a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml">[</a></span><span class="pyg-p">,</span> <span class="pyg-m">1</span><span class="pyg-n">]</span><span class="pyg-p">)</span> <span class="pyg-c1"># Number of samples</span>
    <span class="pyg-n">temp</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-strsplit" class="mini-popup" href="/r/base/strsplit.html" data-mini-url="/r/base/strsplit.minihtml">strsplit</a></span><span class="pyg-p">(</span><span class="pyg-n">input.ds</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-split" class="mini-popup" href="/r/base/split.html" data-mini-url="/r/base/split.minihtml">split</a></span><span class="pyg-o">=</span><span class="pyg-s">&quot;/&quot;</span><span class="pyg-p">)</span>
    <span class="pyg-n">s</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-p">(</span><span class="pyg-n">temp<a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml">[</a>[1]]</span><span class="pyg-p">)</span>
    <span class="pyg-n">input.file.name</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">temp<a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml">[</a>[1]][s]</span>
    <span class="pyg-n">temp</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-strsplit" class="mini-popup" href="/r/base/strsplit.html" data-mini-url="/r/base/strsplit.minihtml">strsplit</a></span><span class="pyg-p">(</span><span class="pyg-n">input.file.name</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-split" class="mini-popup" href="/r/base/split.html" data-mini-url="/r/base/split.minihtml">split</a></span><span class="pyg-o">=</span><span class="pyg-s">&quot;.gct&quot;</span><span class="pyg-p">)</span>
    <span class="pyg-n">input.file.prefix</span> <span class="pyg-o">&lt;-</span>  <span class="pyg-n">temp<a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml">[</a>[1]][1]</span>

    <span class="pyg-c1">## Sample rank normalization</span>
    <span class="pyg-nf">for </span><span class="pyg-p">(</span><span class="pyg-n">j</span> <span class="pyg-n"><a id="sym-in" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml">in</a></span> <span class="pyg-m">1</span><span class="pyg-o">:</span><span class="pyg-n">Ns</span><span class="pyg-p">)</span> <span class="pyg-p">{</span>
        <span class="pyg-n">m<a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml">[</a></span><span class="pyg-p">,</span> <span class="pyg-n">j]</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-rank" class="mini-popup" href="/r/base/rank.html" data-mini-url="/r/base/rank.minihtml">rank</a></span><span class="pyg-p">(</span><span class="pyg-n">m<a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml">[</a></span><span class="pyg-p">,</span> <span class="pyg-n">j]</span><span class="pyg-p">,</span> <span class="pyg-n">ties.method</span><span class="pyg-o">=</span><span class="pyg-s">&quot;average&quot;</span><span class="pyg-p">)</span>
    <span class="pyg-p">}</span>
    <span class="pyg-n">m</span> <span class="pyg-o">&lt;-</span> <span class="pyg-m">10000</span><span class="pyg-o">*</span><span class="pyg-n">m</span><span class="pyg-o">/</span><span class="pyg-n">Ng</span>

    <span class="pyg-c1">## SI_geneset</span>
    <span class="pyg-n">gs</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-as.matrix" class="mini-popup" href="/r/base/matrix.html" data-mini-url="/r/base/matrix.minihtml">as.matrix</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-SI_geneset" class="mini-popup" href="/rforge/estimate/man/e90-SI_geneset-data.html" data-mini-url="/rforge/estimate/man/e90-SI_geneset-data.minihtml">SI_geneset</a><a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml">[</a></span><span class="pyg-p">,</span> <span class="pyg-m">-1</span><span class="pyg-n">]</span><span class="pyg-p">,</span><span class="pyg-n"><a id="sym-dimnames" class="mini-popup" href="/r/base/dimnames.html" data-mini-url="/r/base/dimnames.minihtml">dimnames</a></span><span class="pyg-o">=</span><span class="pyg-kc"><a id="sym-NULL" class="mini-popup" href="/r/base/NULL.html" data-mini-url="/r/base/NULL.minihtml">NULL</a></span><span class="pyg-p">)</span> 
    <span class="pyg-n">N.gs</span> <span class="pyg-o">&lt;-</span> <span class="pyg-m">2</span>
    <span class="pyg-n">gs.names</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-row.names" class="mini-popup" href="/r/base/row.names.html" data-mini-url="/r/base/row.names.minihtml">row.names</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-SI_geneset" class="mini-popup" href="/rforge/estimate/man/e90-SI_geneset-data.html" data-mini-url="/rforge/estimate/man/e90-SI_geneset-data.minihtml">SI_geneset</a></span><span class="pyg-p">)</span> 
   
    <span class="pyg-c1">## Loop over gene sets</span>
    <span class="pyg-n">score.matrix</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-matrix" class="mini-popup" href="/r/base/matrix.html" data-mini-url="/r/base/matrix.minihtml">matrix</a></span><span class="pyg-p">(</span><span class="pyg-m">0</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-nrow" class="mini-popup" href="/r/base/nrow.html" data-mini-url="/r/base/nrow.minihtml">nrow</a></span><span class="pyg-o">=</span><span class="pyg-n">N.gs</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-ncol" class="mini-popup" href="/r/base/nrow.html" data-mini-url="/r/base/nrow.minihtml">ncol</a></span><span class="pyg-o">=</span><span class="pyg-n">Ns</span><span class="pyg-p">)</span>
    <span class="pyg-nf">for </span><span class="pyg-p">(</span><span class="pyg-n">gs.i</span> <span class="pyg-n"><a id="sym-in" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml">in</a></span> <span class="pyg-m">1</span><span class="pyg-o">:</span><span class="pyg-n">N.gs</span><span class="pyg-p">)</span> <span class="pyg-p">{</span>
        <span class="pyg-n">gene.set</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">gs[gs.i</span><span class="pyg-p">,</span><span class="pyg-n">]</span>
        <span class="pyg-n">gene.overlap</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-intersect" class="mini-popup" href="/r/base/sets.html" data-mini-url="/r/base/sets.minihtml">intersect</a></span><span class="pyg-p">(</span><span class="pyg-n">gene.set</span><span class="pyg-p">,</span> <span class="pyg-n">gene.names</span><span class="pyg-p">)</span>
        <span class="pyg-nf"><a id="sym-print" class="mini-popup" href="/r/base/print.html" data-mini-url="/r/base/print.minihtml">print</a></span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-paste" class="mini-popup" href="/r/base/paste.html" data-mini-url="/r/base/paste.minihtml">paste</a></span><span class="pyg-p">(</span><span class="pyg-n">gs.i</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;gene set:&quot;</span><span class="pyg-p">,</span> <span class="pyg-n">gs.names[gs.i]</span><span class="pyg-p">,</span> <span class="pyg-s">&quot; overlap=&quot;</span><span class="pyg-p">,</span> <span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-p">(</span><span class="pyg-n">gene.overlap</span><span class="pyg-p">)))</span>
        <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-p">(</span><span class="pyg-n">gene.overlap</span><span class="pyg-p">)</span> <span class="pyg-o">==</span> <span class="pyg-m">0</span><span class="pyg-p">)</span> <span class="pyg-p">{</span> 
           <span class="pyg-n">score.matrix[gs.i</span><span class="pyg-p">,</span> <span class="pyg-n">]</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-rep" class="mini-popup" href="/r/base/rep.html" data-mini-url="/r/base/rep.minihtml">rep</a></span><span class="pyg-p">(</span><span class="pyg-kc"><a id="sym-NA" class="mini-popup" href="/r/base/NA.html" data-mini-url="/r/base/NA.minihtml">NA</a></span><span class="pyg-p">,</span> <span class="pyg-n">Ns</span><span class="pyg-p">)</span>
           <span class="pyg-n"><a id="sym-next" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml">next</a></span>
        <span class="pyg-p">}</span> <span class="pyg-n"><a id="sym-else" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml">else</a></span> <span class="pyg-p">{</span>
            <span class="pyg-n">ES.vector</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-vector" class="mini-popup" href="/r/base/vector.html" data-mini-url="/r/base/vector.minihtml">vector</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-o">=</span><span class="pyg-n">Ns</span><span class="pyg-p">)</span>
         
            <span class="pyg-c1">## Enrichment score</span>
            <span class="pyg-nf">for </span><span class="pyg-p">(</span><span class="pyg-n">S.index</span> <span class="pyg-n"><a id="sym-in" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml">in</a></span> <span class="pyg-m">1</span><span class="pyg-o">:</span><span class="pyg-n">Ns</span><span class="pyg-p">)</span> <span class="pyg-p">{</span>
                <span class="pyg-n">gene.list</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-order" class="mini-popup" href="/r/base/order.html" data-mini-url="/r/base/order.minihtml">order</a></span><span class="pyg-p">(</span><span class="pyg-n">m<a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml">[</a></span><span class="pyg-p">,</span> <span class="pyg-n">S.index]</span><span class="pyg-p">,</span> <span class="pyg-n">decreasing</span><span class="pyg-o">=</span><span class="pyg-kc"><a id="sym-TRUE" class="mini-popup" href="/r/base/logical.html" data-mini-url="/r/base/logical.minihtml">TRUE</a></span><span class="pyg-p">)</span>            
                <span class="pyg-n">gene.set2</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-match" class="mini-popup" href="/r/base/match.html" data-mini-url="/r/base/match.minihtml">match</a></span><span class="pyg-p">(</span><span class="pyg-n">gene.overlap</span><span class="pyg-p">,</span> <span class="pyg-n">gene.names</span><span class="pyg-p">)</span>
                <span class="pyg-n">correl.vector</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">m[gene.list</span><span class="pyg-p">,</span> <span class="pyg-n">S.index]</span>
          
                <span class="pyg-n">TAG</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-sign" class="mini-popup" href="/r/base/sign.html" data-mini-url="/r/base/sign.minihtml">sign</a></span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-match" class="mini-popup" href="/r/base/match.html" data-mini-url="/r/base/match.minihtml">match</a></span><span class="pyg-p">(</span><span class="pyg-n">gene.list</span><span class="pyg-p">,</span> <span class="pyg-n">gene.set2</span><span class="pyg-p">,</span> <span class="pyg-n">nomatch</span><span class="pyg-o">=</span><span class="pyg-m">0</span><span class="pyg-p">))</span>    <span class="pyg-c1"># 1 (TAG) &amp; 0 (no.TAG)</span>
                <span class="pyg-n">no.TAG</span> <span class="pyg-o">&lt;-</span> <span class="pyg-m">1</span> <span class="pyg-o">-</span> <span class="pyg-n">TAG</span> 
                <span class="pyg-n">N</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-p">(</span><span class="pyg-n">gene.list</span><span class="pyg-p">)</span> 
                <span class="pyg-n">Nh</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-p">(</span><span class="pyg-n">gene.set2</span><span class="pyg-p">)</span> 
                <span class="pyg-n">Nm</span> <span class="pyg-o">&lt;-</span>  <span class="pyg-n">N</span> <span class="pyg-o">-</span> <span class="pyg-n">Nh</span> 
                <span class="pyg-n">correl.vector</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-abs" class="mini-popup" href="/r/base/MathFun.html" data-mini-url="/r/base/MathFun.minihtml">abs</a></span><span class="pyg-p">(</span><span class="pyg-n">correl.vector</span><span class="pyg-p">)</span><span class="pyg-n">^0.25</span>
                <span class="pyg-n">sum.correl</span>  <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-sum" class="mini-popup" href="/r/base/sum.html" data-mini-url="/r/base/sum.minihtml">sum</a></span><span class="pyg-p">(</span><span class="pyg-n">correl.vector[TAG</span> <span class="pyg-o">==</span> <span class="pyg-m">1</span><span class="pyg-n">]</span><span class="pyg-p">)</span>
                <span class="pyg-n">P0</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">no.TAG</span> <span class="pyg-o">/</span> <span class="pyg-n">Nm</span>
                <span class="pyg-n">F0</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-cumsum" class="mini-popup" href="/r/base/cumsum.html" data-mini-url="/r/base/cumsum.minihtml">cumsum</a></span><span class="pyg-p">(</span><span class="pyg-n">P0</span><span class="pyg-p">)</span>
                <span class="pyg-n">Pn</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">TAG</span> <span class="pyg-o">*</span> <span class="pyg-n">correl.vector</span> <span class="pyg-o">/</span> <span class="pyg-n">sum.correl</span>
                <span class="pyg-n">Fn</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-cumsum" class="mini-popup" href="/r/base/cumsum.html" data-mini-url="/r/base/cumsum.minihtml">cumsum</a></span><span class="pyg-p">(</span><span class="pyg-n">Pn</span><span class="pyg-p">)</span>
                <span class="pyg-n">RES</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">Fn</span> <span class="pyg-o">-</span> <span class="pyg-n">F0</span>
                <span class="pyg-n">max.ES</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-max" class="mini-popup" href="/r/base/Extremes.html" data-mini-url="/r/base/Extremes.minihtml">max</a></span><span class="pyg-p">(</span><span class="pyg-n">RES</span><span class="pyg-p">)</span>
                <span class="pyg-n">min.ES</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-min" class="mini-popup" href="/r/base/Extremes.html" data-mini-url="/r/base/Extremes.minihtml">min</a></span><span class="pyg-p">(</span><span class="pyg-n">RES</span><span class="pyg-p">)</span>
                <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n">max.ES</span> <span class="pyg-o">&gt;</span> <span class="pyg-o">-</span> <span class="pyg-n">min.ES</span><span class="pyg-p">)</span> <span class="pyg-p">{</span>
                    <span class="pyg-n">arg.ES</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-which.max" class="mini-popup" href="/r/base/which.min.html" data-mini-url="/r/base/which.min.minihtml">which.max</a></span><span class="pyg-p">(</span><span class="pyg-n">RES</span><span class="pyg-p">)</span>
                <span class="pyg-p">}</span> <span class="pyg-n"><a id="sym-else" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml">else</a></span> <span class="pyg-p">{</span>
                    <span class="pyg-n">arg.ES</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-which.min" class="mini-popup" href="/r/base/which.min.html" data-mini-url="/r/base/which.min.minihtml">which.min</a></span><span class="pyg-p">(</span><span class="pyg-n">RES</span><span class="pyg-p">)</span>
                <span class="pyg-p">}</span>
                <span class="pyg-n">ES</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-sum" class="mini-popup" href="/r/base/sum.html" data-mini-url="/r/base/sum.minihtml">sum</a></span><span class="pyg-p">(</span><span class="pyg-n">RES</span><span class="pyg-p">)</span>
                <span class="pyg-n">EnrichmentScore</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-list" class="mini-popup" href="/r/base/list.html" data-mini-url="/r/base/list.minihtml">list</a></span><span class="pyg-p">(</span><span class="pyg-n">ES</span><span class="pyg-o">=</span><span class="pyg-n">ES</span><span class="pyg-p">,</span>
                                        <span class="pyg-n">arg.ES</span><span class="pyg-o">=</span><span class="pyg-n">arg.ES</span><span class="pyg-p">,</span>
                                        <span class="pyg-n">RES</span><span class="pyg-o">=</span><span class="pyg-n">RES</span><span class="pyg-p">,</span>
                                        <span class="pyg-n">indicator</span><span class="pyg-o">=</span><span class="pyg-n">TAG</span><span class="pyg-p">)</span>
                <span class="pyg-n">ES.vector[S.index]</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">EnrichmentScore</span><span class="pyg-o">$</span><span class="pyg-n">ES</span>
            <span class="pyg-p">}</span>
            <span class="pyg-n">score.matrix[gs.i</span><span class="pyg-p">,</span> <span class="pyg-n">]</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">ES.vector</span>
        <span class="pyg-p">}</span>
    <span class="pyg-p">}</span>

    <span class="pyg-n">score.data</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-data.frame" class="mini-popup" href="/r/base/data.frame.html" data-mini-url="/r/base/data.frame.minihtml">data.frame</a></span><span class="pyg-p">(</span><span class="pyg-n">score.matrix</span><span class="pyg-p">)</span>
    <span class="pyg-nf"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml">names</a></span><span class="pyg-p">(</span><span class="pyg-n">score.data</span><span class="pyg-p">)</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">sample.names</span>
    <span class="pyg-nf"><a id="sym-row.names" class="mini-popup" href="/r/base/row.names.html" data-mini-url="/r/base/row.names.minihtml">row.names</a></span><span class="pyg-p">(</span><span class="pyg-n">score.data</span><span class="pyg-p">)</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">gs.names</span>
    <span class="pyg-n">estimate.score</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-apply" class="mini-popup" href="/r/base/apply.html" data-mini-url="/r/base/apply.minihtml">apply</a></span><span class="pyg-p">(</span><span class="pyg-n">score.data</span><span class="pyg-p">,</span> <span class="pyg-m">2</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-sum" class="mini-popup" href="/r/base/sum.html" data-mini-url="/r/base/sum.minihtml">sum</a></span><span class="pyg-p">)</span>
   
    <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n">platform</span> <span class="pyg-o">!=</span> <span class="pyg-s">&quot;affymetrix&quot;</span><span class="pyg-p">){</span>
        <span class="pyg-n">score.data</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-rbind" class="mini-popup" href="/r/base/cbind.html" data-mini-url="/r/base/cbind.minihtml">rbind</a></span><span class="pyg-p">(</span><span class="pyg-n">score.data</span><span class="pyg-p">,</span> <span class="pyg-n">estimate.score</span><span class="pyg-p">)</span>
        <span class="pyg-nf"><a id="sym-rownames" class="mini-popup" href="/r/base/colnames.html" data-mini-url="/r/base/colnames.minihtml">rownames</a></span><span class="pyg-p">(</span><span class="pyg-n">score.data</span><span class="pyg-p">)</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-c" class="mini-popup" href="/r/base/c.html" data-mini-url="/r/base/c.minihtml">c</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;StromalScore&quot;</span><span class="pyg-p">,</span>
                                  <span class="pyg-s">&quot;ImmuneScore&quot;</span><span class="pyg-p">,</span>
                                  <span class="pyg-s">&quot;ESTIMATEScore&quot;</span><span class="pyg-p">)</span>
    <span class="pyg-p">}</span> <span class="pyg-n"><a id="sym-else" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml">else</a></span> <span class="pyg-p">{</span>
        <span class="pyg-c1">##---------------------------------------------------------------------</span>
        <span class="pyg-c1">## Calculate ESTIMATE-based tumor purity (Affymetrix-specific)</span>
        <span class="pyg-n">convert_row_estimate_score_to_tumor_purity</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-function" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml">function</a></span><span class="pyg-p">(</span><span class="pyg-n">x</span><span class="pyg-p">)</span> <span class="pyg-p">{</span>
            <span class="pyg-nf"><a id="sym-stopifnot" class="mini-popup" href="/r/base/stopifnot.html" data-mini-url="/r/base/stopifnot.minihtml">stopifnot</a></span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-is.numeric" class="mini-popup" href="/r/base/numeric.html" data-mini-url="/r/base/numeric.minihtml">is.numeric</a></span><span class="pyg-p">(</span><span class="pyg-n">x</span><span class="pyg-p">))</span>
            <span class="pyg-nf"><a id="sym-cos" class="mini-popup" href="/r/base/Trig.html" data-mini-url="/r/base/Trig.minihtml">cos</a></span><span class="pyg-p">(</span><span class="pyg-m">0.6049872018</span> <span class="pyg-o">+</span> <span class="pyg-m">0.0001467884</span><span class="pyg-o">*</span><span class="pyg-n">x</span><span class="pyg-p">)</span>
        <span class="pyg-p">}</span>
        
        <span class="pyg-n">est.new</span> <span class="pyg-o">&lt;-</span> <span class="pyg-kc"><a id="sym-NULL" class="mini-popup" href="/r/base/NULL.html" data-mini-url="/r/base/NULL.minihtml">NULL</a></span>
        <span class="pyg-nf">for </span><span class="pyg-p">(</span><span class="pyg-n">i</span> <span class="pyg-n"><a id="sym-in" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml">in</a></span> <span class="pyg-m">1</span><span class="pyg-o">:</span><span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml">length</a></span><span class="pyg-p">(</span><span class="pyg-n">estimate.score</span><span class="pyg-p">))</span> <span class="pyg-p">{</span>
            <span class="pyg-n">est_i</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf">convert_row_estimate_score_to_tumor_purity</span><span class="pyg-p">(</span><span class="pyg-n">estimate.score[i]</span><span class="pyg-p">)</span>
            <span class="pyg-n">est.new</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-rbind" class="mini-popup" href="/r/base/cbind.html" data-mini-url="/r/base/cbind.minihtml">rbind</a></span><span class="pyg-p">(</span><span class="pyg-n">est.new</span><span class="pyg-p">,</span> <span class="pyg-n">est_i</span><span class="pyg-p">)</span>
            <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n">est_i</span> <span class="pyg-o">&gt;=</span> <span class="pyg-m">0</span><span class="pyg-p">)</span> <span class="pyg-p">{</span>
                <span class="pyg-n"><a id="sym-next" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml">next</a></span>
            <span class="pyg-p">}</span> <span class="pyg-n"><a id="sym-else" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml">else</a></span> <span class="pyg-p">{</span>
                <span class="pyg-nf"><a id="sym-message" class="mini-popup" href="/r/base/message.html" data-mini-url="/r/base/message.minihtml">message</a></span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-paste" class="mini-popup" href="/r/base/paste.html" data-mini-url="/r/base/paste.minihtml">paste</a></span><span class="pyg-p">(</span><span class="pyg-n">sample.names[i]</span><span class="pyg-p">,</span><span class="pyg-s">&quot;: out of bounds&quot;</span><span class="pyg-p">,</span> <span class="pyg-n">sep</span><span class="pyg-o">=</span><span class="pyg-s">&quot;&quot;</span><span class="pyg-p">))</span>
            <span class="pyg-p">}</span>
        <span class="pyg-p">}</span>
        <span class="pyg-nf"><a id="sym-colnames" class="mini-popup" href="/r/base/colnames.html" data-mini-url="/r/base/colnames.minihtml">colnames</a></span><span class="pyg-p">(</span><span class="pyg-n">est.new</span><span class="pyg-p">)</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-c" class="mini-popup" href="/r/base/c.html" data-mini-url="/r/base/c.minihtml">c</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;TumorPurity&quot;</span><span class="pyg-p">)</span>
        <span class="pyg-n">estimate.t1</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-cbind" class="mini-popup" href="/r/base/cbind.html" data-mini-url="/r/base/cbind.minihtml">cbind</a></span><span class="pyg-p">(</span><span class="pyg-n">estimate.score</span><span class="pyg-p">,</span> <span class="pyg-n">est.new</span><span class="pyg-p">)</span>
        <span class="pyg-n">x.bad.tumor.purities</span> <span class="pyg-o">&lt;-</span> <span class="pyg-n">estimate.t1<a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml">[</a></span><span class="pyg-p">,</span> <span class="pyg-s">&quot;TumorPurity&quot;</span><span class="pyg-n">]</span> <span class="pyg-o">&lt;</span> <span class="pyg-m">0</span>
        <span class="pyg-n">estimate.t1[x.bad.tumor.purities</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;TumorPurity&quot;</span><span class="pyg-n">]</span> <span class="pyg-o">&lt;-</span> <span class="pyg-kc"><a id="sym-NA" class="mini-popup" href="/r/base/NA.html" data-mini-url="/r/base/NA.minihtml">NA</a></span>
        <span class="pyg-n">score.data</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-rbind" class="mini-popup" href="/r/base/cbind.html" data-mini-url="/r/base/cbind.minihtml">rbind</a></span><span class="pyg-p">(</span><span class="pyg-n">score.data</span><span class="pyg-p">,</span> <span class="pyg-nf"><a id="sym-t" class="mini-popup" href="/r/base/t.html" data-mini-url="/r/base/t.minihtml">t</a></span><span class="pyg-p">(</span><span class="pyg-n">estimate.t1</span><span class="pyg-p">))</span>
        <span class="pyg-nf"><a id="sym-rownames" class="mini-popup" href="/r/base/colnames.html" data-mini-url="/r/base/colnames.minihtml">rownames</a></span><span class="pyg-p">(</span><span class="pyg-n">score.data</span><span class="pyg-p">)</span> <span class="pyg-o">&lt;-</span> <span class="pyg-nf"><a id="sym-c" class="mini-popup" href="/r/base/c.html" data-mini-url="/r/base/c.minihtml">c</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;StromalScore&quot;</span><span class="pyg-p">,</span>
                                  <span class="pyg-s">&quot;ImmuneScore&quot;</span><span class="pyg-p">,</span>
                                  <span class="pyg-s">&quot;ESTIMATEScore&quot;</span><span class="pyg-p">,</span>
                                  <span class="pyg-s">&quot;TumorPurity&quot;</span><span class="pyg-p">)</span>
    <span class="pyg-p">}</span>
    <span class="pyg-nf"><a id="sym-outputGCT" class="mini-popup" href="/rforge/estimate/man/e50-outputGCT.html" data-mini-url="/rforge/estimate/man/e50-outputGCT.minihtml">outputGCT</a></span><span class="pyg-p">(</span><span class="pyg-n">score.data</span><span class="pyg-p">,</span> <span class="pyg-n">output.ds</span><span class="pyg-p">)</span>
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
