#!/usr/bin/perl -w
#package nodefield_sfbool_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

ok my $testNode = new TestNode;
ok my $sfboolId = $testNode->sfbool->getId;
is $sfboolId, $testNode->sfbool->getId;

is $testNode->sfbool = 0, 0;
is $testNode->sfbool, NO;
is $testNode->sfbool = 1, 1;
is $testNode->sfbool, YES;

is ++$testNode->sfbool, YES;
is ++$testNode->sfbool, YES;
is $testNode->sfbool, YES;
is --$testNode->sfbool, NO;
is $testNode->sfbool, NO;
is --$testNode->sfbool, YES;
is $testNode->sfbool, YES;

is $testNode->sfbool = !$testNode->sfbool, '';
is $testNode->sfbool, NO;

my $sfbool = $testNode->sfbool;
is ref $sfbool, '';

is $sfboolId, $testNode->sfbool->getId;
1;
__END__

