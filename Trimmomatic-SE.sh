#!/usr/bin/bash 
### Trimmomatic for Sigle END Reads ####
Trimmomatic_Adapters=/home/lakshmanteja/NGS_SOFTWARE_TOOLS/QC/Trimmomatic-0.38/adapters
$Trimmomatic SE -phred33 \
reads_1.fastq.gz \
reads_1_clean.fastq.gz \
ILLUMINACLIP:${Trimmomatic_Adapters}/TruSeq3-SE.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36


