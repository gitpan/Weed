#!/usr/bin/perl -w
#package 01_hierarchy_childnode1
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

use Weed::Perl;
my $seed = new X3DChildNode;

ok $seed;
ok int($seed);
say int($seed);
ok $seed->getId;
say $seed->getId;
ok $seed->getType;
ok $seed->toString;
ok "$seed";

is $seed->getId,   $seed->getId;
is $seed->getType, $seed->getType;
is $seed, $seed;
is $seed, "$seed";

__END__
isa_ok $seed, 'X3DNode';
isa_ok $seed, 'Weed::Components::Core::Node';
isa_ok $seed, 'X3DObject';
isa_ok $seed, 'Weed::Seed';
isa_ok $seed, 'X3DUniversal';
isa_ok $seed, 'Weed::Universal';
say $seed;
say $seed->package::stringify;
