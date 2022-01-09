library("tidyverse")

src("scripts/utils.R")

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



#--- BREAKDOWN PER INDICATOR ---

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
  
role_tally <- role %>% count(RoleType, wt = n) %>%
  mutate(RoleType = as.factor(RoleType)) %>%
  mutate(RoleType = fct_relevel(RoleType, c("analytical", "ambiguous", "creative", "unknown"))) %>%
  mutate(nPerc = n/sum(n) * 100) %>%
  arrange(RoleType)


# Years of Experience (Junior vs Senior)
# Variables: YearsDVExperience (priority), YearsWorkExperience (if priority not available)

experience <- main2021 %>% select(YearsDVExperience, YearsWorkExperience) %>%
  # mutate_all(function(x){ str_replace_all(x, "â€“", "-") }) %>%
  mutate(YearsDVExperience = if_else(YearsDVExperience != "", YearsDVExperience, YearsWorkExperience)) %>%
  mutate(YearsDVExperience = as.factor(YearsDVExperience))
  # mutate(YearsTotalExperience = mean(YearsDVExperience, YearsWorkExperience, na.rm = T))
  
experience_tally <- experience %>%
  count(YearsDVExperience) %>%
  arrange(str_length(YearsDVExperience)) %>%
  filter(YearsDVExperience != "")
experience_tally <- bind_rows(
  experience_tally[12,], # Less 1 year
  experience_tally[-c(12),])
experience_sorted <- experience_tally %>%
  mutate(YearsDVExperience = fct_relevel(
    experience_tally$YearsDVExperience, 
    experience_tally$YearsDVExperience %>% as.character()))

experience_tally_proxy <- experience_tally %>%
  mutate(YearsDVExperience = recode(
    experience_tally$YearsDVExperience,
    `Less than 1 year` = "0-1",
    `1` = "1-2",
    `2` = "2-3",
    `3` = "3-4",
    `4` = "4-5",
    `5` = "5-6",
    `More than 30` = "30-35" # 35 proxy to make work with GroupedMedian function
    ))


# Income Group (Commoner vs Elite)
# Variables: PayAnnual (priority), PayHourly (if priority not available)

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

income_sorted <- income_tally %>%
  mutate(PayAnnual = fct_relevel(income_tally$PayAnnual,
                                 income_tally$PayAnnual %>% as.character()))

income_tally_proxy <- income_tally %>%
  # 250k proxy value to match with GroupedMedian function
  mutate(PayAnnual = recode(income_tally$PayAnnual, 
                            `Less than $10,000` = "$0 - $10,000", 
                            `$240,000 or more` = "$240,000 - $250,000")) %>%
  mutate(PayAnnual = str_replace_all(PayAnnual, "[\\$\\,\\s]", ""))
  # mutate(PayAnnualSplit = str_extract_all(PayAnnual, "[0-9]+", simplify = T)) %>%
  # mutate(PayAnnualMean = mean(PayAnnualSplit %>% as.numeric()))


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
  # mutate(hobbyist_count = if_else(DVRoles_Hobbyist == HOBBYIST, 3, 0) +
  #          if_else(DVRoles_Student == STUDENT, 2, 0) + 
  #          if_else(DVRoles_PassiveIncome == PASSIVE, 1, 0)) %>%
  # mutate(professional_count = if_else(DVRoles_Employee == EMPLOYEE, 1, 0) +
  #          if_else(DVRoles_Freelance == FREELANCE, 1, 0) + 
  #          if_else(DVRoles_Academic == ACADEMIC, 1, 0)) %>%
  # mutate(commitment = if_else(hobbyist_count > professional_count, "hobbyist", if_else(
  #   hobbyist_count < professional_count, "professional", "ambiguous"
  # ))) %>%
  mutate(HobbyistCount = if_else(DVRoles_Hobbyist == HOBBYIST, 4, 0) +
           if_else(DVRoles_Freelance == FREELANCE, 3, 0) +
           if_else(DVRoles_Student == STUDENT, 2, 0) +
           if_else(DVRoles_PassiveIncome == PASSIVE, 1, 0)) %>%
  mutate(ProfessionalCount = if_else(DVRoles_Employee == EMPLOYEE, 1, 0) +
           if_else(DVRoles_Academic == ACADEMIC, 1, 0)) %>%
  mutate(Commitment = if_else(HobbyistCount > ProfessionalCount, "hobbyist", if_else(
    HobbyistCount < ProfessionalCount, "professional", "ambiguous"
  )) %>% as.factor())
  
