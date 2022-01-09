library("tidyverse")

path <-"data/raw/"
raw_list <- list.files(path)

raw_data_list <- lapply(raw_list, function(file) {
  return (read.csv(paste0(path, file)))
})

main2021 <- raw_data_list[2] %>% as.data.frame() %>%
  select(RoleAsEmployee,
         RoleAsFreelance,
         YearsDVExperience,
         YearsWorkExperience,
         PayAnnual,
         PayHourly,
         DVRoles_Freelance,
         DVRoles_Employee,
         DVRoles_Hobbyist,
         DVRoles_Student,
         DVRoles_Academic,
         DVRoles_PassiveIncome) %>%
  mutate_at(vars(YearsDVExperience, YearsWorkExperience), function(x){ str_replace_all(x, "â€“", "-") }) %>%
  mutate_all( function(x){ as.factor(x) })



#--- BREAKDOWN PER PARAMETER ---

# Role (Analytical vs Creative)
# Variables: RoleAsEmployee (priority), RoleAsFreelance (if priority not available)

creative_types <- c("Designer", "Journalist", "Teacher")
analytical_types <- c("Analyst", "Developer", "Scientist", "Engineer")
ambiguous_types <- c("Leadership (Manager, Director, VP, etc.)", "Cartographer")

role <- main2021 %>% select(RoleAsEmployee, RoleAsFreelance) %>%
  mutate(RoleAny = if_else(RoleAsEmployee != "", RoleAsEmployee, RoleAsFreelance)) %>%
  count(RoleAny) %>%
  arrange(desc(n)) %>%
  mutate(RoleType = if_else(RoleAny %in% creative_types, "creative",
                            if_else(RoleAny %in% analytical_types, "analytical", "ambiguous"))) %>%
  mutate(RoleType = if_else(RoleAny != "", RoleType, "unknown"))

role_tally <- role %>% count(RoleType, wt = n)


# Years of Experience (Junior vs Senior)
# Variables: YearsDVExperience (priority), YearsWorkExperience (if priority not available)

experience <- main2021 %>% select(YearsDVExperience, YearsWorkExperience) %>%
  # mutate_all(function(x){ str_replace_all(x, "â€“", "-") }) %>%
  mutate(YearsDVExperience = if_else(YearsDVExperience != "", YearsDVExperience, YearsWorkExperience)) %>%
  mutate(YearsDVExperience = as.factor(YearsDVExperience))
  # mutate(YearsTotalExperience = mean(YearsDVExperience, YearsWorkExperience, na.rm = T))
  
experience_tally <- experience %>%
  count(YearsDVExperience) %>%
  arrange(str_length(YearsDVExperience))

experience_tally <- bind_rows(
  experience_tally[1,], # unknown
  experience_tally[13,], # Less 1 year
  experience_tally[-c(1, 13),])


# Income Group (Commoner vs Elite)
# Variables: PayAnnual (priority), PayHourly (if priority not available)
# hours_per_year <- 8 * 20 * 12
# pay_annual_uq <- main2021 %>% select(PayAnnual) %>%
#   unique() %>% pull() %>% as.character()
# convert_to_yearly <- function(str) {
#   range_hourly <- str_extract_all(str, "[0-9]+") %>% 
#     unlist() %>% as.numeric()
#   mean_annual <- mean(range_hourly) * hours_per_year
#   
#   for(ann in pay_annual_uq) {
#     range_result <- ""
#     range_annual <-  str_extract_all(ann, "[0-9]+\\,[0-9]+") %>%
#       unlist() %>% 
#       str_replace_all(",", "") %>%
#       as.numeric()
#     
#     if(length(range_annual) > 0) {
#       if(length(range_annual) == 2){
#         if(mean_annual >= range_annual[1] && mean_annual <= range_annual[2]) {
#           range_result <- ann
#         }
#       } else if(length(range_annual) == 1){
#         # if(str_detect(ann, "Less")) {
#         #   print ("Less")
#         # } else if (str_detect(ann, "more")) {
#         #   print ("more")
#         # }
#         range_result <- ann
#       }
#     } else {
#       range_result <- ""
#     }
#   }
#   return (range_result)
# }
# convert_to_yearly("Less than $15")

