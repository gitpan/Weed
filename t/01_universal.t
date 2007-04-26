#!/usr/bin/perl -w
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Universal';
}

ok ! @{ Weed::Universal->ARRAY('ISA') };

__END__
