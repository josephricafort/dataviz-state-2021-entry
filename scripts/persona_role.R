library("tidyverse")

source("scripts/clean.R")
tribe
tribe_tally

persona_role <- tribe %>%
  select(RoleAsFreelance , RoleType, Experience, IncomeGroup, Commitment) %>%
  filter(RoleType != "unknown", 
         RoleType != "ambiguous") %>%
  mutate(persona = paste(Experience, RoleType, IncomeGroup, Commitment, sep = "-")) %>%
  group_by(persona, RoleAsFreelance ) %>%
  count() %>% ungroup() %>% 
  arrange(desc(n))

selected <- tribe_tally[12,] %>%
  mutate(tribeLong = paste(experience, roleType, incomeGroup, commitment, sep = "-")) %>%
  select(tribeLong) %>% pull()

persona_role %>%
  filter(persona == selected)
