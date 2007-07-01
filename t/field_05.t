#!/usr/bin/perl -w
#package field_05
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

is my $float1 = new SFFloat, 0;
is my $float2 = new SFFloat(1.234), 1.234;

__END__

