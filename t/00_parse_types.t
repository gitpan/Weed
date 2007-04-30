#!/usr/bin/perl -w
#package 00_parse_types
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Parse::FieldTypes';
}

my ($s, $v);

$s = 'TRUE';
is Weed::Parse::FieldTypes::sfboolValue(\$s), '1';
$s = 'FALSE';
ok ! Weed::Parse::FieldTypes::sfboolValue(\$s);

$s = '"holoo"';
is Weed::Parse::FieldTypes::sfstringValue(\$s), 'holoo';

$s = '.89 54 5';
is ref ($v = Weed::Parse::FieldTypes::sfcolorValue(\$s)), 'ARRAY';
is $v->[0], '.89';
is $v->[1], '54';
is $v->[2], '5';

$s = '89 54 5 432 4323';
is ref ($v = Weed::Parse::FieldTypes::sfimageValue(\$s)), 'ARRAY';
is $v->[0], '89';
is $v->[1], '54';
is $v->[2], '5';
is $v->[3]->[0], '432';

$s = '[]';
is ref ($v = Weed::Parse::FieldTypes::mfboolValue(\$s)), 'ARRAY';
$s = '[]';
is ref ($v = Weed::Parse::FieldTypes::mftimeValue(\$s)), 'ARRAY';
$s = '[]';
is @{$v = Weed::Parse::FieldTypes::mftimeValue(\$s)}, '0';
$s = '';
is $v = Weed::Parse::FieldTypes::mftimeValue(\$s), undef;

$s = '[89 54 5 432 4323]';
is ref ($v = Weed::Parse::FieldTypes::mffloatValue(\$s)), 'ARRAY';
is $v->[0], '89';
is $v->[1], '54';
is $v->[2], '5';
is $v->[3], '432';
is $v->[4], '4323';

$s = '[.89 .54 .5 .432 .4323]';
is ref ($v = Weed::Parse::FieldTypes::mffloatValue(\$s)), 'ARRAY';
is $v->[0], '.89';
is $v->[1], '.54';
is $v->[2], '.5';
is $v->[3], '.432';
is $v->[4], '.4323';

$s = '[1.89 21.54 12.5 12.432 21.4323]';
is ref ($v = Weed::Parse::FieldTypes::mffloatValue(\$s)), 'ARRAY';
is $v->[0], '1.89';
is $v->[1], '21.54';
is $v->[2], '12.5';
is $v->[3], '12.432';
is $v->[4], '21.4323';

$s = '[89 54 5 432 4323]';
is ref ($v = Weed::Parse::FieldTypes::mfint32Value(\$s)), 'ARRAY';
is $v->[0], '89';
is $v->[1], '54';
is $v->[2], '5';
is $v->[3], '432';
is $v->[4], '4323';


$s = '[1.89 21.54 12.5 12.432 21.4323]';
is ref ($v = Weed::Parse::FieldTypes::mfdoubleValue(\$s)), 'ARRAY';
is $v->[0], '1.89';
is $v->[1], '21.54';
is $v->[2], '12.5';
is $v->[3], '12.432';
is $v->[4], '21.4323';


$s = '[1 2 3 4, 2 3 4 5  6 7 8 9]';
is ref ($v = Weed::Parse::FieldTypes::mfrotationValue(\$s)), 'ARRAY';
is $v->[0]->[0], '1';
is $v->[1]->[1], '3';
is $v->[2]->[2], '8';
is $v->[2]->[3], '9';


$s = '[1 2 3, 2 3 4  6 7 8]';
is ref ($v = Weed::Parse::FieldTypes::mfvec3fValue(\$s)), 'ARRAY';
is $v->[0]->[0], '1';
is $v->[1]->[1], '3';
is $v->[2]->[2], '8';

$s = '[1 2 3, 2 3 4  6 7 8]';
is ref ($v = Weed::Parse::FieldTypes::mfvec3dValue(\$s)), 'ARRAY';
is $v->[0]->[0], '1';
is $v->[1]->[1], '3';
is $v->[2]->[2], '8';

$s = '[1 2, 2 3  6 7]';
is ref ($v = Weed::Parse::FieldTypes::mfvec2dValue(\$s)), 'ARRAY';
is $v->[0]->[0], '1';
is $v->[1]->[0], '2';
is $v->[2]->[1], '7';



__END__
