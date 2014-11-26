#' Replace first occurrence of a matched pattern in a string.
#'
#' Vectorised over \code{string}, \code{pattern} and \code{replacement}.
#' Shorter arguments will be expanded to length of longest.
#'
#' @inheritParams str_detect
#' @param replacement replacement string.  References of the form \code{\1},
#'   \code{\2} will be replaced with the contents of the respective matched
#'   group (created by \code{()}) within the pattern.
#' @return character vector.
#' @keywords character
#' @seealso \code{\link{sub}} which this function wraps,
#'   \code{\link{str_replace_all}} to replace all matches
#' @export
#' @examples
#' fruits <- c("one apple", "two pears", "three bananas")
#' str_replace(fruits, "[aeiou]", "-")
#' str_replace_all(fruits, "[aeiou]", "-")
#'
#' str_replace(fruits, "([aeiou])", "")
#' str_replace(fruits, "([aeiou])", "\\1\\1")
#' str_replace(fruits, "[aeiou]", c("1", "2", "3"))
#' str_replace(fruits, c("a", "e", "i"), "-")
str_replace <- function(string, pattern, replacement) {
  switch(type(pattern),
    fixed = stri_replace_first_fixed(string, pattern, replacement),
    regex = stri_replace_first_regex(string, pattern, replacement, attr(pattern, "options")),
    coll  = stri_replace_first_coll(string, pattern, replacement, attr(pattern, "options"))
  )
}

#' Replace all occurrences of a matched pattern in a string.
#'
#' Vectorised over \code{string}, \code{pattern} and \code{replacement}.
#' Shorter arguments will be expanded to length of longest.
#'
#' @inheritParams str_detect
#' @param pattern,replacement Supply separate pattern and replacement strings
#'   to vectorise over the patterns. References of the form \code{\1},
#'   \code{\2} will be replaced with the contents of the respective matched
#'   group (created by \code{()}) within the pattern.
#'
#'   If you want to apply multiple patterns and replacements to each string,
#'   pass a named character to \code{pattern}.
#' @return character vector.
#' @keywords character
#' @seealso \code{\link{gsub}} which this function wraps,
#'   \code{\link{str_replace}} to replace a single match
#' @export
#' @examples
#' fruits <- c("one apple", "two pears", "three bananas")
#' str_replace(fruits, "[aeiou]", "-")
#' str_replace_all(fruits, "[aeiou]", "-")
#'
#' str_replace_all(fruits, "([aeiou])", "")
#' str_replace_all(fruits, "([aeiou])", "\\1\\1")
#' str_replace_all(fruits, "[aeiou]", c("1", "2", "3"))
#' str_replace_all(fruits, c("a", "e", "i"), "-")
#'
#' # If you want to apply multiple patterns and replacements to the same
#' # string, pass a named version to pattern.
#' str_replace_all(str_c(fruits, collapse = "---"),
#'  c("one" = 1, "two" = 2, "three" = 3))
str_replace_all <- function(string, pattern, replacement) {
  if (!is.null(names(pattern))) {
    replacement <- unname(pattern)
    pattern <- names(pattern)
    vec <- FALSE
  } else {
    vec <- TRUE
  }

  switch(type(pattern),
    fixed = stri_replace_all_fixed(string, pattern, replacement, vec),
    regex = stri_replace_all_regex(string, pattern, replacement, vec, attr(pattern, "options")),
    coll  = stri_replace_all_coll(string, pattern, replacement, vec, attr(pattern, "options"))
  )
}
