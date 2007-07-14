#!/usr/bin/perl -w
#package nodefield_sfint32_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode  = new SFNode( new TestNode );
ok my $sfint32Id = $testNode->sfint32->getId;
is $sfint32Id, $testNode->sfint32->getId;

is $testNode->sfint32, 0;
is $testNode->sfint32 ? 1 : 0, 0;
is $testNode->sfint32 = 1, 1;
is $testNode->sfint32 ? 1 : 0, 1;
is $testNode->sfint32 = 2, 2;
is $testNode->sfint32 ? 1 : 0, 1;
is $testNode->sfint32 = 2.3, 2.3;
is int $testNode->sfint32, 2;
ok $testNode->sfint32 == 2;
ok !( $testNode->sfint32 == 3 );
ok !( $testNode->sfint32 != 2 );
ok $testNode->sfint32 != 3;
ok $testNode->sfint32 == 2;
is $testNode->sfint32, 2;
ok $testNode->sfint32 eq 2;
ok !( $testNode->sfint32 eq 3 );
ok !( $testNode->sfint32 ne 2 );
ok $testNode->sfint32 ne 3;

ok $testNode->sfint32 == 2;
ok $testNode->sfint32->getValue == 2;

is $testNode->sfint32 += 1.7, 3;
is $testNode->sfint32->getValue, 3;

is $testNode->sfint32 += 1,   4;
is $testNode->sfint32 += 6,   10;
is ++$testNode->sfint32, 11;
is ++$testNode->sfint32, 12;
is ++$testNode->sfint32, 13;
is ++$testNode->sfint32, 14;
is ++$testNode->sfint32, 15;
is $testNode->sfint32++, 15;
is $testNode->sfint32++, 16;
is $testNode->sfint32++, 17;
is $testNode->sfint32++, 18;
is $testNode->sfint32++, 19;
is $testNode->sfint32 -= 18, 2;
is $testNode->sfint32**= 4, 16;
is 2**$testNode->sfint32, 65536;
is $testNode->sfint32 %= 3, 1;
is $testNode->sfint32 /= 1/3, 3;
is 1 / $testNode->sfint32, 1/3;

is $testNode->sfint32 = 0.3, 0.3;
is $testNode->sfint32, 0;

is $testNode->sfint32 <=> 0.3, 0 <=> 0.3;
is $testNode->sfint32 <=> 0,   0 <=> 0;
is $testNode->sfint32 <=> 1,   0 <=> 1;
is 0.3 <=> $testNode->sfint32, 0.3 <=> 0;
is 0 <=> $testNode->sfint32,   0 <=> 0;
is 1 <=> $testNode->sfint32,   1 <=> 0;

is $testNode->sfint32, 0;

ok $testNode->sfint32 <= 0.3;
ok $testNode->sfint32 <= 9;
ok $testNode->sfint32 >= -1;
ok $testNode->sfint32 >= 0;
ok $testNode->sfint32 < 9;
ok 9 > $testNode->sfint32;
ok $testNode->sfint32 > -1;
ok -2 < $testNode->sfint32;

ok !( $testNode->sfint32 cmp 0 );
ok !( 0 cmp $testNode->sfint32 );
ok $testNode->sfint32 lt 9;
ok $testNode->sfint32 gt -1;

is $testNode->sfint32 . $testNode->sfint32, "00";

is $testNode->sfint32 = 1.3, 1.3;
is $testNode->sfint32, 1;

is $testNode->sfint32 <<= 2, 4;
is $testNode->sfint32, 4;
is $testNode->sfint32 >>= 1, 2;
is $testNode->sfint32, 2;
is $testNode->sfint32 x 4, 2222;
is $testNode->sfint32 |= 1, 3;
is $testNode->sfint32 &= 2, 2;
is $testNode->sfint32 ^= 3, 1;
is - $testNode->sfint32, -1;

is $testNode->sfint32, 1;
is ~$testNode->sfint32, ~int(1);
is $testNode->sfint32 = ~$testNode->sfint32, 4294967294;
is ~$testNode->sfint32, 1;
is ~~$testNode->sfint32, 4294967294;

$testNode->sfint32 = 4294967294;
is ++$testNode->sfint32, -1;

is cos( $testNode->sfint32 ), cos(4294967295);
is sin( $testNode->sfint32 ), sin(4294967295);
is exp( $testNode->sfint32 ), exp(4294967295);
is abs( -$testNode->sfint32 ), abs(-4294967295);
is log( $testNode->sfint32 ), log(4294967295);
is sqrt( $testNode->sfint32 ), sqrt(4294967295);
is $testNode->sfint32 = -1.3, -1.3;
is abs( $testNode->sfint32 ), 1;
is !$testNode->sfint32, !1;
is $testNode->sfint32, -1;
is - $testNode->sfint32, 1;

my $sfint32 = $testNode->sfint32;
isa_ok $sfint32, 'X3DField';

$testNode->sfint32 = 0b10110;
is $testNode->sfint32 & 0b10011, 0b10010;
is ~$testNode->sfint32, ~0b10110;

is $sfint32Id, $testNode->sfint32->getId;
1;
__END__



