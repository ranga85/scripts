################################################################## 
# Usage: Rscript DMR-Bsseq-script.R 
# Input: Tab delimited file of methylation counts (chr,position,number of reads mapped, number of methylated cytosines)
# Output: Tab delimited file i.e DMR regions  
# Installation: 
# source("https://bioconductor.org/biocLite.R")
# biocLite("DSS")
# biocLite("bsseq")
###################################################################

library(DSS)
require(bsseq)
dat1 <- read.table("Input file with for Control sample for CG,CHG and CHH seperately", header=TRUE)
dat2 <- read.table("Input file with for Treated sample for CG,CHG and CHH seperately", header=TRUE)

# read BS seq data into bsseq object
BSobj.CG <- makeBSseqData( list(dat1, dat2),c("Control","Treated") ) 
BSobj.CHG <- makeBSseqData( list(dat1, dat2),c("Control","Treated") ) 
BSobj.CHH <- makeBSseqData( list(dat1, dat2),c("Control","Treated") ) 

# Test for differentially methylated loci 

dmlTest.CG <- DMLtest(BSobj.CG, group1=c("Control"), group2=c("Treated"),smoothing = TRUE) 
head(dmlTest.CG)
dmlTest.CHG <- DMLtest(BSobj.CHG, group1=c("Control"), group2=c("Treated"),smoothing = TRUE)
head(dmlTest.CHG)
dmlTest.CHH <- DMLtest(BSobj.CHH, group1=c("Control"), group2=c("Treated"),smoothing = TRUE)
head(dmlTest.CHH)

# Call differentially methylated regions
dmrs2.CG <- callDMR(dmlTest.CG, delta=0.1, p.threshold=0.05,minlen = 100,minCG = 10,dis.merge = 100)
dmrs2.CHG <- callDMR(dmlTest.CHG, delta=0.1, p.threshold=0.05,minlen = 100,minCG = 10,dis.merge = 100)
dmrs2.CHG <- callDMR(dmlTest.CHH, delta=0.1, p.threshold=0.05,minlen = 100,minCG = 10,dis.merge = 100)

# write result to output file in tab delimited format
write.table(dmrs2.CG,"Path to write DMR output",quote=FALSE,sep = "\t",row.names = FALSE)
