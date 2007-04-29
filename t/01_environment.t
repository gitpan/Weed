#!/usr/bin/perl -w
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Environment';
}

ok my $core = new X3DComponent("Core");

printf "%s\n", $core;

__END__