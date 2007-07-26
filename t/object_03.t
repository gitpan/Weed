#!/usr/bin/perl -w
#package object_03
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok new X3DObject;
ok my $object = new X3DObject;



1;
__END__



