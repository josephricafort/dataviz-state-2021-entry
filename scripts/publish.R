library("bookdown")
library("tidyverse")
library("blogdown")

source("scripts/clean.R")
source("scripts/add_indicators.R")

render_book(
  input = "story",
  output_format = "html_document")

install_hugo()
config_Rprofile()
config_netlify()