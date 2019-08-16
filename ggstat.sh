mkdir ggstat_results
cd ggstat_results

lines=()
while read line; do lines+=("$line"); done < $1

for n in ${!lines[@]}
do
	para=$(echo ${lines[$n]} | awk '{print $1,$2}')
	perl ggstat.pl $para > ggstat_tmp
	if [ $n = "0" ]; then
		cat ggstat_tmp > ggstat_genome.txt
	else
		cut -f2 ggstat_tmp | paste ggstat_genome.txt - > ggstat_genome.tmp
		mv ggstat_genome.tmp ggstat_genome.txt
	fi
done

rm ggstat_tmp


