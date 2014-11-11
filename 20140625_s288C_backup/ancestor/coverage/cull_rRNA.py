import sys

f=open(sys.argv[1],'r')

ll=f.readlines()

for line in ll:
    line1=line
    line=line.split()
    if line[0]=='Supercontig_1.13' or line[0]=='Supercontig_1.10':
        if int(line[3])>1000:
            print line[0],line[1],line[2],100,line[4],line[5]
        else:
            print line1.rstrip('\n')
    else:
        print line1.rstrip('\n')

