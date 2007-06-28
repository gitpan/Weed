#!perl -w -I "~holger/perl"
use strict;
use warnings;

use X3D;
use Time::HiRes qw(time);

my $b1 = new SFString;
my $b2 = new SFString (1);

printf "%s\n", ref $b1;
printf "%s\n", $b1;
printf "%s\n", $b2;

use Benchmark;
my $v = new SFString (1);
#timethis(1000000, sub { $v = new SFString ( ) });
#timethis(10000000, sub { $v = new SFString (1) });
#timethis(2000000, sub { $v = $v->copy });
#timethis(2000000, sub { $v->setValue(2) });
#timethis(20000000, sub { $v->getValue });

my @a = (1 ... 10000);
my $d = new SFDouble(2);
my $t0 = time;
foreach (@a) {
	$d = new SFDouble($d + $_);
}
print time - $t0, "\n";
print $d, "\n";

1;
__END__
