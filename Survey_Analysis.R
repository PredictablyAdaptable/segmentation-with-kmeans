

library(rio)
library(dplyr)

user <- Sys.getenv("USERNAME")
setwd(paste0("C:/Users/", user, "/OneWorkplace/Decisions Science - 3. Audience and Agility/Client Work/Noble Foods/2022 Happy Eggs Segmentation/Data"))

#survey <- import("survey_formatted.csv")
survey <- import("Run Information/survey_run_9.csv")





# sustainability
# ---------------------------------------------------------------------------
survey_sust <- survey %>% select(contains("sustainability_"))

for(i in 1:ncol(survey_sust)){
  print(colnames(survey_sust[i]))
  print(table(survey_sust[i]))
}





# brands
# ---------------------------------------------------------------------------
survey_brand <- survey %>% select(contains("brand_joy_"),"cluster")

brand <- data.frame()
for(cl in 1:6){
  temp <- survey_brand[survey_brand$cluster == cl,]
  for(i in 1:(ncol(temp)-1)){
    brand <- rbind(brand, c(colnames(temp[i]),"count",cl))
    colnames(brand) <- c("Var1", "Freq", "cluster")
    tbl <- as.data.frame(table(temp[i]))
    tbl$cluster <- cl
    brand <- rbind(brand, tbl)
  }
}


                      
                      
write.csv(brand, "Analysis/Brand Joy Analysis.csv")



# 
# ---------------------------------------------------------------------------
survey_welfare <- survey %>% select(contains("welfare_"))
survey_welfare <- survey_welfare[,-c(1:8)]

welfare <- data.frame()
for(i in 1:ncol(survey_welfare)){
  welfare <- rbind(welfare, c(colnames(survey_welfare[i]),"count"))
  colnames(welfare) <- c("Var1", "Freq")
  welfare <- rbind(welfare, as.data.frame(table(survey_welfare[i])))
}

write.csv(welfare, "Analysis/Welfare Analysis.csv")








# response tranformations
# ---------------------------------------------------------------------------
survey <- import("Run Information/survey_run_9.csv")
data_tab <- import("Raw/Happy Egg_Final_2308_map.csv")

# remove 'delete' rows
data_tab <- data_tab[!data_tab$Question_name == "delete",]
data_tab <- data_tab[,c("Question_name", "Label", "Precodes")]

# split out Precodes
#within(data_tab, Precodes<-data.frame(do.call('rbind', strsplit(as.character(Precodes), '|', fixed=TRUE))))
#library(stringr)
#df_new <- data.frame(cbind(data,str_split(data_tab$Precodes, "|")))

#names(df_new) <- c("names","length",paste0("name",1:max(len)))


# demographics grouped
survey$demo_abc1 <- ifelse(survey$demo_occupation < 4, 1,0)
survey$demo_c2de <- ifelse(survey$demo_occupation > 3, 1,0)

sum(survey$demo_abc1)
sum(survey$demo_c2de)



export(data_tab, "Raw/Response_Map.csv")
# split using excel
data_tab <- import("Raw/Response_Map_split.csv")
 
library(tidyr)
# convert to long form
data_tab <- data_tab %>%
  pivot_longer(!c(Question_name, Label), names_to = "delete", values_to = "Precodes")

# remove blanks in precodes column
data_tab <- data_tab[!data_tab$Precodes == "",]
data_tab$delete <- NULL
# split by ":"
precode_tab <- data.frame(do.call('rbind', strsplit(as.character(data_tab$Precodes), ':', fixed=TRUE)))

tab <- cbind(data_tab,precode_tab)
tab$Precodes <- NULL
tab$X1 <-  as.numeric(tab$X1)
colnames(tab) <- c("Question_name","Label","Value","Response")

export(tab, "Raw/Response_Map.csv")



data_tab <- import("Raw/Response_Map.csv")
survey <- import("Run Information/survey_run_9.csv")


for(j in 2:ncol(survey)){
  for(i in 1:nrow(survey)){
    temp <- data_tab[data_tab$Question_name == colnames(survey[j]) & data_tab$Value == survey[i,j],]
    survey[i,j] <- temp[1,4]
  }
}

export(survey, "Raw/Response_Map_long.xlsx")
export(survey, "Run Information/survey_run_9_responses_long.xlsx")







