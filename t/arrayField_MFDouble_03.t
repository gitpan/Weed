#!/usr/bin/perl -w
#package arrayField_MFDouble_03
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

my $n = 10;

my $mfd1 = new MFDouble( 1 .. $n );
my $mfd2 = new MFDouble( 1 .. $n );
my $arr1 = [ 1 .. $n ];

is $mfd1 <=> $mfd2, 0;
is $mfd1 <=> $arr1, 0;

is $mfd1 cmp $mfd2, 0;
is $mfd1 cmp $arr1, 0;

1;
__END__

