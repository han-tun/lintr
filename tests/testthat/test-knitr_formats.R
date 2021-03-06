context("knitr_formats")

test_that("it handles dir", {
  lints <- lint_dir(path = "knitr_formats", pattern = rex::rex(".R", one_of("html", "md", "nw", "rst", "tex", "txt")))
  has_lints <- length(lints) > 0
  testthat::expect(has_lints, "There should be lints")

  testthat::expect_equivalent(length(unique(names(lints))), 6, info="For every file there should be at least 1 lint")
})


test_that("it handles markdown", {
  expect_lint(file = "knitr_formats/test.Rmd",
    checks = list(
      list(rex("Use <-, not =, for assignment."), line_number = 9),
      list(rex("local variable"), line_number = 22),
      list(rex("Use <-, not =, for assignment."), line_number = 22),
      list(rex("Trailing blank lines are superfluous."), line_number = 24)
    ),
    default_linters
  )
})
test_that("it handles Sweave", {
  expect_lint(file = "knitr_formats/test.Rnw",
    checks = list(
      list(rex("Use <-, not =, for assignment."), line_number = 12),
      list(rex("local variable"), line_number = 24),
      list(rex("Use <-, not =, for assignment."), line_number = 24),
      list(rex("Trailing blank lines are superfluous."), line_number = 26)
    ),
    default_linters
  )
})
test_that("it handles reStructuredText", {
  expect_lint(file = "knitr_formats/test.Rrst",
    checks = list(
      list(rex("Use <-, not =, for assignment."), line_number = 10),
      list(rex("local variable"), line_number = 23),
      list(rex("Use <-, not =, for assignment."), line_number = 23),
      list(rex("Trailing blank lines are superfluous."), line_number = 25)
    ),
    default_linters
  )
})
test_that("it handles HTML", {
  expect_lint(file = "knitr_formats/test.Rhtml",
    checks = list(
      list(rex("Use <-, not =, for assignment."), line_number = 15),
      list(rex("local variable"), line_number = 27),
      list(rex("Use <-, not =, for assignment."), line_number = 27),
      list(rex("Trailing blank lines are superfluous."), line_number = 29)
    ),
    default_linters
  )
})
test_that("it handles tex", {
  expect_lint(file = "knitr_formats/test.Rtex",
    checks = list(
      list(rex("Use <-, not =, for assignment."), line_number = 11),
      list(rex("local variable"), line_number = 23),
      list(rex("Use <-, not =, for assignment."), line_number = 23),
      list(rex("Trailing blank lines are superfluous."), line_number = 25)
    ),
    default_linters
  )
})
test_that("it handles asciidoc", {
  expect_lint(file = "knitr_formats/test.Rtxt",
    checks = list(
      list(rex("Use <-, not =, for assignment."), line_number = 9),
      list(rex("local variable"), line_number = 22),
      list(rex("Use <-, not =, for assignment."), line_number = 22),
      list(rex("Trailing blank lines are superfluous."), line_number = 24)
    ),
    default_linters
  )
})

test_that("it does _not_ handle brew", {
  expect_lint("'<% a %>'\n",
    checks = list(
      rex("Only use double-quotes."),
      rex("Trailing blank lines are superfluous.")
    ),
    default_linters)
})

test_that("it does _not_ error with inline \\Sexpr", {
  expect_lint("#' text \\Sexpr{1 + 1} more text",
    NULL,
    default_linters)
})
