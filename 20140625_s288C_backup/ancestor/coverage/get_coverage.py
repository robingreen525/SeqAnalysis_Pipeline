import sys

f=open(sys.argv[1])
#print 'Reading file...'
#print 'Opening file..'
ll=f.readlines()

chrom_len={}
chrom_depth={}


for line in ll:
	line=line.split()
	if line[0] not in chrom_len.keys():
		chrom_len[line[0]]=1
	else:
		chrom_len[line[0]]+=1
	if line[0] not in chrom_depth.keys():
		chrom_depth[line[0]]=float(line[3])
	else:
		chrom_depth[line[0]]+=float(line[3])
		
print 'Chrom',',','Coverage'


r = (chrom_depth['Supercontig_1.10'])/(chrom_len['Supercontig_1.10'])
n = (chrom_depth['Supercontig_1.13'])/(chrom_len['Supercontig_1.13'])
z = ((r+n)/2.0)

del chrom_len['Supercontig_1.10']
del chrom_len['Supercontig_1.13']



		
#print chrom_len['Supercontig_1.1'],chrom_depth['Supercontig_1.1'],chrom_depth['Supercontig_1.1']/float(chrom_len['Supercontig_1.1'])
for key in chrom_len.keys():
	#print  key,chrom_len[key],chrom_depth[key],chrom_depth[key]/float(chrom_len[key])
        
        print  key+',',chrom_depth[key]/float(chrom_len[key])

#r =(chrom_depth['Supercontig_1.10'])/(chrom_len['Supercontig_1.10'])
#n =(chrom_depth['Supercontig_1.13'])/(chrom_len['Supercontig_1.13'])

print 'XII,',z
