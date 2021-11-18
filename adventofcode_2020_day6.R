library(tidyverse)
library(readr)
library(reshape2)
library(tidyr)
library(stringr)
library(sets)

path <- file.choose()

# part one
# Parse into a data frame
count <- strsplit(read_file(path),'\n\n') %>%
  unlist() %>%
  { gsub("\n","", .) } %>%
  strsplit(.,"") %>%
  melt()
names(count)[2]<-"group"

# keep the different value by groups
clean<-distinct(count, value, group)
cl2<-unique(count, by=c("value", "group"))

nrow(cl2)

# get the numbers of value of different groups
tally(group_by(count, group))->cl2


# part two
# Parse into a data frame
count2 <- strsplit(read_file(path),'\n\n') %>%
  unlist() %>%
  strsplit('[\n]') %>%
  melt()    # just for list
names(count2)[2]<-"group"

count2$split<-str_split(count2$value,"") %>%
  group_by(gruop) %>%
  distinct()





for(n in 1:nrow(count2)) {
  last<-count2$split[[n]]
  if (count2$group[[n]]==count2$group[[n+1]]) {
    last<-intersect(last, count2$split[[n+1]])
    count2$last[n]<-last
  }
}

new<-count2 %>%
  group_by(group) %>%
  mutate(sss = Reduce(intersect, split))