income <- main2021 %>% select(PayAnnual, PayHourly) %>%
  count(PayAnnual) %>%
  arrange(str_length(PayAnnual))

income_tally <- bind_rows(
  income[1,], # Unknown
  income[8,], # Less 10k
  income[-c(1, 2, 8, 16),],
  income[2,], # 240k more
  income[16,]) %>% # Not compensated yearly
  filter(PayAnnual != "", PayAnnual != "I am not compensated on a yearly basis")


# Commitment (Hobbyist vs Professional)
# Variables: DVRoles_Freelance,	DVRoles_Employee,	DVRoles_Hobbyist,
# DVRoles_Student,	DVRoles_Academic,	DVRoles_PassiveIncome

HOBBYIST <- "Non-compensated data visualization hobbyist"
STUDENT <- "Student in a degree program at a college or university"
PASSIVE <- "Passive income from data visualization related products"

EMPLOYEE <- "Position in an organization with some dataviz job responsibilities"
FREELANCE <- "Freelance/Consultant/Independent contractor"
ACADEMIC <- "Academic/Teacher"

commitment <- main2021 %>% select(DVRoles_Freelance,
                                  DVRoles_Employee,
                                  DVRoles_Hobbyist,
                                  DVRoles_Student,
                                  DVRoles_Academic,
                                  DVRoles_PassiveIncome) %>%
  mutate(hobbyist_count = if_else(DVRoles_Hobbyist == HOBBYIST, 3, 0) +
           if_else(DVRoles_Student == STUDENT, 2, 0) + 
           if_else(DVRoles_PassiveIncome == PASSIVE, 1, 0)) %>%
  mutate(professional_count = if_else(DVRoles_Employee == EMPLOYEE, 1, 0) +
           if_else(DVRoles_Freelance == FREELANCE, 1, 0) + 
           if_else(DVRoles_Academic == ACADEMIC, 1, 0)) %>%
  mutate(leaning = if_else(hobbyist_count > professional_count, "hobbyist", if_else(
    hobbyist_count < professional_count, "professional", "ambiguous"
  )))

commitment_tally <- commitment %>% count(leaning)




#--- BREAKDOWN PER TRIBE ---
yearsexp_median <- experience_tally %>% filter(n == median(experience_tally$n)) %>%
  select(YearsDVExperience) %>% pull() %>% as.character()
yearsexp_med_idx <- which(experience_tally$YearsDVExperience == yearsexp_median)

juniors <- experience_tally[1:yearsexp_med_idx,]$YearsDVExperience %>% unique() %>% as.character()
seniors <- experience_tally %>% filter(!(YearsDVExperience %in% juniors)) %>% select(YearsDVExperience) %>%
  pull() %>% unique() %>% as.character()

income_med_idx <- which.min(abs(income_tally$n - (median(income_tally %>% 
                                        select(n) %>% pull()) + 1))) # Added 1 to locate the actual median
humbly_paid <- income_tally[1:income_med_idx,]$PayAnnual %>% unique() %>% as.character()
well_paid <- income_tally %>% filter(!(PayAnnual %in% humbly_paid)) %>% select(PayAnnual) %>%
  pull() %>% unique() %>% as.character()

tribe <- main2021 %>%
  # By role
  mutate(RoleAny = if_else(RoleAsEmployee != "", RoleAsEmployee, RoleAsFreelance)) %>%
  mutate(RoleType = if_else(RoleAny %in% creative_types, "creative",
                            if_else(RoleAny %in% analytical_types, "analytical", "ambiguous"))) %>%
  mutate(RoleType = if_else(RoleAny != "", RoleType, "unknown") %>% as.factor()) %>%
  # By years experience
  mutate(YearsDVExperience = if_else(YearsDVExperience != "", YearsDVExperience, YearsWorkExperience)) %>%
  mutate(Experience = if_else(YearsDVExperience %in% seniors, "senior", "junior") %>% as.factor())
  # By income group
  mutate(IncomeGroup = if_else(PayAnnual ))
  
  

