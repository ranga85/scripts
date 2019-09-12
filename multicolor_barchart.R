## Multi color bar chart with variables more than 12.

#install.packages(ggplot2)
#install.packages(rwantshue)
#install.packages(reshape)

library("ggplot2")
library('rwantshue')
library("reshape")
# read file tab delimited file 
# Input file as matrix of frequency
##
miRNApre <- read.table(file="",sep="\t",header=TRUE)

# Reformat dataframe for plotting
miRNApre.m <- melt(miRNApre)

# Assign colors for all the variables
cols <- colorRampPalette(brewer.pal(12, "Dark2"))
myPal <- cols(length(unique(miRNApre.m$variable)))

# create a color scheme object
scheme <- iwanthue()
# generate a new color palette (vector of hex values) with presets...
scheme$hex(21)

#plot bar chart 
miRNA.plot <- ggplot(data=miRNApre.m, aes(x=X, y=value,fill=variable)) + 
  geom_bar(stat="identity") + 
  theme_classic() +
  scale_fill_manual(values = scheme$hex(21),name="miRNA") + xlab("chromosomes") + ylab("Number of precursor loci")

# Save figure in tiff format
png(filename = "",10,5,res=300,units="in")
miRNA.plot
dev.off()