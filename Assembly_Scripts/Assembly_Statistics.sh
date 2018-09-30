##Generate Kmer Length NOTE: run from the assembly folder
pwd | awk '{kmer=$0;sub(/.*_/,"",kmer);print "Kmer Length\t"kmer}' > Assembly_Stats.txt

##Generate assembled reads stats
tail Log -n 1 | awk -F "/" '{asm=$1;tot=$2;sub(/.*using /,"",asm);sub(/ reads/,"",tot);percAsm=asm/tot*100;print "Assembled Reads\t"asm"\nTotal Reads\t"tot"\nPercentage Assembled\t"percAsm}' >> Assembly_Stats.txt

##Generate sorted contig length information | Max contig length & Min contig length NOTE: Run in each individual directory
awk 'BEGIN{min=100000000;}{if($1~/>/){i++;if(seq!=""){len=length(seq);tLen=tLen+len;print header"\t"len;seq="";if(max<len){max=len};if(min>len){min=len}};header=$0}else{seq=seq""$0}}END{len=length(seq);tLen=tLen+len;aLen=tLen/i;print header"\t"len;if(max<len){max=len};if(min>len){min=len};print "Total No. of Contigs\t"i"\nTotal Assembly Length\t"tLen"\nMax Contig Length\t"max"\nMin Contig Length\t"min"\nAverage Sequence Length\t"aLen >> "Assembly_Stats.txt"}' contigs.fa | sort -k 2,2nr >contig_lengths.txt

##Get n50 count
tail Log -n 1 | awk -F "\t" '{nffty=$1;sub(/.*n50 of /,"",nffty);sub(/, max.*/,"",nffty);print "n50\t"nffty}' >> Assembly_Stats.txt