commitment_tally <- commitment %>% count(Commitment) %>%
  mutate(nPerc = n/sum(n) * 100) %>%
  mutate(Commitment = fct_relevel(Commitment, c("hobbyist", "ambiguous", "professional")))



#--- BREAKDOWN PER TRIBE ---
is_med_range <- function(str, med) {
  income_range <- str_split(str, "-") %>% unlist() %>% as.numeric()
  return (med >= income_range[1] && med < income_range[2])
}

# Role vars

# Experience vars
yearsexp_median <- GroupedMedian(experience_tally_proxy$n,
                                 experience_tally_proxy$YearsDVExperience,
                                 sep="-")
yearsexp_med_range <- experience_tally_proxy$YearsDVExperience[1]
yearsexp_med_idx <- 1
for(i in 1:nrow(experience_tally_proxy)){
  currExp <- experience_tally_proxy$YearsDVExperience[i]
  if (is_med_range(currExp, yearsexp_median)) {
    yearsexp_med_range <- currExp
    yearsexp_med_idx <- i
  }
}

juniors <- experience_tally[1:yearsexp_med_idx,]$YearsDVExperience %>% unique() %>% as.character()
seniors <- experience_tally %>% filter(!(YearsDVExperience %in% juniors)) %>% select(YearsDVExperience) %>%
  pull() %>% unique() %>% as.character()

# Income vars
income_median <- GroupedMedian(income_tally_proxy$n, income_tally_proxy$PayAnnual, sep="-")
income_med_range <- income_tally_proxy$PayAnnual[1]
income_med_idx <- 1
for(i in 1:nrow(income_tally_proxy)){
  currIncome <- income_tally_proxy$PayAnnual[i]
  if (is_med_range(currIncome, income_median)) {
    income_med_range <- currIncome
    income_med_idx <- i
  }
}

humbly_paid <- income_tally[1:income_med_idx,]$PayAnnual %>% unique() %>% as.character()
well_paid <- income_tally %>% filter(!(PayAnnual %in% humbly_paid)) %>% select(PayAnnual) %>%
  pull() %>% unique() %>% as.character()

# Commitment vars

# All together 4 indicators

tribe <- main2021 %>%
  # By role
  mutate(RoleAny = if_else(RoleAsEmployee != "", RoleAsEmployee, RoleAsFreelance)) %>%
  mutate(RoleType = if_else(RoleAny %in% creative_types, "creative",
                            if_else(RoleAny %in% analytical_types, "analytical", "ambiguous"))) %>%
  mutate(RoleType = if_else(RoleAny != "", RoleType, "unknown") %>% as.factor()) %>%
  # By years experience
  mutate(YearsDVExperience = if_else(YearsDVExperience != "", YearsDVExperience, YearsWorkExperience)) %>%
  mutate(Experience = if_else(YearsDVExperience %in% seniors, "senior", "junior") %>% as.factor()) %>%
  # By income group
  mutate(IncomeGroup = if_else(PayAnnual %in% well_paid, "well-paid", 
                               if_else(PayAnnual %in% humbly_paid, "humbly-paid", "unknown")) %>% 
           as.factor()) %>%
  # By commitment
  mutate(HobbyistCount = if_else(DVRoles_Hobbyist == HOBBYIST, 4, 0) +
           if_else(DVRoles_Freelance == FREELANCE, 3, 0) +
           if_else(DVRoles_Student == STUDENT, 2, 0) +
           if_else(DVRoles_PassiveIncome == PASSIVE, 1, 0)) %>%
  mutate(ProfessionalCount = if_else(DVRoles_Employee == EMPLOYEE, 1, 0) +
           if_else(DVRoles_Academic == ACADEMIC, 1, 0)) %>%
  mutate(Commitment = if_else(HobbyistCount > ProfessionalCount, "hobbyist", if_else(
    HobbyistCount < ProfessionalCount, "professional", "ambiguous"
  )) %>% as.factor())

tribe_clean <- tribe %>%
  select(RoleType, Experience, IncomeGroup, Commitment) %>%
  # Remove ambiguous and unknown values
  filter(RoleType != "ambiguous", RoleType != "unknown") %>%
  filter(IncomeGroup != "unknown") %>%
  filter(Commitment != "ambiguous")

tribe_tally <- tribe_clean %>%
  group_by(Experience, RoleType, IncomeGroup, Commitment) %>%
  count() %>% arrange(desc(n)) %>%
  ungroup() %>%
  mutate(nPerc = n/sum(n) * 100)
