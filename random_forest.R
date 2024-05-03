library(haven)

path = file.path()

dataset = read_sav(path)


colnames(dataset)

#write.csv(colnames(dataset),file="C:/Users/tim.brandon/OneWorkplace/Decisions Science - Documents/3. Audience and Agility/Client Work/Snap/TURF/Output/col.csv")


#survey <- read.csv("C:\\Users\\tim.brandon\\OneWorkplace\\Decisions Science - Documents\\3. Audience and Agility\\Client Work\\Noble Foods\\2022 Happy Eggs Segmentation\\Data\\Run Information\\survey_run_9.csv")
survey <- read.csv("C:/Users/rachel.keyte/OneWorkplace/Decisions Science - 3. Audience and Agility\\Client Work\\Noble Foods\\2022 Happy Eggs Segmentation\\Data\\Run Information\\survey_run_9.csv")

survey_yg <- survey[c("ID",
                      "egg_frequency","egg_quantity","egg_size","type_purchase_barn","type_purchase_caged","type_purchase_dk","type_purchase_freerange",
                      "type_purchase_organic","type_purchase_speciality",
                      "lifestyle_diet","demo_age","demo_income","demo_gender","supermarket_shopper","supermarket_tesco_store",
                      "supermarket_tesco_online","supermarket_tesco_click","supermarket_tesco_not","supermarket_coop_store",
                      "supermarket_coop_online","supermarket_coop_click","supermarket_coop_not","supermarket_sains_store",
                      "supermarket_sains_online","supermarket_sains_click","supermarket_sains_not","supermarket_morri_store",
                      "supermarket_morri_online","supermarket_morri_click","supermarket_morri_not","supermarket_ocado_store",
                      "supermarket_ocado_online","supermarket_ocado_click","supermarket_ocado_not","supermarket_amazon_store",
                      "supermarket_amazon_online","supermarket_amazon_click","supermarket_amazon_not","supermarket_budge_store",
                      "supermarket_budge_online","supermarket_budge_click","supermarket_budge_not","supermarket_asda_store",
                      "supermarket_asda_online","supermarket_asda_click","supermarket_asda_not","supermarket_nisa_store",
                      "supermarket_nisa_online","supermarket_nisa_click","supermarket_nisa_not","supermarket_onestop_store",
                      "supermarket_onestop_online","supermarket_onestop_click","supermarket_onestop_not","supermarket_waitr_store",
                      "supermarket_waitr_online","supermarket_waitr_click","supermarket_waitr_not","supermarket_ms_store",
                      "supermarket_ms_online","supermarket_ms_click","supermarket_ms_not","supermarket_lidl_store",
                      "supermarket_lidl_online","supermarket_lidl_click","supermarket_lidl_not","supermarket_aldi_store",
                      "supermarket_aldi_online","supermarket_aldi_click","supermarket_aldi_not","supermarket_icel_store",
                      "supermarket_icel_online","supermarket_icel_click","supermarket_icel_not","supermarket_main_supermarket",
                      "lifestyle_diet_concerned_animal_welfare","lifestyle_diet_recommended_cut_meat_dairy","lifestyle_diet_healthy",
                      "lifestyle_diet_religion","lifestyle_diet_upbringing","lifestyle_diet_reduce_processed_food","lifestyle_diet_environment",
                      "lifestyle_diet_other1","lifestyle_diet_future","lifestyle_diet_food_importance","lifestyle_diet_cook",
                      "lifestyle_diet_cook_frequency","lifestyle_diet_bake_frequency","lifestyle_diet_concerns_salt",
                      "lifestyle_diet_concerns_sugar","lifestyle_diet_concerns_fat","lifestyle_diet_concerns_calories",
                      "lifestyle_diet_concerns_allergen_free","lifestyle_diet_concerns_fair_trade","lifestyle_diet_concerns_organic",
                      "lifestyle_diet_concerns_ethically_farmed","lifestyle_diet_concerns_free_range","lifestyle_diet_concerns_origin",
                      "lifestyle_diet_concerns_local","lifestyle_diet_concerns_freshness","lifestyle_diet_concerns_red_tractor",
                      "lifestyle_diet_concerns_season","lifestyle_diet_concerns_british","lifestyle_diet_concerns_protein",
                      "lifestyle_diet_concerns_carbohydrates","lifestyle_diet_concerns_religion","lifestyle_diet_concerns_other",
                      "lifestyle_diet_concerns_none","lifestyle_exercise_frequency","lifestyle_finances_month_ago",
                      "lifestyle_finances_12_months","sustainability_important_companies_ethical","sustainability_buy_companies_give_back",
                      "sustainability_too_much_environment_concern","sustainability_prepared_compromise_for_environment",
                      "sustainability_companies_overclaim","sustainability_only_worth_saves_money",
                      "sustainability_prepared_pay_environmental_products","sustainability_environmental_products_more_expensive",
                      "sustainability_prefer_organic_natural_foods","sustainability_vegetarian_ethical","sustainability_open_meat_substitutes",
                      #"statements_spontaneous","statements_look_new_ideas","statements_happy_standard_living",
                      #"statements_motivated_more_by_career_than_money","statements_not_afraid_change",
                      #"statements_sacrifice_free_time_for_career","statements_mobile_dependent","statements_dont_like_told_what_to_do",
                      #"statements_dont_care_people_think_me","statements_enjoy_risks","statements_creative_through_hobbies",
                      #"statements_input_people_for_decisions","statements_stick_routine","statements_surround_diverse_cultures",
                      #"statements_seek_out_challenges","statements_important_seize_opportunities","statements_take_care_physically",
                      #"statements_wont_leave_house_not_looking_best","statements_happy_with_life","statements_love_outside",
                      #"statements_less_is_more","statements_family_more_important_than_career","statements_perfect_night_stay_home",
                      #"statements_top_priority_enjoy_myself","statements_satisfied_life","statements_prefer_places_never_been",
                      #"statements_diet_part_fitness","statements_interests_animals","statements_interests_finance",
                      "statements_interests_celebrities","statements_interests_spiritual","statements_interests_tech",
                      "statements_interests_travel","statements_interests_weather","statements_interests_parenting",
                      "statements_interests_education","statements_interests_weddings","statements_interests_relationships",
                      "statements_interests_science","statements_interests_international_news","statements_interests_beauty",
                      "statements_interests_business","statements_interests_cars","statements_interests_fashion",
                      "statements_interests_food_drink","statements_interests_health","statements_interests_interior_design",
                      "statements_interests_politics","statements_interests_national_news","statements_interests_music",
                      "statements_interests_local_events","statements_interests_sports","statements_interests_other",
                      "statements_interests_dk","statements_interests_none","demo_work_status","demo_children","demo_marital_status",
                      "demo_living_with","demo_occupation","cluster")]


