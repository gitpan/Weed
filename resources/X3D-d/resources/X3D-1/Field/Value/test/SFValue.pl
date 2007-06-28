#!perl -w -I "~holger/perl"
use strict;
use warnings;

use X3D::Field::SFValue;

my $v = new X3D::Field::SFValue (1);
printf "%s\n", $v;
printf "%s\n", $$v;


use Benchmark;
timethis(1000000, sub { $v = new X3D::Field::SFValue ( ) });
timethis(1000000, sub { $v = new X3D::Field::SFValue (1) });

1;
__END__
