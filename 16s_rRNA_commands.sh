#conda activate NGS@BIOCONDA
#print_qiime_config.py
## 16s_rRNA_Analysis_QIIME
split_libraries_fastq.py -i CBS2-eDNA.fastq --sample_ids CBS2-eDNA -o Demultiplexes/ -q 19 --barcode_type 'not-barcoded' 
convert_fastaqual_fastq.py -c fastq_to_fastaqual -f CBS2-eDNA.fastq
mkdir fastqc_output ; fastqc CBS2-eDNA.fastq -o fastqc_output
pick_de_novo_otus.py -i CBS2-eDNA.fna -o denovo_OTU_pick
pick_otus.py -i CBS2-eDNA.fna -m uclust -o picked_otus_97_percent_rev/ -s 0.97 -z
pick_otus.py -i CBS2-eDNA.fna -m uclust -o picked_otus_97_percent_rev/ -s 0.97 -l
pick_rep_set.py -m most_abundant -f CBS2-eDNA.fna -i De_Novo_OTU/uclust_picked_otus/CBS2-eDNA_otus.txt -o De_Novo_OTU/CBS2-eDNA_repset.fna
assign_taxonomy.py -m uclust -i De_Novo_OTU/CBS2-eDNA_repset.fna 
identify_chimeric_seqs.py -m ChimeraSlayer -i pynast_aligned_seqs/CBS2-eDNA_rep_set_aligned.fasta -a ~/NGS_TOOLS/TAXONOMIC_PROFILING/Microbiome-util/RESOURCES/rRNA16S.gold.NAST_ALIGNED.fasta -o chimeric_seqs.txt
filter_fasta.py -f pynast_aligned_seqs/CBS2-eDNA_rep_set_aligned.fasta -o non_chimeric_rep_set_aligned.fasta -s chimeric_seqs.txt -n
filter_alignment.py -i non_chimeric_rep_set_aligned.fasta -o filtered_alignment/ 
make_phylogeny.py -i filtered_alignment/non_chimeric_rep_set_aligned_pfiltered.fasta -o rep_phylo.tre
biom summarize-table -i otu_table.biom -o table_summary.txt 
biom convert -i otu_table.biom -o otu_table.txt --to-tsv
biom convert -i otu_table.biom -o otu_table.txt --to-hdf5
summarize_taxa_through_plots.py -i otu_table.biom -o taxa_summary
make_otu_heatmap.py -i otu_table.biom -o otu_table_heatmap.pdf
