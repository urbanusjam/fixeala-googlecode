<!DOCTYPE html>
<html>
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# githubog: http://ogp.me/ns/fb/githubog#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>bootstrap/js/bootstrap-dropdown.js at master · twitter/bootstrap · GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="apple-touch-icon-114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="apple-touch-icon-114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="apple-touch-icon-144.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="apple-touch-icon-144.png" />
    <link rel="logo" type="image/svg" href="http://github-media-downloads.s3.amazonaws.com/github-logo.svg" />
    <meta name="msapplication-TileImage" content="/windows-tile.png">
    <meta name="msapplication-TileColor" content="#ffffff">

    
    
    <link rel="icon" type="image/x-icon" href="/favicon.ico" />

    <meta content="authenticity_token" name="csrf-param" />
<meta content="a5pLZ7Xf/mxuzZBPCLf5T9acdv9ZgwSg5aDlBBcYNbI=" name="csrf-token" />

    <link href="https://a248.e.akamai.net/assets.github.com/assets/github-c8ea93a5a56d1eaf1f3be229fe348969b60f0ed9.css" media="screen" rel="stylesheet" type="text/css" />
    <link href="https://a248.e.akamai.net/assets.github.com/assets/github2-f7aa84731d2f3be4e7d9a49c961266385e9dd351.css" media="screen" rel="stylesheet" type="text/css" />
    


      <script src="https://a248.e.akamai.net/assets.github.com/assets/frameworks-5dcdaf734c8092261f37e6534c8f114696d913a9.js" type="text/javascript"></script>
      <script src="https://a248.e.akamai.net/assets.github.com/assets/github-8a2197ff4d5231057d97c0cb4eef98d0ecf3fd56.js" type="text/javascript"></script>
      

        <link rel='permalink' href='/twitter/bootstrap/blob/ee91afba63bc6e9687397b9052858fca242c2ff5/js/bootstrap-dropdown.js'>
    <meta property="og:title" content="bootstrap"/>
    <meta property="og:type" content="githubog:gitrepository"/>
    <meta property="og:url" content="https://github.com/twitter/bootstrap"/>
    <meta property="og:image" content="https://secure.gravatar.com/avatar/2f4a8254d032a8ec5e4c48d461e54fcc?s=420&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"/>
    <meta property="og:site_name" content="GitHub"/>
    <meta property="og:description" content="bootstrap - Sleek, intuitive, and powerful front-end framework for faster and easier web development."/>
    <meta property="twitter:card" content="summary"/>
    <meta property="twitter:site" content="@GitHub">
    <meta property="twitter:title" content="twitter/bootstrap"/>

    <meta name="description" content="bootstrap - Sleek, intuitive, and powerful front-end framework for faster and easier web development." />

  <link href="https://github.com/twitter/bootstrap/commits/master.atom" rel="alternate" title="Recent Commits to bootstrap:master" type="application/atom+xml" />

  </head>


  <body class="logged_out page-blob linux vis-public env-production  ">
    <div id="wrapper">

      

      

      

      


        <div class="header header-logged-out">
          <div class="container clearfix">

            <a class="header-logo-wordmark" href="https://github.com/">
              <img alt="GitHub" class="github-logo-4x" height="30" src="https://a248.e.akamai.net/assets.github.com/images/modules/header/logov7@4x.png?1338945075" />
              <img alt="GitHub" class="github-logo-4x-hover" height="30" src="https://a248.e.akamai.net/assets.github.com/images/modules/header/logov7@4x-hover.png?1338945075" />
            </a>

              
<ul class="top-nav">
    <li class="explore"><a href="https://github.com/explore">Explore GitHub</a></li>
  <li class="search"><a href="https://github.com/search">Search</a></li>
  <li class="features"><a href="https://github.com/features">Features</a></li>
    <li class="blog"><a href="https://github.com/blog">Blog</a></li>
</ul>


            <div class="header-actions">
                <a class="button primary" href="https://github.com/signup">Sign up for free</a>
              <a class="button" href="https://github.com/login?return_to=%2Ftwitter%2Fbootstrap%2Fblob%2Fmaster%2Fjs%2Fbootstrap-dropdown.js">Sign in</a>
            </div>

          </div>
        </div>


      

      


            <div class="site hfeed" itemscope itemtype="http://schema.org/WebPage">
      <div class="hentry">
        
        <div class="pagehead repohead instapaper_ignore readability-menu">
          <div class="container">
            <div class="title-actions-bar">
              


<ul class="pagehead-actions">



    <li>
      <a href="/login?return_to=%2Ftwitter%2Fbootstrap"
        class="minibutton js-toggler-target star-button entice tooltipped upwards"
        title="You must be signed in to use this feature" rel="nofollow">
        <span class="mini-icon mini-icon-star"></span>Star
      </a>
      <a class="social-count js-social-count" href="/twitter/bootstrap/stargazers">
        44,523
      </a>
    </li>
    <li>
      <a href="/login?return_to=%2Ftwitter%2Fbootstrap"
        class="minibutton js-toggler-target fork-button entice tooltipped upwards"
        title="You must be signed in to fork a repository" rel="nofollow">
        <span class="mini-icon mini-icon-fork"></span>Fork
      </a>
      <a href="/twitter/bootstrap/network" class="social-count">
        12,268
      </a>
    </li>
</ul>

              <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
                <span class="repo-label"><span>public</span></span>
                <span class="mega-icon mega-icon-public-repo"></span>
                <span class="author vcard">
                  <a href="/twitter" class="url fn" itemprop="url" rel="author">
                  <span itemprop="title">twitter</span>
                  </a></span> /
                <strong><a href="/twitter/bootstrap" class="js-current-repository">bootstrap</a></strong>
              </h1>
            </div>

            

  <ul class="tabs">
    <li><a href="/twitter/bootstrap" class="selected" highlight="repo_sourcerepo_downloadsrepo_commitsrepo_tagsrepo_branches">Code</a></li>
    <li><a href="/twitter/bootstrap/network" highlight="repo_network">Network</a></li>
    <li><a href="/twitter/bootstrap/pulls" highlight="repo_pulls">Pull Requests <span class='counter'>10</span></a></li>

      <li><a href="/twitter/bootstrap/issues" highlight="repo_issues">Issues <span class='counter'>105</span></a></li>

      <li><a href="/twitter/bootstrap/wiki" highlight="repo_wiki">Wiki</a></li>


    <li><a href="/twitter/bootstrap/graphs" highlight="repo_graphsrepo_contributors">Graphs</a></li>


  </ul>
  
