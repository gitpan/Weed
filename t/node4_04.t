#!/usr/bin/perl -w
#package node4_04
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeWeed';
}

ok my $weed = new Weed;
isa_ok $weed->getField('style'),   'X3DField';
isa_ok $weed->getField('spacing'), 'X3DField';
isa_ok $weed->getField('string'),  'X3DField';

my $style = $weed->getField('style');

is $style, 'BOLD';
is $weed->getField('style'), 'BOLD';

$weed->getField('style')->setValue('PLAIN');
is $weed->getField('style'), 'PLAIN';

$weed->getField('style')->setValue('BOLD');
is $weed->getField('style'), 'BOLD';

isa_ok $weed->getField('style'),   'X3DField';
isa_ok $weed->getField('spacing'), 'X3DField';
isa_ok $weed->getField('string'),  'X3DField';

is $weed->getField('style'),   $weed->getField('style');
is $weed->getField('spacing'), $weed->getField('spacing');
is $weed->getField('string'),  $weed->getField('string');

ok $weed->getField('style') eq 'BOLD';
ok !( $weed->getField('style') eq 'sss' );

ok !( $weed->getField('style') ne 'BOLD' );
ok $weed->getField('style') ne 'sss';

is $weed->getField('spacing'), $weed->getField('spacing');
is $weed->getField('string'),  $weed->getField('string');

is $weed->getField('size'), 1;
my $field = $weed->getField('size');
ok $weed->getField('size')->getId == $field->getId;
 
is $field, 1;
is ++$field, 2;
is $field++, 2;
is $field, 3;
is $weed->getField('size'), 1;
#ok $weed->getField('size')->getId != $field->getId;


1;
__END__



