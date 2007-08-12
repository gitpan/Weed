#!/usr/bin/perl -w
#package nodefield_sfcolorrgba_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode  = new TestNode;
ok my $sfcolorrgbaId = $testNode->sfcolorrgba->getId;
is $sfcolorrgbaId, $testNode->sfcolorrgba->getId;

$testNode->sfcolorrgba = [@{SFVec4f->new(1, 2, 3, 4) / 10}];
is $testNode->sfcolorrgba->[0], '0.1';
is $testNode->sfcolorrgba->[1], '0.2';
is $testNode->sfcolorrgba->[2], '0.3';
is $testNode->sfcolorrgba->[3], '0.4';
is $testNode->sfcolorrgba->r, '0.1';
is $testNode->sfcolorrgba->g, '0.2';
is $testNode->sfcolorrgba->b, '0.3';
is $testNode->sfcolorrgba->a, '0.4';

$testNode->sfcolorrgba = new SFColorRGBA();
is $testNode->sfcolorrgba, "0 0 0 0";

my $sfcolorrgba = $testNode->sfcolorrgba;
isa_ok $sfcolorrgba, 'X3DColorRGBA';

is $sfcolorrgbaId, $testNode->sfcolorrgba->getId;
1;
__END__

