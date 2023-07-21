library(dplyr); library(stringr); library(readtext);

#part one
dt<-readtext("C:\\Users\\Tsung-wei\\Downloads\\input_4.txt")[2] %>% as.character()
dt<-str_split(string = dt, pattern = "\n\n") %>% data.frame()
txt<-dt[[1]] %>% as.character()
names(dt)[1]<-"pass"

check<-c("byr","iyr","eyr","hgt","hcl","ecl","pid","cid")

for(x in check) {
  dt[x]<-NA %>% as.data.frame()
  
  dt[x]<-ifelse(grepl(x,txt), 1, 0)
}

dt$val<-apply(dt[,2:9], 1, sum)
dt$result<-ifelse((dt$val==8) | (dt$val==7 & dt$cid==0), T, F)

table(dt$result)

#part two
dt$result<-NULL
dt$val<-NULL
dt$byr<-regmatches(dt$pass, regexec("byr:+[0-9]{4}", dt$pass))
dt$byr<-sub("byr:","",dt$byr) %>% as.numeric()

dt$iyr<-regmatches(dt$pass, regexec("iyr:+[0-9]{4}", dt$pass))
dt$iyr<-sub("iyr:","",dt$iyr) %>% as.numeric()

dt$eyr<-regmatches(dt$pass, regexec("eyr:[0-9]{4}", dt$pass))
dt$eyr<-sub("eyr:","",dt$eyr) %>% as.numeric()

dt$hgt<-regmatches(dt$pass, regexec("hgt:+[0-9]{3}[cmin]+", dt$pass))

dt$hgt_cm<-regmatches(dt$pass, regexec("hgt:+[0-9]{3}cm+", dt$pass))
dt$hgt_cm<-sub("hgt:","",dt$hgt_cm)
dt$hgt_cm<-sub("cm","",dt$hgt_cm) %>% as.numeric()

dt$hgt_in<-regmatches(dt$pass, regexec("hgt:+[0-9]{2}in+", dt$pass))
dt$hgt_in<-sub("hgt:","",dt$hgt_in)
dt$hgt_in<-sub("in","",dt$hgt_in) %>% as.numeric()

dt$hcl<-regmatches(dt$pass, regexec("hcl:#+[0-9a-z]{6}", dt$pass))
dt$hcl<-sub("hcl:","",dt$hcl)

dt$ecl<-regmatches(dt$pass, regexec("ecl:+[a-z]{3}", dt$pass))
dt$ecl<-sub("ecl:","",dt$ecl)

dt$pid<-regmatches(dt$pass, regexec("pid:+[0-9]{9}", dt$pass))
dt$pid<-sub("pid:","", dt$pid) %>% as.character()

for(n in check[5:7]) {
  ifelse(identical(dt[n], character(0)), NA_character_, dt[n])
}

assign("byr", ifelse(dt$byr>=1920 & dt$byr<=2002, T, F))
assign("iyr", ifelse(dt$iyr>=2010 & dt$iyr<=2020, T, F))
assign("eyr", ifelse(dt$eyr>=2020 & dt$eyr<=2030, T, F))
assign("hgt", ifelse((dt$hgt_cm>=150 & dt$hgt_cm<=193) | (dt$hgt_in>=59 & dt$hgt_in<=76) , T, F))
assign("hcl", ifelse(grepl("^#[a-f0-9]{6}$", dt$hcl), T, F))
assign("ecl", ifelse(dt$ecl %in% c("amb", "blu", "brn", "gry", "grn", "hzl", "oth") , T, F))
assign("pid", ifelse(grepl("^[0-9]{9}$", dt$pid), T, F)) 

result<-data.frame(byr,iyr,eyr,hgt,hcl,ecl,pid)
result$val<-apply(result, 1, sum)
result$final<-ifelse(result$val>=7, T, F)

table(result$final)


#method 2 (fail)
valid <- dt %>%
  filter(1920 <= byr & byr <= 2002) %>%
  filter(2010 <= iyr & iyr <= 2020) %>%
  filter(2020 <= eyr & eyr <= 2030) %>%
  filter( (hgt_cm >= 150 & hgt_cm <= 193) |
          (hgt_in >= 59  & hgt_in <= 76)) %>%
  filter(str_detect(hcl,"^#[0-9a-f]{6}$")) %>%
  filter(!is.na(ecl)) %>%
  filter(str_detect(pid,"^[0-9]{9}$"))
