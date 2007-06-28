#!perl -w -I "~holger/perl"
use strict;
use warnings;

use X3D;

my $b1 = new SFBool;
my $b2 = new SFBool (1);

printf "%s\n", ref $b1;
printf "%s\n", $b1->getId;
printf "%s\n", $b2->getId;
printf "%s\n", $b2->getType;
printf "%s\n", $b1;
printf "%s\n", $b2;

1;
__END__
