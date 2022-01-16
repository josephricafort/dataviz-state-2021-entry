library("tidyverse")

source("scripts/utils.R")
grouped_median
source("scripts/constants.R")
tools_for_dv_names
tools_for_dv_vars
charts_used_names
charts_used_vars
top_frustrations_names
top_frustrations_vars
top_issues_names
top_issues_vars
org_sector_names
org_sector_vars

path <-"data/raw/"
raw_list <- list.files(path)

raw_data_list <- lapply(raw_list, function(file) {
  return (read.csv(paste0(path, file)))
})

is_med_range <- function(str, med) {
  income_range <- str_split(str, "-") %>% unlist() %>% as.numeric()
  return (med >= income_range[1] && med < income_range[2])
}

main_cols <- c("RoleAsEmployee",
               "RoleAsFreelance",
               "YearsDVExperience",
               "YearsWorkExperience",
               "PayAnnual",
               "PayHourly",
               "DVRoles_Freelance",
               "DVRoles_Employee",
               "DVRoles_Hobbyist",
               "DVRoles_Student",
               "DVRoles_Academic",
               "DVRoles_PassiveIncome")

main2021 <- raw_data_list[2] %>% as.data.frame() %>%
  select(all_of(main_cols), 
         all_of(tools_for_dv_vars), 
         all_of(charts_used_vars), 
         all_of(top_frustrations_vars),
         all_of(top_issues_vars),
         all_of(org_sector_vars)) %>%
  mutate_at(vars(YearsDVExperience, YearsWorkExperience), function(x){ str_replace_all(x, "â€“", "-") }) %>%
  mutate_all( function(x){ as.factor(x) })



#--- BREAKDOWN PER INDICATOR ---#

# Role (Analytical vs Creative)
# Variables: RoleAsEmployee (priority), RoleAsFreelance (if priority not available)

creative_types <- c("Designer", "Journalist", "Teacher", "Cartographer")
analytical_types <- c("Analyst", "Developer", "Scientist", "Engineer", "Leadership (Manager, Director, VP, etc.)")
ambiguous_types <- c("None of these describes my role", "")

role <- main2021 %>% select(RoleAsEmployee, RoleAsFreelance) %>%
  mutate(RoleAny = if_else(RoleAsEmployee != "", RoleAsEmployee, RoleAsFreelance)) %>%
  count(RoleAny) %>%
  arrange(desc(n)) %>%
  mutate(RoleType = if_else(RoleAny %in% creative_types, "creative",
                            if_else(RoleAny %in% analytical_types, "analytical", "unknown")))
  # mutate(RoleType = if_else(RoleAny != "", RoleType, "unknown"))
  
role_tally <- role %>% count(RoleType, wt = n) %>%
  mutate(RoleType = as.factor(RoleType)) %>%
  mutate(RoleType = fct_relevel(RoleType, c("analytical", "creative", "unknown"))) %>%
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

experience_tally_proxy <- experience_tally %>%
  mutate(YearsDVExperience = recode(
    experience_tally$YearsDVExperience,
    `Less than 1 year` = "0-1",
    `1` = "1-2",
    `2` = "2-3",
    `3` = "3-4",
    `4` = "4-5",
    `5` = "5-6",
    `6–10` = "6-10",
    `11–15` = "11-15",
    `16–20` = "16-20",
    `21–25` = "21-25",
    `26–30` = "26-30",
    `More than 30` = "30-35" # 35 proxy to make work with grouped_median function
    ) %>% as.character())

yearsexp_median <- grouped_median(frequencies = experience_tally_proxy$n,
                                 intervals = experience_tally_proxy$YearsDVExperience,
                                 sep = "-")
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

experience_sorted <- experience_tally %>%
  mutate(YearsDVExperience = fct_relevel(
    experience_tally$YearsDVExperience, 
    experience_tally$YearsDVExperience %>% as.character())) %>%
  mutate(experience = if_else(row_number() <= yearsexp_med_idx, "junior", "senior") %>%
           as.factor())


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

income_tally_proxy <- income_tally %>%
  # 250k proxy value to match with grouped_median function
  mutate(PayAnnual = recode(income_tally$PayAnnual, 
                            `Less than $10,000` = "$0 - $10,000", 
                            `$240,000 or more` = "$240,000 - $250,000")) %>%
  mutate(PayAnnual = str_replace_all(PayAnnual, "[\\$\\,\\s]", ""))
  # mutate(PayAnnualSplit = str_extract_all(PayAnnual, "[0-9]+", simplify = T)) %>%
  # mutate(PayAnnualMean = mean(PayAnnualSplit %>% as.numeric()))

income_median <- grouped_median(income_tally_proxy$n, income_tally_proxy$PayAnnual, sep="-")
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

income_sorted <- income_tally %>%
  mutate(PayAnnual = fct_relevel(income_tally$PayAnnual,
                                 income_tally$PayAnnual %>% as.character())) %>%
  mutate(income_group = if_else(row_number() <= income_med_idx, "humblypaid", "wellpaid"))