survey_yg <- survey[c("ID",
                      "egg_frequency","type_purchase_barn","type_purchase_caged","type_purchase_dk","type_purchase_freerange",
                      "type_purchase_organic","type_purchase_speciality",
                      "demo_age","demo_income",
                      "lifestyle_diet_bake_frequency",
                      "sustainability_too_much_environment_concern","sustainability_prepared_pay_environmental_products",
                      "cluster")]

survey_yg <- survey %>% select_if(is.numeric)
survey_yg <- subset(survey_yg, select=-c(type_purchase_speciality, type_speciality_taste))
#write.csv(survey_yg,file="C:/Users/tim.brandon/OneWorkplace/Decisions Science - Documents/3. Audience and Agility/Client Work/Noble Foods/2022 Happy Eggs Segmentation/Recreation/survey_9_yg.csv")

set.seed(20)

library(randomForest)
library(rpart)
library(rpart.plot)
library(rattle)

survey_yg$ccluster <- as.character(survey_yg$cluster)

survey_yg <- subset(survey_yg, select=-c(cluster,ID))


#make new columns
# survey_yg$veggie <- ifelse(survey_yg$lifestyle_diet=="2",1,0)
# survey_yg$meaty <- ifelse(survey_yg$lifestyle_diet=="4",1,0)
# survey_yg$finances_worse <- ifelse(survey_yg$lifestyle_finances_12_months=="1",1,0)
# survey_yg$nokids <- ifelse(survey_yg$demo_children=="4",1,0)
# survey_yg$ABC1 <- ifelse(survey_yg$demo_occupation<="3",1,0)
# survey_yg$foodethics <- survey_yg$lifestyle_diet_concerns_fair_trade + survey_yg$lifestyle_diet_concerns_organic + survey_yg$lifestyle_diet_concerns_ethically_farmed + survey_yg$lifestyle_diet_concerns_free_range


#Run random forest with CLuster as dependant variable
#GTR.rf_1 <- randomForest(Cluster ~ ., data=testset_tracker,type=classification,importance=TRUE,proximity=TRUE)


egg.rf_A <- rpart(ccluster ~ .,data=survey_yg,method = "class", maxdepth=30)


