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


###- All personas in single chart -###

# Percent distribution all 16 personalities #
ggplot(tribe_tally %>% 
         mutate(group = paste(experience, roleType, incomeGroup, commitment)) %>%
         mutate(group = fct_reorder(group, n)) %>%
         mutate(class = "class"), aes(reorder(group, nPerc), nPerc, fill = class)) + 
  geom_col(show.legend = F) +
  coord_flip() +
  labs(
    x = "Personas",
    y = "Percent of the Respondents"
  )

ggsave(
  "chartdistribution-all.svg",
  last_plot(),
  "svg",
  "plots",
  width = 12,
  height = 12
)

# Tribe tools #
ggplot(tribe_tools %>% 
         filter(tools_for_dv_vars %in% tools_top10), 
       aes(tools_for_dv_names, percN, fill = tools_for_dv_type)) +
  geom_bar(width = 1, stat = "identity", color = "white") + 
  # coord_flip() +
  coord_polar() + 
  facet_wrap(vars(tribe_desc)) +
  labs(
    x = "",
    y = "Percent of the Respondents",
    fill = "Tools for DV Category"
  )

ggsave(
  "charttools-all.svg",
  last_plot(),
  "svg",
  "plots/charttools",
  width = 18,
  height = 12
)

# Tribe industries #
ggplot(tribe_orgsec, aes(org_sector_names, n, fill = org_sector_category)) +
  geom_col() +
  coord_flip() +
  facet_wrap(vars(tribe_desc)) +
  labs(
    x = "Industry",
    y = "Number of respondents",
    fill = "Industry Category"
  )

ggsave(
  "chartindustry-all.svg",
  last_plot(),
  "svg",
  "plots/chartindustry",
  width = 18,
  height = 12
)

# Tribe industries but TILEMAP #
orgsec_ordered <- rev(c("Academia",
                        "Marketing",
                        "Finance",
                        "Healthcare/medical",
                        "Information technology",
                        "Journalism",
                        "Public sector (government)",
                        "Private sector",
                        "Non-profit",
                        "Consultant (therefore multiple areas)"))

ggplot(tribe_orgsec %>%
         mutate(org_sector_names = fct_relevel(org_sector_names,
                                               orgsec_ordered)), 
       aes(
  org_sector_names, 
  reorder(tribe_desc, desc(tribe_desc)), 
  fill = n)) +
  geom_tile(color = "white",
            lwd = 0.5) +
  scale_fill_gradient2(low = "#FFFFFF", 
                       high = "#335E35",
                       mid = "#66BB6A",
                       midpoint = max(tribe_orgsec$n)/2,
                       na.value = "#FFFFFF") +
  coord_fixed() +
  scale_x_discrete(position = "top", limits=rev) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0, hjust = 0)) +
  guides(fill = guide_colorbar(barwidth = 0.5,
                               barheight = 20))

ggsave(
  "chartindustry-tilemap.svg",
  last_plot(),
  "svg",
  "plots/chartindustry",
  width = 12,
  height = 8
)



### Factors charts ###

# Years experience #
ggplot(experience_sorted, aes(YearsDVExperience, nPerc, fill = experience)) + 
  geom_col() +
  coord_flip() +
  labs(
    x = "Years of Experience",
    y = "Percent of the Respondents",
    fill = "Experience"
  )

ggsave(
  "yearsexperience.svg",
  last_plot(),
  "svg",
  "plots/indicators",
  width = 9,
  height = 6
)

# Role #
ggplot(role_tally %>% 
         mutate(Class = "class"), 
       aes(Class, nPerc, fill = RoleType)) +
  geom_bar(position = "stack", stat = "identity") +
  coord_flip() + 
  labs(
    x = "",
    y = "Percent of the Respondents",
    fill = "Role Type"
  )

ggsave(
  "role.svg",
  last_plot(),
  "svg",
  "plots/indicators",
  width = 9,
  height = 1
)

# Income #
ggplot(income_sorted, aes(PayAnnual, nPerc, fill = income_group)) +
  geom_col() +
  coord_flip() +
  labs(
    x = "Annual Pay",
    y = "Percent of the Respondents",
    fill = "Income Group"
  )

ggsave(
  "income.svg",
  last_plot(),
  "svg",
  "plots/indicators",
  width = 9,
  height = 6
)

# Commitment #
ggplot(commitment_tally %>%
         mutate(Class = "class"), 
       aes(Class, nPerc, fill = Commitment)) +
  geom_bar(position = "stack", stat = "identity") + 
  coord_flip() +
  labs(
    x = "",
    y = "Percent of the Respondents"
  )

ggsave(
  "commitment.svg",
  last_plot(),
  "svg",
  "plots/indicators",
  width = 9,
  height = 1
)