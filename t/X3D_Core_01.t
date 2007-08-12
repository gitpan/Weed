#!/usr/bin/perl -w
#package X3D_Core_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

{
	ok my $set = new SFNode(new X3D::MetadataSet("Set"));
	print $set->X3DPackage::toString;
	print $set->getHierarchy;

	X3DGenerator->setOutputStyle("ALL");
	print $set;
}

__END__
  MetadataSet,
  X3DNode,
  X3DBaseNode,
  X3DMetadataObject,
  X3DObject,
  X3DUniversal
