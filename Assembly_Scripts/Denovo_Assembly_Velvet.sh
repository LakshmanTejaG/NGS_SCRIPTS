#Velveth for graph generation for kmer:
~/NGS_SOFTWARE_TOOLS/ASSEMBLY/velvet_1.2.10/velveth K-mer 79 -fastq -shortPaired -separate ERR162499_1_HQ.fastq ERR162499_2_HQ.fastq -short unPaired_HQReads
#Velvetg to assemble and generate contigs for kmer:
~/NGS_SOFTWARE_TOOLS/ASSEMBLY/velvet_1.2.10/velvetg K-mer -ins_length 200 -ins_length_sd 50 -scaffolding yes -cov_cutoff 10 -min_contig_lgth 300 -read_trkg yes
