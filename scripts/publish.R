library("bookdown")
library("tidyverse")

source("scripts/clean.R")
source("scripts/add_indicators.R")

render_book(
  input = "story",
  output_format = "html_document")
