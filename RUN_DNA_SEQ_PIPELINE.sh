### STEP 1 ####
echo "Converting SRA into FASTQ read files....." ;
~/NGS_SOFTWARE_TOOLS/QC/sratoolkit.2.9.0/bin/fastq-dump --split-files ERR162499.sra ;
echo "FASTQ files Genereated Successfully";

### STEP 2 ####
echo "Raw Reads QC Running...";
perl ~/NGS_SOFTWARE_TOOLS/QC/NGSQCToolkit_v2.3.3/QC/IlluQC_PRLL.pl -c 4 -pe ERR162499_1.fastq ERR162499_2.fastq 2 Adapter.txt -o QC_Reports
echo "Successfully Completed";
echo "Trimming Low/Poor Quality Reads from ERR162499_1.fastq..." ;
perl ~/NGS_SOFTWARE_TOOLS/QC/NGSQCToolkit_v2.3.3/Trimming/TrimmingReads.pl -i ERR162499_1.fastq -q 30 -o ERR162499_1_HQ.fastq
echo "Trimming Low/Poor Quality Reads from ERR162499_2.fastq..." ;
perl ~/NGS_SOFTWARE_TOOLS/QC/NGSQCToolkit_v2.3.3/Trimming/TrimmingReads.pl -i ERR162499_2.fastq -q 30 -o ERR162499_2_HQ.fastq
echo "Successfully Completed Trimming Reads by Quality(-q)" ;
echo "Adapter Trimming is Running...." ;
~/NGS_SOFTWARE_TOOLS/QC/Cutadapt/cutadapt -a ACACTCTTTCCCTACACGACGCTCTTCCGATCT -A CTCGGCATTCCTGCTGAACCGCTCTTCCGATCT -o ERR162499_1_HQ.fastq -p ERR162499_2_HQ.fastq ERR162499_1.fastq ERR162499_2.fastq
echo "Adapter Trimming Completed";
# QC with Trim Galore (Optional)
trim_galore --phred33 --quality 30 --illumina --paired --fastqc  ERR162499_1.fastq ERR162499_2.fastq
trim_galore --phred33 --quality 30 -a ACACTCTTTCCCTACACGACGCTCTTCCGATCT -a2 CTCGGCATTCCTGCTGAACCGCTCTTCCGATCT --paired --fastqc  ERR162499_1.fastq ERR162499_2.fastq

# Optional QC Process
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

### STEP 3 ####
# K-mergenie for Best K-mer Prediction
echo " Best K-mer Prediction Running.....";
/home/lakshmanteja/NGS_SOFTWARE_TOOLS/ASSEMBLY/kmergenie-1.7048/kmergenie ../ERR162499_1_HQ.fastq -l 31 -k 91 -s 2 > Best_K-mer.txt ;
rm histograms*
echo "Best K-mer Prediction Completed, details open <Best_Kmer.txt> file.";
# Genome Assembly with Velvet
# Velveth for graph generation for kmer:
~/NGS_SOFTWARE_TOOLS/ASSEMBLY/velvet_1.2.10/velveth K-mer 79 -fastq -shortPaired -separate ERR162499_1_HQ.fastq ERR162499_2_HQ.fastq -short unPaired_HQReads
# Velvetg to assemble and generate contigs for kmer:
~/NGS_SOFTWARE_TOOLS/ASSEMBLY/velvet_1.2.10/velvetg K-mer -ins_length 200 -ins_length_sd 50 -scaffolding yes -cov_cutoff 10 -min_contig_lgth 300 -read_trkg yes

# Genome Assembly with SPAdes
echo "Denovo Genome Assembly Running...." ;
/home/lakshmanteja/NGS_SOFTWARE_TOOLS/ASSEMBLY/SPAdes-3.11.1/bin/spades.py \
-t 4 -k 71 --sc \
--pe1-1 ERR162499_1_HQ.fastq \
--pe1-2 ERR162499_2_HQ.fastq \
--pe1-s unPaired_HQReads.fastq \
-o SPAdes_71 > SPAdes_Assembly.log ;
echo "Successfully Completed Denovo Genome Assembly" ;

# Assembly Assessment using QUAST and BUSCO
python ~/NGS_SOFTWARE_TOOLS/ASSEMBLY/Assembly_Assessment/QUAST-4.6.3/quast.py -m 200 -o QUAST contigs.fasta scaffolds.fasta

python ~/NGS_SOFTWARE_TOOLS/ASSEMBLY/Assembly_Assessment/BUSCO-v3/scripts/run_BUSCO.py -i contigs.fasta -l ~/NGS_SOFTWARE_TOOLS/DATABASES/bacteria_odb9/ -m genome --species s_aureus -o BUSCO

### STEP 4 ###
# Genome Alignment or Read Mapping
~/NGS_SOFTWARE_TOOLS/ALIGNMENT/Bowtie2-2.3.4.1/bowtie2 -x ST398 -1 ../Denovo_Assembly/ERR162499_1_HQ.fastq -2 ../Denovo_Assembly/ERR162499_2_HQ.fastq -S Strain_ST398.sam --no-unal

### STEP 5 ###
# SNP Calling
samtools index sorted_Strain_ST398.bam 
samtools mpileup -ugf scaffolds.fasta sorted_Strain_ST398.bam | bcftools call -cv -> var.raw.vcf
bcftools view var.raw.vcf | vcfutils.pl varFilter -D100 > ST398_final.vcf 






