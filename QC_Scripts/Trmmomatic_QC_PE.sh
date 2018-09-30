#/usr/bin/bash
echo "Trimmomatic QC Running...." ;
Trimmomatic_Adapters=/home/lakshmanteja/NGS_SOFTWARE_TOOLS/QC/Trimmomatic-0.38/adapters/
$Trimmomatic PE -phred33 \
ERR162499_1.fastq \
ERR162499_2.fastq \
ERR162499_1_Paired.fastq ERR162499_1_Unpaired.fastq \
ERR162499_2_Paired.fastq ERR162499_2_Unpaired.fastq \
ILLUMINACLIP:${Trimmomatic_Adapters}/TruSeq3-PE.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
echo "Trimmomatic QC Completed Successfully!" ;
