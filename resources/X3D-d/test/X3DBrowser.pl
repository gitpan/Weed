#!perl -w -I "~holger/perl"
use strict;
use warnings;

use X3D;
our @vrml = <DATA>;
printf "%s\n", Browser->createX3DFromString(@vrml);
printf "%s\n", Browser;

use Benchmark;
timethis(20000, sub { Browser->createX3DFromString(@vrml)});

1;
__END__
DEF dbl MetadataDouble {
  name ""
  reference ""
  metadata NULL
  value [ 1, 2.1234567890123457 ]
}, MetadataFloat {
  name ""
  reference ""
  metadata NULL
}, MetadataInteger {
  name ""
  reference ""
  metadata NULL
  value [ 1, 0xf ]
}, MetadataSet {
  name ""
  reference ""
  metadata NULL
  value [ ]
}, MetadataString {
  name ""
  reference ""
  metadata NULL
  value [ ]
}
