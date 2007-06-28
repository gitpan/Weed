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

my $ref = bless {}, 'abc';
print $ref;
print int($ref);
print int($ref);

#ok $seed;
#ok int($seed);
#is int($seed), $seed->getId;
#print int($seed);

ok $seed->getId;
print $seed->getId;
ok $seed->getType;
ok $seed->toString;
ok "$seed";

is $seed->getId,   $seed->getId;
is $seed->getType, $seed->getType;
is $seed, $seed;
is $seed, "$seed";
is "$seed", $seed;
is "$seed", "$seed";

__END__
