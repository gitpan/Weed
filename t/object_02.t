#!/usr/bin/perl -w
#package object_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'Weed::RegularExpressions';
}
use Weed::Perl;
use Weed::RegularExpressions qw($_float);

is( X3DObject->X3DPackage::getSupertype, "Weed::Object" );

ok new X3DObject;
ok my $object1 = new X3DObject;

ok $object1->getId;
is $object1->getType, "X3DObject";
is ref $object1->getComments, 'X3DArray';
is join( ', ', @{ $object1->getHierarchy } ), "X3DObject, X3DUniversal";
is $object1->X3DPackage::getName,      "X3DObject";
is $object1->X3DPackage::getSupertype, "Weed::Object";
is join( ' ', @{ $object1->X3DPackage::getPath } ), "X3DObject Weed::Object X3DUniversal Weed::Universal";
ok $object1->toString;

is ref \$object1->X3DPackage::Scalar('xxx'), "SCALAR";
is ref \$object1->X3DPackage::Array('xxx'),  "ARRAY";
is ref \$object1->X3DPackage::Hash('xxx'),   "HASH";

printf "getId        %s\n", $object1->getId;
printf "getType      %s\n", $object1->getType;
#printf "getComments  %s\n", join ', ', $object1->getComments;
printf "getHierarchy %s\n", join ', ', $object1->getHierarchy;
printf "PACKAGE      %s\n", $object1->X3DPackage::getName;
printf "supertype    %s\n", $object1->X3DPackage::getSupertype;
#printf "VERSION      %s\n", $object1->VERSION;
printf "%s\n", $object1;

is $object1->X3DPackage::getSupertype, 'Weed::Object';

ok my $object2 = new X3DObject;
printf "%s\n", $object2->getId;
printf "%s\n", $object2->getType;

like time, $_float;
ok X3DMath::sum( map { ok( time =~ m/\./ ) } 1 .. 170 );
#ok $object1->{startTime} =~ m/\./;

ok $object1;
ok $object2;
ok $object1 == $object1;
ok $object1 != $object2;
like $object1, qr/X3DObject\s*{\s*}/;

printf "%s\n", $object1;
printf "%s\n", $object2;
ok $object1 eq $object1;
ok $object1 eq $object2;

__END__



