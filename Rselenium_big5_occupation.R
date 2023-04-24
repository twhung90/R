
#loading package
library(RSelenium); library(rvest); library(xml2); library(tidyverse); library(stringr)

rm(list = ls())
URL <- "https://www.stat.gov.tw/standardoccupationalclassification.aspx?n=3145&sms=0&rid=6"
OCCU <- NULL
DES<-NULL
CONTENT <- NULL

#initial setting for connecting port
rem <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4444,
  browserName = "chrome")

# layer
a1=NULL; b2=NULL; c3=NULL; d4=NULL    #�����������|�h���c

#manipulation
rem$open()
rem$navigate(URL)
url<-as.character(rem$getCurrentUrl())   #������eurl�A���ഫ��charcter

a1<- read_html(url) %>%
  html_nodes("div.col-md-6") %>% 
  html_text() %>%  #CSS�[�c�U�Adiv�U��col-md-6����
  str_trim(side = "both") %>% str_split(pattern = "\r\n ") %>% unlist() %>% length()

for(i in 1:a1) {
lay1 <- rem$findElement(using = "xpath", 
                        paste0('//*[@id="ContentPlaceHolder_PageContent_detail_divCategory"]/div/ul/li[',i,']/a'))
lay1$clickElement()    #�I��
link1<-as.character(rem$getCurrentUrl())   #������eurl�A���ഫ��charcter
Sys.sleep(1)

b2<- read_html(link1) %>%
html_nodes("div.col-md-12 ul li") %>% html_text() %>%   #CSS�[�c�U�Adiv�U��col-md-6����
str_trim(side = "both") %>% str_split(pattern = "\r\n ") %>% unlist() %>% length() %>% '-'(1)   #��e�@�h�����ҼơA�G��1

  for(j in 1:b2) {
  lay2 <- rem$findElement(using = "xpath", 
                          paste0('//*[@id="ContentPlaceHolder_PageContent_detail_divCategory"]/div/ul[2]/li[',j,']/a'))
  lay2$clickElement()    #�I��
  link2<-as.character(rem$getCurrentUrl())   #������eurl�A���ഫ��charcter
  Sys.sleep(1)
  
  c3<- read_html(link2) %>%
  html_nodes("div.col-md-12 ul li") %>% html_text() %>%   #CSS�[�c�U�Adiv�U��col-md-6����
  str_trim(side = "both") %>% str_split(pattern = "\r\n ") %>% unlist() %>% length() %>% '-'(2)   #��e�G�h�����ҼơA�G��2
  
    for(k in 1:c3) {
    lay3 <- rem$findElement(using = "xpath", 
                            paste0('//*[@id="ContentPlaceHolder_PageContent_detail_divCategory"]/div/ul[2]/li[',k,']/a'))
    lay3$clickElement()    #�I��
    link3<-as.character(rem$getCurrentUrl())   #������eurl�A���ഫ��charcter
    Sys.sleep(1)
    
    d4<- read_html(link3) %>%
    html_nodes("div.col-md-12 ul li") %>% html_text() %>%   #CSS�[�c�U�Adiv�U��col-md-6����
    str_trim(side = "both") %>% str_split(pattern = "\r\n ") %>% unlist() %>% length() %>% '-'(3)   #��e�T�h�����ҼơA�G��3
    
      for(l in 1:d4) {
      lay4 <- rem$findElement(using = "xpath", 
                              paste0('//*[@id="ContentPlaceHolder_PageContent_detail_divCategory"]/div/ul[2]/li[',l,']/a'))
      lay4$clickElement()    #�I��
      link4<-as.character(rem$getCurrentUrl())   #������eurl�A���ഫ��charcter
      Sys.sleep(1)
      
      #.....�ݭn�󦹳B�}�l�g�J����¾�~��r�����e.....#
      oc<-read_html(link4) %>% html_nodes("div.col-md-12 ul li") %>% html_text() %>% str_trim(side = "both") %>%
            gsub(pattern = "����\t-\t", replacement = "-") %>% .[4]
      OCCU<-append(OCCU,oc)
      
      des<-read_html(link4) %>% html_nodes("div.col-md-12 ul p") %>% html_text() %>% str_trim(side = "both")
      DES<-append(DES,des)
      
      cont<-read_html(link4) %>% html_nodes("div.col-md-12 ul.item li") %>% html_text() %>% paste0(collapse = ";")
      CONTENT<-append(CONTENT,cont)
      
      lay4$goBack()
      }
    
    lay3$goBack()
    }

  lay2$goBack()
  }

lay1$goBack()
}

# merge the data
dta <- data.frame(OCCU,DES)
spt_cont<-as.data.frame(str_split_fixed(CONTENT, pattern = ";", n=50))
dta<-cbind(dta,spt_cont)

write.csv(dta,"�D�p�`�B¾�~�зǤ���_��6���׭q(99�~5��).csv")
