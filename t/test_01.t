#!/usr/bin/perl -w
#package test_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestType';
}

print new TestType;
print new TestType(1,2,3,4);
print TestType->Weed::Package::toString;

1;
__END__
