#Build reference index
~/Programs/bowtie-0.12.7/bowtie-build dmel-all-chromosome-r5.43.fasta dmelanogaster

#Align Input Reads to Reference
~/Programs/bowtie-0.12.7/bowtie -v 2 --best --strata -k 10 -m 11 -t -p 3 --al al.fq --un un.fq --max maxxed.fq --solexa1.3-quals -S ../reference/dmelanogaster ../Input/SRR390256_1.fastq aln_input.sam

#Align ChIP Reads to Reference
~/Programs/bowtie-0.12.7/bowtie -v 2 --best --strata -k 10 -m 11 -t -p 3 --al al.fq --un un.fq --max maxxed.fq --solexa1.3-quals -S ../reference/dmelanogaster ../ChIP/SRR390254_1.fastq aln_chip.sam

#Peak Finding with MACS with Wiggle files
macs14 -n HP1_antibody -f SAM -g dm -w -t ../alignment/aln_chip.sam -c ../alignment/aln_input.sam

#Adding Peak Splitter
PATH=$PATH:/home/user/Programs/PeakSplitter_Cpp/PeakSplitter_Linux64/

#Peak Finding with MACS with Wiggle files with Peak Splitter
macs14 -n HP1_antibody_speaks -f SAM -g dm -w --call-subpeaks -t ../alignment/aln_chip.sam -c ../alignment/aln_input.sam

#Extract Filtered Peak Regions in fasta format
~/Programs/BEDTools-Version-2.15.0/bin/bedtools getfasta -fi ../reference/dmel-all-chromosome-r5.43.fasta -bed HP1_antibody_peaks_filtered_noChr.bed -fo extracted_peak_sequences.fasta

#Annotate Filtered Peak Regions for Nearest Downstream genes
java -jar -Xmx1024m /home/user/Programs/PeakAnnotator_Java/PeakAnnotator.jar -u NDG -p filtered_peak.bed -a dmel.gtf -x hp1_genes -g protein_coding|all

OR 

java -jar /home/user/Programs/PeakAnalyzer_1.3/PeakAnalyzerGUI.jar

#####Motif Detection

#Running GADEM for motif detection
~/Programs/GADEM_v1.3.1/bin/gadem -em 80 -minN 100 -fseq ../peakfinding/extracted_peak_sequences.fasta -maxgap 50 -fEM 0.3 -ev 5000 -pv 0.0005

OR

#Running MEME for motif detection
perl ~/Programs/meme_4.8.0/bin/meme-chip -o HP1_Motif -index-name HP1 -db /home/user/Programs/meme_4.8.0/motif_databases/JASPAR_CORE_2009.meme -run-mast -run-ama -meme-minw 10 -meme-maxw 50 -meme-nmotifs 50 ../peakfinding/extracted_peak_sequences.fasta

