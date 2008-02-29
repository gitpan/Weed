#!/usr/bin/perl -w
#package node5_04
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeWeed';
}

ok my $weed = new WeedTest;
ok my $id = $weed->size->getId;
ok my $size = $weed->size;
#ok $weed->size->getId != $size->getId;
is $weed->size, 1;
is $size, 1;
is $weed->size, $size;

is $weed->size = 2, 2;
is $weed->size, 2;

ok $weed->size != $size;
ok !( $weed->size == $size);
ok $weed->size ne $size;
ok !( $weed->size eq $size);

is $weed->size, 2;
$weed->size = $weed->size + 1;
is $weed->size, 3;

is $size, 1;

is $id, $weed->size->getId;
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



