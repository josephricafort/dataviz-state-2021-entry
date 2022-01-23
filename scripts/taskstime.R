library("tidyverse")

source("scripts/constants.R")
analytical_types
creative_types
ambiguous_types

path <-"data/raw/"
raw_list <- list.files(path)

raw_data_list <- lapply(raw_list, function(file) {
  return (read.csv(paste0(path, file)))
})

taskstime_raw <- raw_data_list[1] %>% as.data.frame() %>% 
  as_tibble() %>%
  select(JobTitle__lightlycleaned, RoleMultichoice_composite, OtherVizTasks__) %>%
  rename(job_title = JobTitle__lightlycleaned, 
         role_choice = RoleMultichoice_composite,
         other_viz_task = OtherVizTasks__) %>%
  mutate(role_choice = as.factor(role_choice)) %>%
  filter(job_title != "") %>%
  mutate(role_type = if_else(role_choice %in% analytical_types, "analytical",
                             if_else(role_choice %in% creative_types, "creative",
                                     "unknown")) %>%
           as.factor())

taskstime_tally <- taskstime_raw %>%
  group_by(job_title, role_choice, role_type) %>%
  count() %>% arrange(desc(n))

taskstime_tally %>% as.data.frame() %>% head(50)
  
