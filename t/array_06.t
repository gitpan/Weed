#!/usr/bin/perl -w
#package array_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok !new X3DArray();
ok new X3DArray( 1, 2, 3 );
is new X3DArray( 1, 2, 3 ), '1, 2, 3';
is( X3DArray->new( 1, 2, 3 )->length, 3 );

ok my $array = new X3DArray( 1, 2, 3, 4 );
is $array, '1, 2, 3, 4';
is $array->length, 4;

ok $array = new X3DArray( 1 .. 100 );

ok Math::sum( map {
		my $copy = ~$array;
		$array != $copy
} 1 .. 100 );

ok Math::sum( map {
		my $copy = ~$array;
		$array ne $copy
} 1 .. 100 );

ok $array == -~$array;
ok -~$array == $array;

ok $array = new X3DArray( 'a10', 'a2', 'a1', 'a4', '1a', '10a', '5a', '2a' );
#is -$array, '1, 2, 3, 4';

print sprintf "%010d", 65;
print join ' ', sort qw.a A à À á Á â Â ã Ã ä Ä å Å æ Æ.;

1;
__END__