<div class="tabnav">

  <span class="tabnav-right">
    <ul class="tabnav-tabs">
          <li><a href="/twitter/bootstrap/tags" class="tabnav-tab" highlight="repo_tags">Tags <span class="counter ">16</span></a></li>
    </ul>
    
  </span>

  <div class="tabnav-widget scope">


    <div class="select-menu js-menu-container js-select-menu js-branch-menu">
      <a class="minibutton select-menu-button js-menu-target" data-hotkey="w" data-ref="master">
        <span class="mini-icon mini-icon-branch"></span>
        <i>branch:</i>
        <span class="js-select-button">master</span>
      </a>

      <div class="select-menu-modal-holder js-menu-content js-navigation-container js-select-menu-pane">

        <div class="select-menu-modal js-select-menu-pane">
          <div class="select-menu-header">
            <span class="select-menu-title">Switch branches/tags</span>
            <span class="mini-icon mini-icon-remove-close js-menu-close"></span>
          </div> <!-- /.select-menu-header -->

          <div class="select-menu-filters">
            <div class="select-menu-text-filter">
              <input type="text" id="commitish-filter-field" class="js-select-menu-text-filter js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
            </div> <!-- /.select-menu-text-filter -->
            <div class="select-menu-tabs">
              <ul>
                <li class="select-menu-tab">
                  <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
                </li>
                <li class="select-menu-tab">
                  <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
                </li>
              </ul>
            </div><!-- /.select-menu-tabs -->
          </div><!-- /.select-menu-filters -->

          <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket css-truncate" data-tab-filter="branches" data-filterable-for="commitish-filter-field" data-filterable-type="substring">



              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                <a href="/twitter/bootstrap/blob/2.3.0-wip/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="2.3.0-wip" rel="nofollow" title="2.3.0-wip">2.3.0-wip</a>
              </div> <!-- /.select-menu-item -->

              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                <a href="/twitter/bootstrap/blob/3.0.0-wip/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="3.0.0-wip" rel="nofollow" title="3.0.0-wip">3.0.0-wip</a>
              </div> <!-- /.select-menu-item -->

              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                <a href="/twitter/bootstrap/blob/bootjack/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="bootjack" rel="nofollow" title="bootjack">bootjack</a>
              </div> <!-- /.select-menu-item -->

              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                <a href="/twitter/bootstrap/blob/gh-pages/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="gh-pages" rel="nofollow" title="gh-pages">gh-pages</a>
              </div> <!-- /.select-menu-item -->

              <div class="select-menu-item js-navigation-item js-navigation-target selected">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                <a href="/twitter/bootstrap/blob/master/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="master" rel="nofollow" title="master">master</a>
              </div> <!-- /.select-menu-item -->

              <div class="select-menu-no-results js-not-filterable">Nothing to show</div>
          </div> <!-- /.select-menu-list -->


          <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket css-truncate" data-tab-filter="tags" data-filterable-for="commitish-filter-field" data-filterable-type="substring">

              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v2.2.2/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v2.2.2" rel="nofollow" title="v2.2.2">v2.2.2</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v2.2.1/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v2.2.1" rel="nofollow" title="v2.2.1">v2.2.1</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v2.2.0/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v2.2.0" rel="nofollow" title="v2.2.0">v2.2.0</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v2.1.1/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v2.1.1" rel="nofollow" title="v2.1.1">v2.1.1</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v2.1.0/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v2.1.0" rel="nofollow" title="v2.1.0">v2.1.0</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v2.0.4/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v2.0.4" rel="nofollow" title="v2.0.4">v2.0.4</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v2.0.3/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v2.0.3" rel="nofollow" title="v2.0.3">v2.0.3</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v2.0.2/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v2.0.2" rel="nofollow" title="v2.0.2">v2.0.2</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v2.0.1/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v2.0.1" rel="nofollow" title="v2.0.1">v2.0.1</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v2.0.0/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v2.0.0" rel="nofollow" title="v2.0.0">v2.0.0</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v1.4.0/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v1.4.0" rel="nofollow" title="v1.4.0">v1.4.0</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v1.3.0/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v1.3.0" rel="nofollow" title="v1.3.0">v1.3.0</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v1.2.0/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v1.2.0" rel="nofollow" title="v1.2.0">v1.2.0</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v1.1.1/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v1.1.1" rel="nofollow" title="v1.1.1">v1.1.1</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v1.1.0/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v1.1.0" rel="nofollow" title="v1.1.0">v1.1.0</a>

              </div> <!-- /.select-menu-item -->
              <div class="select-menu-item js-navigation-item js-navigation-target ">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                    <a href="/twitter/bootstrap/blob/v1.0.0/js/bootstrap-dropdown.js" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="v1.0.0" rel="nofollow" title="v1.0.0">v1.0.0</a>

              </div> <!-- /.select-menu-item -->

            <div class="select-menu-no-results js-not-filterable">Nothing to show</div>

          </div> <!-- /.select-menu-list -->

        </div> <!-- /.select-menu-modal -->
      </div> <!-- /.select-menu-modal-holder -->
    </div> <!-- /.select-menu -->

  </div> <!-- /.scope -->

  <ul class="tabnav-tabs">
    <li><a href="/twitter/bootstrap" class="selected tabnav-tab" highlight="repo_source">Files</a></li>
    <li><a href="/twitter/bootstrap/commits/master" class="tabnav-tab" highlight="repo_commits">Commits</a></li>
    <li><a href="/twitter/bootstrap/branches" class="tabnav-tab" highlight="repo_branches" rel="nofollow">Branches <span class="counter ">5</span></a></li>
  </ul>

</div>

  
  
  


            
          </div>
        </div><!-- /.repohead -->

        <div id="js-repo-pjax-container" class="container context-loader-container" data-pjax-container>
          


<!-- blob contrib key: blob_contributors:v21:948a6d359822cd5c06895d81c6bb4139 -->
<!-- blob contrib frag key: views10/v8/blob_contributors:v21:948a6d359822cd5c06895d81c6bb4139 -->


