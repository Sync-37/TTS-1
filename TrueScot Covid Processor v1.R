---
# title: "Daily Trends Scotland"
# author: "Michael Kent"
# date: "06/12/2020"
# output: html_document
---
 
#knitr::opts_chunk$set(echo = FALSE)
library(tidyverse)
library(readxl)
library(here)
library(janitor)
#source("C:/Users/Michael/githome/utils/utils.txt")
source(here("../utils/utils.Rmd"))
#install.packages("viridis")  # Install
library("viridis")           # Load
#here()
# Now set up some strings etc
#For LIVE data
#str_path = "figures/website"

#For TEST data
str_path = "figures"

# Create Datestamps
today <- format(Sys.Date(), format="%Y-%m-%d ") 
filedate <- format(Sys.Date(), format="%Y-%m-%d") 
pubdate <- format(Sys.Date(), format="%d/%m/%Y ")
############################   FUNCTIONS ######################

# # Print the 5 chart sizes
# # Can call with fiveprint(str_path,v_image_file_name) rest is optional
# 
# fiveprint <- function(vstr_path, image_file_name, vdpi = 280, vwidth = 8, vheight = 5){
#  ggsave(here(vstr_path, paste( image_file_name, "fb.jpg", sep = "", collapse=NULL)), dpi = vdpi, width = vwidth, height = vheight)
#  ggsave(here(str_path, paste( image_file_name, "2240.jpg", sep = "", collapse=NULL)), dpi = vdpi, width = vwidth, height = vheight)
#  ggsave(here(str_path, paste( image_file_name, "1680.jpg", sep = "", collapse=NULL)), dpi = vdpi, width = vwidth, height = vheight)
#  ggsave(here(str_path, paste( image_file_name, "1120.jpg", sep = "", collapse=NULL)), dpi = vdpi, width = vwidth, height = vheight)
#  ggsave(here(str_path, paste( image_file_name, "560.jpg", sep = "", collapse=NULL)), dpi = vdpi, width = vwidth, height = vheight)
# }

# Reading in the data  Do once!
############ UPDATED ###############
# Standardised input - one dataset per spreadsheet/CSV

# All Testing Data
sco_uk_testing <- read_excel("data/S_SCO-UK-Testing-data.xlsx", sheet = "d_SCO_UK_Testing", skip = 3)
j_sco_uk_testing = janitor::clean_names(sco_uk_testing)

# Deaths by certificate
uk_d_certificate <- read_excel("data/S_SCO-UK-Testing-data.xlsx", sheet = "Cert Nation Deaths",  range = "L2:V60")
j_uk_d_certificate = janitor::clean_names(uk_d_certificate)

# Deaths within 28 days
uk_d_28_days <- read_excel("data/S_SCO-UK-Testing-data.xlsx", sheet = "Nation Deaths 28",  range = "L2:V320")
j_uk_d_28_days = janitor::clean_names(uk_d_28_days)

# Cases by Health Board MA
sc_d_cases_by_hb <- read_excel("data/S_SCO-UK-Testing-data.xlsx",  sheet = "d_cases_by_hb", range = "AI3:AX333")
j_sc_d_cases_by_hb = janitor::clean_names(sc_d_cases_by_hb)

# Cases by Health Board per 100,000
sc_d_cases_by_hb100 <- read_excel("data/S_SCO-UK-Testing-data.xlsx",  sheet = "d_cases_by_hb", range = "AZ3:BO333")
j_sc_d_cases_by_hb100 = janitor::clean_names(sc_d_cases_by_hb100)

#4 Nation Cases
sc_nation_cases<- read_excel("data/S_SCO-UK-Testing-data.xlsx", sheet = "Nation Cases", range = "R3:V400")
j_sc_nation_cases = janitor::clean_names(sc_nation_cases)

#4 Nation Tests
sc_nation_tests <- read_excel("data/S_SCO-UK-Testing-data.xlsx", sheet = "4 nation tests", range = "K2:P175")
j_sc_nation_tests = janitor::clean_names(sc_nation_tests)

#Vaccinations
daily_nation_vaccinations <- read_excel("data/S_SCO-UK-Testing-data.xlsx", sheet = "Vaccinations", range = "W4:AB25")
j_d_nation_vaccinations = janitor::clean_names(daily_nation_vaccinations)

