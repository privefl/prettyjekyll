[![Build Status](https://travis-ci.org/privefl/prettyjekyll.svg?branch=master)](https://travis-ci.org/privefl/prettyjekyll)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/privefl/prettyjekyll?branch=master&svg=true)](https://ci.appveyor.com/project/privefl/prettyjekyll)
[![codecov](https://codecov.io/gh/privefl/prettyjekyll/branch/master/graph/badge.svg)](https://codecov.io/gh/privefl/prettyjekyll)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/prettyjekyll)](https://cran.r-project.org/package=prettyjekyll)

prettyjekyll
============

Convert R Markdown Pretty Document to Jekyll Markdown.

This is used in [this template](https://github.com/privefl/jekyll-now-r-template).

Requirements and features of FormatPost
---------------------------------------

- Install package {prettyjekyll} using `devtools::install_github("privefl/prettyjekyll")`.

- The yaml header (delimited by '---') of you Rmd file needs to contain a title and a date.

- Function `prettyjekyll::FormatPost()`

    - renders your R Markdown as an HTML Pretty Document,
    
    - gets the main content of this HTML Pretty Document to put it in a new Markdown post that is rendered with Jekyll,
    
    - creates the name of the markdown file with the date and the title of your post,
    
    - makes some changes in figures' and images' paths to be recognized in the site. 
    
You can keep the default path to figures rendered by knitr. Caching is now supported starting with version 0.2.3. You should directly use the R Markdown template from this package.
