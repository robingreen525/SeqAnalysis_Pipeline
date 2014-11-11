
#getpackage
source("http://bioconductor.org/biocLite.R")
#biocLite("cn.mops")
library("cn.mops")

#setwd('bam_files/')

BAMFiles<-list.files(/shared/silo_researcher/Shou_W/Robin_Code/full_pipeline/cn.mops_model/bam_files)

#setwd('')

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.1')
res1<-haplocn.mops(bamDataRanges) 

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.2')
res2<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.3')
res3<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.4')
res4<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.5')
res5<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.6')
res6<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.7')
res7<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.8')
res8<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.9')
res9<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.10')
res10<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.11')
res11<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.12')
res12<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.13')
res13<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.14')
res14<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.15')
res15<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.16')
res16<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='Supercontig_1.17')
res17<-haplocn.mops(bamDataRanges)

save.image('haplo.RdData')
