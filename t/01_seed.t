#!/usr/bin/perl -w
#package 01_seed
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Seed';
}

ok new Weed::Seed;
ok new X3DObject;

__END__
