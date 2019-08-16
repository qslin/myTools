### ggstat: one command comprehensive statistics of gneomes and annotations

Usage: write a configuration file with the following format (the second column is the estimated genome size; only the first column must exist; the others are optional)

```
genomeA.fa 400000000 genomeA.gtf genomeA.bed
genomeB.fa 450000000 genomeB.gtf genomeB.bed
genomeC.fa 420000000 genomeC.gtf genomeC.bed
```

then excute 

```/path/to/ggstat.sh [/path/to/your/configuration/file]```

The outputs will be in the same directory with your configuration file.

* Basic statistics for genomes:
* [x] Number of scaffolds/contigs
* [x] GC ratio
* [x] Number of Ns
* [x] Genome size
* [x] Average/Largest/Smallest/Median size of contigs
* [x] N25/N50/N75
* [x] L25/L50/L75
* [x] NG25/NG50/NG75
* [x] LG25/LG50/LG75

* Basic statistics for genes:
* [x] Number of genes
* [x] Number of genes with 2 or more isoforms
* [x] Number of mono-exonic transcripts
* [x] Average Number of Exons per transcript
* [x] Average CDS length
* [x] Average exon length
* [x] Average intron length
* [x] Length of genome covered by exons
* [x] Length of genome covered by introns

* Advanced statistics:
* [x] Length of kmer-estimated single copy regions
* [x] Length of kmer-estimated repetitive regions
* [x] Length of genome covered by defined features


