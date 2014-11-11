install.packages('ggplot2',repos='http://cran.fhcrc.org/')
library(ggplot2)


chrom_conv<-list('Supercontig_1.1'='IV','Supercontig_1.2'='VII','Supercontig_1.3'='XV',
                 'Supercontig_1.4'='XVI','Supercontig_1.5'='XIII','Supercontig_1.6'='II',
                 'Supercontig_1.7'='XIV','Supercontig_1.8'='X','Supercontig_1.9'='XI',
                 'Supercontig_1.10'=12.1,'Supercontig_1.11'='V','Supercontig_1.12'='VIII',
                 'Supercontig_1.13'=12.2,'Supercontig_1.14'='IX','Supercontig_1.15'='III',
                 'Supercontig_1.16'='VI','Supercontig_1.17'='I',
                 'XII'='XII')

mytheme =   list(xlab("Chromosome"),ylab("Normalized Coverage"),theme(axis.text=element_text(size=15,color='black'),
                 axis.ticks=element_line(color='black'), panel.background=element_rect(color=NA,fill='white'),
                 panel.grid.major=element_line(color='white'),panel.grid.minor=element_line(color='white'),
                 panel.border=element_rect(color='black',fill=NA)))



cov<-read.table("coverage.txt",header=F,colClasses=c('character','numeric','numeric'))
rownames(cov)<-cov[,1]
cov1<-cov
print(cov1)

p<-c()
#for(i in 1:length(chrom_conv)){ print(chrom_conv[[i]])}

chrXII_cov=0
chrXII_err=0

for(i in cov1[,1])
{
  
  num<-(which(rownames(cov)==i))

  if ((num==10)|| (num==13))
  {
    chrXII_cov=chrXII_cov+(cov[num,2])
    chrXII_err=chrXII_err+(cov[num,3])
    
    
  }
  else
  {
    #temp<-c(chrom_conv[[i]],(cov[num,2]),(cov[num,3]))
    cov1[i,1]=chrom_conv[[i]]
    #print(temp)
    #p<-rbind(p,temp)
  }
 
}

cov1[10,1]='XII'
cov1[10,2]=(chrXII_cov)/2
cov1[10,3]=chrXII_err/2

cov1<-cov1[-13,]
p<-cov1

print(p)
z<-ggplot(p,aes(x=p[,1],y=p[,2]))+geom_point(size=6,color='navyblue',shape=15)+mytheme+ylim(0,75)+geom_errorbar(aes(ymin=p[,2]-p[,3],ymax=p[,2]+p[,3],width=0.2))
png(filename='coverage_plot.png')
print(z)
#dev.off()
  
