import sys
import numpy
#import statistics as stats

f=open(sys.argv[1])
#print 'Reading file...'
#print 'Opening file..'
ll=f.readlines()

chrom_len={}
chrom_depth={}

contigs=[]
chrI=[]
chrII=[]
chrIII=[]
chrIV=[]
chrV=[]
chrVI=[]
chrVII=[]
chrVIII=[]
chrIX=[]
chrX=[]
chrXI=[]
chrXII=[]
chrXIII=[]
chrXIV=[]
chrXV=[]
chrXVI=[]


contigs.append(chrI)
contigs.append(chrII)
contigs.append(chrIII)
contigs.append(chrIV)
contigs.append(chrV)
contigs.append(chrVI)
contigs.append(chrVII)
contigs.append(chrVIII)
contigs.append(chrIX)
contigs.append(chrX)
contigs.append(chrXI)
contigs.append(chrXII)
contigs.append(chrXIII)
contigs.append(chrXIV)
contigs.append(chrXV)
contigs.append(chrXVI)




for line in ll:
	line=line.split()
	if line[0]=='chrI':
		chrI.append(line)
	if line[0]=='chrIV':
		chrIV.append(line)
	if line[0]=='chrVII':
		chrVIII.append(line)
	if line[0]=='chrXV':
		chrXV.append(line)
	if line[0]=='chrXVI':
		chrXVI.append(line)
	if line[0]=='chrXIII':
		chrXIII.append(line)
	if line[0]=='chrII':
		chrII.append(line)	
	if line[0]=='chrXIV':
		chrXIV.append(line)	
	if line[0]=='chrX':
		chrX.append(line)
	if line[0]=='chrXI':
		chrXI.append(line)
	if line[0]=='chrXII':
		chrXII.append(line)
	if line[0]=='chrV':
		chrV.append(line)
	if line[0]=='chrVIII':
		chrVIII.append(line)
	if line[0]=='chrIX':
		chrIX.append(line)
	if line[0]=='chrIII':
		chrIII.append(line)
	if line[0]=='chrVI':
		chrVI.append(line)
		
		
		
		
		
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



