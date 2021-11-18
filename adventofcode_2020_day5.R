library(dplyr); library(stringr); library(readtext);


path <- file.choose()
dt<-read.delim(path, header = F, sep = "\n")

#part one
dt$a11row<-127
dt$allcol<-7
dt$row<-substr(dt$V1,1,7)
dt$col<-substr(dt$V1,8,10)
dt$prow<-str_split(dt$row,"")
dt$pcol<-str_split(dt$col,"")

temrow<-c(0:dt$a11row)
temcol<-c(0:dt$allcol)


# get the real row position
for(n in 1:nrow(dt)) {
  temrow<-c(0:dt$a11row)

  for(p in 1:7) {
    if(dt$prow[[n]][p]=="B"){ 
       temrow<-tail(temrow,2^(7-p))
       dt$realrow[n]<-temrow
    }
    else if (dt$prow[[n]][p]=="F"){
      temrow<-head(temrow,2^(7-p))
      dt$realrow[n]<-temrow
    }
  }
}

# get the real col position
for(n in 1:nrow(dt)) {
  temcol<-c(0:dt$allcol)
  
  for(p in 1:3) {
    if(dt$pcol[[n]][p]=="L"){ 
      temcol<-head(temcol,2^(3-p))
      dt$realcol[n]<-temcol
    }
    else if (dt$pcol[[n]][p]=="R"){
      temcol<-tail(temcol,2^(3-p))
      dt$realcol[n]<-temcol
    }
  }
}

# get the ID of highest position
for(n in 1:nrow(dt)) {
  dt$id[n] = (dt$realrow[n]*8) + dt$realcol[n] 
}

max(dt$id)

#part two

table(dt$realrow, dt$realcol)
