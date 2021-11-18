library(dplyr); library(stringr);

#part one
dt<-read.delim("C:\\Users\\Tsung-wei\\Downloads\\input_2.txt", header = F, sep = "\n")
vec <- dt[[1]]

dt$min<-regmatches(vec, regexec("^[0-99]+", vec))
dt$min<-sub("-","",dt$min) %>% as.numeric(dt$min)

dt$max<-regmatches(vec, regexec("-[0-99]+", vec))
dt$max<-sub("-","",dt$max) %>% as.numeric(dt$max)

dt$search<-regmatches(vec, regexec("[a-z]:", vec))
dt$search<-sub(":","",dt$search)

cont<-str_split(vec,": ")

for(a in 1:nrow(dt)) {
  dt$cont[a]<-cont[[a]][2]
}

dt$count<-str_count(dt$cont,dt$search)
dt$result<-ifelse(dt$count>=dt$min & dt$count<=dt$max,1,0)
    
table(dt$result)

#part two
dt$su1<-substr(dt$cont, dt$min, dt$min)
dt$su2<-substr(dt$cont, dt$max, dt$max)

for(i in 1:nrow(dt)) {
  dt$re1[i]<-dt$su1[i] %in% dt$search[i] %>% as.numeric()
  dt$re2[i]<-dt$su2[i] %in% dt$search[i] %>% as.numeric()
}

dt$sum<-ifelse(dt$re1 + dt$re2==1, 1, 0)

table(st$sum)