#!/usr/bin/perl -w
#package 01_universal
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Universal';
}

ok !@{ Weed::Universal->ARRAY('ISA') };

is( ref( ( Weed::Universal::CAN( 'Weed::Universal', 'import' ) )[0] ), 'CODE' );
is( ref( ( Weed::Universal->CAN( 'import' ) )[0] ), 'CODE' );

ok ! Weed::Universal->CAN( 'blah' );
ok ! Weed::Universal->can( 'blah' );

__END__
