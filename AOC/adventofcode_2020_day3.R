library(dplyr); library(stringr);

#part one
dt<-read.delim("C:\\Users\\Tsung-wei\\Downloads\\input_3.txt", header = F, sep = "\n")
vec<-as.vector(dt[[1]])

ve<-gsub("#",1,vec)
ve<-gsub("\\.",0,ve)

row<-nchar(vec[1])
mat<-strsplit(ve, "") %>% unlist()
matix<-matrix(mat, ncol = 31, byrow = T)

tree<-NULL
z<-1  

for (i in seq(1,nrow(matix),2)) {
  bump <- matix[i,z]
  print(c(i,z))
  z =(z +1)
  if (z>31) {
    z=(z%%row)
  }
  tree = c(tree, bump)
}

table(tree)
