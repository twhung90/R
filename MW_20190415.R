library(psych)

#匯入資料
data<- read.csv("C:\\Users\\user\\Desktop\\factor\\MW_20190415.csv", header=T, sep=",")

#因素分析
PCA<- prcomp(formula= ~e02+d01z01+d01z02+d01z03+d01z04+d01z05+d01z06, data=data, center=T, scale=T)

#陡坡圖
plot(PCA,         # 放pca
     type="line", # 用直線連結每個點
     main="Scree Plot of Gender Ideologies") # 主標題
abline(h=1, col="red")

PCA$rotation    #因素負載量
PCA$rotation[ ,1:2]   #擷取前2個主要成分的負載係數
comp1<- PCA$rotation[ ,1]    #第一元素
comp2<- PCA$rotation[ ,2]    #第二元素

# 第一主成份：由大到小排序原變數的係數
comp1[order(comp1, decreasing=T)] 

# 第二主成份：由大到小排序原變數的係數
comp2[order(comp2, decreasing=T)]

#loadingplot
biplot(PCA, choices=1:2)
abline(h=0.00, v=0.00, col="blue")    #於圖形中心點補上十字線

#Cronbach's Alpha
alpha(data[c(4:10)], na.rm = T, check.keys=T)


