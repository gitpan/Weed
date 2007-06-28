#!perl -w -I "~holger/perl"
use strict;
use warnings;

use X3D;
my $v = 1;

my $f1 = new X3DField (\$v);
my $f2 = new X3DField (\$v);

printf "%s\n", ref $f1;
printf "%s\n", ref $f2;
printf "%s\n", $f1;
printf "%s\n", $f2;

$f1->setValue (2);
printf "%s\n", $f1->getValue;
printf "%s\n", $f2->getValue;
1;
__END__
printf "%s\n", $v;
printf "%s\n", $$v;


use Benchmark;
timethis(1000000, sub { $v = new X3D::Field::SFValue ( ) });
timethis(1000000, sub { $v = new X3D::Field::SFValue (1) });

