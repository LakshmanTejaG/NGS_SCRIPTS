echo "Raw Reads QC Running...";
perl ~/NGS_SOFTWARE_TOOLS/QC/NGSQCToolkit_v2.3.3/QC/IlluQC_PRLL.pl -c 4 -pe ERR162499_1.fastq ERR162499_2.fastq 2 Adapter.txt -o QC_Reports
echo "Successfully Completed";
date
