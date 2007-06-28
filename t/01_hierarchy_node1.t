#!/usr/bin/perl -w
#package 01_hierarchy_node1
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

use Weed::Perl;
ok my $seed = new X3DBaseNode;
isa_ok $seed, 'X3DBaseNode';
isa_ok $seed, 'Weed::BaseNode';
isa_ok $seed, 'X3DObject';
isa_ok $seed, 'Weed::Object';
isa_ok $seed, 'X3DUniversal';
isa_ok $seed, 'Weed::Universal';
print $seed;
print $seed->Weed::Package::stringify;

__END__
