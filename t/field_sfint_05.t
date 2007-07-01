#!/usr/bin/perl -w
#package field_sfint_05
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok my $int1 = new SFInt32(2.23);
ok my $int2 = new SFInt32(23.2);
is $int1, 2;
is $int2, 23;

__END__

