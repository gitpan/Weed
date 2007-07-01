#!/usr/bin/perl -w
#package nodefield_sfbool_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode  = new SFNode( new TestNode );
ok my $sfboolId = $testNode->sfbool->getId;
is $sfboolId, $testNode->sfbool->getId;

is $testNode->sfbool = 0, 0;
is $testNode->sfbool, "FALSE";
is $testNode->sfbool = 1, 1;
is $testNode->sfbool, "TRUE";

is ++$testNode->sfbool, 1;
is ++$testNode->sfbool, 1;
is $testNode->sfbool, "TRUE";
is --$testNode->sfbool, '';
is $testNode->sfbool, "FALSE";
is --$testNode->sfbool, 1;
is $testNode->sfbool, "TRUE";

is $testNode->sfbool = !$testNode->sfbool, "";
is $testNode->sfbool, "FALSE";

my $sfbool = $testNode->sfbool;
isa_ok $sfbool, 'X3DField';

is $sfboolId, $testNode->sfbool->getId;
1;
__END__

