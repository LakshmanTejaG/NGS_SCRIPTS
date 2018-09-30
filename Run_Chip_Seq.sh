#Build Reference Genome Indexing
bowtie-build ./bowtie_index/dmel-all-chromosome-r6.21.fasta dmelanogaster

#Align Input Reads (TEST) to Reference
bowtie -v 2 --best -m 1 -S ../bowtie_index/dmelanogaster SRR390256.fastq aln_input.sam

#Align Chip Reads (CONTROL) to Reference
bowtie -v 2 --best -m 1 -S ../bowtie_index/dmelanogaster SRR390254.fastq aln_chip.sam

#SAM to BAM(Binary Aliment Map)
samtools view -bSo aln_chip.bam aln_chip.sam && samtools view -bSo aln_input.bam aln_input.sam

#Sorted BAM
samtools sort aln_chip.bam -o chip_sorted.bam && samtools sort aln_input.bam -o input_sorted.bam

#Indeing BAM
samtools index chip_sorted.bam && samtools index input_sorted.bam

#Peak Finding with MACS with Wiggle files
macs14 -t chip_sorted.bam -c input_sorted.bam -n HP1_AntiBody -f BAM -g dm -w --diag

#Peak Finding with MACS with Wiggle files with PeakSplitter
macs14 -t chip_sorted.bam -c input_sorted.bam -n HP1_AntiBody -f BAM -g dm -w --call-subpeaks --diag

#Extract Filtered Peak Regions in fasta format
bedtools getfasta -fi ./bowtie_index/dmel-all-chromosome-r6.21.fasta -bed HP1_AntiBody.bed -fo extracted_peak_sequences.fasta

#Annotate Filtered Peak Regions for Nearest Downstream genes
#java -jar -Xmx4096m /home/lakshmanteja/NGS_SOFTWARE_TOOLS/ChIP-Seq/PeakAnnotator_Java_1.4/PeakAnnotator.jar -u NDG -p HP1_AntiBody.bed -a dmel-all-r6.21.gtf -x HP1_Genes -g protein_coding|all


#Running GADEM for motif detection
gadem -em 80 -minN 100 -fseq extracted_peak_sequences.fasta -maxgap 50 -fEM 0.3 -ev 5000 -pv 0.0005

#Running MEME for motif detection
meme-chip -o HP1_Motif -db /home/lakshmanteja/NGS_SOFTWARE_TOOLS/DATABASES/motif_databases/JASPAR/JASPAR_CORE_2016.meme -meme-minw 10 -meme-maxw 50 -meme-nmotif 50 extracted_peak_sequences.fasta



