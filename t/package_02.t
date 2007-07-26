#!/usr/bin/perl -w
#package package_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed');
}

print new X3DArray X3DBaseNode->X3DPackage::getPath;
print new X3DArray X3DBaseNode->X3DPackage::getSubroutine('new');

1;
__END__
