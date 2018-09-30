#############################################################################
### Shell Script to Remove Adapter(s) from Raw Reads of Illumina DNA-Seq ####
#############################################################################
#                                                                           #
# Illumina Universal Adapter		AGATCGGAAGAG                        #
# Illumina Paired End Adapter 1		ACACTCTTTCCCTACACGACGCTCTTCCGATCT   #
# Illumina Paired End Adapter 2		CTCGGCATTCCTGCTGAACCGCTCTTCCGATCT   #
#                                                                           #
#############################################################################
/home/lakshmanteja/NGS_SOFTWARE_TOOLS/QC/Cutadapt/cutadapt -a ACACTCTTTCCCTACACGACGCTCTTCCGATCT -A CTCGGCATTCCTGCTGAACCGCTCTTCCGATCT -o ERR162499_1_HQ.fastq -p ERR162499_2_HQ.fastq ERR162499_1.fastq ERR162499_2.fastq

## echo "Adapter Trimming is Running...." ;
## /home/lakshmanteja/NGS_SOFTWARE_TOOLS/QC/Cutadapt/cutadapt -a AGATCGGAAGAG -o ERR162499_1_HQ.fastq ERR162499_1.fastq > ERR162499_1_Report.txt ;
## /home/lakshmanteja/NGS_SOFTWARE_TOOLS/QC/Cutadapt/cutadapt -a AGATCGGAAGAG -o ERR162499_2_HQ.fastq ERR162499_2.fastq > ERR162499_2_Report.txt ;
## echo "Adapter Trimming Completed";
## date 



