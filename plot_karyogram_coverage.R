# Rscript plot_karyogram_coverage.R 
# Karyogram plot for all chromosomes with coverage.
########################################

library(rtracklayer)
library(ggplot2)
library(ggbio) 
library(IRanges)
library(GenomicRanges)
library(Rsamtools)
library(gridExtra)

bed.ctr <- read.table(file="Path of input file",sep="\t", col.names = c("chrom", "chromStart", "chromEnd", "score","type")) # Bed file format or tab delimited file
musarepgff <- import.bed("annotations bed file") #Bed file for additional annotation


########## Convert to GRanges #########################

ctrbed.gr <- GRanges(seqnames = bed.ctr$chrom,ranges = IRanges(start=bed.ctr$chromStart,end = bed.ctr$chromEnd,),score=bed.ctr$score,type=bed.ctr$type)
musarepgff.gr <- as(musarepgff,"GRanges")  

######### Karyogram plot #########################

final.plot <- ggbio() + layout_karyogram(ctrbed.gr, geom="area", aes(x=start, y=score,fill=type),ylim=c(0,50)) + 
  scale_fill_brewer(palette="Dark2") +
  layout_karyogram(musarepchr1, geom = "rect",ylim = c(70, 100)) + 
  theme_genome() + 
  coord_flip() + 
  theme(legend.position="bottom",axis.text.x = element_blank(),axis.ticks.x = element_blank(),strip.text.x = element_text(colour = "black",size = 12),strip.background = element_blank(),axis.text.y = element_text(colour = "black",size = 10),legend.title = element_blank()) +
  labs(x=NULL,y=NULL) 

############# Save output in PNG format###########
png("path to output",10,3.5,res=300,units="in")
final.plot
dev.off()