#!/usr/bin/perl -w
#package perl_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok YES == YES;
ok !( YES == NO );
ok !( NO == YES );
ok !( YES != YES );
ok YES != NO;
ok NO != YES;

ok YES eq YES;
ok !( YES eq NO );
ok !( NO  eq YES );
ok !( YES ne YES );
ok YES ne NO;
ok NO  ne YES;

__END__
