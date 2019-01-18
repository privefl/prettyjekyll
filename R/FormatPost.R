################################################################################

new_yaml_header <- function(yaml) {

  if (is.null(yaml$title)) stop("Your document should have a YAML title.")
  if (is.null(yaml$date)) stop("Your document should have a YAML date.")

  glue::glue(
    "---",
    "title: \"{yaml$title}\"",
    `if`(is.null(yaml$subtitle), "", "subtitle: \"{yaml$subtitle}\""),
    `if`(is.null(yaml$author), "", "author: \"{yaml$author}\""),
    "date: \"{yaml$date}\"",
    "layout: post",
    "---",
    .sep = "\n"
  )
}

################################################################################

my_render <- function(rmd) {
  cl <- parallel::makePSOCKcluster(1)
  on.exit(parallel::stopCluster(cl), add = TRUE)
  parallel::clusterExport(cl, "rmd", envir = environment())
  parallel::clusterEvalQ(cl, {
    rmarkdown::render(
      rmd,
      prettydoc::html_pretty(highlight = "github", self_contained = FALSE),
      encoding = "UTF-8"
    )
  })[[1]]
}

norm_src <- function(path, dir) {
  path <- tryCatch(withr::with_dir(dir, normalizePath(path, mustWork = TRUE)),
                   error = function(e) path)
  sprintf('src="%s"', path)
}

################################################################################

format_html <- function(rmd, knitr.files.dir) {

  # knit
  html <- my_render(rmd)

  # Read html
  lines.html <- readLines(html)

  # get main section and scripts
  scripts <- lines.html[grep("<script src=", lines.html, fixed = TRUE)]
  section.begin <- grep("<section class=\"main-content\">",
                        lines.html, fixed = TRUE)
  section.ends <- grep("</section>", lines.html, fixed = TRUE)
  section.end <- min(section.ends[section.ends > section.begin])
  lines.html <- c(scripts, "", lines.html[section.begin:section.end])

  # Change path of figures and images
  patterns <- list(
    sub("\\.Rmd$", "_files", basename(rmd)),
    'src="(.*?)"',
    'src="(.*?)"',
    getwd(),
    gsub("\\", "\\\\", normalizePath(getwd()), fixed = TRUE)
  )
  replacements <- list(
    file.path("{{ site.url }}{{ site.baseurl }}", knitr.files.dir, patterns[1]),
    function(path) norm_src(path, dirname(rmd)),
    function(path) norm_src(path, getwd()),
    "{{ site.url }}{{ site.baseurl }}",
    "{{ site.url }}{{ site.baseurl }}"
  )
  for (i in seq_along(patterns)) {
    lines.html <- gsubfn::gsubfn(patterns[[i]], replacements[[i]], lines.html)
  }
  # And move figure directory
  if (!dir.exists(knitr.files.dir)) dir.create(knitr.files.dir)
  file.copy(from = sub("\\.Rmd$", "_files", rmd), to = knitr.files.dir,
            overwrite = TRUE, recursive = TRUE)

  lines.html
}

################################################################################

#' Format an R Markdown post for a Jekyll blog
#'
#' Format an R Markdown Pretty Document (package prettydoc) post for a Jekyll
#' blog and place the resulting Markdown post in directory '_posts'.
#'
#' @param rmd The name (path) to specific Rmd file to convert.
#' @param knitr.files.dir The permanent directory where
#' the files like plots are placed.
#' @param date.format Format of the date used in the YAML header.
#' Default corresponds for example to "August 15, 2016".
#' @param date.locale A locale object, defining the defaults of a country.
#'
#' @return The name (path) of the new Markdown post.
#'
#' @seealso readr::parse_date
#'
#' @export
FormatPost <- function(rmd,
                       knitr.files.dir = "knitr_files",
                       date.format = "%B %d, %Y",
                       date.locale = readr::locale(tz = "US/Central")) {

  # verif
  if (tools::file_ext(rmd) != "Rmd") stop("Input shoud be an R Markdown file")

  # get YAML header
  yaml <- rmarkdown::yaml_front_matter(rmd, encoding = "UTF-8")
  yaml.new <- new_yaml_header(yaml)

  # get html lines
  lines.html <- format_html(rmd, knitr.files.dir)

  # get the right name output format
  format.title <- gsub("[ ]{1,}", "-", tolower(yaml$title))
  for (pattern in c(":", ",", "(", ")", "?", "!")) {
    format.title <- gsub(pattern, "", format.title, fixed = TRUE)
  }
  md.path <- file.path("_posts", sprintf(
    "%s-%s.md",
    readr::parse_date(yaml$date, format = date.format, locale = date.locale),
    format.title))

  # create file with new lines
  if (!dir.exists("_posts")) dir.create("_posts")
  writeLines(c(yaml.new, "", lines.html), md.path, useBytes = FALSE)

  return(md.path)
}

################################################################################
