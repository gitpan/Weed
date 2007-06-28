#!perl -w -I "~holger/perl"
use strict;
use warnings;

use X3D::X3DObject;

my $v = new X3DObject;
printf "%s\n", $v;


use Benchmark;
timethis(10000000, sub { $v = new X3DObject });

1;
__END__
