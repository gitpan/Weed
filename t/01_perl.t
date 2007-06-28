#!/usr/bin/perl -w
#package 01_perl
use Test::More no_plan;
use Benchmark;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

use Weed::Perl;

ok YES == YES;
ok !( YES == NO );
ok !( YES != YES );
ok YES != NO;

__END__
