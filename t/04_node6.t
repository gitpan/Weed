#!/usr/bin/perl -w
#package 04_node6
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeWeed';
}

ok my $weed = new SFNode(new Weed);
ok my $id   = $weed->size->getId;
ok my $size = $weed->size;
ok $weed->size->getId != $size->getId;

is $weed->size, 1;
is $size, 1;

$weed->size = $weed->size + 1;
is $weed->size, 2;

$weed->size = $weed->size - 1;
is $weed->size, 1;

$weed->size = 10 - $weed->size;
is $weed->size, 9;

$weed->size = 2 + $weed->size;
is $weed->size, 11;
is $weed->size + 3, 14;
#is ref($weed->size + 3), NO;

is $size, 1;
is $id,   $weed->size->getId;

is $size++, 1;
is $size++, 2;
is $size, 3;

is $size--, 3;
is $size--, 2;
is $size, 1;

is ++$size, 2;
is ++$size, 3;
is $size, 3;

is --$size, 2;
is --$size, 1;
is $size, 1;

my $s = $size;
#print $size->getId;
is $size += 2, 3;
#print $size->getId;
is $size += 2, 5;
#print $size->getId;
is $size -= 2, 3;
is $size -= 4, -1;
#print $size->getId;

is ($size = $size +0, -1);
is ($size = 0+ $size, -1);
#isa_ok $size, 'SFFloat';

is $s, 1;
#ok $s->getId != $size->getId;

$weed->size = 16;

is $weed->size, 16;

isa_ok $weed->size, 'SFFloat';
is $weed->size += 3, 19;

is $weed->size += 3, 22;
is $weed->size += 3, 25;
is $weed->size -= 3, 22;
is $weed->size -= 3, 19;
is $weed->size, 19;

is ++$weed->size, 20;
is ++$weed->size, 21;
is ++$weed->size, 22;
is $weed->size++, 22;
is $weed->size++, 23;
is $weed->size++, 24;
is $weed->size, 25;

is --$weed->size, 24;
is --$weed->size, 23;
is --$weed->size, 22;
is --$weed->size, 21;
is $weed->size--, 21;
is $weed->size--, 20;
is $weed->size--, 19;
is $weed->size--, 18;
is $weed->size, 17;

is $weed->size, 17;
is $weed->size += 3, 20;
is $weed->size,  20;

is $weed->size += 3, 23;
is $weed->size += 3, 26;
is $weed->size, 26;
is $weed->size, 26;

is $weed->size -= 3, 23;
is $weed->size -= 3, 20;
is $weed->size -= 3, 17;
is $weed->size, 17;

is $size,     -1;
#isa_ok $size, 'SFFloat';
#ok $weed->size->getId != $size->getId;

is $weed->floats, '[ 1, 2, 3 ]';
#$weed->floats->[2] = 3;
#is $weed->floats, '[ 1, 2, 3 ]';

is $weed->getValue->getField('size'),     17;
isa_ok $weed->getValue->getField('size'), 'SFFloat';
is $weed->getValue->getField('size'),     $weed->size;
is $weed->getValue->getField('size')->getId, $weed->size->getId;
is $weed->getValue->getField('size')->getId, $id;
is $weed->size->getId, $id;

1;
__END__


isa_ok $weed->getField('style'),   'X3DField';
isa_ok $weed->getField('spacing'), 'X3DField';
isa_ok $weed->getField('string'),  'X3DField';

my $style = $weed->style;

is $style, '"BOLD"';
is $weed->style, '"BOLD"';

$weed->style = 'PLAIN';
is $weed->style, '"PLAIN"';

$weed->style = 'BOLD';
is $weed->style, '"BOLD"';

isa_ok $weed->style,   'X3DField';
isa_ok $weed->spacing, 'X3DField';
isa_ok $weed->string,  'X3DField';

is $weed->style,   $weed->getField('style');
is $weed->spacing, $weed->getField('spacing');
is $weed->string,  $weed->getField('string');

ok $weed->style eq 'BOLD';
is $weed->style eq 'BOLD', "TRUE";
ok !( $weed->style eq 'sss' );
is $weed->style eq 'sss', "FALSE";

ok !( $weed->style ne 'BOLD' );
is $weed->style ne 'BOLD', "FALSE";
ok $weed->style ne 'sss';
is $weed->style ne 'sss',  "TRUE";

is $weed->spacing, $weed->getField('spacing');
is $weed->string,  $weed->getField('string');

my $field = $weed->size;
is $weed->size->getId, $field->getId;
 
#is $field, 1;
#is ++$field, 2;
#is $field++, 2;
#is $field, 3;
#is $weed->size->getId, $field->getId;

#print ++( $weed->size );
#print ++( $weed->size );
#print ++( $weed->size );
#print ($weed->size)++;
