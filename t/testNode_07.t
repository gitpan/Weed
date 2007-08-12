#!/usr/bin/perl -w
#package testNode_07
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

X3DGenerator->setOutputStyle("ALL");

ok my $testNode = new TestNode;
$testNode->sfnode = new TestNode;

#print new X3DHash {%$testNode};

#print $testNode;
#print $testNode->sfnode->sfnode;
#print $testNode->sfnode;

sub nop { ref $_[0] }
is ref $testNode->sfdouble, '';
is nop( $testNode->sfdouble ), '';
is nop( $testNode->sfnode->sfdouble ),   '';

1;
__END__

print $testNode->set_translation();
print $testNode->translation_changed;
print $testNode->{translation} = new Vec3(1,2,3);
print $testNode->{translation}->{x};
print $testNode->{translation}->[x];
