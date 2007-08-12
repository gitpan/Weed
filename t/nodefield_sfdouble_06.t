#!/usr/bin/perl -w
#package nodefield_sfdouble_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode   = new TestNode;
ok my $sfdoubleId = $testNode->sfdouble->getId;
is $sfdoubleId, $testNode->sfdouble->getId;

is $testNode->sfdouble, 0;
is $testNode->sfdouble ? 1 : 0, 0;
is $testNode->sfdouble = 1, 1;
is $testNode->sfdouble ? 1 : 0, 1;
is $testNode->sfdouble = 2, 2;
is $testNode->sfdouble ? 1 : 0, 1;
is $testNode->sfdouble = 2.3, 2.3;
is int $testNode->sfdouble, 2;
ok $testNode->sfdouble == 2.3;
ok !( $testNode->sfdouble == 2 );
ok !( $testNode->sfdouble != 2.3 );
ok $testNode->sfdouble != 2;
ok $testNode->sfdouble == 2.3;
is $testNode->sfdouble, 2.3;
ok $testNode->sfdouble eq 2.3;
ok !( $testNode->sfdouble eq 2 );
ok !( $testNode->sfdouble ne 2.3 );
ok $testNode->sfdouble ne 2;
is $testNode->sfdouble += 0.7, 3;
is $testNode->sfdouble += 1,   4;
is $testNode->sfdouble += 6,   10;
is ++$testNode->sfdouble, 11;
is ++$testNode->sfdouble, 12;
is ++$testNode->sfdouble, 13;
is ++$testNode->sfdouble, 14;
is ++$testNode->sfdouble, 15;

is 20 + $testNode->sfdouble, 35;
is 20 - $testNode->sfdouble, 5;
is $testNode->sfdouble + 5, 20;
is $testNode->sfdouble - 5, 10;
is $testNode->sfdouble * 2, 30;
is $testNode->sfdouble / 2, 7.5;

is $testNode->sfdouble++, 15;
is $testNode->sfdouble++, 16;
is $testNode->sfdouble++, 17;
is $testNode->sfdouble++, 18;
is $testNode->sfdouble++, 19;
is $testNode->sfdouble -= 18, 2;
is $testNode->sfdouble**= 4, 16;
is 2**$testNode->sfdouble, 65536;
is $testNode->sfdouble %= 3, 1;
is $testNode->sfdouble /= 3, 1 / 3;
is 1 / $testNode->sfdouble, 3;

is $testNode->sfdouble = 0.3, 0.3;

is $testNode->sfdouble <=> 0.3, 0.3 <=> 0.3;
is $testNode->sfdouble <=> 0,   0.3 <=> 0;
is $testNode->sfdouble <=> 1,   0.3 <=> 1;
is 0.3 <=> $testNode->sfdouble, 0.3 <=> 0.3;
is 0 <=> $testNode->sfdouble,   0 <=> 0.3;
is 1 <=> $testNode->sfdouble,   1 <=> 0.3;

is $testNode->sfdouble, 0.3;

ok $testNode->sfdouble <= 0.3;
ok $testNode->sfdouble <= 9;
ok $testNode->sfdouble >= 0.3;
ok $testNode->sfdouble >= 0;
ok $testNode->sfdouble < 9;
ok 9 > $testNode->sfdouble;
ok $testNode->sfdouble > 0;
ok 0 < $testNode->sfdouble;

ok !( $testNode->sfdouble cmp 0.3 );
ok !( 0.3 cmp $testNode->sfdouble );
ok $testNode->sfdouble lt 9;
ok $testNode->sfdouble gt 0;

is $testNode->sfdouble . $testNode->sfdouble, "0.30.3";

is $testNode->sfdouble = 1.3, 1.3;
is $testNode->sfdouble, 1.3;

is $testNode->sfdouble x 3, '1.31.31.3';
is 'a' x $testNode->sfdouble, 'a';
is 'a' . $testNode->sfdouble, 'a1.3';
is $testNode->sfdouble . 'a', '1.3a';

is $testNode->sfdouble << 2, 4;
is 2 << $testNode->sfdouble, 4;
is $testNode->sfdouble >> 2, 0;
is 2 >> $testNode->sfdouble, 1;
is $testNode->sfdouble <<= 2, 4;
is $testNode->sfdouble, 4;
is $testNode->sfdouble >>= 1, 2;
is $testNode->sfdouble, 2;
is 'a' x $testNode->sfdouble, 'aa';
is $testNode->sfdouble x 4, 2222;
is $testNode->sfdouble | 1, 3;
is $testNode->sfdouble | 2, 2;
is $testNode->sfdouble & 1, 0;
is $testNode->sfdouble & 2, 2;
is $testNode->sfdouble & 3, 2;
is $testNode->sfdouble |= 1, 3;
is $testNode->sfdouble &= 2, 2;
is $testNode->sfdouble ^= 3, 1;
is - $testNode->sfdouble, -1;
is $testNode->sfdouble = ~$testNode->sfdouble, '4294967294';
is ++$testNode->sfdouble, 4294967295;

is $testNode->sfdouble = 4294967295, 4294967295;
is cos( $testNode->sfdouble ), cos(4294967295);
is sin( $testNode->sfdouble ), sin(4294967295);
is exp( $testNode->sfdouble ), exp(4294967295);
is abs( -$testNode->sfdouble ), abs(-4294967295);
is log( $testNode->sfdouble ), log(4294967295);
is sqrt( $testNode->sfdouble ), sqrt(4294967295);
is $testNode->sfdouble = -1.3, -1.3;
is abs( $testNode->sfdouble ), 1.3;
is !$testNode->sfdouble, !1;
is - $testNode->sfdouble, 1.3;
is $testNode->sfdouble, -1.3;

$testNode->sfdouble->setValue(undef);
is $testNode->sfdouble, 0;
$testNode->sfdouble->setValue("xxx");
is $testNode->sfdouble, 0;

is $testNode->sfdouble = undef, undef;
is $testNode->sfdouble = 123.456, 123.456;
is $testNode->sfdouble = "fdsfds", "fdsfds";
is $testNode->sfdouble, 0;

my $sfdouble = $testNode->sfdouble;
is ref $sfdouble, '';

is $sfdoubleId, $testNode->sfdouble->getId;

$testNode->sffloat->setValue("xxx");
is $testNode->sffloat, 0;
$testNode->sfint32->setValue("xxx");
is $testNode->sfint32, 0;
$testNode->sfstring->setValue(undef);
is $testNode->sfstring, '';
$testNode->sfdouble->setValue("xxx");
is $testNode->sfdouble, 0;
$testNode->sftime->setValue("xxx");
is $testNode->sftime, 0;
$testNode->sfbool->setValue(undef);
is $testNode->sfbool, '';
$testNode->sfnode->setValue(undef);
is $testNode->sfnode, undef;

$testNode->sffloat->setValue(undef);
is $testNode->sffloat, 0;
$testNode->sfint32->setValue(undef);
is $testNode->sfint32, 0;
$testNode->sfstring->setValue(undef);
is $testNode->sfstring, '';
$testNode->sfdouble->setValue(undef);
is $testNode->sfdouble, 0;
$testNode->sftime->setValue(undef);
is $testNode->sftime, 0;
$testNode->sfbool->setValue(undef);
is $testNode->sfbool, "";
$testNode->sfnode->setValue(undef);
is $testNode->sfnode, undef;

1;
__END__

