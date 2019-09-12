# Volcanoplot with multiple annotations


library(ggplot2)
library(reshape)

fcdmr <- read.table("~/Dropbox/musa-meth-v2/dmr/musa-dmr-fc-gene-vplot-V1.txt", header=TRUE)
#fcdmr0 <- subset(fcdmr,fcdmr$FC!="NA")
fcdmr1 <- melt(fcdmr)
fcdmr2 <- subset(fcdmr1,fcdmr1$variable!="Non.DMR")

#########Define variables for x and y-axis #######
x <- c(2,2,2,2)
y <- c(0,20,40,100)
a <- c(-2,-2,-2,-2)# represents p = 0.1
b <- c(0,20,40,100)
line1 <- data.frame(x,y)
line2 <- data.frame(a,b)

######### Plot ##############
png("volcanoplot.png",12,8,res = 300,units = "in")
par(mfrow=c(1,1))
with(fcdmr, plot(FC,-log10(q.value), pch=20, cex = 0.7, col = "gray",ylim=range(0,100),
                 ylab = "-log10(qvalue)", xlab = "log2(foldchange)"))
with(subset(fcdmr,type == "UT"), points(FC,-log10(q.value), pch = 20, cex = 0.4, col = "darkgray"))
with(subset(fcdmr,type == "ST"), points(FC,-log10(q.value), pch = 20, cex = 0.4, col = "black"))

with(subset(fcdmr,q.value <= 0.05 & FC >= 2 & type == "ST"), points(FC,-log10(q.value), pch = 17, cex = 1, col = "red"))
with(subset(fcdmr,q.value <= 0.05 & FC <= -2 & type == "ST"), points(FC,-log10(q.value), pch = 17, cex = 1, col = "red"))

with(subset(fcdmr,q.value <= 0.05 & FC >= 2 & type == "UT"), points(FC,-log10(q.value), pch = 17, cex = 1, col = "orange"))
with(subset(fcdmr,q.value <= 0.05 & FC <= -2 & type == "UT"), points(FC,-log10(q.value), pch = 17, cex = 1, col = "orange"))

lines(line1, col = "red", lwd = 1, lty=2)
lines(line2, col = "red", lwd =1, lty =2 )
legend("topleft", legend=c("UT-DMR", "ST-DMR"), col=c("orange", "red"), pch = 17, cex=0.8,title = "DE-genes")
legend("topright", legend=c("UT-DMR", "ST-DMR","Non-DMR"), col=c("darkgray", "black","gray"), pch = 20, cex=0.8,title = "Non-DE genes")
dev.off()