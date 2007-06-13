#!/usr/bin/perl -w
#package 01_seed
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Seed';
}

ok new X3DObject;
ok new X3DObject;

ok new X3DObject;
ok my $seed1 = new X3DObject;

isa_ok $seed1, 'X3DUniversal';
isa_ok $seed1, 'X3DObject';

is $seed1, 'X3DObject { }'

__END__
