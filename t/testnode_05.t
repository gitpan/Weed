#!/usr/bin/perl -w
#package testnode_05
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
X3DGenerator->tidy_fields(NO);

ok ! (my $nullNode = new SFNode);
ok my $testNode = new SFNode(new TestNode);

is $testNode->sfbool, 'FALSE';

is $testNode->sfbool = 1, '1';
ok my $b = $testNode->sfbool;
$b--;
is $testNode->sfbool = 1, '1';

$testNode->sfbool = 1;
is $testNode->sfbool, 'TRUE';

$testNode->sfbool = 0;
is $testNode->sfbool, 'FALSE';

is $nullNode, 'NULL';
is $testNode->sfbool, 'FALSE';

is $testNode->doubles, '[ 1.2, 3.4, 5.6 ]';
is $testNode->doubles->[0], 1.2;
is $testNode->doubles->[0]++, 1.2;
is $testNode->doubles->[0]++, 2.2;
is $testNode->doubles->[0]++, 3.2;
is $testNode->doubles->[0], 4.2;
is $testNode->doubles, '[ 4.2, 3.4, 5.6 ]';
is $testNode->doubles->[1]++, 3.4;
is $testNode->doubles->[1]++, 4.4;
is $testNode->doubles->[1]++, 5.4;
is $testNode->doubles, '[ 4.2, 6.4, 5.6 ]';
is $testNode->doubles->[2] = X3DMath::PI, 3.14159265358979;
is $testNode->doubles, '[ 4.2, 6.4, 3.14159265358979 ]';

is $testNode->doubles2 = $testNode->doubles, '[ 4.2, 6.4, 3.14159265358979 ]';
is $testNode->doubles2, '[ 4.2, 6.4, 3.14159265358979 ]';
#is $testNode->doubles2->[1]++, 6.4;
#is $testNode->doubles2, '[ 4.2, 7.4, 3.14159265358979 ]';

is $testNode->doubles, '[ 4.2, 6.4, 3.14159265358979 ]';

#print $testNode->getFields;

__END__

