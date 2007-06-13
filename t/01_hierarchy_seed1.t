#!/usr/bin/perl -w
#package 01_hierarchy_seed1
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Seed';
}

use Weed::Perl;
my $seed = new X3DObject;
isa_ok $seed, 'X3DObject';
isa_ok $seed, 'Weed::Seed';
isa_ok $seed, 'X3DUniversal';
isa_ok $seed, 'Weed::Universal';

say $seed;
say $seed->Weed::Package::stringify;

__END__
