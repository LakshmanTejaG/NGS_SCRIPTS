# K-mergenie for Best K-mer Prediction
echo " Best K-mer Prediction Running.....";
/home/lakshmanteja/NGS_SOFTWARE_TOOLS/ASSEMBLY/kmergenie-1.7048/kmergenie ../ERR162499_1_HQ.fastq -l 31 -k 91 -s 2 > Best_K-mer.txt ;
rm histograms*
echo "Best K-mer Prediction Completed, details opne Best_Kmer.txt file."
