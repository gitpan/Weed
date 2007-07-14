#!/usr/bin/perl -w
#package seed_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Generator';
	use_ok 'Weed::Object';
}

ok CREATE X3DObject;
ok CREATE X3DObject;

ok CREATE X3DObject;
ok my $seed1 = CREATE X3DObject;

isa_ok $seed1, 'X3DUniversal';
isa_ok $seed1, 'X3DObject';

is $seed1, 'X3DObject { }'

__END__

