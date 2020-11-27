library(dplyr)
library(rvest)
library(xml2)

#Get the information from the assigned website
herf<-"https://www.rchss.sinica.edu.tw/inside/security/today.php"
dt<-read_html(herf) %>%
    html_nodes("pre") %>%
    html_text()

#The file namew as the date
fname<-gsub(as.character(Sys.Date()), pattern = "-", replacement = "")

#operating function only for working days
holiday<- weekdays(Sys.Date()) %in% c("星期六","星期日")
des<-"C:\\Users\\user\\Desktop\\人社中心打卡資料\\"

#Save the information as CSV
if (holiday==FALSE) {
  write(dt, file = as.character(paste0(des,fname,".csv")))
  print("Done")
}
