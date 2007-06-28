#!perl -w -I "~holger/perl"
use strict;
use warnings;

use X3D;

my $v = new SFFloat (1);
printf "%s\n", $v;

$v->setValue(2);
printf "%s\n", $v->getValue;

use Benchmark;
#timethis(2000000, sub { $v = new SFFloat ( ) });
#timethis(2000000, sub { $v = new SFFloat (1) });
timethis(2000000, sub { my $s = "$v" });

1;
__END__
