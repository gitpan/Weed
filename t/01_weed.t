#!/usr/bin/perl -w
#package 01_weed
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed');
}

use_ok 'Weed' for 1 .. 10;

do { use Weed } for 1 .. 10;

ok 'Weed'->VERSION;

__END__