nation_vaccinations <- read_excel("data/S_SCO-UK-Testing-data.xlsx", sheet = "Vaccinations", range = "AH4:AM25")
j_nation_vaccinations = janitor::clean_names(nation_vaccinations)

# SetupEnd ----------------------------------------------------------------

break

ctitle <- c(names(nation_vaccinations))
cfield <- c(names(j_nation_vaccinations))
ctitle
cfield
ldf <- data.frame(stringsAsFactors=FALSE, c_field = cfield, c_title =ctitle)
head(ldf)

# Various Setup - labels, date etc

# Caption with website
v_caption = paste( "Chart © Thetrue.scot \n","Data Source:- Scottish and UK government statistics as published ", pubdate,  sep = "", collapse=NULL)

# Caption - No Website
#v_caption = paste( "Data Source: Scottish and UK government statistics as published ", pubdate,  sep = "", collapse=NULL)

# Start date for zoomed charts
wave2date = "2020-08-01"

# LABELS
labels_SCO_UK_Test <- as_labeller(c(
  `date_notified`  = "Date notified",
  `uk_daily_tests`  = "UK Daily Tests",
  `uk_daily_tests_per_100_000`  = "UK Daily Tests per 100,000",
  `uk_daily_tests_per_100_000_ma`  = "UK Daily Tests per 100,000 MA",
  `people_reported_negative`  = "People Reported Negative",
  `people_reported_positive`  = "People Reported Positive",
  `people_reported_total`  = "People Reported Total",
  `daily_new_cases`  = "Daily New Cases",
  `ratio_new_cases_to_people_newly_tested` = "ratio New cases to people newly tested",
  `nhs_reported_tests_daily`  = "NHS Reported Tests Daily",
  `nhs_reported_tests_cumulative`  = "NHS Reported Tests Cumulative",
  `uk_gov_reported_tests_daily`  = "UK Gov Reported Tests Daily",
  `uk_gov_reported_tests_cumulative`  = "UK Gov Reported Tests Cumulative",
  `scot_daily_tests`  = "Scot daily tests",
  `total_daily_positive_reported`  = "Total daily positive reported",
  `percent_daily_positive`  = "Percent Daily Positive",
  `people_with_first_test_7_days`  = "People with first test 7 days",
  `positive_cases_7_days`  = "Positive cases 7 days",
  `tests_reported_7_days`  = "Tests reported 7 days",
  `positive_tests_7_days`  = "Positive tests 7 days",
  `test_positivity_7_days`  = "Test positivity 7 days",
  `scot_daily_tests_per_1_000`  = "Scot daily tests per 1,000",
  `daily_new_cases_ma`  = "Daily New Cases (7 day MA)",
  `percent_dnc`  = "Percent DNC",
  `daily_tests_7_day_ma`  = "daily tests 7 day MA",
  `sco_daily_tests_per_100_000`  = "Sco daily tests per 100,000",
  `sco_daily_tests_per_100_000_ma`  = "Sco Daily Tests per 100,000 MA",
  `percent_daily_positive_ma`  = "Percent Daily Positive MA",
  `new_cases_last_14_days`  = "New Cases last 14 days",
  `people_newly_tested` = "People Newly Tested",
  `people_newly_tested_ma` = "People Newly Tested MA",
  `percent_daily_positive_adj` = "Percent Daily Positive",
  `z_scot_daily_tests_7_day_ma` = "Daily Tests (7 day MA)"))

labels_28_day_deaths <- as_labeller(c(
  `daily_new_cases_ma` = "Daily New Cases (7 day MA)",
  `daily_tests_7_day_ma` = "Daily Tests Reported (7 day MA)"))

# LABELS
labels_HB_Data <- as_labeller(c(
  `nhs_ayrshire_arran`="NHS Ayrshire & Arran",
  `nhs_borders`="NHS Borders",
  `nhs_dumfries_galloway`="NHS Dumfries & Galloway",
  `nhs_fife`="NHS Fife",
  `nhs_forth_valley`="NHS Forth Valley",
  `nhs_grampian`="NHS Grampian",
  `nhs_greater_glasgow_clyde`="NHS Greater Glasgow & Clyde",
  `nhs_highland`="NHS Highland",
  `nhs_lanarkshire`="NHS Lanarkshire",
  `nhs_lothian`="NHS Lothian",
  `nhs_orkney`="NHS Orkney",
  `nhs_shetland`="NHS Shetland",
  `nhs_tayside`="NHS Tayside",
  `nhs_western_isles`="NHS Western Isles",
  `scotland`="Scotland"
))


