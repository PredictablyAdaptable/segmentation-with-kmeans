
##################################################
### Dendrogram/ Factor Analysis and Clustering ###
##################################################


library(rio)
library(FactoMineR)
library(dplyr)
library(tidyr)
library(compareGroups)
library(data.table)
library(rpart)
library(rpart.plot)
library(caret)


user <- Sys.getenv("USERNAME")
setwd(paste0("C:/Users/", user, "/OneWorkplace/Decisions Science - 3. Audience and Agility/Client Work/Noble Foods/2022 Happy Eggs Segmentation/Data"))

survey <- import("survey_formatted.csv")
run <- "9"
max_cluster <- 6
set.seed(100) # main seed
# set.seed(120) # run 6, 7, 11, 13
# set.seed(150) # run 12, 14
# set.seed(200) # run 15, 16, 17
# set.seed(450) # run 18, 19

# select questions and format answers
# ---------------------------------------------------------------------------
# select the questions to cluster on
#clusterset1 <- survey %>% select("ID", contains(c("demo_", "statements_"))) # run 7
#clusterset1$demo_age2 <- NULL

clusterset1 <- survey %>%
  select(ID,
         # supermarkets used
         # supermarket_tesco_not, supermarket_coop_not, supermarket_sains_not, supermarket_morri_not, supermarket_ocado_not, supermarket_amazon_not, supermarket_budge_not, supermarket_asda_not, supermarket_nisa_not, supermarket_onestop_not, supermarket_waitr_not,supermarket_ms_not,supermarket_lidl_not,supermarket_aldi_not,supermarket_icel_not,
         # egg purchasing
         egg_frequency,egg_size,egg_quantity,
         # demographics
         demo_income,demo_age,demo_children,#demo_abc1,demo_c2de,
         # egg type
         type_purchase_organic,type_purchase_barn,type_purchase_caged,type_purchase_speciality,type_purchase_freerange,
         # welfare
         welfare_eggs_same,welfare_pay_more_quality_life,welfare_too_expensive_regularly,#welfare_considerate,
         # sustainability
         sustainability_prepared_pay_environmental_products,#sustainability_important_companies_ethical,#sustainability_thinkers,sustainability_not_thinkers,sustainability_acting,sustainability_not_acting,
         # lifestyle
         lifestyle_frequent_cook,#lifestyle_diet_cook_frequency, lifestyle_diet_bake_frequency,##lifestyle_diet_food_importance, 
         # statements 1
         statements_happy,statements_interests_animals,statements_interests_food_drink,
         # statements 2 ##### added at run 9
         statements_motivated_more_by_career_than_money,statements_adventurous,statements_mobile_dependent,statements_take_care_physically,statements_diet_part_fitness
         # brands purchased
         # brand_purchased_happy,brand_purchased_freshlay,brand_purchased_purely,brand_purchased_bigfresh,brand_purchased_heritage,brand_purchased_supermarket,brand_purchased_clarence,brand_purchased_freshnfree,brand_purchased_colony,brand_purchased_chuckle,brand_purchased_respectful,brand_purchased_enriched,
         # barriers
         # type_barrier_cost,type_barrier_quality,type_barrier_reputation,type_barrier_welfare_low,type_barrier_taste,type_barrier_availabiltity,
         # rank
         # egg_rank_quality_taste,egg_rank_quality_welfare,egg_rank_quality_yolk,
         # taste
         # type_freerange_taste,type_organic_taste,type_speciality_taste,
         # health
         #type_freerange_health,type_organic_health,type_speciality_health
         # health2
         #lifestyle_diet_try_limit_eggs, lifestyle_exercise_frequency
         )
clusterset <- clusterset1[ , !(names(clusterset1) %in% c("ID"))]



# PCA
# ---------------------------------------------------------------------------
# run PCA, scale units for standardized data, ncp is the number of principle components, graph for the variables factor map
# pf <- PCA(clusterset, scale.unit = TRUE, ncp = 10, graph = T)

# check validity of your principal components, this will show how much variance each PC explains, as well as eigenvalues
# most readings suggest that an eigenvalue of > 1 is not ideal as if variance of every input variable is 1 then it is reasonable 
# to retain only PCs which are "stronger" (have variance greater) than an individual input variable. (Kaiser Rule) 
# you also want to take into account how much cumulative variance your PCs explain
# eigenvalues <- pf$eig





# clustering - kmeans
# ---------------------------------------------------------------------------
# test number of clusters needed
# k.max <- 15
# wss <- sapply(1:k.max,
#               function(k){kmeans(clusterset, k, nstart=50,iter.max = 15 )$tot.withinss})
# 
# plot(1:k.max, wss,
#      xlab="Number of clusters K",
#      ylab="Total within-clusters sum of squares")

