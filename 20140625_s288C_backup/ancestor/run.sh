#!/bin/sh
echo "This is a script"
#module load bwa
#remove anything from reference directory that isn't the fasta file (indexes)
rm -rf reference/*.fa.*


############################
#defines varaibles needed for alignment
read1=$(pwd)/reads/*R1_001.fastq
read2=$(pwd)/reads/*R2_001.fastq
ref=$(pwd)/reference/*.fa

head $ref


################################
#Align PE reads to reference genome and make sorted BAM file of alignment
bwa index $ref
mkdir alignment

echo $read1
echo $read2

#bwa align in format outlined by GATK
bwa mem -M -R '@RG\tID:Sample_WS\tSM:sample1\tPL:illumina\tLB:lib1\tPU:unit1' $ref $read1 $read2 > alignment/aligned_reads.sam

cd alignment
samtools view -bS aligned_reads.sam | samtools sort - aligned_reads.sorted

cd ..



###################################

#Call SNPs and small indels with GATK

cp alignment/aligned_reads.sam GATK/
cp $ref GATK/reference.fa


cd GATK
echo 'running GATK....'
sbatch -O run_GATK.sh
cd ..


###############################
# run pindel to detect structural variants


cd pindel
echo 'Running pindel....'
cp ../alignment/aligned_reads.sorted.bam .
cp ../reference/*.fa  reference.fa
sbatch -n 1 -c 1 run_pindel.sh
cd ..

#################################################
#run splitread to detect structural variants
echo 'Running Splitread...'

cd splitread

sbatch -n 1 -c 1 run_splitread.sh $read1 $read2 $ref
cd ..

##################################################
# compute whole chromosomal coverage (to detect duplications/deletions)
echo 'Calculating Coverage and Plotting...'
samtools mpileup -f $ref alignment/aligned_reads.sorted.bam > coverage/sample.pileup
cd coverage
python sliding_window.py sample.pileup >coverage.txt
#python cull_rRNA.py sample.pileup>sample.rRNAculled.pileup
#python get_coverage.py sample.rRNAculled.pileup >coverage.csv
Rscript coverage_plots.R
cd ../






echo 'End'

