[![Build Status](https://travis-ci.org/privefl/prettyjekyll.svg?branch=master)](https://travis-ci.org/privefl/prettyjekyll) [![codecov](https://codecov.io/gh/privefl/prettyjekyll/branch/master/graph/badge.svg)](https://codecov.io/gh/privefl/prettyjekyll)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/prettyjekyll)](https://cran.r-project.org/package=prettyjekyll)

prettyjekyll
============

Convert R Markdown Pretty Document to Jekyll Markdown.

This is used in [this template](https://github.com/privefl/jekyll-now-r-template).

Requirements and features of FormatPost
---------------------------------------

-   Install package prettyjekyll with `devtools::install_github("privefl/prettyjekyll")` if not already done.
-   The yaml header (delimited by '---') of you Rmd file needs to contain a title and a date.

-   It gets the main content of an HTML Pretty Document to put it in a new Markdown post that is rendered with Jekyll.
-   It creates the name of your post's Markdown file with the current date (the date in the name is not important) and the title of your post.
-   It makes some changes in figures' and images' paths to be recognized in the site. You should keep the default path to figures rendered by knitr. **Caching is not supported**.
-   This works only with this specified output:

``` yml
output:                   # DO NOT CHANGE
  prettydoc::html_pretty: # DO NOT CHANGE
    theme: cayman         # DO NOT CHANGE
    highlight: github     # DO NOT CHANGE
```

You should directly use the R Markdown template from this package.

![](https://cdn2.iconfinder.com/data/icons/freecns-cumulus/32/519791-101_Warning-128.png) This works with all the cases that I tried. Yet, I could not test or think about every possible cases that need to be handled. If you found an error, please open an issue.
