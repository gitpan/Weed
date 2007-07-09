#!/usr/bin/perl -w
#package perl_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Perl';
}

ok YES == YES;
ok !( YES == NO );
ok !( YES != YES );
ok YES != NO;

__END__

