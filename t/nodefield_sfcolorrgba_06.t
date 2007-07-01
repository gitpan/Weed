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

ok my $testNode  = new SFNode( new TestNode );
ok my $sfcolorrgbaId = $testNode->sfcolorrgba->getId;
is $sfcolorrgbaId, $testNode->sfcolorrgba->getId;




$testNode->sfcolorrgba = new SFColorRGBA();
is $testNode->sfcolorrgba, "0 0 0 0";

my $sfcolorrgba = $testNode->sfcolorrgba;
isa_ok $sfcolorrgba, 'X3DField';

is $sfcolorrgbaId, $testNode->sfcolorrgba->getId;
1;
__END__

