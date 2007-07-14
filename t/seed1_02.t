#!/usr/bin/perl -w
#package seed1_02
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

ok CREATE X3DObject;
ok my $seed1 = CREATE X3DObject;

ok $seed1->getId;
is $seed1->getType, "X3DObject";
is ref $seed1->getComments, 'ARRAY';
is join( ', ', $seed1->getHierarchy ), "X3DObject, X3DUniversal";
is $seed1->X3DPackage::getName,      "X3DObject";
is $seed1->X3DPackage::getSupertype, "Weed::Object";
is join( ' ', $seed1->X3DPackage::getSuperpath ), "Weed::Object X3DUniversal Weed::Universal";
ok $seed1->toString;

is ref \$seed1->X3DPackage::Scalar('xxx'), "SCALAR";
is ref \$seed1->X3DPackage::Array('xxx'),  "ARRAY";
is ref \$seed1->X3DPackage::Hash('xxx'),   "HASH";

printf "getId        %s\n", $seed1->getId;
printf "getType      %s\n", $seed1->getType;
#printf "getComments  %s\n", join ', ', $seed1->getComments;
printf "getHierarchy %s\n", join ', ', $seed1->getHierarchy;
printf "PACKAGE      %s\n", $seed1->X3DPackage::getName;
printf "supertype    %s\n", $seed1->X3DPackage::getSupertype;
#printf "VERSION      %s\n", $seed1->VERSION;
printf "%s\n", $seed1;

is $seed1->X3DPackage::getSupertype, 'Weed::Object';

ok my $seed2 = CREATE X3DObject;
printf "%s\n", $seed2->getId;
printf "%s\n", $seed2->getType;

like time, $_float;
ok X3DMath::sum( map { ok( time =~ m/\./ ) } 1 .. 170 );
#ok $seed1->{startTime} =~ m/\./;

ok $seed1;
ok $seed2;
ok $seed1 == $seed1;
ok $seed1 != $seed2;
like $seed1, qr/X3DObject\s*{\s*}/;

printf "%s\n", $seed1;
printf "%s\n", $seed2;
ok $seed1 eq $seed1;
ok $seed1 eq $seed2;

__END__



