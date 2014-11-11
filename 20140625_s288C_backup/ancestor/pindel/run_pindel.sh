#!/bin/sh

samtools faidx reference.fa
samtools index aligned_reads.sorted.bam
/fh/fast/shou_w/bin/Robin/pindel/pindel -f reference.fa -i configure -c ALL -o SeqPESample