# Declare standard plot settings
p_geom <-geom_line(aes(color = variable),size=0.65 ) 

lset_HB = c("NHS Ayrshire & Arran", "NHS Borders", "NHS Dumfries & Galloway", "NHS Fife", "NHS Forth Valley", "NHS Grampian", "NHS Greater Glasgow & Clyde", "NHS Highland", "NHS Lanarkshire", "NHS Lothian", "NHS Orkney", "NHS Shetland", "NHS Tayside", "NHS Western Isles" )


cset_x2 = c("purple3", "steelblue3")
cset_x4 = c( "plum1", "purple3","steelblue1", "blue4")
cset_x4n = c( "blue3", "green3", "purple3","grey50")
cset_x5 = c( "blue3", "green3", "purple3","grey50", "red3")

lset_4Nations = c("England",	"Northern Ireland", "Scotland",	"Wales")
lset_2Nations = c("England", "Scotland")
lset_Nations = c("England",	"Northern Ireland", "Scotland", "UK" ,	"Wales")

cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7",  "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# Weekly deaths - certificated

df_uk_d_certificate <- data.frame(j_uk_d_certificate) %>%
  select(date,  england_weekly, northern_ireland_weekly, scotland_weekly, wales_weekly ) %>%
  gather(key = "variable", value = "value",-date)
df_uk_d_certificate <-filter(df_uk_d_certificate, date >= wave2date)
v_title="Weekly Deaths with Covid on Certificate (per 100,000)"
v_ylabel = "Number of Deaths"
ggplot(df_uk_d_certificate, aes(x = date, y = value)) + 
  p_geom  + theme_light() + theme(legend.position = "top")+ 
  scale_color_manual(labels = lset_4Nations,values = cset_x4n) +  
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
fiveprint(str_path,"Deaths_Covid_on_cert_") 

# Scot-Eng only 
df_uk_d_certificate <- data.frame(j_uk_d_certificate) %>%
  select(date,  england_weekly, scotland_weekly ) %>%
  gather(key = "variable", value = "value",-date)
df_uk_d_certificate <-filter(df_uk_d_certificate, date >= wave2date)
ggplot(df_uk_d_certificate, aes(x = date, y = value)) + 
  p_geom  + theme_light() + theme(legend.position = "top")+ 
  scale_color_manual(labels = lset_2Nations,values = c("steelblue3","purple3")) +  
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
fiveprint(str_path,"Deaths_Covid_on_cert_Eng_Sco")

# Weekly deaths - 28 days of test
df_uk_d_28_days <- data.frame(j_uk_d_28_days) %>%
  select(date,  england_daily, northern_ireland_daily, scotland_daily, wales_daily ) %>%
  gather(key = "variable", value = "value",-date)
df_uk_d_28_days <-filter(df_uk_d_28_days, date >= wave2date)
v_title="Daily Deaths within 28 days of a test (per 100,000)"
v_ylabel = "Number of Deaths"
ggplot(df_uk_d_28_days, aes(x = date, y = value)) + 
  p_geom  + theme_light() + theme(legend.position = "top")+ 
  scale_color_manual(labels = lset_4Nations,values = cset_x4n) +  
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
fiveprint(str_path,"Deaths_28_days_")

# Scot-Eng only 
df_uk_d_28_days <- data.frame(j_uk_d_28_days) %>%
  select(date,  england_daily, scotland_daily ) %>%
  gather(key = "variable", value = "value",-date)
df_uk_d_28_days <-filter(df_uk_d_28_days, date >= wave2date)
ggplot(df_uk_d_28_days, aes(x = date, y = value)) + 
  p_geom  + theme_light() + theme(legend.position = "top")+ 
  scale_color_manual(labels = lset_2Nations,values = c("steelblue3","purple3")) +  
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
fiveprint(str_path,"Deaths_28_days_Eng_Sco")


