# list of json locale
library("httr")
library("purrr")
library("stringr")

locale_list <- GET("https://unpkg.com/d3-format@latest/locale/?json")
locale_files <- map_chr(content(locale_list)$files, "path")

fmt_locale <- function(x) {
  if (!is.null(x$grouping)) x$grouping <- flatten_int(x$grouping)
  if (!is.null(x$numerals)) x$numerals <- flatten_chr(x$numerals)
  if (!is.null(x$currency)) x$currency <- flatten_chr(x$currency)
  structure(x, class = "fmt_locale")
}

locales <- list()
for (f in locale_files) {
  nm <- tools::file_path_sans_ext(basename(f))
  x <- content(GET(file.path("https://unpkg.com/d3-format@latest", f)))
  locales[[nm]] <- fmt_locale(x)
}

print.fmt_locale <- function(x, ...) {
  cat("<fmt_locale>\n")
  cat("Decimal:   ", x$decimal, "\n")
  cat("Thousands: ", x$thousands, "\n")
  cat("Grouping:  ", str_c(x$grouping, collapse = ", "), "\n")
  cat("Currency:  ", x$currency[[1]], "1", x$currency[[2]], "\n", sep = "")
  cat("Numerals:  ",
      if (is.null(x$numerals)) str_c(c(1:9, 0L), collapse = ", ")
      else str_c(x$numerals, collapse = ", "),
      "\n")
}
