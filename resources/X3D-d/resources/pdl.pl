
use PDL;
use PDL::IO::Pic;

my $path = "/net/usr/creator/holger/images/geography/earth/tiles/elevation";

my $im = zeroes( short, 5400, 5400 );

#$im->rpic("$path/ANTARCPS.sgi");

open STDERR, ">/dev/console";
foreach my $x ( 0 .. ( 5400 - 1 ) ) {
	foreach my $y ( 0 .. ( 5400 - 1 ) ) {
		print STDERR $im->index($y)->index($x), "\n";
	}
}
