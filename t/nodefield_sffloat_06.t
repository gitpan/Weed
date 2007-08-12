#!/usr/bin/perl -w
#package nodefield_sffloat_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode  = new TestNode;
ok my $sffloatId = $testNode->sffloat->getId;
is $sffloatId, $testNode->sffloat->getId;

is $testNode->sffloat, 0;
is $testNode->sffloat ? 1 : 0, 0;
is $testNode->sffloat = 1, 1;
is $testNode->sffloat ? 1 : 0, 1;
is $testNode->sffloat = 2, 2;
is $testNode->sffloat ? 1 : 0, 1;
is $testNode->sffloat = 2.3, 2.3;
is int $testNode->sffloat, 2;
ok $testNode->sffloat == 2.3;
ok !( $testNode->sffloat == 2 );
ok !( $testNode->sffloat != 2.3 );
ok $testNode->sffloat != 2;
ok $testNode->sffloat eq 2.3;
ok !( $testNode->sffloat eq 2 );
ok !( $testNode->sffloat ne 2.3 );
ok $testNode->sffloat ne 2;
is $testNode->sffloat += 0.7, 3;
is $testNode->sffloat += 1,   4;
is $testNode->sffloat += 6,   10;
is ++$testNode->sffloat, 11;
is ++$testNode->sffloat, 12;
is ++$testNode->sffloat, 13;
is ++$testNode->sffloat, 14;
is ++$testNode->sffloat, 15;
is $testNode->sffloat++, 15;
is $testNode->sffloat++, 16;
is $testNode->sffloat++, 17;
is $testNode->sffloat++, 18;
is $testNode->sffloat++, 19;
is $testNode->sffloat -= 18, 2;
is $testNode->sffloat**= 4, 16;
is 2**$testNode->sffloat, 65536;
is $testNode->sffloat %= 3, 1;
is $testNode->sffloat /= 3, 1/3;
is 1 / $testNode->sffloat, 3;

is $testNode->sffloat = 0.3, 0.3;

is $testNode->sffloat <=> 0.3, 0.3 <=> 0.3;
is $testNode->sffloat <=> 0,   0.3 <=> 0;
is $testNode->sffloat <=> 1,   0.3 <=> 1;
is 0.3 <=> $testNode->sffloat, 0.3 <=> 0.3;
is 0 <=> $testNode->sffloat,   0 <=> 0.3;
is 1 <=> $testNode->sffloat,   1 <=> 0.3;

is $testNode->sffloat, 0.3;

ok $testNode->sffloat <= 0.3;
ok $testNode->sffloat <= 9;
ok $testNode->sffloat >= 0.3;
ok $testNode->sffloat >= 0;
ok $testNode->sffloat < 9;
ok 9 > $testNode->sffloat;
ok $testNode->sffloat > 0;
ok 0 < $testNode->sffloat;

ok !( $testNode->sffloat cmp 0.3 );
ok !( 0.3 cmp $testNode->sffloat );
ok $testNode->sffloat lt 9;
ok $testNode->sffloat gt 0;

is $testNode->sffloat . $testNode->sffloat, "0.30.3";

is $testNode->sffloat = 1.3, 1.3;
is $testNode->sffloat, 1.3;

is $testNode->sffloat <<= 2, 4;
is $testNode->sffloat, 4;
is $testNode->sffloat >>= 1, 2;
is $testNode->sffloat, 2;
is $testNode->sffloat x 4, 2222;
is $testNode->sffloat |= 1, 3;
is $testNode->sffloat &= 2, 2;
is $testNode->sffloat ^= 3, 1;
is - $testNode->sffloat, -1;
is $testNode->sffloat = ~$testNode->sffloat, '4294967294';
ok $testNode->sffloat = 4294967294;
is ++$testNode->sffloat, 4294967295;

is cos( $testNode->sffloat ), cos(4294967295);
is sin( $testNode->sffloat ), sin(4294967295);
is exp( $testNode->sffloat ), exp(4294967295);
is abs( -$testNode->sffloat ), abs(-4294967295);
is log( $testNode->sffloat ), log(4294967295);
is sqrt( $testNode->sffloat ), sqrt(4294967295);
is $testNode->sffloat = -1.3, -1.3;
is abs( $testNode->sffloat ), 1.3;
is !$testNode->sffloat, !1;
is - $testNode->sffloat, 1.3;

my $sffloat = $testNode->sffloat;
is ref $sffloat, '';

is $sffloatId, $testNode->sffloat->getId;
1;
__END__

