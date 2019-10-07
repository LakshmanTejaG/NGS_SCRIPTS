echo "Denovo Genome Assembly Running...." ;

/home/lakshmanteja/NGS_SOFTWARE_TOOLS/ASSEMBLY/SPAdes-3.11.1/bin/spades.py \
-t 4 -k 71 --sc \
--pe1-1 ERR162499_1_HQ.fastq \
--pe1-2 ERR162499_2_HQ.fastq \
--pe1-s unPaired_HQReads.fastq \
-o SPAdes_71 > SPAdes_Assembly.log ;
echo "Successfully Completed Denovo Genome Assembly" ;
date
