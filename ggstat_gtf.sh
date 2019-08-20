geneNum=`awk '$3~/gene/{sum+=1}END{print sum}' $1`
perl -se 'print "Number of genes\t$n\n"' -- -n=$geneNum
transcriptNum=`awk '$3~/transcript/{sum+=1}END{print sum}' $1`
perl -se 'print "Number of transcripts\t$n\n"' -- -n=$transcriptNum
alterNum=$(echo $transcriptNum-$geneNum|bc)
perl -se 'print "Number of genes with 2 or more isoforms\t$n\n"' -- -n=$alterNum
monoNum=`awk '$3~/exon/{print $10}' $1|cut -f2 -d '"'|uniq -c|awk '$1==1{print $2}'|wc -l`
perl -se 'print "Number of mono-exonic transcripts\t$n\n"' -- -n=$monoNum
avgExonNum=`awk '$3~/exon/{print $10}' $1 |cut -f2 -d '"'|uniq -c|awk '{print $1}'|awk '{sum+=$1} END {print sum/NR}'`
perl -se 'print "Average number of exons per transcript\t$n\n"' -- -n=$avgExonNum

awk '$3~/exon/{print $10,$5-$4+1}' OFS='\t' $1|tr -d '"'|tr -d ';'|perl -lane '{ $length{$F[0]}+=$F[1] }END{ foreach $t (sort keys %length){ print "$t\t$length{$t}" } }' > transcript_length.tmp
transcriptAvg=`cut -f2 transcript_length.tmp |awk '{sum+=$1} END {print sum/NR}'`
perl -se 'print "Average transcript length\t$n\n"' -- -n=$transcriptAvg
transcriptMost=`cut -f2 transcript_length.tmp |sort -n|uniq -c|awk '{print $2"\t"$1}'|sort -k2 -nr|head -1|cut -f1`
perl -se 'print "Most frequent transcript length\t$n\n"' -- -n=$transcriptMost
transcriptMax=`cut -f2 transcript_length.tmp |sort -n|uniq -c|awk '{print $2"\t"$1}'|tail -1|cut -f1`
perl -se 'print "Longest transcript length\t$n\n"' -- -n=$transcriptMax
transcriptMin=`cut -f2 transcript_length.tmp |sort -n|uniq -c|awk '{print $2"\t"$1}'|head -1|cut -f1`
perl -se 'print "Shortest transcript length\t$n\n"' -- -n=$transcriptMin
rm transcript_length.tmp

exonAvg=`awk '$3~/exon/{print $5-$4+1}' $1 |awk '{sum+=$1} END {print sum/NR}'`
perl -se 'print "Average exon length\t$n\n"' -- -n=$exonAvg
exonMost=`awk '$3~/exon/{print $5-$4+1}' $1 |sort -n|uniq -c|awk '{print $2"\t"$1}'|sort -k2 -nr|head -1|cut -f1`
perl -se 'print "Most frequent exon length\t$n\n"' -- -n=$exonMost
exonMax=`awk '$3~/exon/{print $5-$4+1}' $1 |sort -n|uniq -c|awk '{print $2"\t"$1}'|tail -1|cut -f1`
perl -se 'print "Longest exon length\t$n\n"' -- -n=$exonMax
exonMin=`awk '$3~/exon/{print $5-$4+1}' $1 |sort -n|uniq -c|awk '{print $2"\t"$1}'|head -1|cut -f1`
perl -se 'print "Shortest exon length\t$n\n"' -- -n=$exonMin

intronAvg=`awk '$3~/intron/{print $5-$4+1}' $1 |awk '{sum+=$1} END {print sum/NR}'`
perl -se 'print "Average intron length\t$n\n"' -- -n=$intronAvg
intronMost=`awk '$3~/intron/{print $5-$4+1}' $1 |sort -n|uniq -c|awk '{print $2"\t"$1}'|sort -k2 -nr|head -1|cut -f1`
perl -se 'print "Most frequent intron length\t$n\n"' -- -n=$intronMost
intronMax=`awk '$3~/intron/{print $5-$4+1}' $1 |sort -n|uniq -c|awk '{print $2"\t"$1}'|tail -1|cut -f1`
perl -se 'print "Longest intron length\t$n\n"' -- -n=$intronMax
intronMin=`awk '$3~/intron/{print $5-$4+1}' $1 |sort -n|uniq -c|awk '{print $2"\t"$1}'|head -1|cut -f1`
perl -se 'print "Shortest intron length\t$n\n"' -- -n=$intronMin

module load bedtools

geneCov=`awk '$3~/gene/{print $1,$4,$5}' OFS='\t' $1 |sort -k1,1 -k2,2n|bedtools merge -i -|awk '{sum+=($3-$2)}END{print sum}'`
perl -se 'print "Length of genome covered by genes\t$n\n"' -- -n=$geneCov
exonCov=`awk '$3~/exon/{print $1,$4,$5}' OFS='\t' $1 |sort -k1,1 -k2,2n|bedtools merge -i -|awk '{sum+=($3-$2)}END{print sum}'`
perl -se 'print "Length of genome covered by exons\t$n\n"' -- -n=$exonCov
intronCov=`awk '$3~/intron/{print $1,$4,$5}' OFS='\t' $1 |sort -k1,1 -k2,2n|bedtools merge -i -|awk '{sum+=($3-$2)}END{print sum}'`
perl -se 'print "Length of genome covered by introns\t$n\n"' -- -n=$intronCov