# Commitment (Independent vs Associate)
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
  mutate(IndependentCount = if_else(DVRoles_Hobbyist == HOBBYIST, 4, 0) +
           if_else(DVRoles_Freelance == FREELANCE, 3, 0) +
           if_else(DVRoles_Student == STUDENT, 2, 0) +
           if_else(DVRoles_PassiveIncome == PASSIVE, 1, 0)) %>%
  mutate(AssociateCount = if_else(DVRoles_Employee == EMPLOYEE, 1, 0) +
           if_else(DVRoles_Academic == ACADEMIC, 1, 0)) %>%
  mutate(Commitment = if_else(IndependentCount > AssociateCount, "independent", if_else(
    IndependentCount < AssociateCount, "associate", "ambiguous"
  )) %>% as.factor())
  
commitment_tally <- commitment %>% count(Commitment) %>%
  mutate(nPerc = n/sum(n) * 100) %>%
  mutate(Commitment = fct_relevel(Commitment, c("independent", "ambiguous", "associate")))



#--- ADDITIONAL INDICATORS ---#
# Tools used, prefered charts and frustrations are the
# additional indicators we look at to help identify
# the characters of every persona
tools_for_dv_names # c("ArcGIS", "D3.js"...
tools_for_dv_vars # c("ToolsForDV_ArcGIS", "ToolsForDV_D3"...

charts_used_names # c("Line Chart", "Bar Chart"...
charts_used_vars # c("ChartsUsed_Line", "ChartsUsed_Bar"...

top_frustrations_names # c("Lack of time"...
top_frustrations_vars # c("TopFrustrationsDV_LackTime"...

top_issues_names # c('Lack of awareness of the impact of dataviz'...
top_issues_vars # c("TopIssuesDV_LackAwarenessOfDVImpact"...

org_sector_names # c("Journalism...
org_sector_vars # c("OrgSector_Journalism...

all_add_vars <- c(tools_for_dv_vars, 
                  charts_used_vars, 
                  top_frustrations_vars, 
                  top_issues_vars,
                  org_sector_vars)



#--- BREAKDOWN PER TRIBE ---#
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
  mutate(IncomeGroup = if_else(PayAnnual %in% well_paid, "wellpaid", 
                               if_else(PayAnnual %in% humbly_paid, "humblypaid", "unknown")) %>% 
           as.factor()) %>%
  # By commitment
  mutate(IndependentCount = if_else(DVRoles_Hobbyist == HOBBYIST, 4, 0) +
           if_else(DVRoles_Freelance == FREELANCE, 3, 0) +
           if_else(DVRoles_Student == STUDENT, 2, 0) +
           if_else(DVRoles_PassiveIncome == PASSIVE, 1, 0)) %>%
  mutate(AssociateCount = if_else(DVRoles_Employee == EMPLOYEE, 1, 0) +
           if_else(DVRoles_Academic == ACADEMIC, 1, 0)) %>%
  mutate(Commitment = if_else(IndependentCount > AssociateCount, "independent", if_else(
    IndependentCount < AssociateCount, "associate", "ambiguous"
  )) %>% as.factor()) %>%
  # Additional indicators
  # By tools for dv, charts used and top frustrations
  mutate(across(all_of(all_add_vars), function(x) {if_else(str_length(x) > 0, 1, 0)}))

tribe_clean <- tribe %>%
  select(RoleType, Experience, IncomeGroup, Commitment, 
         all_of(tools_for_dv_vars),
         all_of(charts_used_vars),
         all_of(top_frustrations_vars),
         all_of(top_issues_vars),
         all_of(org_sector_vars)) %>%
  # Remove ambiguous and unknown values
  filter(RoleType != "ambiguous", RoleType != "unknown") %>%
  filter(IncomeGroup != "unknown") %>%
  filter(Commitment != "ambiguous")
  # Summarize per additional indicators
  # gather("tools_for_dv_vars", "tools_for_dv_count", tools_for_dv_vars) %>%
  # gather("charts_used_vars", "charts_used_count", charts_used_vars) %>%
  # gather("top_frustrations_vars", "top_frustrations_count", top_frustrations_vars) %>%
  # filter(tools_for_dv_count != 0 |
  #          charts_used_count != 0 |
  #          top_frustrations_count != 0) %>%
  # mutate(tools_for_dv_vars = as.factor(tools_for_dv_vars),
  #        charts_used_vars = as.factor(charts_used_vars),
  #        top_frustrations_vars = as.factor(top_frustrations_vars))

tribe_tally <- tribe_clean %>%
  group_by(Experience, RoleType, IncomeGroup, Commitment) %>%
  count() %>% 
  arrange(desc(n)) %>%
  ungroup() %>%
  mutate(nPerc = n/sum(n) * 100)

