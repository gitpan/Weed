#!/usr/bin/perl -w
#package 01_foobah
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('FooBah');
}

ok new FooBah;
ok my $fooBah = new FooBah("haBooF");
isa_ok $fooBah, 'X3DObject';
can_ok $fooBah, 'getName';
can_ok $fooBah, 'getTypeName';
can_ok $fooBah, 'getType';
can_ok $fooBah, 'getId';

printf "%s\n", $fooBah;
printf "%s\n", join ", ", $fooBah->getHierarchy;

1;
__END__
