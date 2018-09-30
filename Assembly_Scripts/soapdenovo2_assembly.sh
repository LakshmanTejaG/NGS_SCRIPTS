########################################################################################################
############### **soap.conf file for Genome Denovo Assembly** ##########################################
########################################################################################################
##maximal read length
max_rd_len=101
[LIB]
#average insert size
avg_ins=450
#if sequence needs to be reversed
reverse_seq=0
#in which part(s) the reads are used
asm_flags=3
#use only first 100 bps of each read
rd_len_cutoff=100
#in which order the reads are used while scaffolding
rank=1
# cutoff of pair number for a reliable connection (at least 3 for short insert size)
pair_num_cutoff=3
#minimum aligned length to contigs for a reliable read location (at least 32 for short insert size)
map_len=32
#a pair of fastq file, read 1 file should always be followed by read 2 file
q1=/home/lakshmanteja/NGS_ANALYSIS/NGS_Practise/SOAPdenovo/mito_reads_pe1.fastq
q2=/home/lakshmanteja/NGS_ANALYSIS/NGS_Practise/SOAPdenovo/mito_reads_pe2.fastq
#########################################################################################################

## SoapDenovo2 Command to Run:
soapdenovo2-63mer all -s soap.conf -o assembly -K 35 -p 2 -N 16600 -V
