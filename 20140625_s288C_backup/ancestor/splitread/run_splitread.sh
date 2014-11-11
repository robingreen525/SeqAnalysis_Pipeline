#!/bin/sh

echo $1
echo $2
ref=$3
echo $ref
echo $ref.fai

samtools faidx $ref
/fh/fast/shou_w/bin/Robin/mrsfast/mrsfast-2.6.0.4/mrsfast --index $ref

echo 'Merging Files....'
./mixcatnewHeader -f $1 -r $2 >newheader.fastq

echo 'Splitting reads'
mkdir splits
split -l 200000 newheader.fastq splits/reads.

cd splits

mkdir trimmed

ls |while read i; do /fh/fast/shou_w/bin/Robin/Splitread2/Pipeline2/bin/Readtrimmer -i $i -o trimmed/$i.trim -l 148 ; echo $i; done;

cd trimmed

rm trimmed.trim

ls| while read i; do echo $i;/fh/fast/shou_w/bin/Robin/Splitread2/Pipeline2/bin/SplitReadAll_lite -ref $ref -len 148 -ed 4 -ed2 2 -u 500 -l 100 -m 10000000  -refai  $ref.fai -seq $i -out $i.map -outunmap $i.unmapped -outdir $i.match -path /fh/fast/shou_w/bin/Robin/Splitread2/Pipeline2/bin/ -mrsfast /fh/fast/shou_w/bin/Robin/mrsfast/mrsfast-2.6.0.4/ -samtools /app/bin/ ;done;

mkdir results

cat *.match.pair.discordand.txt >results/sample.match.pair.discordant.txt

rm -rf reads*
cd ../
rm -rf reads*

cd trimmed/results/
python /fh/fast/shou_w/bin/Robin/user_scripts/splitread_pipeline/bin_total.py sample.match.pair.discordant.txt > sample.bins
python /fh/fast/shou_w/bin/Robin/user_scripts/splitread_pipeline/get_raw_input_from_targets.py sample.bins sample.match.pair.discordant.txt >sample.binned.events
python /fh/fast/shou_w/bin/Robin/user_scripts/splitread_pipeline/get_unqiue_call_reads.py sample.binned.events > sample.unique.bins








echo 'End'