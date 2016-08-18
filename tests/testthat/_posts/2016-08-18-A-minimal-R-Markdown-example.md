---
title: A minimal R Markdown example

date: August 15, 2016
layout: post
---



<section class="main-content">
<div id="quotes" class="section level2">
<h2>Quotes</h2>
<blockquote>
<p>I love R and I like writing articles with R Markdown.</p>
</blockquote>
</div>
<div id="lists" class="section level2">
<h2>Lists</h2>
<p>This is a bullet list:</p>
<ul>
<li>item 1,</li>
<li>item 2.</li>
</ul>
<p>This is an ordered list:</p>
<ol style="list-style-type: decimal">
<li>item 3,</li>
<li>item 4.</li>
</ol>
</div>
<div id="equations" class="section level2">
<h2>Equations</h2>
<p>This is an inline equation with an inline R code chunk: <span class="math inline">\(\pi = 3.1415927\)</span>.</p>
<p>This is the Gaussian integral equation: <span class="math display">\[\int_{-\infty}^{+\infty} e^{-x^2}~dx = \sqrt{\pi}.\]</span></p>
</div>
<div id="plots" class="section level2">
<h2>Plots</h2>
<div class="sourceCode"><pre class="sourceCode r"><code class="sourceCode r"><span class="kw">curve</span>(<span class="kw">exp</span>(-x^<span class="dv">2</span>), -<span class="fl">2.5</span>, <span class="fl">2.5</span>)</code></pre></div>
<div class="figure" style="text-align: center">
<img src="{{ site.baseurl }}/knitr_files/knitr-minimal_files/figure-html/unnamed-chunk-1-1.png" alt="This is a nice plot."  />
<p class="caption">
This is a nice plot.
</p>
</div>
</div>
<div id="images" class="section level2">
<h2>Images</h2>
<ul>
<li>An image from Barry Clark’s GitHub account:</li>
</ul>
<div class="figure">
<img src="https://raw.githubusercontent.com/barryclark/jekyll-now/master/images/jekyll-logo.png" alt="Jekyll Now is the base of this template" />
<p class="caption">Jekyll Now is the base of this template</p>
</div>
<ul>
<li>A local image:</li>
</ul>
<div class="figure">
<img src="{{ site.baseurl }}/images/github-pages.jpg" alt="Thanks GitHub for hosting my website!" />
<p class="caption">Thanks GitHub for hosting my website!</p>
</div>
</div>
</section>
