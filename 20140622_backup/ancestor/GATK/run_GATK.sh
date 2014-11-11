#!/bin/sh
#UPDATED by RJG on 2014-06-22 to change minumum read depth needed to call snps (20->10). Minimum qualtity score unchanged (200->200)
export PERL5LIB=/fh/fast/shou_w/bin/Robin/vcftools/vcftools_0.1.11/perl/
#picard commands to generate bam files,sorted with duplicated reads masked
java -jar /fh/fast/shou_w/bin/Robin/picard/picard-tools-1.104/SortSam.jar I=aligned_reads.sam O=sorted_reads.bam SO=coordinate
java -jar /fh/fast/shou_w/bin/Robin/picard/picard-tools-1.104/MarkDuplicates.jar I=sorted_reads.bam O=dedup_reads.bam M=metrics.txt
java -jar /fh/fast/shou_w/bin/Robin/picard/picard-tools-1.104/BuildBamIndex.jar I=dedup_reads.bam 


samtools faidx reference.fa
java -jar /fh/fast/shou_w/bin/Robin/picard/picard-tools-1.104/CreateSequenceDictionary.jar R=reference.fa O=reference.dict



#indel relaignment
# had to download java 1.7, in the Robin folder of Shou_W bin
/fh/fast/shou_w/bin/Robin/java_1.7/jre1.7.0_45/bin/java -jar /fh/fast/shou_w/bin/Robin/GATK/GenomeAnalysisTK.jar -T RealignerTargetCreator -R reference.fa -I dedup_reads.bam  -o target_intervals.list 


# INFO  00:12:30,349 ProgressMeter - Total runtime 129.29 secs, 2.15 min, 0.04 hours 
# INFO  00:12:30,468 MicroScheduler - 2745137 reads were filtered out during the traversal out of approximately 12154239 total reads (22.59%) 
# INFO  00:12:30,469 MicroScheduler -   -> 0 reads (0.00% of total) failing BadCigarFilter 
# INFO  00:12:30,469 MicroScheduler -   -> 4778 reads (0.04% of total) failing BadMateFilter 
# INFO  00:12:30,469 MicroScheduler -   -> 532531 reads (4.38% of total) failing DuplicateReadFilter 
# INFO  00:12:30,469 MicroScheduler -   -> 0 reads (0.00% of total) failing FailsVendorQualityCheckFilter 
# INFO  00:12:30,469 MicroScheduler -   -> 0 reads (0.00% of total) failing MalformedReadFilter 
# INFO  00:12:30,470 MicroScheduler -   -> 0 reads (0.00% of total) failing MappingQualityUnavailableFilter 
# INFO  00:12:30,470 MicroScheduler -   -> 2207828 reads (18.17% of total) failing MappingQualityZeroFilter 
# INFO  00:12:30,470 MicroScheduler -   -> 0 reads (0.00% of total) failing NotPrimaryAlignmentFilter 
# INFO  00:12:30,470 MicroScheduler -   -> 0 reads (0.00% of total) failing Platform454Filter 
# INFO  00:12:30,470 MicroScheduler -   -> 0 reads (0.00% of total) failing UnmappedReadFilter 
# INFO  00:12:31,678 GATKRunReport - Uploaded run statistics report to AWS S3 


#problem starts at this step

#realign indel areas
/fh/fast/shou_w/bin/Robin/java_1.7/jre1.7.0_45/bin/java -jar /fh/fast/shou_w/bin/Robin/GATK/GenomeAnalysisTK.jar -T IndelRealigner -R reference.fa -I dedup_reads.bam -targetIntervals target_intervals.list -o realigned_reads.bam  
# GATK recommends that I generated a vcf file on uncalibrated data, filter snp calls based on what I am 
# comfortable with (I'll use vcf tools), and then use this vcf file as the SNP database. This can be interated 
# until the SNP calls don't change

#call SNPs with uncalibrated reads 
/fh/fast/shou_w/bin/Robin/java_1.7/jre1.7.0_45/bin/java -jar /fh/fast/shou_w/bin/Robin/GATK/GenomeAnalysisTK.jar -T UnifiedGenotyper -R reference.fa -I realigned_reads.bam -ploidy 1  -glm BOTH   -stand\_emit\_conf 10  -stand\_call\_conf 30  -o raw_haploid_variants_notcalibrated.vcf 
#filter vcf files (minimum quality 200 at depth of 20 reads)
/fh/fast/shou_w/bin/Robin/vcftools/vcftools_0.1.11/bin/vcf-annotate --filter Qual=200/MinDP=10 raw_haploid_variants_notcalibrated.vcf >raw_haploid_variants_notcalibrated_filtered.vcf

#round1
/fh/fast/shou_w/bin/Robin/java_1.7/jre1.7.0_45/bin/java -jar /fh/fast/shou_w/bin/Robin/GATK/GenomeAnalysisTK.jar -T BaseRecalibrator -R reference.fa -I realigned_reads.bam  -knownSites raw_haploid_variants_notcalibrated_filtered.vcf -o recal_data.table
/fh/fast/shou_w/bin/Robin/java_1.7/jre1.7.0_45/bin/java -jar /fh/fast/shou_w/bin/Robin/GATK/GenomeAnalysisTK.jar -T BaseRecalibrator -R reference.fa -I realigned_reads.bam  -knownSites raw_haploid_variants_notcalibrated_filtered.vcf -BQSR recal_data.table  -o post_recal_data.table 
#having trouble using the plot funtion to make before and after plots(something to do with visualization)
/fh/fast/shou_w/bin/Robin/java_1.7/jre1.7.0_45/bin/java -jar /fh/fast/shou_w/bin/Robin/GATK/GenomeAnalysisTK.jar -T PrintReads -R reference.fa -I realigned_reads.bam -BQSR recal_data.table -o recal_reads.bam


/fh/fast/shou_w/bin/Robin/java_1.7/jre1.7.0_45/bin/java -jar /fh/fast/shou_w/bin/Robin/GATK/GenomeAnalysisTK.jar -T UnifiedGenotyper -R reference.fa -I recal_reads.bam -ploidy 1  -glm BOTH   -stand\_emit\_conf 10  -stand\_call\_conf 30  -o round1.vcf
