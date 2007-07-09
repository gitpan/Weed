#!/usr/bin/perl -w
#package arrayField_MFDouble_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

my $MFType = "MFDouble";
my $SFType = "SFDouble";

print "#" x 23;
my $mfX = $MFType->new( 1 .. 20 );
print "#" x 23;
is $mfX->length, 20;
is scalar @$mfX, 20;
is $#$mfX, 19;

#is ref $mfX->[0], $SFType;
is $mfX->[0] = 100, 100;
is $mfX->[0], 100;

is $mfX->[99] = 100, 100;
is $mfX->[99], 100;

is $mfX->length, 100;
is scalar @$mfX, 100;
is $#$mfX, 99;

is $#$mfX = 29, 29;
is $mfX->length, 30;
is scalar @$mfX, 30;
is $#$mfX, 29;

ok my $tn = new SFNode( new TestNode );
is ref tied $tn->doubles, 'Weed::Tie::Field';
is ref tied @{ $tn->doubles }, 'Weed::Tie::ArrayFieldValue';
is ref $tn->doubles, 'MFDouble';
ok my $doubles = $tn->doubles;
is $tn->doubles, '[ 1.2, 3.4, 5.6 ]';
is $doubles, '[ 1.2, 3.4, 5.6 ]';
is $tn->doubles->[0] = 123, 123;
is my $d = $tn->doubles->[0], 123;
is $tn->doubles->[0], 123;
$d->setValue(1);
is $d, 1;
is $tn->doubles->[0], 123;

is $tn->doubles->[0] = 11, 11;
is $tn->doubles->[0] = 123, 123;
is $d, 1;

my $sd = $tn->sfdouble;
is $sd, 0;
is $tn->sfdouble, 0;
is ref $sd, 'SFDouble';
$sd->setValue(1);
is $tn->sfdouble, 0;
is $sd, 1;

is $doubles->getParents, "{ }";
is $tn->doubles->[0]->getParents, "{ }";

is ref $tn->sfdouble, 'SFDouble';
is ref $tn->doubles->[0], 'SFDouble';

is $tn->doubles, '[ 123, 3.4, 5.6 ]';
is $doubles, '[ 1.2, 3.4, 5.6 ]';

is $tn->doubles->[0]++, 123;
is $tn->doubles->[0]++, 124;
is $tn->doubles->[0]++, 125;
is $tn->doubles->[0], 126;
is ++$tn->doubles->[0], 127;
is ++$tn->doubles->[0], 128;
is ++$tn->doubles->[0], 129;
is ++$tn->doubles->[0], 130;
is $tn->doubles, '[ 130, 3.4, 5.6 ]';

is $d, 1;

1;
__END__