<div id="slider">
    <div class="frame-meta">

      <p title="This is a placeholder element" class="js-history-link-replace hidden"></p>

        <div class="breadcrumb">
          <span class='bold'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/twitter/bootstrap" class="js-slide-to" data-direction="back" itemscope="url"><span itemprop="title">bootstrap</span></a></span></span> / <span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/twitter/bootstrap/tree/master/js" class="js-slide-to" data-direction="back" itemscope="url"><span itemprop="title">js</span></a></span> / <strong class="final-path">bootstrap-dropdown.js</strong> <span class="js-zeroclipboard zeroclipboard-button" data-clipboard-text="js/bootstrap-dropdown.js" data-copied-hint="copied!" title="copy to clipboard"><span class="mini-icon mini-icon-clipboard"></span></span>
        </div>

      <a href="/twitter/bootstrap/find/master" class="js-slide-to" data-hotkey="t" style="display:none">Show File Finder</a>


        
  <div class="commit file-history-tease">
    <img class="main-avatar" height="24" src="https://secure.gravatar.com/avatar/a98244cbdacaf1c0b55499466002f7a8?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="24" />
    <span class="author"><a href="/fat" rel="author">fat</a></span>
    <time class="js-relative-date" datetime="2012-12-07T15:37:32-08:00" title="2012-12-07 15:37:32">December 07, 2012</time>
    <div class="commit-title">
        <a href="/twitter/bootstrap/commit/437654030aa283b92a260245b54fa17a417c20d8" class="message">focus on escape in typeahead</a>
    </div>

    <div class="participation">
      <p class="quickstat"><a href="#blob_contributors_box" rel="facebox"><strong>6</strong> contributors</a></p>
          <a class="avatar tooltipped downwards" title="fat" href="/twitter/bootstrap/commits/master/js/bootstrap-dropdown.js?author=fat"><img height="20" src="https://secure.gravatar.com/avatar/a98244cbdacaf1c0b55499466002f7a8?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="20" /></a>
    <a class="avatar tooltipped downwards" title="mdo" href="/twitter/bootstrap/commits/master/js/bootstrap-dropdown.js?author=mdo"><img height="20" src="https://secure.gravatar.com/avatar/bc4ab438f7a4ce1c406aadc688427f2c?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="20" /></a>
    <a class="avatar tooltipped downwards" title="badcarl" href="/twitter/bootstrap/commits/master/js/bootstrap-dropdown.js?author=badcarl"><img height="20" src="https://secure.gravatar.com/avatar/aedd89a10aba3a46576ea4f604146c65?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="20" /></a>
    <a class="avatar tooltipped downwards" title="artiz" href="/twitter/bootstrap/commits/master/js/bootstrap-dropdown.js?author=artiz"><img height="20" src="https://secure.gravatar.com/avatar/396bbe5f330553121c57d8b2979b26e2?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="20" /></a>
    <a class="avatar tooltipped downwards" title="lookfirst" href="/twitter/bootstrap/commits/master/js/bootstrap-dropdown.js?author=lookfirst"><img height="20" src="https://secure.gravatar.com/avatar/0797402e2558924b62845d0ac0fddbb3?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="20" /></a>
    <a class="avatar tooltipped downwards" title="erlendfh" href="/twitter/bootstrap/commits/master/js/bootstrap-dropdown.js?author=erlendfh"><img height="20" src="https://secure.gravatar.com/avatar/cf4621433dfa81bba4712eed74acbebb?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="20" /></a>


    </div>
    <div id="blob_contributors_box" style="display:none">
      <h2>Users on GitHub who have contributed to this file</h2>
      <ul class="facebox-user-list">
        <li>
          <img height="24" src="https://secure.gravatar.com/avatar/a98244cbdacaf1c0b55499466002f7a8?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="24" />
          <a href="/fat">fat</a>
        </li>
        <li>
          <img height="24" src="https://secure.gravatar.com/avatar/bc4ab438f7a4ce1c406aadc688427f2c?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="24" />
          <a href="/mdo">mdo</a>
        </li>
        <li>
          <img height="24" src="https://secure.gravatar.com/avatar/aedd89a10aba3a46576ea4f604146c65?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="24" />
          <a href="/badcarl">badcarl</a>
        </li>
        <li>
          <img height="24" src="https://secure.gravatar.com/avatar/396bbe5f330553121c57d8b2979b26e2?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="24" />
          <a href="/artiz">artiz</a>
        </li>
        <li>
          <img height="24" src="https://secure.gravatar.com/avatar/0797402e2558924b62845d0ac0fddbb3?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="24" />
          <a href="/lookfirst">lookfirst</a>
        </li>
        <li>
          <img height="24" src="https://secure.gravatar.com/avatar/cf4621433dfa81bba4712eed74acbebb?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="24" />
          <a href="/erlendfh">erlendfh</a>
        </li>
      </ul>
    </div>
  </div>


    </div><!-- ./.frame-meta -->

    <div class="frames">
      <div class="frame" data-permalink-url="/twitter/bootstrap/blob/ee91afba63bc6e9687397b9052858fca242c2ff5/js/bootstrap-dropdown.js" data-title="bootstrap/js/bootstrap-dropdown.js at master · twitter/bootstrap · GitHub" data-type="blob">

        <div id="files" class="bubble">
          <div class="file">
            <div class="meta">
              <div class="info">
                <span class="icon"><b class="mini-icon mini-icon-text-file"></b></span>
                <span class="mode" title="File Mode">file</span>
                  <span>161 lines (114 sloc)</span>
                <span>4.236 kb</span>
              </div>
              <div class="actions">
                <div class="button-group">
                      <a class="minibutton js-entice" href=""
                         data-entice="You must be signed in and on a branch to make or propose changes">Edit</a>
                  <a href="/twitter/bootstrap/raw/master/js/bootstrap-dropdown.js" class="button minibutton " id="raw-url">Raw</a>
                    <a href="/twitter/bootstrap/blame/master/js/bootstrap-dropdown.js" class="button minibutton ">Blame</a>
                  <a href="/twitter/bootstrap/commits/master/js/bootstrap-dropdown.js" class="button minibutton " rel="nofollow">History</a>
                </div><!-- /.button-group -->
              </div><!-- /.actions -->

            </div>
                <div class="data type-javascript">
      <table cellpadding="0" cellspacing="0" class="lines">
        <tr>
          <td>
            <pre class="line_numbers"><span id="L1" rel="#L1">1</span>
