# Explore additional indicators

source("scripts/clean.R")
tribe
tribe_clean
tribe_tally
source("scripts/constants.R")
tools_for_dv_vars
charts_used_vars
top_frustrations_vars

main_indicators <- c("RoleType", "Experience", "IncomeGroup", "Commitment")

# Tools for DV
tribe_tools_gather <- tribe_clean %>% 
  select(all_of(main_indicators), all_of(tools_for_dv_vars)) %>%
  # Filter those who have at least 1 answer
  filter(rowSums(across(where(is.numeric))) != 0)

tribe_tools_count <- tribe_tools_gather %>%
  group_by(Experience, RoleType, IncomeGroup, Commitment) %>%
  summarize(tribe_count = n()) %>%
  ungroup() %>% arrange(desc(tribe_count))

tribe_tools <- tribe_tools_gather %>%
  gather("tools_for_dv_vars", "tools_for_dv_count", tools_for_dv_vars) %>%
  filter(tools_for_dv_count != 0) %>%
  mutate(tools_for_dv_vars = as.factor(tools_for_dv_vars)) %>%
  group_by(RoleType, Experience, IncomeGroup, Commitment, tools_for_dv_vars) %>%
  count() %>%
  ungroup() %>% arrange(desc(n)) %>%
  group_by(RoleType, Experience, IncomeGroup, Commitment) %>%
  left_join(tribe_tools_count, by = main_indicators) %>%
  mutate(percN = n/tribe_count * 100) %>%
  mutate(tribe_desc = paste(Experience, RoleType, IncomeGroup, Commitment, sep = "-")) %>%
  ungroup() %>%
  mutate(tools_for_dv_vars = fct_reorder(tools_for_dv_vars, percN))
  

# Charts used
tribe_charts_gather <- tribe_clean %>% 
  select(all_of(main_indicators), all_of(charts_used_vars)) %>%
  # Filter those who have at least 1 answer
  filter(rowSums(across(where(is.numeric))) != 0)

tribe_charts_count <- tribe_charts_gather %>%
  group_by(Experience, RoleType, IncomeGroup, Commitment) %>%
  summarize(tribe_count = n()) %>%
  ungroup() %>% arrange(desc(tribe_count))

tribe_charts <- tribe_charts_gather %>%
  gather("charts_used_vars", "charts_used_count", charts_used_vars) %>%
  filter(charts_used_count != 0) %>%
  mutate(charts_used_vars = as.factor(charts_used_vars)) %>%
  group_by(RoleType, Experience, IncomeGroup, Commitment, charts_used_vars) %>%
  count() %>%
  ungroup() %>% arrange(desc(n)) %>%
  group_by(RoleType, Experience, IncomeGroup, Commitment) %>%
  left_join(tribe_charts_count, by = main_indicators) %>%
  mutate(percN = n/tribe_count * 100) %>%
  mutate(tribe_desc = paste(Experience, RoleType, IncomeGroup, Commitment, sep = "-")) %>%
  ungroup() %>%
  mutate(charts_used_vars = fct_reorder(charts_used_vars, percN))


# Top Frustrations
tribe_frustrations_gather <- tribe_clean %>% 
  select(all_of(main_indicators), all_of(top_frustrations_vars)) %>%
  # Filter those who have at least 1 answer
  filter(rowSums(across(where(is.numeric))) != 0)

tribe_frustrations_count <- tribe_frustrations_gather %>%
  group_by(Experience, RoleType, IncomeGroup, Commitment) %>%
  summarize(tribe_count = n()) %>%
  ungroup() %>% arrange(desc(tribe_count))

tribe_frustrations <- tribe_frustrations_gather %>%
  gather("top_frustrations_vars", "top_frustrations_count", top_frustrations_vars) %>%
  filter(top_frustrations_count != 0) %>%
  mutate(top_frustrations_vars = as.factor(top_frustrations_vars)) %>%
  group_by(RoleType, Experience, IncomeGroup, Commitment, top_frustrations_vars) %>%
  count() %>%
  ungroup() %>% arrange(desc(n)) %>%
  group_by(RoleType, Experience, IncomeGroup, Commitment) %>%
  left_join(tribe_frustrations_count, by = main_indicators) %>%
  mutate(percN = n/tribe_count * 100) %>%
  mutate(tribe_desc = paste(Experience, RoleType, IncomeGroup, Commitment, sep = "-")) %>%
  ungroup() %>%
  mutate(top_frustrations_vars = fct_reorder(top_frustrations_vars, percN))