###############################################################
## Scottish and UK testing data
# Prepare
v_title="Testing rates for Scotland and all UK"
v_xlabel = "Date"
v_ylabel = "Tests per 100,000 population"


##-----------Sco/UK testing comparison ----------------------------------------
# All Data
df_sc_uk_test <- data.frame(j_sco_uk_testing) %>%
  select(date_notified, uk_daily_tests_per_100_000_ma, sco_daily_tests_per_100_000_ma) %>%
  gather(key = "variable", value = "value",-date_notified)
ggplot(df_sc_uk_test, aes(x = date_notified, y = value)) + 
  p_geom  + theme_light() + 
  scale_color_manual(labels = c("Scotland", "Whole UK"),values = cset_x2 ) +
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
fiveprint(str_path,"Compare_Testing_MA_Scot-UK_all_")

# from 1st August
df_sc_uk_test <- data.frame(j_sco_uk_testing) %>%
  select(date_notified, uk_daily_tests_per_100_000_ma, sco_daily_tests_per_100_000_ma) %>%
  gather(key = "variable", value = "value",-date_notified)
df_sc_uk_test <-filter(df_sc_uk_test, date_notified >= wave2date)

ggplot(df_sc_uk_test, aes(x = date_notified, y = value)) + 
  p_geom  + theme_light() + 
  scale_color_manual(labels = c("Scotland", "Whole UK"),values = cset_x2 ) +  # OK #
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
fiveprint(str_path,"Compare_Testing_MA_Scot-UK_zoom_")

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# from 1st August
df_sc_uk_test <- data.frame(j_sco_uk_testing) %>%
  select(date_notified, uk_daily_tests_per_100_000, uk_daily_tests_per_100_000_ma, sco_daily_tests_per_100_000, sco_daily_tests_per_100_000_ma) %>%
  gather(key = "variable", value = "value",-date_notified)
df_sc_uk_test <-filter(df_sc_uk_test, date_notified >= wave2date)

ggplot(df_sc_uk_test, aes(x = date_notified, y = value)) + 
  p_geom  + theme_light() + 
  scale_color_manual(labels = c("Scotland Daily", "Scotland Smoothed", "UK Daily", "UK Smoothed"),values = cset_x4 ) +  
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
fiveprint(str_path,"Compare_Testing_Raw+MA_Scot-UK_zoom_")

# Daily Tests Scot/UK/Total with raw

df_sc_test_ma_raw <- data.frame(j_sco_uk_testing) %>%
  select(date_notified,  nhs_reported_tests_daily, nhs_reported_tests_daily_ma, uk_gov_reported_tests_daily, uk_gov_reported_tests_daily_ma ) %>%
  gather(key = "variable", value = "value",-date_notified)
df_sc_test_ma_raw <-filter(df_sc_test_ma_raw, date_notified >= wave2date)

v_title="Processing tests in Scotland"
v_ylabel = "Number of Tests"
ggplot(df_sc_test_ma_raw, aes(x = date_notified, y = value)) + 
  p_geom  + theme_light() + theme(legend.position = "top")+ 
  scale_color_manual(labels = c("NHS Scotland Labs Daily",  "NHS Scotland Labs Smoothed", "UK Labs Daily", "UK Labs Smoothed"),values = cset_x4) +  
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
fiveprint(str_path,"Processing_Tests_in_Scotland_")

#---------- Daily Positive Data ------------------------------------------------
v_title="Positive test rates for Scotland and UK"
v_xlabel = "Date"
v_ylabel = "Percentage tests positive"

df_sc_uk_positive <- data.frame(j_sco_uk_testing) %>%
  select(date_notified, scotland_test_positivity, uk_test_positivity) %>%
  gather(key = "variable", value = "value",-date_notified)
df_sc_uk_positive <-filter(df_sc_uk_positive, date_notified >= wave2date)

ggplot(df_sc_uk_positive, aes(x = date_notified, y = value)) + 
  p_geom  + theme_light() + theme(legend.position = "top")+ 
  scale_color_manual(labels = c("Scotland", "Whole UK"),values =  cset_x2 ) +  
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "")
fiveprint(str_path,"UK-SCO_Positive_Test_Rate_(WHO)_")


# First data frame is for Sco/UK testing comparison.
v_title="New Covid 19 cases by Health Board (per 100,000 population)"
v_xlabel = "Date"
v_ylabel = "New Cases per 100,000 population"