# set the number of groups you want
# fit <- kmeans(pf$ind$coord,5)
# set.seed(450)
standardClusterset <- sapply(clusterset, function(data) (data-mean(data))/sd(data))
fit <- kmeans(standardClusterset,max_cluster)
# add cluster to survey data
survey$cluster <- fit$cluster
clusterset1$cluster <- fit$cluster
print("kmeans:")
count(survey, cluster)



# clustering - hierarchical
# ---------------------------------------------------------------------------
# different hierarchical methods
dd <- dist(scale(clusterset), method = "euclidean")
hc <- hclust(dd, method="single")
hc_cut <- cutree(hc, max_cluster)
survey$cluster <- hc_cut
clusterset1$cluster <- hc_cut
print("hier single:")
count(survey, cluster)

hc <- hclust(dd, method = "ward.D2")
hc_cut <- cutree(hc, max_cluster)
survey$cluster <- hc_cut
clusterset1$cluster <- hc_cut
print("hier ward:")
count(survey, cluster)

hc <- hclust(dd, method = "complete")
hc_cut <- cutree(hc, max_cluster)
survey$cluster <- hc_cut
clusterset1$cluster <- hc_cut
print("hier complete:")
count(survey, cluster)

hc <- hclust(dd, method = "average")
hc_cut <- cutree(hc, max_cluster)
survey$cluster <- hc_cut
clusterset1$cluster <- hc_cut
print("hier average:")
count(survey, cluster)


# # The higher the height of the fusion, the less similar the observations are
# plot(hc, hang = -1, main = "Hierarchical dendrogram")
#
# # summarise clusters
# table(hc_cut)
# table(hc_cut, survey$demo_gender)
# 
# # dendrogram with cluster outlines
# plot(hc, cex = 0.6)
# rect.hclust(hc, k = max_cluster, border = 2:5)






# output into tableau format
# ---------------------------------------------------------------------------
survey$run <- run
size <- count(survey, cluster)
# question, response, run, cluster, value %
survey_out <- survey
survey$ID <- NULL
AllQuestions <- descrTable(cluster ~ ., survey, method=3, type=1,hide.no = "no", show.all = TRUE,max.xlev = 20,max.ylev = 20, include.label= FALSE,include.miss=TRUE)
# pull out the table in a nicer format, then clean it up a bit
AllQuestionsFormat <- as.data.frame(AllQuestions[["descr"]])
AllQuestionsFormat <- AllQuestionsFormat[,-(ncol(AllQuestionsFormat))]
AllQuestionsFormat$variables <- rownames(AllQuestionsFormat)
colnames(AllQuestionsFormat)[1] <- "ALL"
AllQuestionsFormat <- separate(AllQuestionsFormat, col = variables, into = c("VarName","Response"), sep = ":")
AllQuestionsFormat$Response <- trimws(AllQuestionsFormat$Response)
AllQuestionsFormat$Run <- paste0("run_",run)
long <- melt(setDT(AllQuestionsFormat), id.vars = c("VarName","Response","Run"), variable.name = "Cluster")

##### adding non numerical responses to this?




# read in prev if made to add new run
prev_runs <- read.csv("Tableau Data/Tableau Cluster Comparison Data.csv")
#colnames(prev_runs) <- c("ALL","1","2","3","4","5","6","VarName","Response","Run") # check
long <- dplyr::bind_rows(long,prev_runs)

# output tableau file and clusterset survey with run name
write.csv(clusterset, paste0("Run Information/variables_run_", run, ".csv"), row.names = F)
write.csv(size, paste0("Run Information/cluster_size_run_", run, ".csv"), row.names = F)
write.csv(long, "Tableau Data/Tableau Cluster Comparison Data.csv", row.names = F)
write.csv(survey_out,paste0("Run Information/survey_run_", run, ".csv"), row.names = F)







# Decision tree to understand the important variables 
# ---------------------------------------------------------------------------
tree <- rpart(cluster~., data=clusterset1, method="class")
# Visualize the decision tree with rpart.plot
rpart.plot(tree, nn=TRUE, extra=1)


# p <- predict(tree, clusterset1, type = 'class')
# confusionMatrix(p, clusterset1$cluster)





# evaluating the clusters
# ---------------------------------------------------------------------------

library(hopkins)
library(seriation)

#If the value is close to zero, then the dataset is significantly a clusterable data.
#A value of about 0.5 means it is uniformly distributed (no meaningful clusters)
hopkins(clusterset)

# dissimilarity between the data
df_dist <- dist(as.data.frame(standardClusterset)) 
dissplot(df_dist)

km.res <- kmeans(standardClusterset, max_cluster)
dissplot(df_dist, labels = km.res$cluster)
