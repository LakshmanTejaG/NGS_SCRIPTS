echo "Trimming Low/Poor Quality Reads from ERR162499_1.fastq..." ;
perl ~/NGS_SOFTWARE_TOOLS/QC/NGSQCToolkit_v2.3.3/Trimming/TrimmingReads.pl -i ERR162499_1.fastq -q 30 -o ERR162499_1_HQ.fastq
echo "Trimming Low/Poor Quality Reads from ERR162499_2.fastq..." ;
perl ~/NGS_SOFTWARE_TOOLS/QC/NGSQCToolkit_v2.3.3/Trimming/TrimmingReads.pl -i ERR162499_2.fastq -q 30 -o ERR162499_2_HQ.fastq
echo "Successfully Completed Trimming Reads by Quality(-q)" ;
date
