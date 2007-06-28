#!/usr/bin/perl -w
#package 01_benchmark1
use Test::More no_plan;
use Benchmark;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

my $v;
timethis( 2, sub { $v = Weed::Object->import } );

__END__
