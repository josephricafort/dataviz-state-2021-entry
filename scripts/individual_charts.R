library("svglite")

source("scripts/clean.R")
tribe_tally

source("script/add_indicators.R")
tribe_tools
tribe_orgsec

filename <- function(prefix) {
  paste0(prefix, d_row %>%
     mutate(name = paste(
       experience, 
       roleType, 
       incomeGroup, 
       commitment,
       sep = "-")) %>%
     select(name), ".svg")
}


for(row_n in 1:nrow(tribe_tally)){
  # Tools for DV
  d_row <- tribe_tally[row_n,] %>% mutate_all(as.character)
  print(d_row)
  
  ggplot(tribe_tools %>%
           filter(tools_for_dv_vars %in% tools_top10) %>%
           filter(Experience == d_row$experience &
                    RoleType == d_row$roleType &
                    IncomeGroup == d_row$incomeGroup &
                    Commitment == d_row$commitment),
         aes(tools_for_dv_names, percN, fill = tools_for_dv_type)) +
    geom_bar(width = 1, stat = "identity", color = "white") +
    coord_polar() +
    theme_minimal() +
    labs(
      x = "",
      y = "Percent of the Respondents",
      fill = "Tools for DV Category"
    )

  ggsave(
    filename("charttools-"),
    last_plot(),
    "svg",
    "plots/charttools",
    width = 6,
    height = 4
  )
  
  # # Industry
  # ggplot(tribe_orgsec %>%
  #          filter(Experience == d_row$experience &
  #                   RoleType == d_row$roleType &
  #                   IncomeGroup == d_row$incomeGroup &
  #                   Commitment == d_row$commitment), 
  #        aes(org_sector_names, n, fill = org_sector_category)) +
  #   geom_col() +
  #   coord_flip() +
  #   theme_minimal() +
  #   labs(
  #     x = "Industry",
  #     y = "Number of respondents",
  #     fill = "Industry Category"
  #   )
  # 
  # ggsave(
  #   filename("chartindustry-"),
  #   last_plot(),
  #   "svg",
  #   "plots/chartindustry",
  #   units = c("in"),
  #   width = 7,
  #   height = 3
  # )
}






