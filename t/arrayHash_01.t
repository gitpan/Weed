#!/usr/bin/perl -w
#package arrayHash_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Test::ArrayHash';
}

print new X3DArrayHash;
#print X3DArrayHash->Weed::Package::stringify;

1;
__END__

