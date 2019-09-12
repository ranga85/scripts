# Heatmap for frequency matrix 

#install.packages("ComplexHeatmap")
#install.packages("preprocessCore")
#install.packages("circlize")

library(ComplexHeatmap)
library(preprocessCore)
library(circlize)


TF.freq <- as.matrix(read.table(file="",sep="\t",header=TRUE,row.names = 1))
miRNA.class <- read.table(file="",sep="\t",header = TRUE)
TF.class <- read.table(file="",sep="\t",header = TRUE)

TF.norm <- normalize.quantiles(TF.freq,copy = TRUE)
colnames(TF.norm) <- colnames(TF.freq)
rownames(TF.norm) <- rownames(TF.freq)

hmap <- Heatmap(TF.freq,cluster_columns = FALSE,cluster_rows = FALSE,name="Frequency", 
                clustering_method_rows = "complete",clustering_distance_rows = "pearson",
                row_names_gp = gpar(fontsize = 12),column_names_gp =  gpar(fontsize = 12), bottom_annotation = hcol,row_names_side = "left")

hcol <- columnAnnotation(df=miRNA.class,width = unit(1, "cm"))
hrow <- rowAnnotation(df=TF.class,width = unit(1, "cm"))

png(filename = "",20,18,res=300,units="in")
hmap + hrow
dev.off()