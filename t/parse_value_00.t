#!/usr/bin/perl -w
#package parse_value_00
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

my ( $s, $v );

$s = 'TRUE';
is Weed::Parse::FieldValue::sfboolValue( \$s ), '1';
$s = 'FALSE';
ok !Weed::Parse::FieldValue::sfboolValue( \$s );

$s = '"a~ha"';
is Weed::Parse::FieldValue::sfstringValue( \$s ), 'a~ha';

$s = '"\"a~ha\""';
is Weed::Parse::FieldValue::sfstringValue( \$s ), '\"a~ha\"';

$s = '.89 54 5';
isa_ok  $v = Weed::Parse::FieldValue::sfcolorValue( \$s ) , 'X3DColor';
is $v->[0], '0.89';
is $v->[1], '54';
is $v->[2], '5';
is scalar @$v, 3;

$s = '.89 54 5 .2';
isa_ok  $v = Weed::Parse::FieldValue::sfcolorRGBAValue( \$s ) , 'X3DColorRGBA';
is $v->[0], '0.89';
is $v->[1], '54';
is $v->[2], '5';
is $v->[3], '0.2';
is scalar @$v, 4;

$s = '.89 54 5  .2';
isa_ok  $v = Weed::Parse::FieldValue::sfrotationValue( \$s ) , 'X3DRotation';
is $v->getX,         '0.89';
is $v->getY,         '54';
is $v->getZ,         '5';
is $v->getAngle,     '0.2';
is $v->elementCount, 4;

$s = '1 2';
isa_ok  $v = Weed::Parse::FieldValue::sfvec2fValue( \$s ) , 'X3DVec2';
is $v->[0], '1';
is $v->[1], '2';
is scalar @$v, 2;

$s = '1 2';
isa_ok  $v = Weed::Parse::FieldValue::sfvec2dValue( \$s ) , 'X3DVec2';
is $v->[0], '1';
is $v->[1], '2';
is scalar @$v, 2;

$s = '1 2 3';
isa_ok  $v = Weed::Parse::FieldValue::sfvec3fValue( \$s ) , 'X3DVec3';
is $v->[0], '1';
is $v->[1], '2';
is $v->[2], '3';
is scalar @$v, 3;

$s = '1 2 3';
isa_ok  $v = Weed::Parse::FieldValue::sfvec3dValue( \$s ) , 'X3DVec3';
is $v->[0], '1';
is $v->[1], '2';
is $v->[2], '3';
is scalar @$v, 3;

$s = '1 2 3 4';
isa_ok  $v = Weed::Parse::FieldValue::sfvec4fValue( \$s ) , 'X3DVec4';
is $v->[0], '1';
is $v->[1], '2';
is $v->[2], '3';
is $v->[3], '4';
is scalar @$v, 4;

$s = '1 2 3 4';
isa_ok  $v = Weed::Parse::FieldValue::sfvec4dValue( \$s ) , 'X3DVec4';
is $v->[0], '1';
is $v->[1], '2';
is $v->[2], '3';
is $v->[3], '4';
is scalar @$v, 4;

$s = '89 54 5 432 4323';
isa_ok  $v = Weed::Parse::FieldValue::sfimageValue( \$s ) , 'X3DImage';
is $v->getWidth,      '89';
is $v->getHeight,     '54';
is $v->getComponents, '5';
is $v->getArray->[0], '432';

$s = '[]';
isa_ok  $v = Weed::Parse::FieldValue::mfboolValue( \$s ) , 'X3DArray';
$s = '[]';
isa_ok  $v = Weed::Parse::FieldValue::mftimeValue( \$s ) , 'X3DArray';
$s = '[]';
is @{ $v = Weed::Parse::FieldValue::mftimeValue( \$s ) }, '0';
$s = '';
is $v = Weed::Parse::FieldValue::mftimeValue( \$s ), undef;

$s = '[89 54 5 432 4323]';
isa_ok  $v = Weed::Parse::FieldValue::mffloatValue( \$s ) , 'X3DArray';
is $v->[0], '89';
is $v->[1], '54';
is $v->[2], '5';
is $v->[3], '432';
is $v->[4], '4323';

$s = '[.89 .54 .5 .432 .4323]';
isa_ok  $v = Weed::Parse::FieldValue::mffloatValue( \$s ) , 'X3DArray';
is $v->[0], '0.89';
is $v->[1], '0.54';
is $v->[2], '0.5';
is $v->[3], '0.432';
is $v->[4], '0.4323';

$s = '[1.89 21.54 12.5 12.432 21.4323]';
isa_ok  $v = Weed::Parse::FieldValue::mffloatValue( \$s ) , 'X3DArray';
is $v->[0], '1.89';
is $v->[1], '21.54';
is $v->[2], '12.5';
is $v->[3], '12.432';
is $v->[4], '21.4323';

$s = '[89 54 5 432 4323]';
isa_ok  $v = Weed::Parse::FieldValue::mfint32Value( \$s ) , 'X3DArray';
is $v->[0], '89';
is $v->[1], '54';
is $v->[2], '5';
is $v->[3], '432';
is $v->[4], '4323';

# $s = '[1.89 21.54 12.5 12.432 21.4323]';
# isa_ok  $v = Weed::Parse::FieldValue::mfdoubleValue( \$s ) , 'X3DArray';
# is $v->[0], '1.89';
# is $v->[1], '21.54';
# is $v->[2], '12.5';
# is $v->[3], '12.432';
# is $v->[4], '21.4323';

$s = '[1 2 3 4, 2 3 4 5  6 7 8 9]';
isa_ok  $v = Weed::Parse::FieldValue::mfrotationValue( \$s ) , 'X3DArray';
is $v->[0]->getX,     '1';
is $v->[1]->getY,     '3';
is $v->[2]->getZ,     '8';
is $v->[2]->getAngle, '9';

$s = '[1 2 3, 2 3 4  6 7 8]';
isa_ok  $v = Weed::Parse::FieldValue::mfvec3fValue( \$s ) , 'X3DArray';
is $v->[0]->[0], '1';
is $v->[1]->[1], '3';
is $v->[2]->[2], '8';

$s = '[1 2 3, 2 3 4  6 7 8]';
isa_ok  $v = Weed::Parse::FieldValue::mfvec3dValue( \$s ) , 'X3DArray';
is $v->[0]->[0], '1';
is $v->[1]->[1], '3';
is $v->[2]->[2], '8';

$s = '[1 2, 2 3  6 7]';
isa_ok  $v = Weed::Parse::FieldValue::mfvec2dValue( \$s ) , 'X3DArray';
is $v->[0]->[0], '1';
is $v->[1]->[0], '2';
is $v->[2]->[1], '7';

my $n = 1000;
$s = '[' . join( ' ', 1 .. $n ) . ']';

sub bench {
	$s =~ /a/go;
	my $v = Weed::Parse::FieldValue::mfdoubleValue( \$s );
	is $v->getLength, $n;
}

&bench foreach 1 .. 4;

__END__

