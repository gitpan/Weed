#!/usr/bin/perl -w
#package 02_seed
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'Weed::RegularExpressions';
}

use Weed::RegularExpressions qw($_float);

is (X3DObject->SUPER, "Weed::Seed");

ok new Weed::Seed;
ok my $seed1 = new X3DObject;

ok $seed1->getId;
is $seed1->getType,    "X3DObject";
is $seed1->getComment, "";
is join( ', ', $seed1->getHierarchy ), "X3DUniversal, X3DObject";
is $seed1->PACKAGE, "X3DObject";
is $seed1->SUPER,   "Weed::Seed";
is join( ', ', $seed1->PATH ), "Weed::Universal, X3DUniversal, Weed::Seed, X3DObject";
ok $seed1->toString;

is ref $seed1->SCALAR('xxx'), "SCALAR";
is ref $seed1->ARRAY('xxx'),  "ARRAY";
is ref $seed1->HASH('xxx'),   "HASH";

printf "getId        %s\n", $seed1->getId;
printf "getType      %s\n", $seed1->getType;
printf "getComment   %s\n", $seed1->getComment;
printf "getHierarchy %s\n", join ', ', $seed1->getHierarchy;
printf "PACKAGE      %s\n", $seed1->PACKAGE;
printf "SUPER        %s\n", $seed1->SUPER;
printf "ISA          %s\n", join ', ', $seed1->PATH;
#printf "VERSION      %s\n", $seed1->VERSION;
printf "%s\n",              $seed1;

ok my $seed2 = new X3DObject;
printf "%s\n", $seed2->getId;
printf "%s\n", $seed2->getType;

like time, $_float;

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
