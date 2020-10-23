library("rvest"); library("dplyr");library(stringr); library("RSelenium")

check<-c()    #網頁網址清單(空白資料向量)
p<-c()    

for (i in c(1:39)) {
  p<-read_html(paste0('https://gcis.nat.gov.tw/mainNew/closeCmpyAction.do?method=list&d-16496-p=',i)) %>%
  html_nodes(".td_showg a") %>% html_attr("href")
  check<-c(check, p)    #以獲得網址資訊更新「網頁網址清單」
}

# 連接 Selenium 伺服器，選用 Chorme 瀏覽器
rem <- remoteDriver(
    remoteServerAddr = "localhost",
    port = 4444,
    browserName = "chrome")


# the numbers of strata in checklist

rem$open()
PA<-NULL    #每個網頁清單中的statum數量

for (k in check) {
    Sys.sleep(runif(1,2,5))
    rem$navigate(k)
    web <- rem$findElement(using = "xpath", value = '//*[@id="queryListForm"]/div[3]/div/div/div/div/div[4]/div[1]')
    pa<-as.character(web$getElementText()) %>% substr(start=3,stop=4) %>% str_trim() %>% as.numeric()    #抓取頁數資訊(最大2位數)
    PA<-c(PA,pa)    #將爬取的頁數資訊儲存為vector
}


#開始爬取資料

rem$open()

for (k in 1644:length(check)) {
  rem$navigate(check[k])
  web <- rem$findElement(using = "xpath", value = '//*[@id="queryListForm"]/div[3]/div/div/div/div/div[4]/div[1]')
  pa<-as.character(web$getElementText()) %>% substr(start=3,stop=4) %>% str_trim() %>% as.numeric()    #抓取頁數資訊(最大2位數)
  
  if (pa>1) {
    for(s in 1:pa) {
      Sys.sleep(runif(1,3,5))
      rem$navigate(check[k])
      temp<-rem$findElement(value = paste0('//*[@id="vParagraph"]/div[',s,']/div[2]/span[9]'))
      temp$clickElement()
      
      class<- rem$findElement(using = "xpath", value = '/html/body/div[2]/div[1]/div/div/div/div/nav/div/div[3]/span')
      cc<-class$getElementText()     # get the title of the page
      
      ans<-substr(cc, start = 1,stop =2) %>% grepl("工廠")    #若為公司，ans=F; 若為工廠，ans=T
        if (ans==FALSE) {
            infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[1]/td[2]')
            c_id<-infor$getElementText()
            c_id<-gsub('訂閱', replacement = '', c_id)
            C_id = as.character(c(C_id, c_id)) %>% str_trim()
            
            infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[3]/td[2]')
            c_name<-infor$getElementText() %>% as.character()
            c_name<-strsplit(c_name, split="Google搜尋")
            c_name = c_name[[1]][1]
            C_name = as.character(c(C_name, c_name)) %>% str_trim()
            
            infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[9]/td[2]')
            c_address<-infor$getElementText()
            c_address<-gsub('電子地圖', replacement = '', c_address)
            C_address = as.character(c(C_address, c_address)) %>% str_trim()
            
            infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[8]/td[2]')
            c_represent<-infor$getElementText()
            c_represent = as.character(c_represent) %>% str_trim()
            C_represent = c(C_represent,c_represent)
            
            infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[6]/td[2]')
            c_capital<-infor$getElementText()
            c_capital = as.character(c_capital) %>% str_trim()
            C_capital = c(C_capital,c_capital)
            
            infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[7]/td[2]')
            c_rcapital<-infor$getElementText()
            c_rcapital = as.character(c_rcapital) %>% str_trim()
            C_Rcapital = c(C_Rcapital,c_rcapital)
            
            infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[10]/td[2]')
            c_registration<-infor$getElementText()
            c_registration = as.character(c_registration) %>% str_trim()
            C_registration = c(C_registration,c_registration)
            
            infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[11]/td[2]')
            c_setdate<-infor$getElementText()
            c_setdate = as.character(c_setdate) %>% str_trim()
            C_setdate = c(C_setdate,c_setdate)
            
            infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[12]/td[2]')
            c_lastdate<-infor$getElementText()
            c_lastdate = as.character(c_lastdate) %>% str_trim()
            C_lastdate = c(C_lastdate,c_lastdate)
            
            rm(c_id,c_name,c_address,c_represent,c_capital,c_rcapital,c_registration,c_setdate,c_lastdate)
          
        }
      }
    }
    else if (pa<=1) {
      Sys.sleep(runif(1,3,5))
      rem$navigate(check[k])
      temp<-rem$findElement(value = paste0('//*[@id="vParagraph"]/div/div[2]/span[9]'))
      temp$clickElement()
      
      class<- rem$findElement(using = "xpath", value = '/html/body/div[2]/div[1]/div/div/div/div/nav/div/div[3]/span')
      cc<-class$getElementText()     # get the title of the page
      
        ans<-substr(cc, start = 1,stop =2) %>% grepl("工廠")    #若為公司，ans=F; 若為工廠，ans=T
      
          infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[1]/td[2]')
          c_id<-infor$getElementText()
          c_id<-gsub('訂閱', replacement = '', c_id)
          C_id = as.character(c(C_id, c_id)) %>% str_trim()
        
          infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[3]/td[2]')
          c_name<-infor$getElementText() %>% as.character()
          c_name<-strsplit(c_name, split="Google搜尋")
          c_name = c_name[[1]][1]
          C_name = as.character(c(C_name, c_name)) %>% str_trim()
          
          infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[9]/td[2]')
          c_address<-infor$getElementText()
          c_address<-gsub('電子地圖', replacement = '', c_address)
          C_address = as.character(c(C_address, c_address)) %>% str_trim()
          
          infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[8]/td[2]')
          c_represent<-infor$getElementText()
          c_represent = as.character(c_represent) %>% str_trim()
          C_represent = c(C_represent,c_represent)
          
          infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[6]/td[2]')
          c_capital<-infor$getElementText()
          c_capital = as.character(c_capital) %>% str_trim()
          C_capital = c(C_capital,c_capital)
          
          infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[7]/td[2]')
          c_rcapital<-infor$getElementText()
          c_rcapital = as.character(c_rcapital) %>% str_trim()
          C_Rcapital = c(C_Rcapital,c_rcapital)
          
          infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[10]/td[2]')
          c_registration<-infor$getElementText()
          c_registration = as.character(c_registration) %>% str_trim()
          C_registration = c(C_registration,c_registration)
          
          infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[11]/td[2]')
          c_setdate<-infor$getElementText()
          c_setdate = as.character(c_setdate) %>% str_trim()
          C_setdate = c(C_setdate,c_setdate)
          
          infor<-rem$findElement(using = "xpath", value = '//*[@id="tabCmpyContent"]/div/table/tbody/tr[12]/td[2]')
          c_lastdate<-infor$getElementText()
          c_lastdate = as.character(c_lastdate) %>% str_trim()
          C_lastdate = c(C_lastdate,c_lastdate)
          
          rm(c_id,c_name,c_address,c_represent,c_capital,c_rcapital,c_registration,c_setdate,c_lastdate)
      
    }
}


# the basic information of companies

COM_basic<-list(C_id,C_name,C_address,C_represent,C_capital,C_Rcapital,C_registration,C_setdate,C_lastdate) %>%
           as.data.frame()
names(COM_basic)<-c("統一編號","公司名稱","公司所在地","代表人","資本總額(元)","實際資本總額(元)","登記機關",
                    "核准設立日期","最後核准變更日期")
write.csv(COM_basic, file = "Basic_information.csv")

