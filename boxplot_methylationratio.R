library("ggplot2")
library("reshape")

one.dat <-  read.table(file="Path to inputfile",sep="\t",header=TRUE)

one.m <- melt(one.dat)

one.plot <- ggplot(data = one.m,aes(x=variable,y=value,fill=X)) + geom_boxplot(position = "dodge") + 
  theme_classic() + xlab("") +  ylab("Relative methylation ratio") + 
  theme(axis.title.x=element_blank(),legend.title=element_blank(),axis.text.x = element_text(angle = 45, hjust = 1)) + 
  scale_fill_brewer(palette = "Set1")  

png(filename = "Path to output png file",10,3.5,res=300,units="in")
one.plot
dev.off()