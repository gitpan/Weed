#!/usr/bin/perl -w
#package arrayField_MFNode_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

X3DGenerator->compact;
my $MFType = "MFNode";

my $mf0 = $MFType->new();
ok !$mf0;
ok !$mf0->length;
is $mf0->length, 0;
is $mf0, '[ ]';

my $mf1 = $MFType->new(new SFNode(new TestNode));
print "#" x 20;
ok $mf1;
ok $mf1->length;
is $mf1->length, 1;


my $mfb = $MFType->new(new SFNode(new TestNode), new SFNode(new TestNode));
ok $mfb;
ok $mfb->length;
is $mfb->length, 2;
is ref $mfb->[0], 'SFNode';
is $mfb->[0]->doubles, '[ 1.2, 3.4, 5.6 ]';

my $mfs = $MFType->new(new SFNode(new TestNode), new SFNode(new TestNode));
ok $mfs;
ok $mfs->length;
is $mfs->length, 2;
is ref $mfs->[0], 'SFNode';
is $mfs->[0]->doubles, '[ 1.2, 3.4, 5.6 ]';

1;
__END__

