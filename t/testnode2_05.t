#!/usr/bin/perl -w
#package testnode2_05
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

my $testNode = new SFNode(new TestNode);
isa_ok $testNode, 'Weed::Universal';
ok $testNode->getValue->isa('X3DBaseNode');

#isa_ok $testNode->isa, '';
#isa_ok $testNode->can, '';

is $testNode, 'TestNode { }';

1;
__END__
print $testNode->Weed::Package::stringify;
print $_ foreach $testNode->getHierarchy;



