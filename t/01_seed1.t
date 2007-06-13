#!/usr/bin/perl -w
#package 01_seed1
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

use Weed::Perl;
my $seed = new X3DUniversal;

ok $seed;
ok int($seed);
is int($seed), $seed->getId;
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
is "$seed", $seed;
is "$seed", "$seed";

my $ref = bless {}, 'abc';
say $ref;
say int($ref);
say int($ref);

__END__
isa_ok $seed, 'X3DNode';
isa_ok $seed, 'Weed::Components::Core::Node';
isa_ok $seed, 'X3DObject';
say int($ref);
isa_ok $seed, 'Weed::Seed';
isa_ok $seed, 'X3DUniversal';
isa_ok $seed, 'Weed::Universal';
say $seed;
say $seed->package::stringify;
