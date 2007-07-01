#!/usr/bin/perl -w
#package constants_00
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok( !X3DConstants->NULL );
ok( X3DConstants->TRUE );
ok( !X3DConstants->FALSE );

ok( !X3DConstants->NULL );
ok( X3DConstants->TRUE );
ok( !X3DConstants->FALSE );

is( X3DConstants->initializeOnly, 0 );
is( X3DConstants->inputOnly,      1 );
is( X3DConstants->outputOnly,     2 );
is( X3DConstants->inputOutput,    3 );

ok( X3DConstants->NULL->getId != X3DConstants->NULL->getId );
ok( X3DConstants->FALSE->getId != X3DConstants->FALSE->getId );
ok( X3DConstants->TRUE->getId != X3DConstants->TRUE->getId );

__END__

