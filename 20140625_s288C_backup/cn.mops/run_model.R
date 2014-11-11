
#getpackage
source("http://bioconductor.org/biocLite.R")
biocLite("cn.mops")
library("cn.mops")

setwd('bam_files/')

BAMFiles<-list.files()


bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrIV')
res4<-haplocn.mops(bamDataRanges) 

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrVII')
res7<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrXV')
res15<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrXVI')
res16<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrXIII')
res5<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrII')
res2<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrXIV')
res14<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrX')
res10<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrXI')
res11<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrXII')
res12<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrV')
res5<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrVIII')
res8<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrIX')
res9<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrIII')
res3<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrVI')
res6<-haplocn.mops(bamDataRanges)

bamDataRanges<-getReadCountsFromBAM(BAMFiles,sampleNames=BAMFiles,mode='paired',refSeqName='chrI')
res1<-haplocn.mops(bamDataRanges)

save.image('haplo_model.RdData')
