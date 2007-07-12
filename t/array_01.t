#!/usr/bin/perl -w
#package array_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok !new X3DArray [];
ok new X3DArray [ 1, 2, 3 ];
is new X3DArray( [ 1, 2, 3 ] ), '[ 1, 2, 3 ]';
is( X3DArray->new( 1, 2, 3 )->getLength, 3 );
is( X3DArray->new( [ 1, 2, 3 ] )->getLength, 3 );
is( X3DArray->new( [ 1, 2, 3 ], [ 1, 2, 3 ] )->getLength, 2 );

ok my $array = new X3DArray [ 1, 2, 3, 4 ];
is $array, '[ 1, 2, 3, 4 ]';
is $array->getLength, 4;

ok $array = new X3DArray [ 1 .. 100 ];

ok $array->getValue;
ok @{ $array->getValue } == 100;
ok( X3DArray->new( $array->getValue )->getLength == 100 );
ok $array->getClone->getLength == 100;
ok $array->shuffle->getLength == 100;

is $array <=> 100, 0;
is $array <=> 99,  1;
is $array <=> 101, -1;
ok $array == 100;
ok $array >= 100;
ok $array >= 99;
ok $array > 99;
ok $array <= 100;
ok $array <= 101;
ok $array < 101;

is 100 <=> $array, 0;
is 99 <=> $array,  -1;
is 101 <=> $array, 1;
ok 100 == $array;
ok 100 >= $array;
ok 101 >= $array;
ok 101 > $array;
ok 100 <= $array;
ok 99 <= $array;
ok 99 < $array;

is $array <=> new SFDouble(100), 0;
is $array <=> new SFDouble(99),  1;
is $array <=> new SFDouble(101), -1;
ok $array == new SFDouble(100);
ok $array >= new SFDouble(100);
ok $array >= new SFDouble(99);
ok $array > new SFDouble(99);
ok $array <= new SFDouble(100);
ok $array <= new SFDouble(101);
ok $array < new SFDouble(101);

is new SFDouble(100) <=> $array, 0;
is new SFDouble(99) <=> $array,  -1;
is new SFDouble(101) <=> $array, 1;
ok new SFDouble(100) == $array;
ok new SFDouble(100) >= $array;
ok new SFDouble(101) >= $array;
ok new SFDouble(101) > $array;
ok new SFDouble(100) <= $array;
ok new SFDouble(99) <= $array;
ok new SFDouble(99) < $array;

ok $array == $array;
ok !( $array != $array );

#print $array->shuffle;

ok Math::sum( map {
		$array != $array->shuffle
} 1 .. 1 );

ok Math::sum( map {
		$array ne $array->shuffle
} 1 .. 100 );

ok $array == $array->shuffle->sort;
ok $array->shuffle->sort == $array;

is $array->setLength(-23), undef;
is $array->getLength, 0;
ok X3DArray::isArray($array);

ok $array = new X3DArray [ 'a10', 'a2', 'a1', 'a4', '1a', '10a', '5a', '2a' ];

1;
__END__
