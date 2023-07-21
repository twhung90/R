if(!require("sjlabelled")) {
  install.packages("sjlabelled")
}
library(sjlabelled)
library(rio)
dt<-read.csv("C:\\Users\\user\\Downloads\\psfd20230515114209_1.csv")
attach(dt)

# value label of variables
c01_label = c("0 不適用"=0,"1 有"=1,"2 沒有"=2)

dt$c01_1999 <- set_labels(c01_1999,labels = c01_label)
dt$c01_2000 <- set_labels(c01_2000,labels = c01_label)
dt$c01_2001 <- set_labels(c01_2001,labels = c01_label)
dt$c01_2002 <- set_labels(c01_2002,labels = c01_label)
dt$c01_2003 <- set_labels(c01_2003,labels = c01_label)
dt$c01_2004 <- set_labels(c01_2004,labels = c01_label)
dt$c01_2005 <- set_labels(c01_2005,labels = c01_label)
dt$c01_2006 <- set_labels(c01_2006,labels = c01_label)
dt$c01_2007 <- set_labels(c01_2007,labels = c01_label)


c08_label = c("00 跳答或不適用"=0,
              "01 自己一人工作，沒有雇人"=1,
              "02 自己當老闆，而且有雇人"=2,
              "03 為私人雇主或私人機構工作"=3,
              "04 為公營企業工作"=4,
              "05 幫家裡工作，支領固定薪水"=5,
              "06 幫政府機構工作"=6,
              "07 為非營利機構工作"=7,
              "08 幫家裡工作，沒有拿薪水"=8,
              "09 和他人合夥，沒有雇人"=9,
              "96 不知道"=96,
              "97 其他（請說明）"=97,
              "98 拒答"=98)

dt$c08b_1999 <- set_labels(c08b_1999, labels = c08_label)
dt$c08b_2000 <- set_labels(c08b_2000, labels = c08_label)
dt$c08b_2001 <- set_labels(c08b_2001, labels = c08_label)
dt$c08b_2002 <- set_labels(c08b_2002, labels = c08_label)
dt$c08b_2003 <- set_labels(c08b_2003, labels = c08_label)
dt$c08b_2004 <- set_labels(c08b_2004, labels = c08_label)
dt$c08b_2005 <- set_labels(c08b_2005, labels = c08_label)
dt$c08b_2006 <- set_labels(c08b_2006, labels = c08_label)
dt$c08b_2007 <- set_labels(c08b_2007, labels = c08_label)

gender_label = c("0 跳答或不適用"=0,
                 "1 男性"=1,
                 "2 女性"=2,
                 "6 不知道"=6,
                 "8 拒答"=8,
                 "9 遺漏值"=9)

dt$gender <- set_labels(gender, labels = gender_label)


# variables label
set_label(dt) <- c("受訪者編號", 
                   "請問您是民國年出生？", 
                   "請問您目前有工作嗎?_1999", 
                   "請問您目前有工作嗎?_2000",
                   "請問您目前有工作嗎?_2001",
                   "請問您目前有工作嗎?_2002", 
                   "請問您目前有工作嗎?_2003",
                   "請問您目前有工作嗎?_2004",
                   "請問您目前有工作嗎?_2005", 
                   "請問您目前有工作嗎?_2006", 
                   "請問您目前有工作嗎?_2007", 
                   "您是在為誰工作?_1999", 
                   "您是在為誰工作?_2000",
                   "您是在為誰工作?_2001", 
                   "您是在為誰工作?_2002", 
                   "您是在為誰工作?_2003", 
                   "您是在為誰工作?_2004", 
                   "您是在為誰工作?_2005", 
                   "您是在為誰工作?_2006",
                   "您是在為誰工作?_2007", 
                   "受訪者性別",
                   "受訪者首次訪問年")

rm(c01_label,c08_label,gender_label)
save(dt, file = "C:\\Users\\user\\Downloads\\psfd20230515114209_1.RData")
write_stata(dt, path = "C:\\Users\\user\\Downloads\\testtt.dta", version = 14)