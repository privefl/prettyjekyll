context("FORMAT_POST")

rmd <- file.path("_knitr", "knitr-minimal.Rmd")
new.post <- FormatPost(rmd)

test_that("Created some directories", {
  expect_true(dir.exists("_posts"))
  expect_true(dir.exists("knitr_files"))
})

test_that("Created some files", {
  expect_true(file.exists(new.post))
  expect_true(file.exists(
    file.path("knitr_files", "knitr-minimal_files", "figure-html",
              "unnamed-chunk-1-1.png")))
})

new.post.content <- readLines(new.post, encoding = "UTF-8")

test_that("Expected content", {
  expect_equal(sum(grepl(getwd(), new.post.content, fixed = TRUE)), 0)
  print(siteurl <- grepl("{{ site.baseurl }}", new.post.content, fixed = TRUE))
  expect_equal(sum(siteurl), 2)
})
