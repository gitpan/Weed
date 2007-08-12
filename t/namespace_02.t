#!/usr/bin/perl -w
#package namespace_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

is (X3DPackage->getNamespace, '');
Weed::Namespace->import('Weed');
is (X3DPackage->getNamespace, 'Weed');
Weed::Namespace->unimport;
is (X3DPackage->getNamespace, '');
Weed::Namespace->import('X3D');
is (X3DPackage->getNamespace, 'X3D');
Weed::Namespace->unimport;
is (X3DPackage->getNamespace, '');

1;
__END__
