#!/usr/bin/perl -w
#package generator_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

#X3DGenerator->break foreach 1..1_000_000;

__END__