<span id="L2" rel="#L2">2</span>
<span id="L3" rel="#L3">3</span>
<span id="L4" rel="#L4">4</span>
<span id="L5" rel="#L5">5</span>
<span id="L6" rel="#L6">6</span>
<span id="L7" rel="#L7">7</span>
<span id="L8" rel="#L8">8</span>
<span id="L9" rel="#L9">9</span>
<span id="L10" rel="#L10">10</span>
<span id="L11" rel="#L11">11</span>
<span id="L12" rel="#L12">12</span>
<span id="L13" rel="#L13">13</span>
<span id="L14" rel="#L14">14</span>
<span id="L15" rel="#L15">15</span>
<span id="L16" rel="#L16">16</span>
<span id="L17" rel="#L17">17</span>
<span id="L18" rel="#L18">18</span>
<span id="L19" rel="#L19">19</span>
<span id="L20" rel="#L20">20</span>
<span id="L21" rel="#L21">21</span>
<span id="L22" rel="#L22">22</span>
<span id="L23" rel="#L23">23</span>
<span id="L24" rel="#L24">24</span>
<span id="L25" rel="#L25">25</span>
<span id="L26" rel="#L26">26</span>
<span id="L27" rel="#L27">27</span>
<span id="L28" rel="#L28">28</span>
<span id="L29" rel="#L29">29</span>
<span id="L30" rel="#L30">30</span>
<span id="L31" rel="#L31">31</span>
<span id="L32" rel="#L32">32</span>
<span id="L33" rel="#L33">33</span>
<span id="L34" rel="#L34">34</span>
<span id="L35" rel="#L35">35</span>
<span id="L36" rel="#L36">36</span>
<span id="L37" rel="#L37">37</span>
<span id="L38" rel="#L38">38</span>
<span id="L39" rel="#L39">39</span>
<span id="L40" rel="#L40">40</span>
<span id="L41" rel="#L41">41</span>
<span id="L42" rel="#L42">42</span>
<span id="L43" rel="#L43">43</span>
<span id="L44" rel="#L44">44</span>
<span id="L45" rel="#L45">45</span>
<span id="L46" rel="#L46">46</span>
<span id="L47" rel="#L47">47</span>
<span id="L48" rel="#L48">48</span>
<span id="L49" rel="#L49">49</span>
<span id="L50" rel="#L50">50</span>
<span id="L51" rel="#L51">51</span>
<span id="L52" rel="#L52">52</span>
<span id="L53" rel="#L53">53</span>
<span id="L54" rel="#L54">54</span>
<span id="L55" rel="#L55">55</span>
<span id="L56" rel="#L56">56</span>
<span id="L57" rel="#L57">57</span>
<span id="L58" rel="#L58">58</span>
<span id="L59" rel="#L59">59</span>
<span id="L60" rel="#L60">60</span>
<span id="L61" rel="#L61">61</span>
<span id="L62" rel="#L62">62</span>
<span id="L63" rel="#L63">63</span>
<span id="L64" rel="#L64">64</span>
<span id="L65" rel="#L65">65</span>
<span id="L66" rel="#L66">66</span>
<span id="L67" rel="#L67">67</span>
<span id="L68" rel="#L68">68</span>
<span id="L69" rel="#L69">69</span>
<span id="L70" rel="#L70">70</span>
<span id="L71" rel="#L71">71</span>
<span id="L72" rel="#L72">72</span>
<span id="L73" rel="#L73">73</span>
<span id="L74" rel="#L74">74</span>
<span id="L75" rel="#L75">75</span>
<span id="L76" rel="#L76">76</span>
<span id="L77" rel="#L77">77</span>
<span id="L78" rel="#L78">78</span>
<span id="L79" rel="#L79">79</span>
<span id="L80" rel="#L80">80</span>
<span id="L81" rel="#L81">81</span>
<span id="L82" rel="#L82">82</span>
<span id="L83" rel="#L83">83</span>
<span id="L84" rel="#L84">84</span>
<span id="L85" rel="#L85">85</span>
<span id="L86" rel="#L86">86</span>
<span id="L87" rel="#L87">87</span>
<span id="L88" rel="#L88">88</span>
<span id="L89" rel="#L89">89</span>
<span id="L90" rel="#L90">90</span>
<span id="L91" rel="#L91">91</span>
<span id="L92" rel="#L92">92</span>
<span id="L93" rel="#L93">93</span>
<span id="L94" rel="#L94">94</span>
<span id="L95" rel="#L95">95</span>
<span id="L96" rel="#L96">96</span>
<span id="L97" rel="#L97">97</span>
<span id="L98" rel="#L98">98</span>
<span id="L99" rel="#L99">99</span>
<span id="L100" rel="#L100">100</span>
<span id="L101" rel="#L101">101</span>
<span id="L102" rel="#L102">102</span>
<span id="L103" rel="#L103">103</span>
<span id="L104" rel="#L104">104</span>
<span id="L105" rel="#L105">105</span>
<span id="L106" rel="#L106">106</span>
<span id="L107" rel="#L107">107</span>
<span id="L108" rel="#L108">108</span>
<span id="L109" rel="#L109">109</span>
<span id="L110" rel="#L110">110</span>
<span id="L111" rel="#L111">111</span>
<span id="L112" rel="#L112">112</span>
<span id="L113" rel="#L113">113</span>
<span id="L114" rel="#L114">114</span>
<span id="L115" rel="#L115">115</span>
<span id="L116" rel="#L116">116</span>
<span id="L117" rel="#L117">117</span>
<span id="L118" rel="#L118">118</span>
<span id="L119" rel="#L119">119</span>
<span id="L120" rel="#L120">120</span>
<span id="L121" rel="#L121">121</span>
<span id="L122" rel="#L122">122</span>
<span id="L123" rel="#L123">123</span>
<span id="L124" rel="#L124">124</span>
<span id="L125" rel="#L125">125</span>
<span id="L126" rel="#L126">126</span>
<span id="L127" rel="#L127">127</span>
<span id="L128" rel="#L128">128</span>
<span id="L129" rel="#L129">129</span>
<span id="L130" rel="#L130">130</span>
<span id="L131" rel="#L131">131</span>
<span id="L132" rel="#L132">132</span>
<span id="L133" rel="#L133">133</span>
<span id="L134" rel="#L134">134</span>
<span id="L135" rel="#L135">135</span>
<span id="L136" rel="#L136">136</span>
<span id="L137" rel="#L137">137</span>
<span id="L138" rel="#L138">138</span>
<span id="L139" rel="#L139">139</span>
<span id="L140" rel="#L140">140</span>
<span id="L141" rel="#L141">141</span>
<span id="L142" rel="#L142">142</span>
<span id="L143" rel="#L143">143</span>
<span id="L144" rel="#L144">144</span>
<span id="L145" rel="#L145">145</span>
<span id="L146" rel="#L146">146</span>
<span id="L147" rel="#L147">147</span>
<span id="L148" rel="#L148">148</span>
<span id="L149" rel="#L149">149</span>
<span id="L150" rel="#L150">150</span>
<span id="L151" rel="#L151">151</span>
<span id="L152" rel="#L152">152</span>
<span id="L153" rel="#L153">153</span>
<span id="L154" rel="#L154">154</span>
<span id="L155" rel="#L155">155</span>
<span id="L156" rel="#L156">156</span>
<span id="L157" rel="#L157">157</span>
<span id="L158" rel="#L158">158</span>
<span id="L159" rel="#L159">159</span>
<span id="L160" rel="#L160">160</span>
<span id="L161" rel="#L161">161</span>
</pre>
          </td>
          <td width="100%">
                <div class="highlight"><pre><div class='line' id='LC1'><span class="cm">/* ============================================================</span></div><div class='line' id='LC2'><span class="cm"> * bootstrap-dropdown.js v2.2.2</span></div><div class='line' id='LC3'><span class="cm"> * http://twitter.github.com/bootstrap/javascript.html#dropdowns</span></div><div class='line' id='LC4'><span class="cm"> * ============================================================</span></div><div class='line' id='LC5'><span class="cm"> * Copyright 2012 Twitter, Inc.</span></div><div class='line' id='LC6'><span class="cm"> *</span></div><div class='line' id='LC7'><span class="cm"> * Licensed under the Apache License, Version 2.0 (the &quot;License&quot;);</span></div><div class='line' id='LC8'><span class="cm"> * you may not use this file except in compliance with the License.</span></div><div class='line' id='LC9'><span class="cm"> * You may obtain a copy of the License at</span></div><div class='line' id='LC10'><span class="cm"> *</span></div><div class='line' id='LC11'><span class="cm"> * http://www.apache.org/licenses/LICENSE-2.0</span></div><div class='line' id='LC12'><span class="cm"> *</span></div><div class='line' id='LC13'><span class="cm"> * Unless required by applicable law or agreed to in writing, software</span></div><div class='line' id='LC14'><span class="cm"> * distributed under the License is distributed on an &quot;AS IS&quot; BASIS,</span></div><div class='line' id='LC15'><span class="cm"> * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.</span></div><div class='line' id='LC16'><span class="cm"> * See the License for the specific language governing permissions and</span></div><div class='line' id='LC17'><span class="cm"> * limitations under the License.</span></div><div class='line' id='LC18'><span class="cm"> * ============================================================ */</span></div><div class='line' id='LC19'><br/></div><div class='line' id='LC20'><br/></div><div class='line' id='LC21'><span class="o">!</span><span class="kd">function</span> <span class="p">(</span><span class="nx">$</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC22'><br/></div><div class='line' id='LC23'>&nbsp;&nbsp;<span class="s2">&quot;use strict&quot;</span><span class="p">;</span> <span class="c1">// jshint ;_;</span></div><div class='line' id='LC24'><br/></div><div class='line' id='LC25'><br/></div><div class='line' id='LC26'>&nbsp;<span class="cm">/* DROPDOWN CLASS DEFINITION</span></div><div class='line' id='LC27'><span class="cm">  * ========================= */</span></div><div class='line' id='LC28'><br/></div><div class='line' id='LC29'>&nbsp;&nbsp;<span class="kd">var</span> <span class="nx">toggle</span> <span class="o">=</span> <span class="s1">&#39;[data-toggle=dropdown]&#39;</span></div><div class='line' id='LC30'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">,</span> <span class="nx">Dropdown</span> <span class="o">=</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">element</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC31'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="kd">var</span> <span class="nx">$el</span> <span class="o">=</span> <span class="nx">$</span><span class="p">(</span><span class="nx">element</span><span class="p">).</span><span class="nx">on</span><span class="p">(</span><span class="s1">&#39;click.dropdown.data-api&#39;</span><span class="p">,</span> <span class="k">this</span><span class="p">.</span><span class="nx">toggle</span><span class="p">)</span></div><div class='line' id='LC32'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$</span><span class="p">(</span><span class="s1">&#39;html&#39;</span><span class="p">).</span><span class="nx">on</span><span class="p">(</span><span class="s1">&#39;click.dropdown.data-api&#39;</span><span class="p">,</span> <span class="kd">function</span> <span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC33'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$el</span><span class="p">.</span><span class="nx">parent</span><span class="p">().</span><span class="nx">removeClass</span><span class="p">(</span><span class="s1">&#39;open&#39;</span><span class="p">)</span></div><div class='line' id='LC34'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">})</span></div><div class='line' id='LC35'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class='line' id='LC36'><br/></div><div class='line' id='LC37'>&nbsp;&nbsp;<span class="nx">Dropdown</span><span class="p">.</span><span class="nx">prototype</span> <span class="o">=</span> <span class="p">{</span></div><div class='line' id='LC38'><br/></div><div class='line' id='LC39'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">constructor</span><span class="o">:</span> <span class="nx">Dropdown</span></div><div class='line' id='LC40'><br/></div><div class='line' id='LC41'>&nbsp;&nbsp;<span class="p">,</span> <span class="nx">toggle</span><span class="o">:</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">e</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC42'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="kd">var</span> <span class="nx">$this</span> <span class="o">=</span> <span class="nx">$</span><span class="p">(</span><span class="k">this</span><span class="p">)</span></div><div class='line' id='LC43'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">,</span> <span class="nx">$parent</span></div><div class='line' id='LC44'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">,</span> <span class="nx">isActive</span></div><div class='line' id='LC45'><br/></div><div class='line' id='LC46'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="nx">$this</span><span class="p">.</span><span class="nx">is</span><span class="p">(</span><span class="s1">&#39;.disabled, :disabled&#39;</span><span class="p">))</span> <span class="k">return</span></div><div class='line' id='LC47'><br/></div><div class='line' id='LC48'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$parent</span> <span class="o">=</span> <span class="nx">getParent</span><span class="p">(</span><span class="nx">$this</span><span class="p">)</span></div><div class='line' id='LC49'><br/></div><div class='line' id='LC50'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">isActive</span> <span class="o">=</span> <span class="nx">$parent</span><span class="p">.</span><span class="nx">hasClass</span><span class="p">(</span><span class="s1">&#39;open&#39;</span><span class="p">)</span></div><div class='line' id='LC51'><br/></div><div class='line' id='LC52'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">clearMenus</span><span class="p">()</span></div><div class='line' id='LC53'><br/></div><div class='line' id='LC54'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="o">!</span><span class="nx">isActive</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC55'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$parent</span><span class="p">.</span><span class="nx">toggleClass</span><span class="p">(</span><span class="s1">&#39;open&#39;</span><span class="p">)</span></div><div class='line' id='LC56'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class='line' id='LC57'><br/></div><div class='line' id='LC58'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$this</span><span class="p">.</span><span class="nx">focus</span><span class="p">()</span></div><div class='line' id='LC59'><br/></div><div class='line' id='LC60'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="kc">false</span></div><div class='line' id='LC61'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class='line' id='LC62'><br/></div><div class='line' id='LC63'>&nbsp;&nbsp;<span class="p">,</span> <span class="nx">keydown</span><span class="o">:</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">e</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC64'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="kd">var</span> <span class="nx">$this</span></div><div class='line' id='LC65'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">,</span> <span class="nx">$items</span></div><div class='line' id='LC66'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">,</span> <span class="nx">$active</span></div><div class='line' id='LC67'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">,</span> <span class="nx">$parent</span></div><div class='line' id='LC68'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">,</span> <span class="nx">isActive</span></div><div class='line' id='LC69'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">,</span> <span class="nx">index</span></div><div class='line' id='LC70'><br/></div><div class='line' id='LC71'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="o">!</span><span class="sr">/(38|40|27)/</span><span class="p">.</span><span class="nx">test</span><span class="p">(</span><span class="nx">e</span><span class="p">.</span><span class="nx">keyCode</span><span class="p">))</span> <span class="k">return</span></div><div class='line' id='LC72'><br/></div><div class='line' id='LC73'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$this</span> <span class="o">=</span> <span class="nx">$</span><span class="p">(</span><span class="k">this</span><span class="p">)</span></div><div class='line' id='LC74'><br/></div><div class='line' id='LC75'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">e</span><span class="p">.</span><span class="nx">preventDefault</span><span class="p">()</span></div><div class='line' id='LC76'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">e</span><span class="p">.</span><span class="nx">stopPropagation</span><span class="p">()</span></div><div class='line' id='LC77'><br/></div><div class='line' id='LC78'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="nx">$this</span><span class="p">.</span><span class="nx">is</span><span class="p">(</span><span class="s1">&#39;.disabled, :disabled&#39;</span><span class="p">))</span> <span class="k">return</span></div><div class='line' id='LC79'><br/></div><div class='line' id='LC80'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$parent</span> <span class="o">=</span> <span class="nx">getParent</span><span class="p">(</span><span class="nx">$this</span><span class="p">)</span></div><div class='line' id='LC81'><br/></div><div class='line' id='LC82'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">isActive</span> <span class="o">=</span> <span class="nx">$parent</span><span class="p">.</span><span class="nx">hasClass</span><span class="p">(</span><span class="s1">&#39;open&#39;</span><span class="p">)</span></div><div class='line' id='LC83'><br/></div><div class='line' id='LC84'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="o">!</span><span class="nx">isActive</span> <span class="o">||</span> <span class="p">(</span><span class="nx">isActive</span> <span class="o">&amp;&amp;</span> <span class="nx">e</span><span class="p">.</span><span class="nx">keyCode</span> <span class="o">==</span> <span class="mi">27</span><span class="p">))</span> <span class="k">return</span> <span class="nx">$this</span><span class="p">.</span><span class="nx">click</span><span class="p">()</span></div><div class='line' id='LC85'><br/></div><div class='line' id='LC86'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$items</span> <span class="o">=</span> <span class="nx">$</span><span class="p">(</span><span class="s1">&#39;[role=menu] li:not(.divider):visible a&#39;</span><span class="p">,</span> <span class="nx">$parent</span><span class="p">)</span></div><div class='line' id='LC87'><br/></div><div class='line' id='LC88'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="o">!</span><span class="nx">$items</span><span class="p">.</span><span class="nx">length</span><span class="p">)</span> <span class="k">return</span></div><div class='line' id='LC89'><br/></div><div class='line' id='LC90'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">index</span> <span class="o">=</span> <span class="nx">$items</span><span class="p">.</span><span class="nx">index</span><span class="p">(</span><span class="nx">$items</span><span class="p">.</span><span class="nx">filter</span><span class="p">(</span><span class="s1">&#39;:focus&#39;</span><span class="p">))</span></div><div class='line' id='LC91'><br/></div><div class='line' id='LC92'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="nx">e</span><span class="p">.</span><span class="nx">keyCode</span> <span class="o">==</span> <span class="mi">38</span> <span class="o">&amp;&amp;</span> <span class="nx">index</span> <span class="o">&gt;</span> <span class="mi">0</span><span class="p">)</span> <span class="nx">index</span><span class="o">--</span>                                        <span class="c1">// up</span></div><div class='line' id='LC93'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="nx">e</span><span class="p">.</span><span class="nx">keyCode</span> <span class="o">==</span> <span class="mi">40</span> <span class="o">&amp;&amp;</span> <span class="nx">index</span> <span class="o">&lt;</span> <span class="nx">$items</span><span class="p">.</span><span class="nx">length</span> <span class="o">-</span> <span class="mi">1</span><span class="p">)</span> <span class="nx">index</span><span class="o">++</span>                        <span class="c1">// down</span></div><div class='line' id='LC94'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="o">!~</span><span class="nx">index</span><span class="p">)</span> <span class="nx">index</span> <span class="o">=</span> <span class="mi">0</span></div><div class='line' id='LC95'><br/></div><div class='line' id='LC96'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$items</span></div><div class='line' id='LC97'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">.</span><span class="nx">eq</span><span class="p">(</span><span class="nx">index</span><span class="p">)</span></div><div class='line' id='LC98'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">.</span><span class="nx">focus</span><span class="p">()</span></div><div class='line' id='LC99'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class='line' id='LC100'><br/></div><div class='line' id='LC101'>&nbsp;&nbsp;<span class="p">}</span></div><div class='line' id='LC102'><br/></div><div class='line' id='LC103'>&nbsp;&nbsp;<span class="kd">function</span> <span class="nx">clearMenus</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC104'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$</span><span class="p">(</span><span class="nx">toggle</span><span class="p">).</span><span class="nx">each</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC105'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">getParent</span><span class="p">(</span><span class="nx">$</span><span class="p">(</span><span class="k">this</span><span class="p">)).</span><span class="nx">removeClass</span><span class="p">(</span><span class="s1">&#39;open&#39;</span><span class="p">)</span></div><div class='line' id='LC106'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">})</span></div><div class='line' id='LC107'>&nbsp;&nbsp;<span class="p">}</span></div><div class='line' id='LC108'><br/></div><div class='line' id='LC109'>&nbsp;&nbsp;<span class="kd">function</span> <span class="nx">getParent</span><span class="p">(</span><span class="nx">$this</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC110'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="kd">var</span> <span class="nx">selector</span> <span class="o">=</span> <span class="nx">$this</span><span class="p">.</span><span class="nx">attr</span><span class="p">(</span><span class="s1">&#39;data-target&#39;</span><span class="p">)</span></div><div class='line' id='LC111'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">,</span> <span class="nx">$parent</span></div><div class='line' id='LC112'><br/></div><div class='line' id='LC113'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="o">!</span><span class="nx">selector</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC114'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">selector</span> <span class="o">=</span> <span class="nx">$this</span><span class="p">.</span><span class="nx">attr</span><span class="p">(</span><span class="s1">&#39;href&#39;</span><span class="p">)</span></div><div class='line' id='LC115'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">selector</span> <span class="o">=</span> <span class="nx">selector</span> <span class="o">&amp;&amp;</span> <span class="sr">/#/</span><span class="p">.</span><span class="nx">test</span><span class="p">(</span><span class="nx">selector</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="nx">selector</span><span class="p">.</span><span class="nx">replace</span><span class="p">(</span><span class="sr">/.*(?=#[^\s]*$)/</span><span class="p">,</span> <span class="s1">&#39;&#39;</span><span class="p">)</span> <span class="c1">//strip for ie7</span></div><div class='line' id='LC116'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class='line' id='LC117'><br/></div><div class='line' id='LC118'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$parent</span> <span class="o">=</span> <span class="nx">$</span><span class="p">(</span><span class="nx">selector</span><span class="p">)</span></div><div class='line' id='LC119'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$parent</span><span class="p">.</span><span class="nx">length</span> <span class="o">||</span> <span class="p">(</span><span class="nx">$parent</span> <span class="o">=</span> <span class="nx">$this</span><span class="p">.</span><span class="nx">parent</span><span class="p">())</span></div><div class='line' id='LC120'><br/></div><div class='line' id='LC121'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="nx">$parent</span></div><div class='line' id='LC122'>&nbsp;&nbsp;<span class="p">}</span></div><div class='line' id='LC123'><br/></div><div class='line' id='LC124'><br/></div><div class='line' id='LC125'>&nbsp;&nbsp;<span class="cm">/* DROPDOWN PLUGIN DEFINITION</span></div><div class='line' id='LC126'><span class="cm">   * ========================== */</span></div><div class='line' id='LC127'><br/></div><div class='line' id='LC128'>&nbsp;&nbsp;<span class="kd">var</span> <span class="nx">old</span> <span class="o">=</span> <span class="nx">$</span><span class="p">.</span><span class="nx">fn</span><span class="p">.</span><span class="nx">dropdown</span></div><div class='line' id='LC129'><br/></div><div class='line' id='LC130'>&nbsp;&nbsp;<span class="nx">$</span><span class="p">.</span><span class="nx">fn</span><span class="p">.</span><span class="nx">dropdown</span> <span class="o">=</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">option</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC131'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="k">this</span><span class="p">.</span><span class="nx">each</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC132'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="kd">var</span> <span class="nx">$this</span> <span class="o">=</span> <span class="nx">$</span><span class="p">(</span><span class="k">this</span><span class="p">)</span></div><div class='line' id='LC133'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">,</span> <span class="nx">data</span> <span class="o">=</span> <span class="nx">$this</span><span class="p">.</span><span class="nx">data</span><span class="p">(</span><span class="s1">&#39;dropdown&#39;</span><span class="p">)</span></div><div class='line' id='LC134'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="o">!</span><span class="nx">data</span><span class="p">)</span> <span class="nx">$this</span><span class="p">.</span><span class="nx">data</span><span class="p">(</span><span class="s1">&#39;dropdown&#39;</span><span class="p">,</span> <span class="p">(</span><span class="nx">data</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">Dropdown</span><span class="p">(</span><span class="k">this</span><span class="p">)))</span></div><div class='line' id='LC135'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="k">typeof</span> <span class="nx">option</span> <span class="o">==</span> <span class="s1">&#39;string&#39;</span><span class="p">)</span> <span class="nx">data</span><span class="p">[</span><span class="nx">option</span><span class="p">].</span><span class="nx">call</span><span class="p">(</span><span class="nx">$this</span><span class="p">)</span></div><div class='line' id='LC136'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">})</span></div><div class='line' id='LC137'>&nbsp;&nbsp;<span class="p">}</span></div><div class='line' id='LC138'><br/></div><div class='line' id='LC139'>&nbsp;&nbsp;<span class="nx">$</span><span class="p">.</span><span class="nx">fn</span><span class="p">.</span><span class="nx">dropdown</span><span class="p">.</span><span class="nx">Constructor</span> <span class="o">=</span> <span class="nx">Dropdown</span></div><div class='line' id='LC140'><br/></div><div class='line' id='LC141'><br/></div><div class='line' id='LC142'>&nbsp;<span class="cm">/* DROPDOWN NO CONFLICT</span></div><div class='line' id='LC143'><span class="cm">  * ==================== */</span></div><div class='line' id='LC144'><br/></div><div class='line' id='LC145'>&nbsp;&nbsp;<span class="nx">$</span><span class="p">.</span><span class="nx">fn</span><span class="p">.</span><span class="nx">dropdown</span><span class="p">.</span><span class="nx">noConflict</span> <span class="o">=</span> <span class="kd">function</span> <span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC146'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nx">$</span><span class="p">.</span><span class="nx">fn</span><span class="p">.</span><span class="nx">dropdown</span> <span class="o">=</span> <span class="nx">old</span></div><div class='line' id='LC147'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="k">this</span></div><div class='line' id='LC148'>&nbsp;&nbsp;<span class="p">}</span></div><div class='line' id='LC149'><br/></div><div class='line' id='LC150'><br/></div><div class='line' id='LC151'>&nbsp;&nbsp;<span class="cm">/* APPLY TO STANDARD DROPDOWN ELEMENTS</span></div><div class='line' id='LC152'><span class="cm">   * =================================== */</span></div><div class='line' id='LC153'><br/></div><div class='line' id='LC154'>&nbsp;&nbsp;<span class="nx">$</span><span class="p">(</span><span class="nb">document</span><span class="p">)</span></div><div class='line' id='LC155'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">.</span><span class="nx">on</span><span class="p">(</span><span class="s1">&#39;click.dropdown.data-api touchstart.dropdown.data-api&#39;</span><span class="p">,</span> <span class="nx">clearMenus</span><span class="p">)</span></div><div class='line' id='LC156'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">.</span><span class="nx">on</span><span class="p">(</span><span class="s1">&#39;click.dropdown touchstart.dropdown.data-api&#39;</span><span class="p">,</span> <span class="s1">&#39;.dropdown form&#39;</span><span class="p">,</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">e</span><span class="p">)</span> <span class="p">{</span> <span class="nx">e</span><span class="p">.</span><span class="nx">stopPropagation</span><span class="p">()</span> <span class="p">})</span></div><div class='line' id='LC157'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">.</span><span class="nx">on</span><span class="p">(</span><span class="s1">&#39;touchstart.dropdown.data-api&#39;</span><span class="p">,</span> <span class="s1">&#39;.dropdown-menu&#39;</span><span class="p">,</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">e</span><span class="p">)</span> <span class="p">{</span> <span class="nx">e</span><span class="p">.</span><span class="nx">stopPropagation</span><span class="p">()</span> <span class="p">})</span></div><div class='line' id='LC158'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">.</span><span class="nx">on</span><span class="p">(</span><span class="s1">&#39;click.dropdown.data-api touchstart.dropdown.data-api&#39;</span>  <span class="p">,</span> <span class="nx">toggle</span><span class="p">,</span> <span class="nx">Dropdown</span><span class="p">.</span><span class="nx">prototype</span><span class="p">.</span><span class="nx">toggle</span><span class="p">)</span></div><div class='line' id='LC159'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">.</span><span class="nx">on</span><span class="p">(</span><span class="s1">&#39;keydown.dropdown.data-api touchstart.dropdown.data-api&#39;</span><span class="p">,</span> <span class="nx">toggle</span> <span class="o">+</span> <span class="s1">&#39;, [role=menu]&#39;</span> <span class="p">,</span> <span class="nx">Dropdown</span><span class="p">.</span><span class="nx">prototype</span><span class="p">.</span><span class="nx">keydown</span><span class="p">)</span></div><div class='line' id='LC160'><br/></div><div class='line' id='LC161'><span class="p">}(</span><span class="nb">window</span><span class="p">.</span><span class="nx">jQuery</span><span class="p">);</span></div></pre></div>
          </td>
        </tr>
      </table>
  </div>

          </div>
        </div>

        <a href="#jump-to-line" rel="facebox" data-hotkey="l" class="js-jump-to-line" style="display:none">Jump to Line</a>
        <div id="jump-to-line" style="display:none">
          <h2>Jump to Line</h2>
          <form accept-charset="UTF-8" class="js-jump-to-line-form">
            <input class="textfield js-jump-to-line-field" type="text">
            <div class="full-button">
              <button type="submit" class="button">Go</button>
            </div>
          </form>
        </div>

      </div>
    </div>
</div>

<div id="js-frame-loading-template" class="frame frame-loading large-loading-area" style="display:none;">
  <img class="js-frame-loading-spinner" src="https://a248.e.akamai.net/assets.github.com/images/spinners/octocat-spinner-128.gif?1347543527" height="64" width="64">
</div>


        </div>
      </div>
      <div class="context-overlay"></div>
    </div>

      <div id="footer-push"></div><!-- hack for sticky footer -->
    </div><!-- end of wrapper - hack for sticky footer -->

      <!-- footer -->
      <div id="footer">
  <div class="container clearfix">

      <dl class="footer_nav">
        <dt>GitHub</dt>
        <dd><a href="https://github.com/about">About us</a></dd>
        <dd><a href="https://github.com/blog">Blog</a></dd>
        <dd><a href="https://github.com/contact">Contact &amp; support</a></dd>
        <dd><a href="http://enterprise.github.com/">GitHub Enterprise</a></dd>
        <dd><a href="http://status.github.com/">Site status</a></dd>
      </dl>

      <dl class="footer_nav">
        <dt>Applications</dt>
        <dd><a href="http://mac.github.com/">GitHub for Mac</a></dd>
        <dd><a href="http://windows.github.com/">GitHub for Windows</a></dd>
        <dd><a href="http://eclipse.github.com/">GitHub for Eclipse</a></dd>
        <dd><a href="http://mobile.github.com/">GitHub mobile apps</a></dd>
      </dl>

      <dl class="footer_nav">
        <dt>Services</dt>
        <dd><a href="http://get.gaug.es/">Gauges: Web analytics</a></dd>
        <dd><a href="http://speakerdeck.com">Speaker Deck: Presentations</a></dd>
        <dd><a href="https://gist.github.com">Gist: Code snippets</a></dd>
        <dd><a href="http://jobs.github.com/">Job board</a></dd>
      </dl>

      <dl class="footer_nav">
        <dt>Documentation</dt>
        <dd><a href="http://help.github.com/">GitHub Help</a></dd>
        <dd><a href="http://developer.github.com/">Developer API</a></dd>
        <dd><a href="http://github.github.com/github-flavored-markdown/">GitHub Flavored Markdown</a></dd>
        <dd><a href="http://pages.github.com/">GitHub Pages</a></dd>
      </dl>

      <dl class="footer_nav">
        <dt>More</dt>
        <dd><a href="http://training.github.com/">Training</a></dd>
        <dd><a href="https://github.com/edu">Students &amp; teachers</a></dd>
        <dd><a href="http://shop.github.com">The Shop</a></dd>
        <dd><a href="/plans">Plans &amp; pricing</a></dd>
        <dd><a href="http://octodex.github.com/">The Octodex</a></dd>
      </dl>

      <hr class="footer-divider">


    <p class="right">&copy; 2013 <span title="0.11712s from fe2.rs.github.com">GitHub</span> Inc. All rights reserved.</p>
    <a class="left" href="https://github.com/">
      <span class="mega-icon mega-icon-invertocat"></span>
    </a>
    <ul id="legal">
        <li><a href="https://github.com/site/terms">Terms of Service</a></li>
        <li><a href="https://github.com/site/privacy">Privacy</a></li>
        <li><a href="https://github.com/security">Security</a></li>
    </ul>

  </div><!-- /.container -->

</div><!-- /.#footer -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-fullscreen-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="js-fullscreen-contents" placeholder="" data-suggester="fullscreen_suggester"></textarea>
          <div class="suggester-container">
              <div class="suggester fullscreen-suggester js-navigation-container" id="fullscreen_suggester"
                 data-url="/twitter/bootstrap/suggestions/commit/ee91afba63bc6e9687397b9052858fca242c2ff5">
              </div>
          </div>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped leftwards" title="Exit Zen Mode">
      <span class="mega-icon mega-icon-normalscreen"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped leftwards"
      title="Switch themes">
      <span class="mini-icon mini-icon-brightness"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="mini-icon mini-icon-exclamation"></span>
      Something went wrong with that request. Please try again.
      <a href="#" class="mini-icon mini-icon-remove-close ajax-error-dismiss"></a>
    </div>

    
    
    <span id='server_response_time' data-time='0.11765' data-host='fe2'></span>
    
  </body>
</html>

