######################################################################
# Usage : mac_promoter_extraction_genome.py 
#Retrieve 5' 2kb upstream region of miRNA precursor
#######################################################################
from Bio import SeqIO
from Bio.Seq import Seq
outfile=open("miRNA_promoter_using_genome.fasta","w") # the output file

for rec1 in SeqIO.parse("precursors.fa","fasta"):#Input file precursor file name in fasta format 
  T=True
print rec1.description
for rec2 in SeqIO.parse("genome.fa","fasta"): #the genome file name and format
  
  if str(rec1.seq).upper() in str(rec2.seq).replace("T","U"):
  T=False
n1=str(rec2.seq).replace("T","U").find(str(rec1.seq).upper())
n2=n1+len(str(rec1.seq))
outfile.write(">")
outfile.write(str(rec1.description)) 
outfile.write(" Promoter:")
#outfile.write(str(rec2.description))
outfile.write(str(n1-2000))
outfile.write("..")
outfile.write(str(n1))
#  outfile.write("(+)")
outfile.write("\n")
promoter = str(rec2.seq)[n1-2000:n1]
#  print promoter
outfile.write(str(promoter))
outfile.write("\n")
print "found on +"

rStrand=str(rec2.seq.complement()).replace("T","U")[::-1]
if str(rec1.seq).upper() in rStrand:
  T=False
n1=rStrand.find(str(rec1.seq).upper())
n2=n1+len(str(rec1.seq))
n11=len(rStrand)-n2
n22=len(rStrand)-n1
outfile.write(">")
outfile.write(str(rec1.description)) 
outfile.write(" Promoter:")
#outfile.write(str(rec2.description))
outfile.write(str(n22))
outfile.write("..")
outfile.write(str(n22+2000))
outfile.write("\n")
promoter = rStrand[n1-2000:n1]
#print promoter.replace("U","T")
outfile.write(str(promoter).replace("U","T"))
outfile.write("\n")
print "found on -"

if T:
  print "Not found! ******************** Not found!"
outfile.close()    
