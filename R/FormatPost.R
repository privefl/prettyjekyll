#' @title Format an R Markdown post for a Jekyll blog
#' @description Format an R Markdown Pretty Document (package
#' prettydoc) post for a Jekyll blog
#' and place the resulting Markdown post in directory '_posts'.
#' @param rmd The name (path) to specific Rmd file to convert.
#' @param knitr.files.dir The permanent directory where
#' the files like plots are placed.
#' @param tmp.dir The temporary directory for the temporary html file.
#' @return The name (path) of the new Markdown post.
#' @name FormatPost
#' @export
FormatPost <- function(rmd,
                       knitr.files.dir = "knitr_files",
                       tmp.dir = "_built") {
  # rmd: name/path to specific Rmd file to convert
  # knitr.files.dir: The permanent directory where the files like plots
  #                  are put
  # tmp.dir: temporary directory for the temporary html file

  # verif
  if (tools::file_ext(rmd) != "Rmd") stop("Input shoud be an R Markdown file")

  # knit
  html <- rmarkdown::render(rmd,
                            prettydoc::html_pretty(highlight = "github",
                                                   self_contained = FALSE),
                            output_dir = tmp.dir,
                            clean = FALSE,
                            encoding = "UTF-8")

  # Read rmd
  lines.rmd <- readLines(rmd, encoding = "UTF-8")
  lines.html <- readLines(html, encoding = "UTF-8")

  # get main section
  section.begin <- grep("<section class=\"main-content\">",
                        lines.html, fixed = TRUE)
  section.ends <- grep("</section>", lines.html, fixed = TRUE)
  section.end <- min(section.ends[section.ends > section.begin])
  lines.html <- lines.html[section.begin:section.end]

  # get yaml header (delimited by the first '---')
  header.rmd <- grep("---", x = lines.rmd, fixed = TRUE)[2]
  if (is.na(header.rmd)) stop("Your document should have an YAML header")

  # get 'title', 'date' and 'layout' headers
  title <- grep("title:", lines.rmd[1:header.rmd], fixed = TRUE)
  if (length(title) == 0) stop("Your document should have an YAML title")
  date <- grep("date:", lines.rmd[1:header.rmd], fixed = TRUE)
  if (length(date) == 0) stop("Your document should have an YAML date")
  author <- grep("author:", lines.rmd[1:header.rmd], fixed = TRUE)
  new.header <- paste("---", lines.rmd[title], lines.rmd[author], lines.rmd[date],
                      "layout: post", "---", "", sep = "\n")

  # get the right name output format
  line.title <- sub("title:", "", lines.rmd[title], fixed = TRUE)
  line.title <- gsub('\"', "", line.title, fixed = TRUE)
  suffix <- gsub("[ ]{1,}", "-", line.title)
  md.path <- file.path("_posts", paste0(Sys.Date(), suffix, ".md"))

  # Change path to figures
  rmd.base <- sub("\\.Rmd$", "", basename(rmd))
  pattern <-  paste0(rmd.base, "_files")
  tmp <- gsubfn::strapply(lines.html, pattern)
  ind <- which(!sapply(tmp, is.null))
  if (length(ind > 0)) {
    for (i in ind) {
      lines.html[i] <-
        gsubfn::gsubfn(pattern, file.path("{{ site.baseurl }}", knitr.files.dir,
                                          tmp[[i]][1]), lines.html[i])
    }
    dir.source <- file.path(tmp.dir, pattern)
    if (!dir.exists(knitr.files.dir)) dir.create(knitr.files.dir)
    file.copy(from = dir.source, to = knitr.files.dir,
              overwrite = TRUE, recursive = TRUE)
  }

  # Change path to images
  pattern <- getwd()
  tmp <- gsubfn::strapply(lines.html, pattern)
  ind <- which(!sapply(tmp, is.null))
  for (i in ind) {
    lines.html[i] <-
      gsubfn::gsubfn(pattern, "{{ site.baseurl }}", lines.html[i])
  }

  # create file with new lines
  if (!dir.exists("_posts")) dir.create("_posts")
  writeLines(c(new.header, "", "", lines.html),
             md.path, useBytes = TRUE)

  # remove temporary directory and clean build files
  unlink(tmp.dir, recursive = TRUE)
  file.remove(sub(pattern = "\\.Rmd$", ".knit.md", rmd))
  file.remove(sub(pattern = "\\.Rmd$", ".utf8.md", rmd))

  return(md.path)
}

