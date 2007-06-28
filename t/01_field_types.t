#!/usr/bin/perl -w
#package 01_field_types
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Parse::FieldValue';
}

my ( $s, $v );

use Benchmark;
timethis( 100, sub {

		$s = sprintf "%g %g %g", rand, rand, rand;
		ok Weed::Parse::FieldValue::sfvec3fValue( \$s );

} );


__END__
