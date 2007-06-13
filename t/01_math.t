#!/usr/bin/perl -w
#package 01_math
use Test::More no_plan;
use Benchmark;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Math';
}

use Weed::Math;

can_ok 'Math', 'acos';
can_ok 'Math', 'round';

__END__
my $v;
timethis( 2, sub { $v = Weed::Seed->import } );