df_sc_d_cases_by_hb <- data.frame(j_sc_d_cases_by_hb100) %>%
  select(date_notified, nhs_ayrshire_arran:nhs_western_isles) %>%
  gather(key = "variable", value = "value",-date_notified)
df_sc_d_cases_by_hb <-filter(df_sc_d_cases_by_hb, date_notified >= wave2date)

p <- ggplot(df_sc_d_cases_by_hb, aes(x = date_notified, y = value)) + 
  geom_line(aes(color = variable),size=0.75 ) + theme_light() + 
  scale_color_manual(labels = lset_HB, values = cbbPalette) +
  labs(x = v_xlabel,
       y = v_ylabel, 
       title = v_title,
       caption = v_caption,
       color = "")
p 
fiveprint(str_path,"Average_new_cases_per_100k_by_HB_")

#----------------
p_facet <- facet_wrap(~ variable, ncol=4, labeller = labels_HB_Data, scales = "free_y", as.table = TRUE)  
p +  p_facet + theme(legend.position = "none") 
fiveprint(str_path,"Average_new_cases_per_100k_by_HB_set_")

# First data frame is for Sco/UK testing comparison.
v_title="New Covid 19 cases by Health Board"
v_ylabel = "New Cases (7 day average)"

df_sc_d_cases_by_hb <- data.frame(j_sc_d_cases_by_hb) %>%
  select(date_notified, nhs_ayrshire_arran:nhs_western_isles) %>%
  gather(key = "variable", value = "value",-date_notified)
df_sc_d_cases_by_hb <-filter(df_sc_d_cases_by_hb, date_notified >= wave2date)

p <- ggplot(df_sc_d_cases_by_hb, aes(x = date_notified, y = value)) + 
  geom_line(aes(color = variable),size=0.75 ) + theme_light() + 
  scale_color_manual(labels = lset_HB, values = cbbPalette) +
  labs(x = v_xlabel,
       y = v_ylabel, 
       title = v_title,
       caption = v_caption,
       color = "")
p 
fiveprint(str_path,"Average_new_cases_by_HB_")

#----------------
p_facet <- facet_wrap(~ variable, ncol=4, labeller = labels_HB_Data, scales = "free_y", as.table = TRUE)  
p +  p_facet + theme(legend.position = "none")
fiveprint(str_path,"Average_new_cases_by_HB_set_")


#-----------------Compare Tests and new cases-----------------------------------
# Second compares testing and case numbers.
df_sc_t5 <- data.frame(j_sco_uk_testing) %>%
  select(date_notified, daily_new_cases_ma, z_scot_daily_tests_7_day_ma) %>%
  gather(key = "variable", value = "value",-date_notified)
#head(df_sc_t5)

# Change image file name
v_title="Daily New Cases and Tests"
v_xlabel = "Date"
v_ylabel = "Count"
# Testing v positive tests
ggplot(df_sc_t5, aes(x = date_notified, y = value)) + 
  p_geom + theme_light() +theme(legend.position = "none")+
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") +
  facet_wrap(~ variable , labeller = labels_SCO_UK_Test , ncol=1, scales = "free_y")
fiveprint(str_path,"Testing_v_New_Cases_")


# Filter for zoomed chart
df_sc_t5 <-filter(df_sc_t5, date_notified >= wave2date)
ggplot(df_sc_t5, aes(x = date_notified, y = value)) + 
  p_geom + theme_light() +theme(legend.position = "none")+
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") +
  facet_wrap(~ variable , labeller = labels_SCO_UK_Test, ncol=1, scales = "free_y")
fiveprint(str_path,"Testing_v_New_Cases_zoom_")

#-----------------Compare Tests and new cases Scotland/England-----------------------------------j_sc_nation_tests

# # England Scotland Cases
df_sc_nation_cases <- data.frame(j_sc_nation_cases) %>%
  select(date, england, scotland) %>%
  gather(key = "variable", value = "value",-date)
df_sc_nation_cases <-filter(df_sc_nation_cases, date >= wave2date)

#head(sc_nation_cases_zoom)

