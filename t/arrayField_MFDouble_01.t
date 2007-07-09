#!/usr/bin/perl -w
#package arrayField_MFDouble_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

my $MFType = "MFDouble";

my $mf0 = $MFType->new();
ok !$mf0;
ok !$mf0->length;
is $mf0->length, 0;
is $mf0, '[ ]';

my $mf1 = $MFType->new(123);
ok $mf1;
ok $mf1->length;
is $mf1->length, 1;
is $mf1, '123';

is $mf1->length = 20, 20;
is $mf1->length, 20;
is ++$mf1->length, 21;
is $mf1->length = 3, 3;
is $mf1, '[ 123, 0, 0 ]';

my $mf2 = $MFType->new(123, 234);
ok $mf2;
ok $mf2->length;
is $mf2->length, 2;
is $mf2, '[ 123, 234 ]';

my $mfX = $MFType->new( 1 .. 20 );
is $mfX->length, 20;

is $mfX->[0], 1;

$mfX->[0] = 100;

print $mfX;

1;
__END__