# #Take a peek
# print(egg.rf_1)
# 
# split <- egg.rf_1$splits
# write.csv(split, paste0("C:/Users/tim.brandon/OneWorkplace/Decisions Science - Documents/3. Audience and Agility/Client Work/Noble Foods/2022 Happy Eggs Segmentation/Recreation/RF/split2.csv"), row.names = T)
# 
# 
# #Create a decision tree using only variables with large (relative) importance, minunim bucket size 100
# egg.rf_2<-rpart(ccluster~
#                   sustainability_prepared_pay_environmental_products + 
#                   lifestyle_diet_bake_frequency + statements_interests_animals + 
#                   demo_age + sustainability_prefer_organic_natural_foods + 
#                   sustainability_too_much_environment_concern + sustainability_only_worth_saves_money + 
#                   lifestyle_diet_concerns_organic + lifestyle_diet_future + supermarket_budge_not + 
#                   lifestyle_exercise_frequency + supermarket_waitr_not
#                 ,data=survey_yg,minbucket=100)
# 
# #Create a pruned tree with the minimum error
# egg.rf_2<- prune(egg.rf_2, cp=   egg.rf_2$cptable[which.min(egg.rf_2$cptable[,"xerror"]),"CP"])
# 
# #plot the tree
# plot(egg.rf_1, uniform=TRUE, main="NSPCC Tree 1")
# text(egg.rf_1, use.n=TRUE, all=TRUE, cex=.8)
# print(egg.rf_1)
# 
# #plot the tree
# plot(egg.rf_2, uniform=TRUE, main="NSPCC Tree 1")
# text(egg.rf_2, use.n=TRUE, all=TRUE, cex=.8)
# print(egg.rf_2)

fancyRpartPlot(egg.rf_A,main="Egg ALL",cex=0.5)

#1 test
testset_1 <- survey_yg
testset_1$cluster <- ifelse(testset_1$ccluster=="1",1,0)
testset_1 <- subset(testset_1, select=-c(ccluster))
egg.rf_1 <- rpart(cluster ~ .,data=testset_1,method = "class", maxdepth=30)
fancyRpartPlot(egg.rf_1,main="Egg 1")

testset_2 <- survey_yg
testset_2$cluster <- ifelse(testset_2$ccluster=="2",1,0)
testset_2 <- subset(testset_2, select=-c(ccluster))
egg.rf_2 <- rpart(cluster ~ .,data=testset_2,method = "class", maxdepth=30)
fancyRpartPlot(egg.rf_2,main="Egg 2")

testset_3 <- survey_yg
testset_3$cluster <- ifelse(testset_3$ccluster=="3",1,0)
testset_3 <- subset(testset_3, select=-c(ccluster))
egg.rf_3 <- rpart(cluster ~ .,data=testset_3,method = "class", maxdepth=30)
fancyRpartPlot(egg.rf_3,main="Egg 3")

testset_4 <- survey_yg
testset_4$cluster <- ifelse(testset_4$ccluster=="4",1,0)
testset_4 <- subset(testset_4, select=-c(ccluster))
egg.rf_4 <- rpart(cluster ~ .,data=testset_4,method = "class", maxdepth=30)
fancyRpartPlot(egg.rf_4,main="Egg 4")

testset_5 <- survey_yg
testset_5$cluster <- ifelse(testset_5$ccluster=="5",1,0)
testset_5 <- subset(testset_5, select=-c(ccluster))
egg.rf_5 <- rpart(cluster ~ .,data=testset_5,method = "class", maxdepth=30)
fancyRpartPlot(egg.rf_5,main="Egg 5",cex=0.5)

testset_6 <- survey_yg
testset_6$cluster <- ifelse(testset_6$ccluster=="6",1,0)
testset_6 <- subset(testset_6, select=-c(ccluster))
egg.rf_6 <- rpart(cluster ~ .,data=testset_6,method = "class", maxdepth=30)
fancyRpartPlot(egg.rf_6,main="Egg 6")

#3 and 5 split
testset_35 <- subset(survey_yg, ccluster %in% c('3','5'))
egg.rf_35 <- rpart(ccluster ~ .,data=testset_35,method = "class", maxdepth=30)
fancyRpartPlot(egg.rf_35,main="Egg 3 v 5",cex=0.7)

#1 and 4 split
testset_14 <- subset(survey_yg, ccluster %in% c('1','4'))
egg.rf_14 <- rpart(ccluster ~ .,data=testset_14,method = "class", maxdepth=30)
fancyRpartPlot(egg.rf_14,main="Egg 1 v 4",cex=0.7)

#2 and 6 split
testset_26 <- subset(survey_yg, ccluster %in% c('2','6'))
egg.rf_26 <- rpart(ccluster ~ .,data=testset_26,method = "class", maxdepth=30)
fancyRpartPlot(egg.rf_26,main="Egg 2 v 6",cex=0.7)
