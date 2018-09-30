#! /usr/bin/bash -v
samtools index sorted_Strain_ST398.bam 
samtools mpileup -ugf scaffolds.fasta sorted_Strain_ST398.bam | bcftools call -cv -> var.raw.vcf
bcftools view var.raw.vcf | vcfutils.pl varFilter -D100 > ST398_final.vcf 

