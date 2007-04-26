#!/usr/bin/perl -w
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok (X3DConstants->TRUE);
ok (! X3DConstants->FALSE);

__END__

