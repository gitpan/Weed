#!/usr/bin/perl -w
#package 00_constants
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Constants';
}

ok( X3DConstants->TRUE );
ok( X3DConstants->TRUE );
ok( !X3DConstants->FALSE );

is( X3DConstants->initializeOnly, 0 );
is( X3DConstants->inputOnly,      1 );
is( X3DConstants->outputOnly,     2 );
is( X3DConstants->inputOutput,    3 );

__END__
