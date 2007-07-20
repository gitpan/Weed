#!/usr/bin/perl -w
#package values_array_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

X3DGenerator->setOutputStyle("COMPACT");
ok my $array = new X3DArray [ 1, 2, 3 ];
ok my $copy = $array->getClone;
ok $array->[0] = 7;
ok $copy->[1] = 9;
is $array, '[ 7, 2, 3 ]';
is $copy, '[ 1, 9, 3 ]';
X3DGenerator->setOutputStyle("CLEAN");
is $copy, '[1 9 3]';

1;
__END__

