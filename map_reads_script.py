###########################################################
# Usage : map_reads_script.py input file > output.fasta
# input file = Length,abundance and sequence tab delimited format
# Output file = miRNA matches in fasta format
#
#######################################################################
from Bio import SeqIO
import csv
import sys

readFile = sys.argv[1]             # Read input from command line  

it = SeqIO.parse(open('Non-redundant miRBase/PMRD miRNA in fasta format'),'fasta') # 

nrD = {}
for rec in it: 
  nrD[rec.seq.tostring()] = rec.id              # Creating ids for matching reads and identifies 5' and 3' pairing.
nrD[rec.seq.tostring()[1:]] = rec.id+'_5pdg' 
nrD[rec.seq.tostring()[:-1]] = rec.id+'_3pdg'

linkedMature = ' '.join(nrD.keys())             
print linkedMature               

reader = csv.reader(open(readFile,'rU'), delimiter='\t')         # Read input file

for line in reader:
  length,  count,  seq = line                                  
seq = seq.replace('T', 'U')                                    
if seq in linkedMature:
  
  try:
  print '>%s %s'%(nrD[seq], count)                     # print match sequence in fasta format
print seq
except KeyError:
  pass
