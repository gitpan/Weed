#!/usr/bin/perl -w
#package time_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Time';
	use_ok 'Weed::Math';
}

ok X3DMath::sum( map { time =~ m/\./ } 1 .. 170 ) <= 170 foreach 1 .. 10;

no Weed::Time;

ok !X3DMath::sum( map { time =~ m/\./ ? 1 : 0 } 1 .. 170 ) foreach 1 .. 10;

__END__
