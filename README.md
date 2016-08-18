[![Build Status](https://travis-ci.org/privefl/prettyjekyll.svg?branch=master)](https://travis-ci.org/privefl/prettyjekyll) [![codecov](https://codecov.io/gh/privefl/prettyjekyll/branch/master/graph/badge.svg)](https://codecov.io/gh/privefl/prettyjekyll) [![Project Status: Active ? The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![Licence](https://img.shields.io/badge/licence-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)

------------------------------------------------------------------------

[![minimal R version](https://img.shields.io/badge/R%3E%3D-3.3.1-6666ff.svg)](https://cran.r-project.org/) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/prettyjekyll)](https://cran.r-project.org/package=prettyjekyll)

[![packageversion](https://img.shields.io/badge/Package%20version-0.1.0-orange.svg?style=flat-square)](commits/master)

------------------------------------------------------------------------

[![Last-changedate](https://img.shields.io/badge/last%20change-2016--08--18-yellowgreen.svg)](/commits/master)

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

![](https://cdn2.iconfinder.com/data/icons/freecns-cumulus/32/519791-101_Warning-128.png) This works with all the cases that I tried. Yet, I could not test or think about every possible cases that need to be handled. If you found an error, please open an issue.
