library(dplyr)
library(eeptools)
library(ggplot2)
library(graphics)


setwd("~/afs/ing1/pbs1/tp2")
cbData <- read.csv(file = "Operations CB.csv",
                     sep = ",")
clientFile <- read.csv(file = "Fichier clients.csv",
                       sep = ",")

str(clientFile)

clientFile$Date_naissance = as.Date(clientFile$Date_naissance, format = '%d/%m/%Y')
clientFile$Age = floor(age_calc(clientFile$Date_naissance, as.Date('2021-06-01'), units = "years"))
mergedFile = left_join(clientFile,
                   (cbData %>% group_by(noCompte) %>% summarize(Total_Operation = sum(Operation), Count_Operation = n())),
                   by = "noCompte",
                   all = FALSE)

age <- cor.test(clientFile$Age, mergedFile$Total_Operation)
arrondissement <- chisq.test(clientFile$CP, mergedFile$Total_Operation)
genre <- chisq.test(clientFile$CIV, mergedFile$Total_Operation)

boxplot(mergedFile$Count_Operation ~ clientFile$Age)
boxplot(mergedFile$Total_Operation ~ clientFile$Age)

boxplot(mergedFile$Count_Operation ~ clientFile$CP)
boxplot(mergedFile$Total_Operation ~ clientFile$CP)
