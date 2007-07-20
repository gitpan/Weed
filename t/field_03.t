#!/usr/bin/perl -w
#package field_03
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

package NodeType;
use Weed 'Node : X3DBaseNode {
  SFNode   [in,out] sfnode    NULL
  SFVec3f  [in,out] sfvec3f   0 0 0
  SFDouble [in,out] sfdouble  0
}';

package main;
#use Benchmark ':hireswallclock';

my $sfnode = new SFNode(new Node);

is $sfnode->sfvec3f++, '0 0 0';
is $sfnode->sfvec3f, '1 1 1';
my $sfvec3f = $sfnode->sfvec3f;

#timethis( 1_000_000, sub { $sfnode->getValue } ); #134952.77/s

#timethis( 1_0_000, sub { $sfnode->sfvec3f++ } ); #2500.02/s
#timethis( 1_000_000, sub { $sfvec3f++ } ); #134952.77/s

#is $sfnode->sfvec3f, '10001 10001 10001';
#is $sfvec3f, '10001 10001 10001';

#my $v;
#my $s = "+1234.5678";
#timethis( 10_000_000, sub { $v = Weed::Parse::FieldValue::sfdoubleValue( \$s ); pos($s) = 0 } ); #187617.26/s
#timethis( 10_000_000, sub { $v = Weed::Parse::FieldValue::sfint32Value( \$s ); pos($s) = 0 } ); #201328.77/s
#print $v;

1;
__END__

187617.26/s

184467.81/s
182248.95/s
