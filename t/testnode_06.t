#!/usr/bin/perl -w
#package testnode_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

#X3DGenerator->setOutputStyle("COMPACT");

ok my $testNode = new TestNode;

X3DGenerator->setTidyFields(NO);

print $$testNode->{fields};

print $testNode;

1;
__END__






























print $testNode->set_translation();
print $testNode->translation_changed;
print $testNode->{translation} = new Vec3(1,2,3);
print $testNode->{translation}->{x};
print $testNode->{translation}->[x];
