#!/usr/bin/perl -w
#package package_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('Weed');
}

is X3DPackage::toString('main'), 'main []';
print X3DPackage::toString('X3DFieldSet');

eval { X3DPackage::getPath('') };
ok $@; eval { };
ok not $@;

eval { X3DPackage::getPath('ThisPackageDoesNotExists') };
ok $@; eval { };
ok not $@;

my $path = X3DFieldSet->X3DPackage::getPath;
is $path->[0], 'X3DFieldSet';
is $path->[1], 'Weed::FieldSet';
is $path->[2], 'X3DArrayHash';
is $path->[3], 'Weed::ArrayHash';
is $path->[4], 'X3DArray';
is $path->[5], 'Weed::Array';
is $path->[6], 'X3DHash';
is $path->[7], 'Weed::Hash';
is $path->[8], 'X3DUniversal';
is $path->[9], 'Weed::Universal';

$path = X3DFieldSet->getHierarchy;
is $path->[0], 'X3DFieldSet';
is $path->[1], 'X3DArrayHash';
is $path->[2], 'X3DArray';
is $path->[3], 'X3DHash';
is $path->[4], 'X3DUniversal';

is X3DPackage::getSupertype('X3DFieldSet'), 'Weed::FieldSet';
is join( ' ', @{ X3DPackage::getSupertypes('X3DFieldSet') } ), 'Weed::FieldSet X3DArrayHash';

#print $_ foreach @{ X3DBaseNode->X3DPackage::Can('new') };

__END__
