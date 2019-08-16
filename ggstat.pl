#!/opt/perl/bin/perl
#
#use warnings;

die "usage: <Genome_statistics.pl>\n" unless @ARGV >= 1;
$inputfile = $ARGV[0];
open (FILE, $inputfile); 

$contig_length = 0;

while (<FILE>) {

	if (/>/) {
	push (@contig_length, $contig_length);
	$contig_length = 0;
	} else {
	chomp $_;
	$line_A = $_ =~ tr/Aa/Aa/;
	$line_C = $_ =~ tr/Cc/Cc/;
	$line_G = $_ =~ tr/Gg/Gg/;
	$line_T = $_ =~ tr/Tt/Tt/;
	$line_N = $_ =~ tr/N/N/;
	$A_count += $line_A;
	$C_count += $line_C;
	$G_count += $line_G;
	$T_count += $line_T;
	$N_count += $line_N;
	$contig_length += length($_);
	}
}

close FILE;

$total_size = $A_count + $T_count + $G_count + $C_count+ $N_count;
$GCratio = ($G_count + $C_count)/($total_size-$N_count);
shift @contig_length;
push (@contig_length, $contig_length);
$contig_number = scalar @contig_length;
$average_length = int($total_size/$contig_number);

print "File\t$ARGV[0]\n";
print "Number of scaffolds\t$contig_number\n";

print "GC ratio\t$GCratio\n";
print "Number of Ns\t$N_count\n";
print "Genome size\t$total_size\n";
print "Average size of contigs\t$average_length\n";

@contig_length = sort {$b<=>$a} @contig_length;

print "Largest size of contigs\t$contig_length[0]\n";
print "Smallest size of contigs\t$contig_length[-1]\n";

if ($contig_number % 2 == 0) {
	$median = int( ($contig_length[$contig_number/2 - 1] + $contig_length[$contig_number/2])/2 );
} else {
	$median = $contig_length[($contig_number-1)/2];
}

print "Median size of contigs\t$median\n";

$i = 0;
$sum = 0;

while ($sum < $total_size * 0.25){
$sum += $contig_length[$i];
$i++;
}
$N25 = $contig_length [$i-1];
$L25 = $i-1;
print "N25\t$N25\n";
print "L25\t$L25\n";

while ($sum < $total_size * 0.5){
$sum += $contig_length[$i];
$i++;
}
$N50 = $contig_length [$i-1];
$L50 = $i-1;
print "N50\t$N50\n";
print "L50\t$L50\n";

while ($sum < $total_size * 0.75){
$sum += $contig_length[$i];
$i++;
}
$N75 = $contig_length [$i-1];
$L75 = $i-1;
print "N75\t$N75\n";
print "L75\t$L75\n";

if ( $ARGV[1] ){

$estimatedgenomesize = $ARGV[1];
$i = 0;
$sum = 0;

while ($sum < $estimatedgenomesize * 0.25){
	$sum += $contig_length[$i];
	$i++;
}
$NG25 = $contig_length [$i-1];
$LG25 = $i-1;

while ($sum < $estimatedgenomesize * 0.5){
$sum += $contig_length[$i];
$i++;
}
$NG50 = $contig_length [$i-1];
$LG50 = $i-1;

while ($sum < $estimatedgenomesize * 0.75){
$sum += $contig_length[$i];
$i++;
}
$NG75 = $contig_length [$i-1];
$LG75 = $i-1;
}else{

$NG25 = "NA";
$LG25 = "NA";
$NG50 = "NA";
$LG50 = "NA";
$NG75 = "NA";
$LG75 = "NA";

}

print "NG25\t$NG25\n";
print "LG25\t$LG25\n";

print "NG50\t$NG50\n";
print "LG50\t$LG50\n";

print "NG75\t$NG75\n";
print "LG75\t$LG75\n";

exit;

