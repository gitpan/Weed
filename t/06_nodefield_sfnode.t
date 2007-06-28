#!/usr/bin/perl -w
#package 06_nodefield_sfnode
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNode';
}

ok my $testNode  = new SFNode( new TestNode );
ok my $sfnodeId = $testNode->sfnode->getId;
is $sfnodeId, $testNode->sfnode->getId;




my $sfnode = $testNode->sfnode;
isa_ok $sfnode, 'X3DField';

is $sfnodeId, $testNode->sfnode->getId;
1;
__END__