# 4 Nations Cases
df_sc_4nation_cases <- data.frame(j_sc_nation_cases) %>%
  select(date, england, northern_ireland, scotland, wales) %>%
  gather(key = "variable", value = "value",-date)
df_sc_4nation_cases <-filter(df_sc_4nation_cases, date >= wave2date)

# England Scotland Tests
df_j_sc_nation_tests <- data.frame(j_sc_nation_tests) %>%
  select(date, england, scotland) %>%
  gather(key = "variable", value = "value",-date)
#head(sc_nation_cases_zoom)

# 4 Nations Tests
df_j_sc_4nation_tests <- data.frame(j_sc_nation_tests) %>%
  select(date, england, northern_ireland, scotland, wales) %>%
  gather(key = "variable", value = "value",-date)
#head(sc_nation_cases_zoom)

# Then the Sco testing and case numbers
# Change image file name
v_title="Daily New Cases per 100,000"
v_xlabel = "Date"
v_ylabel = "Cases"
# Testing v positive tests
ggplot(df_sc_nation_cases, aes(x = date, y = value)) + 
  p_geom + theme_light() + theme(legend.position = "bottom")+
  scale_color_manual(labels = c( "England", "Scotland"),values = c( "steelblue3", "purple3") ) +  # OK #
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
fiveprint(str_path,"Daily_New_Cases_Eng_Sco_")

ggplot(df_sc_4nation_cases, aes(x = date, y = value)) + 
  p_geom + theme_light() + theme(legend.position = "bottom")+
  scale_color_manual(labels = lset_4Nations,values = cset_x4n ) +  # OK #
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
fiveprint(str_path,"Daily_New_Cases_All_")


# Change image file name
v_title="Daily New Tests per 100,000"
v_xlabel = "Date"
v_ylabel = "Tests"
# Testing v positive tests
ggplot(df_j_sc_nation_tests, aes(x = date, y = value)) + 
  p_geom + theme_light() + theme(legend.position = "bottom")+
  scale_color_manual(labels = c( "England", "Scotland"),values = c( "steelblue3", "purple3") ) +  # OK #
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
fiveprint(str_path,"Daily_New_Tests_Eng_Sco_")

################################################################
ggplot(df_j_sc_4nation_tests, aes(x = date, y = value)) + 
  p_geom + theme_light() + theme(legend.position = "bottom")+   
  #    scale_y_discrete(limits=c("0","100","200", "300", "400" ,"500", "600", "700", "800", "900", "1000")) +
  scale_color_manual(labels = lset_4Nations,values = cset_x4n ) +  # OK #
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
v_image_file_name =  "Daily_New_Tests_All_"
fiveprint(str_path,"Daily_New_Tests_All_")




#j_nation_vaccinations
#---------- Daily Positive Data ------------------------------------------------daily_nation_vaccinations
v_title="UK Nation Vaccination Rates (per 100 people)"
v_xlabel = "Date"
v_ylabel = "Doses Administered"
# Total Rates
df_nation_vaccinations <- data.frame(j_nation_vaccinations) %>%
  select(date, england:wales)  %>%
  gather(key = "variable", value = "value",-date)
ggplot(df_nation_vaccinations, aes(x = date, y = value)) + geom_line(aes(color = variable),size=0.8 )+ #  p_geom  +
  theme_light() + theme(legend.position = "top")+ 
  scale_color_manual(labels = lset_4Nations, values =  cset_x5 ) +  
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "") 
####facet_wrap(~ variable, scales = "free_y", as.table = TRUE, labeller(ldf))
fiveprint(str_path,"UK_Nations_Vaccinations_")

#Daily Rates
v_title="UK Nation Daily Vaccination Rates (per 100 people)"
# Total Rates
df_nation_vaccinations <- data.frame(j_d_nation_vaccinations) %>%
  select(date, england:wales)  %>%
  gather(key = "variable", value = "value",-date)
ggplot(df_nation_vaccinations, aes(x = date, y = value)) + geom_line(aes(color = variable),size=0.8 )+ #  p_geom  +
  theme_light() + theme(legend.position = "top")+ 
  scale_color_manual(labels = lset_4Nations, values =  cset_x5 ) +  
  labs(x = v_xlabel, y = v_ylabel, title = v_title, caption = v_caption, color = "")
fiveprint(str_path,"UK_Nations_Vaccinations_Daily_")







