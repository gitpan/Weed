#!/usr/bin/perl -w
#package scene_00
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

X3DGenerator->setOutputStyle("ALL");
{
	my $scene = new X3DScene;
	ok $scene;
	print $scene;
	print $scene->getSpecificationVersion;
	print $scene->getEncoding;
	print $scene->getProfile;
	print $scene->getComponents;
	print $scene->getWorldURL;
	#print $scene->getProtos;
	#print $scene->getExternProtos;
	print $scene->getRootNodes;
	print $scene->getRoutes;

	print $scene->specificationVersion;
	print $scene->encoding;
	print $scene->profile;
	print $scene->components;
	print $scene->worldURL;
	print $scene->protos;
	print $scene->externProtos;
	print $scene->rootNodes;
	print $scene->routes;
}
print new X3D::MetadataDouble();

1;
__END__
