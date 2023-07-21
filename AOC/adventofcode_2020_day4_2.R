library(dplyr)
library(reshape2)
library(tidyr)
library(stringr)

inputpath <- file.choose()

# Parse into a data frame with all values as character strings
passports_str <- strsplit(readr::read_file(inputpath),'\n\n') %>%
  unlist() %>%
  strsplit('[ \n]') %>%
  melt() %>%
  separate(col = value, into=c('key','value'), sep=':') %>%
  dcast(L1 ~ key, value.var="value") %>%
  select(-L1)

# Re-type the variables
passports <- passports_str %>%
  mutate(ecl = factor(ecl, levels=c('amb','blu','brn','gry','grn','hzl','oth'))) %>%
  separate(col = hgt, into=c('hgt_v','hgt_u'), sep=-2) %>%
  mutate(hgt_v = as.numeric(hgt_v),
         hgt_u = factor(hgt_u, levels=c('cm','in')))

# Filter out bad passports
valid <- passports %>%
  filter(1920 <= byr & byr <= 2002) %>%
  filter(2010 <= iyr & iyr <= 2020) %>%
  filter(2020 <= eyr & eyr <= 2030) %>%
  filter( (hgt_u == 'cm' & hgt_v >= 150 & hgt_v <= 193) |
            (hgt_u == 'in' & hgt_v >= 59  & hgt_v <= 76)) %>%
  filter(str_detect(hcl,"^#[0-9a-f]{6}$")) %>%
  filter(!is.na(ecl)) %>%
  filter(str_detect(pid,"^[0-9]{9}$"))

# Solve the problem
nrow(valid)
