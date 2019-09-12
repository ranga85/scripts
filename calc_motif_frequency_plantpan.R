library(plyr)
library(dplyr)

out_directory <- "Input folder name from with files from plantpan promoter analysis" # Read all files from the folder 
setwd(out_directory)
file_list <- list.files()
#list.data <- lapply(file_list, read.delim,header=FALSE)
list.data <- lapply(file_list,function(i){read.table(i, header=FALSE,sep = "\t") })# Read each file in directory
names(list.data)<- as.character(file_list) # Assigns filenames
PA <- ldply(list.data, data.frame) # Arranges all files data into one dataframe
motif.count <- count(PA,V1,V3) # Counts based on miRNA and TF family motifs
#motif.filter <- subset(motif.count,n >= 4) # filters motifs with more than 4 frequency  (Run if required)
motif.freq <- aggregate(n ~ V1 + V3, data = motif.count, sum) # Sums the motif frequency based on TF family and miRNA

# Splits data frame based on miRNA and assigns frequency to each TF family
motif.split <- split(motif.freq , f = motif.freq$V1) 
motif.lap <- lapply(motif.split,function(x) x[(names(x) %in% c("V3", "n"))])

merge.all <- function(x, y) {
  merge(x, y, all=TRUE, by="V3")  
}
# Merges all data frame into single dataframe and gives column names 
motif.merge <- Reduce(merge.all, motif.lap)
col_list <- c("Motif",file_list)
colnames(motif.merge)[1:ncol(motif.merge)]<- col_list
motif.merge[is.na(motif.merge)] <- 0

# Write output in tab delimited format
write.table(motif.merge,file="Path of output file",sep="\t",quote = FALSE,row.names = FALSE)