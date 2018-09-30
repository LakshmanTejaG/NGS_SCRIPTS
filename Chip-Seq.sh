# INDEXING 
bowtie-build bowtie_index/mm10.fa bowtie_index/mm10

# ALIGNMENT
bowtie2 -x bowtie_index/mm10 -U Oct4.fastq -S Oct4.sam --no-unal

# SAM 2 BAM
samtools view -bSo Oct4.bam Oct4.sam

# Sorted BAM
samtools sort Oct4.bam -o Oct4.sorted.bam

# Indeing BAM
samtools index Oct4.sorted.bam

# BAM 2 bigwig
genomeCoverageBed -bg -ibam Oct4.sorted.bam -g bowtie_index/mouse.mm10.genome > Oct4.bedgraph
or 
genomeCoverageBed -bg -ibam Oct4.sorted.bam > Oct4.bedgraph

# convert the bedgraph into a binary graph, called Oct4.bw,using the tool bedGraphToBigWig from the UCSC tools
bedGraphToBigWig Oct4.bedgraph bowtie_index/mouse.mm10.genome Oct4.bw



macs14 -t Oct4.sorted.bam -c gfp.sorted.bam --format=BAM --name=Oct4 --gsize=138000000 --tsize=26 --diag --wig



