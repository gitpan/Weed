#!/usr/bin/perl -w
#package parse_field_value_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

my ( $s, $v );

for (1..100) {

		$s = sprintf "%g %g %g", rand, rand, rand;
		ok Weed::Parse::FieldValue::sfvec3fValue( \$s );

}


__END__

