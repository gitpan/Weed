#!/usr/bin/perl -w
#package 06_nodefield
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeWeed';
}

ok my $weed    = new SFNode( new Weed );
ok my $styleId = $weed->style->getId;
is $styleId, $weed->style->getId;
is $weed->metadata, 'NULL';
isa_ok $weed->metadata, 'SFNode';
isa_ok my $sfnode = $weed->metadata, 'SFNode';
isa_ok $sfnode, 'SFNode';


ok my $sizeId = $weed->size->getId;
is $sizeId, $weed->size->getId;

is $weed->style, 'BOLD';
is ref $weed->style, 'SFString';
isa_ok $weed->style, 'SFString';
isa_ok $weed->style, 'X3DField';    #8

ok ref $weed->style;
ok tied $weed->style;
ok ref tied $weed->style;
ok new SFBool ref $weed->style;
ok new SFBool tied $weed->style;
ok new SFBool ref tied $weed->style;
isa_ok tied $weed->style, 'Weed::Tie::Field';    #15

isa_ok $weed->getValue->getField('metadata'),    'SFNode';
isa_ok $weed->getValue->getField('metadata'),    'SFNode';
isa_ok $weed->getValue->getField('family'),      'MFString';
isa_ok $weed->getValue->getField('horizontal'),  'SFBool';
isa_ok $weed->getValue->getField('justify'),     'MFString';
isa_ok $weed->getValue->getField('string'),      'MFString';
isa_ok $weed->getValue->getField('language'),    'SFString';
isa_ok $weed->getValue->getField('leftToRight'), 'SFBool';
isa_ok $weed->getValue->getField('size'),        'SFFloat';
isa_ok $weed->getValue->getField('spacing'),     'SFFloat';
isa_ok $weed->getValue->getField('style'),       'SFString';
isa_ok $weed->getValue->getField('topToBottom'), 'SFBool';

isa_ok tied $weed->getValue->private_getField('metadata'),    'Weed::Tie::Field';
isa_ok tied $weed->getValue->private_getField('family'),      'Weed::Tie::Field';
isa_ok tied $weed->getValue->private_getField('horizontal'),  'Weed::Tie::Field';
isa_ok tied $weed->getValue->private_getField('justify'),     'Weed::Tie::Field';
isa_ok tied $weed->getValue->private_getField('string'),      'Weed::Tie::Field';
isa_ok tied $weed->getValue->private_getField('language'),    'Weed::Tie::Field';
isa_ok tied $weed->getValue->private_getField('leftToRight'), 'Weed::Tie::Field';
isa_ok tied $weed->getValue->private_getField('size'),        'Weed::Tie::Field';
isa_ok tied $weed->getValue->private_getField('spacing'),     'Weed::Tie::Field';
isa_ok tied $weed->getValue->private_getField('style'),       'Weed::Tie::Field';
isa_ok tied $weed->getValue->private_getField('topToBottom'), 'Weed::Tie::Field';

ok tied $weed->getValue->private_getField('metadata');
ok tied $weed->getValue->private_getField('family');
ok tied $weed->getValue->private_getField('horizontal');
ok tied $weed->getValue->private_getField('justify');
ok tied $weed->getValue->private_getField('string');
ok tied $weed->getValue->private_getField('language');
ok tied $weed->getValue->private_getField('leftToRight');
ok tied $weed->getValue->private_getField('size');
ok tied $weed->getValue->private_getField('spacing');
ok tied $weed->getValue->private_getField('style');
ok tied $weed->getValue->private_getField('topToBottom');

is ref $weed->getValue->getField('metadata'),    'SFNode';
is ref $weed->getValue->getField('family'),      'MFString';
is ref $weed->getValue->getField('horizontal'),  'SFBool';
is ref $weed->getValue->getField('justify'),     'MFString';
is ref $weed->getValue->getField('string'),      'MFString';
is ref $weed->getValue->getField('language'),    'SFString';
is ref $weed->getValue->getField('leftToRight'), 'SFBool';
is ref $weed->getValue->getField('size'),        'SFFloat';
is ref $weed->getValue->getField('spacing'),     'SFFloat';
is ref $weed->getValue->getField('style'),       'SFString';
is ref $weed->getValue->getField('topToBottom'), 'SFBool';

