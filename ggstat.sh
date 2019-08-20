SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

mkdir ggstat_results_$(date +%Y%m%d_%H%M%S)
cd ggstat_results_$(date +%Y%m%d_%H%M%S)

lines=()
while read line; do lines+=("$line"); done < ../$1

for n in ${!lines[@]}
do
	para1=$(echo ${lines[$n]} | awk '{print $1,$2}')
	para2=$(echo ${lines[$n]} | awk '{print $3,$4}')
	perl $SCRIPTPATH/ggstat.pl $para1 > ggstat_tmp
	sh $SCRIPTPATH/ggstat_gtf.sh $para2 >> ggstat_tmp
	if [ $n = "0" ]; then
		cat ggstat_tmp > ggstat_genome.txt
	else
		cut -f2 ggstat_tmp | paste ggstat_genome.txt - > ggstat_genome.tmp
		mv ggstat_genome.tmp ggstat_genome.txt
	fi
done

rm ggstat_tmp


