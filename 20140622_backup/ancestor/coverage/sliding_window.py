import sys
import numpy
#import statistics as stats

f=open(sys.argv[1])
#print 'Reading file...'
#print 'Opening file..'
ll=f.readlines()

chrom_len={}
chrom_depth={}
#contigs=[]

contigs=[]
Supercontig_1=[]
Supercontig_2=[]
Supercontig_3=[]
Supercontig_4=[]
Supercontig_5=[]
Supercontig_6=[]
Supercontig_7=[]
Supercontig_8=[]
Supercontig_9=[]
Supercontig_10=[]
Supercontig_11=[]
Supercontig_12=[]
Supercontig_13=[]
Supercontig_14=[]
Supercontig_15=[]
Supercontig_16=[]
Supercontig_17=[]

contigs.append(Supercontig_1)
contigs.append(Supercontig_2)
contigs.append(Supercontig_3)
contigs.append(Supercontig_4)
contigs.append(Supercontig_5)
contigs.append(Supercontig_6)
contigs.append(Supercontig_7)
contigs.append(Supercontig_8)
contigs.append(Supercontig_9)
contigs.append(Supercontig_10)
contigs.append(Supercontig_11)
contigs.append(Supercontig_12)
contigs.append(Supercontig_13)
contigs.append(Supercontig_14)
contigs.append(Supercontig_15)
contigs.append(Supercontig_16)
contigs.append(Supercontig_17)



for line in ll:
	line=line.split()
	if line[0]=='Supercontig_1.17':
		Supercontig_17.append(line)
	if line[0]=='Supercontig_1.1':
		Supercontig_1.append(line)
	if line[0]=='Supercontig_1.2':
		Supercontig_2.append(line)
	if line[0]=='Supercontig_1.3':
		Supercontig_3.append(line)
	if line[0]=='Supercontig_1.4':
		Supercontig_4.append(line)
	if line[0]=='Supercontig_1.5':
		Supercontig_5.append(line)
	if line[0]=='Supercontig_1.6':
		Supercontig_6.append(line)	
	if line[0]=='Supercontig_1.7':
		Supercontig_7.append(line)	
	if line[0]=='Supercontig_1.8':
		Supercontig_8.append(line)
	if line[0]=='Supercontig_1.9':
		Supercontig_9.append(line)
	if line[0]=='Supercontig_1.10':
		Supercontig_10.append(line)
	if line[0]=='Supercontig_1.11':
		Supercontig_11.append(line)
	if line[0]=='Supercontig_1.12':
		Supercontig_12.append(line)
	if line[0]=='Supercontig_1.13':
		Supercontig_13.append(line)
	if line[0]=='Supercontig_1.14':
		Supercontig_14.append(line)
	if line[0]=='Supercontig_1.15':
		Supercontig_15.append(line)
	if line[0]=='Supercontig_1.16':
		Supercontig_16.append(line)
		
		
# for line in ll:
# 	line=line.split()
# 	if line[0] not in contigs.keys():
# 		contigs[line[0]]=[]
# 		contigs[line[0]].append(line)
# 	else:
# 		contigs[line[0]].append(line)
		
		
for contig in contigs:
	length=len(contig)
	cov_bins=numpy.array([])
	#for i in range(length-10000):
	i=0
	while i<length-10000:
		start=i
		end=i+10000
		#print contig[i]
		#print start,end
		cov=0
		for j in range(start,end):
			temp=contig[j]
			cov+=int(temp[3])
		cov_bins=numpy.append(cov_bins,float(cov/10000))
		#print cov_bins
		#print i, length-10000,cov/10000, float(i)/float((length-10000))*100.0,'%',contig[0][0]
		i+=1
		#i+=10000 # REMOVE THIS TO RETURN TO SLIDING WINDOW	
		
	print contig[0][0],numpy.mean(cov_bins),numpy.std(cov_bins)
#print stats.mean(cov_bins)



