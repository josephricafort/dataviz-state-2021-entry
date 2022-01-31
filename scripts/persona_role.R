library("tidyverse")

source("scripts/clean.R")
tribe
tribe_tally

persona_role <- tribe %>%
  select(RoleAny, RoleType, Experience, IncomeGroup, Commitment) %>%
  filter(RoleType != "unknown", 
         RoleType != "ambiguous") %>%
  mutate(persona = paste(Experience, RoleType, IncomeGroup, Commitment, sep = "-")) %>%
  group_by(persona, RoleAny) %>%
  count() %>% ungroup() %>% 
  arrange(desc(n))

persona_role %>%
  filter(persona == "junior-analytical-wellpaid-independent")