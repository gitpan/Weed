#!/usr/bin/perl -w
#package nodefield_sftime_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode = new TestNode;
ok my $sftimeId = $testNode->sftime->getId;
is $sftimeId, $testNode->sftime->getId;

is $testNode->sftime, 0;
is $testNode->sftime ? 1 : 0, 0;
is $testNode->sftime = 1, 1;
is $testNode->sftime ? 1 : 0, 1;
is $testNode->sftime = 2, 2;
is $testNode->sftime ? 1 : 0, 1;
is $testNode->sftime = 2.3, 2.3;
is int $testNode->sftime, 2;
ok $testNode->sftime == 2.3;
ok !( $testNode->sftime == 2 );
ok !( $testNode->sftime != 2.3 );
ok $testNode->sftime != 2;
ok $testNode->sftime == 2.3;
is $testNode->sftime, 2.3;
ok $testNode->sftime eq 2.3;
ok !( $testNode->sftime eq 2 );
ok !( $testNode->sftime ne 2.3 );
ok $testNode->sftime ne 2;
is $testNode->sftime += 0.7, 3;
is $testNode->sftime += 1,   4;
is $testNode->sftime += 6,   10;
is ++$testNode->sftime, 11;
is ++$testNode->sftime, 12;
is ++$testNode->sftime, 13;
is ++$testNode->sftime, 14;
is ++$testNode->sftime, 15;
is $testNode->sftime++, 15;
is $testNode->sftime++, 16;
is $testNode->sftime++, 17;
is $testNode->sftime++, 18;
is $testNode->sftime++, 19;
is $testNode->sftime -= 18, 2;
is $testNode->sftime**= 4, 16;
is 2**$testNode->sftime, 65536;
is $testNode->sftime %= 3, 1;
is $testNode->sftime /= 3, 1 / 3;
is 1 / $testNode->sftime, 3;

is $testNode->sftime = 0.3, 0.3;

is $testNode->sftime <=> 0.3, 0.3 <=> 0.3;
is $testNode->sftime <=> 0,   0.3 <=> 0;
is $testNode->sftime <=> 1,   0.3 <=> 1;
is 0.3 <=> $testNode->sftime, 0.3 <=> 0.3;
is 0 <=> $testNode->sftime,   0 <=> 0.3;
is 1 <=> $testNode->sftime,   1 <=> 0.3;

is $testNode->sftime, 0.3;

ok $testNode->sftime <= 0.3;
ok $testNode->sftime <= 9;
ok $testNode->sftime >= 0.3;
ok $testNode->sftime >= 0;
ok $testNode->sftime < 9;
ok 9 > $testNode->sftime;
ok $testNode->sftime > 0;
ok 0 < $testNode->sftime;

ok !( $testNode->sftime cmp 0.3 );
ok !( 0.3 cmp $testNode->sftime );
ok $testNode->sftime lt 9;
ok $testNode->sftime gt 0;

is $testNode->sftime . $testNode->sftime, "0.30.3";

is $testNode->sftime = 1.3, 1.3;
is $testNode->sftime, 1.3;

is $testNode->sftime <<= 2, 4;
is $testNode->sftime, 4;
is $testNode->sftime >>= 1, 2;
is $testNode->sftime, 2;
is $testNode->sftime x 4, 2222;
is $testNode->sftime |= 1, 3;
is $testNode->sftime &= 2, 2;
is $testNode->sftime ^= 3, 1;
is - $testNode->sftime, -1;
is $testNode->sftime = ~$testNode->sftime, '4294967294';
$testNode->sftime = 4294967294;
is ++$testNode->sftime, 4294967295;

is cos( $testNode->sftime ), cos(4294967295);
is sin( $testNode->sftime ), sin(4294967295);
is exp( $testNode->sftime ), exp(4294967295);
is abs( -$testNode->sftime ), abs(-4294967295);
is log( $testNode->sftime ), log(4294967295);
is sqrt( $testNode->sftime ), sqrt(4294967295);
is $testNode->sftime = -1.3, -1.3;
is abs( $testNode->sftime ), 1.3;
is !$testNode->sftime, !1;
is - $testNode->sftime, 1.3;

my $sftime = $testNode->sftime;
is ref $sftime, '';

is $testNode->sftime, '-1.3';
is $testNode->time,   '0';

is $sftimeId, $testNode->sftime->getId;
1;
__END__

