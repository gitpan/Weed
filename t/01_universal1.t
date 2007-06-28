#!/usr/bin/perl -w
#package 01_universal1
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Universal';
}

use Weed::Perl;

ok !@{ Weed::Universal->Weed::Package::array('ISA') };

is( ref( ( Weed::Universal->Weed::Package::can('import') )[0] ), 'CODE' );

ok !Weed::Universal->Weed::Package::can('blah');

__END__