is ref $weed->metadata,    'SFNode';
is ref $weed->family,      'MFString';
is ref $weed->horizontal,  'SFBool';
is ref $weed->justify,     'MFString';
is ref $weed->string,      'MFString';
is ref $weed->language,    'SFString';
is ref $weed->leftToRight, 'SFBool';
is ref $weed->size,        'SFFloat';
is ref $weed->spacing,     'SFFloat';
is ref $weed->style,       'SFString';
is ref $weed->topToBottom, 'SFBool';

isa_ok $weed->metadata,    'X3DField';
isa_ok $weed->family,      'X3DField';
isa_ok $weed->horizontal,  'X3DField';
isa_ok $weed->justify,     'X3DField';
isa_ok $weed->string,      'X3DField';
isa_ok $weed->language,    'X3DField';
isa_ok $weed->leftToRight, 'X3DField';
isa_ok $weed->size,        'X3DField';
isa_ok $weed->spacing,     'X3DField';
isa_ok $weed->style,       'X3DField';
isa_ok $weed->topToBottom, 'X3DField';

ok my $style = $weed->style;
ok my $name  = $weed->style->getName;

is $style, 'BOLD';
is $weed->style, 'BOLD';

is $weed->style->getName, 'style';
is $weed->style->getName, $name;
is $style->getName, '';

$weed->style = 'PLAIN';
is $weed->style, 'PLAIN';

$weed->style = 'BOLD';
is $weed->style, 'BOLD';

isa_ok $weed->style,   'X3DField';
isa_ok $weed->spacing, 'X3DField';
isa_ok $weed->string,  'X3DField';

is $weed->style,   $weed->getValue->getField('style');
is $weed->spacing, $weed->getValue->getField('spacing');
is $weed->string,  $weed->getValue->getField('string');

ok $weed->style eq 'BOLD';
ok !( $weed->style eq 'sss' );

ok !( $weed->style ne 'BOLD' );
ok $weed->style ne 'sss';

is $weed->spacing, $weed->getValue->getField('spacing');
is $weed->string,  $weed->getValue->getField('string');

my $field = $weed->size;                        #25 # $weed->size->clone
isa_ok $field, 'X3DField';
ok $weed->size->getId != $field->getId;         #26
ok $weed->size->getId == $weed->size->getId;    #27

is $field, 1;                                   #28
is ++$field, 2;                                 #29
is $field++, 2;                                 #30
is $field, 3;                                   #31
#ok $weed->size->getId != $field->getId;         #32

$field = $weed->size;                        #25 # $weed->size->clone
ok $weed->size->getId != $field->getId;         #26
$field->setValue(123);

ok $weed->size = 2;                             #33
is $weed, 'Weed {
  size 2
}';                                             #34

is ++$weed->size, 3;                            #115
is ++$weed->size, 4;                            #116
is ++$weed->size, 5;                            #117
is ++$weed->size, 6;                            #118
is $weed->size++, 6;
is $weed->size++, 7;
is $weed->size++, 8;
is $weed->size, 9;

is $weed, 'Weed {
  size 9
}';

print '';
print $weed->style;

print '';
my $style2 = $weed->style;
print $style2 ;

sub noop { shift }
is noop($weed->style)->getId, $weed->style->getId;

sub test_id { shift->getId }
is test_id($weed->style), $weed->style->getId;

my $id1 = $weed->style->getId;
my $id2 = $weed->style->getId;
my $id3 = $weed->style->getId;
is $id1, $id2;
is $id1, $id3;
is $id2, $id3;
is $id2, $weed->getValue->getField('style')->getId;

sub test_name{ shift->getName }
is test_name($weed->style), $weed->style->getName;
is test_name($weed->style), 'style';

$weed->style = 'BOLD';
sub test_value { shift->getValue }
is test_value($weed->style), $weed->style;
is test_value($weed->style), 'BOLD';

sub test_value2 { $_[0]->setValue('BOLDITALIC'); shift }
is test_value2($weed->style), $weed->style;
is test_value2($weed->style), 'BOLDITALIC';

$weed->style->setValue('BOLD');
is $weed->style, 'BOLD';

is $styleId, $weed->style->getId;
is $sizeId,  $weed->size->getId;

1;
__END__
