trim_blast_short -l AAGCAGTGGTATCAACGCAGAGTACATGGG -l AAGCAGTGGTATCAACGCAGAGTACTTTTT -o reads_no_adapt.fastq reads_1.fastq.gz 
trim_blast_short -l AAGCAGTGGTATCAACGCAGAGTACATGGG -l AAGCAGTGGTATCAACGCAGAGTACTTTTT reads_1.fastq.gz | trim_quality | filter_by_length -Z -n 40 -o reads_cleaned.fastq.gz

