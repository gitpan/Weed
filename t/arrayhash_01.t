#!/usr/bin/perl -w
#package arrayhash_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

#X3DGenerator->compact;
print my $arrayHash = new X3DArrayHash;
ok !$arrayHash;
is int $arrayHash, 0;

$arrayHash->[0] = '1';
print $arrayHash;
ok $arrayHash;
is int $arrayHash, 1;

$arrayHash->clear;
ok !$arrayHash;

$arrayHash->{a} = 'a';
print $arrayHash;
ok $arrayHash;
is int $arrayHash, 1;

$arrayHash->clear;
ok !$arrayHash;

$arrayHash->[0] = '1';
$arrayHash->{a} = 'a';
print $arrayHash;
ok $arrayHash;
is int $arrayHash, 2;

$arrayHash->[1] = '2';
print $arrayHash;
ok $arrayHash;
is int $arrayHash, 3;
is sprintf("%d", $arrayHash), 3;
is sprintf("%g", $arrayHash), 3;

$arrayHash->[2] = $arrayHash->getClone;
print $arrayHash;
ok $arrayHash;
is int $arrayHash, 4;

print X3DArrayHash->Weed::Package::toString;
#print new X3DTest;
#print new X3DTest(1,2,3,4);
#print X3DTest->Weed::Package::toString;

1;
__END__
