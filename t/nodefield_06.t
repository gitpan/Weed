#!/usr/bin/perl -w
#package nodefield_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeWeed';
}

ok my $weed    = new Weed;
ok my $styleId = $weed->style->getId;
is $styleId, $weed->style->getId;
is $weed->metadata, undef;
is ref $weed->metadata, '';
ok not my $sfnode = $weed->metadata;
is ref $sfnode, '';


ok my $sizeId = $weed->size->getId;
is $sizeId, $weed->size->getId;

is $weed->style, 'BOLD';
is ref $weed->style, '';
#isa_ok $weed->style, 'SFString';
#isa_ok $weed->style, 'X3DField';    #8

ok not ref $weed->style;
ok tied $weed->style;
ok ref tied $weed->style;
ok not new SFBool ref $weed->style;
ok new SFBool tied $weed->style;
ok new SFBool ref tied $weed->style;
isa_ok tied $weed->style, 'Weed::Tie::Field';    #15

isa_ok $weed->getField('metadata'), 	'SFNode';
isa_ok $weed->getField('metadata'), 	'SFNode';
isa_ok $weed->getField('family'),		'MFString';
isa_ok $weed->getField('horizontal'),  'SFBool';
isa_ok $weed->getField('justify'),  	'MFString';
isa_ok $weed->getField('string'),		'MFString';
isa_ok $weed->getField('language'), 	'SFString';
isa_ok $weed->getField('leftToRight'), 'SFBool';
isa_ok $weed->getField('size'),  		'SFFloat';
isa_ok $weed->getField('spacing'),  	'SFFloat';
isa_ok $weed->getField('style'), 		'SFString';
isa_ok $weed->getField('topToBottom'), 'SFBool';

isa_ok tied $weed->getFields->getTiedField('metadata'),    'Weed::Tie::Field';
isa_ok tied $weed->getFields->getTiedField('family'), 	  'Weed::Tie::Field';
isa_ok tied $weed->getFields->getTiedField('horizontal'),  'Weed::Tie::Field';
isa_ok tied $weed->getFields->getTiedField('justify'),	  'Weed::Tie::Field';
isa_ok tied $weed->getFields->getTiedField('string'), 	  'Weed::Tie::Field';
isa_ok tied $weed->getFields->getTiedField('language'),    'Weed::Tie::Field';
isa_ok tied $weed->getFields->getTiedField('leftToRight'), 'Weed::Tie::Field';
isa_ok tied $weed->getFields->getTiedField('size'),		  'Weed::Tie::Field';
isa_ok tied $weed->getFields->getTiedField('spacing'),	  'Weed::Tie::Field';
isa_ok tied $weed->getFields->getTiedField('style'),  	  'Weed::Tie::Field';
isa_ok tied $weed->getFields->getTiedField('topToBottom'), 'Weed::Tie::Field';

ok tied $weed->getFields->getTiedField('metadata');
ok tied $weed->getFields->getTiedField('family');
ok tied $weed->getFields->getTiedField('horizontal');
ok tied $weed->getFields->getTiedField('justify');
ok tied $weed->getFields->getTiedField('string');
ok tied $weed->getFields->getTiedField('language');
ok tied $weed->getFields->getTiedField('leftToRight');
ok tied $weed->getFields->getTiedField('size');
ok tied $weed->getFields->getTiedField('spacing');
ok tied $weed->getFields->getTiedField('style');
ok tied $weed->getFields->getTiedField('topToBottom');

is ref $weed->getField('metadata'), 	'SFNode';
is ref $weed->getField('family'),		'MFString';
is ref $weed->getField('horizontal'),  'SFBool';
is ref $weed->getField('justify'),  	'MFString';
is ref $weed->getField('string'),		'MFString';
is ref $weed->getField('language'), 	'SFString';
is ref $weed->getField('leftToRight'), 'SFBool';
is ref $weed->getField('size'),  		'SFFloat';
is ref $weed->getField('spacing'),  	'SFFloat';
is ref $weed->getField('style'), 		'SFString';
is ref $weed->getField('topToBottom'), 'SFBool';

is ref $weed->metadata,    '';
is ref $weed->family,      'X3DArray';
is ref $weed->horizontal,  '';
is ref $weed->justify,     'X3DArray';
is ref $weed->string,      'X3DArray';
is ref $weed->language,    '';
is ref $weed->leftToRight, '';
is ref $weed->size,        '';
is ref $weed->spacing,     '';
is ref $weed->style,       '';
is ref $weed->topToBottom, '';

# isa_ok $weed->metadata,    'X3DField';
# isa_ok $weed->family,      'X3DField';
# isa_ok $weed->horizontal,  'X3DField';
# isa_ok $weed->justify,     'X3DField';
# isa_ok $weed->string,      'X3DField';
# isa_ok $weed->language,    'X3DField';
# isa_ok $weed->leftToRight, 'X3DField';
# isa_ok $weed->size,        'X3DField';
# isa_ok $weed->spacing,     'X3DField';
# isa_ok $weed->style,       'X3DField';
# isa_ok $weed->topToBottom, 'X3DField';

ok my $style = $weed->style;
ok my $name  = $weed->style->getName;

is $style, 'BOLD';
is $weed->style, 'BOLD';

is $weed->style->getName, 'style';
is $weed->style->getName, $name;
#is $style->getName, '';

$weed->style = 'PLAIN';
is $weed->style, 'PLAIN';

$weed->style = 'BOLD';
is $weed->style, 'BOLD';

#isa_ok $weed->style,   'X3DField';
#isa_ok $weed->spacing, 'X3DField';
#isa_ok $weed->string,  'X3DField';

is $weed->style,   $weed->getField('style')->getValue;
is $weed->spacing, $weed->getField('spacing')->getValue;
is $weed->string,  $weed->getField('string')->getValue;

ok $weed->style eq 'BOLD';
ok !( $weed->style eq 'sss' );

ok !( $weed->style ne 'BOLD' );
ok $weed->style ne 'sss';

is $weed->spacing, $weed->getField('spacing');
is $weed->string,  $weed->getField('string');

my $field = $weed->size;                        #25 # $weed->size->clone
is ref $field, '';
#ok $weed->size->getId != $field->getId;         #26
ok $weed->size->getId == $weed->size->getId;    #27

is $field, 1;                                   #28
is ++$field, 2;                                 #29
is $field++, 2;                                 #30
is $field, 3;                                   #31
#ok $weed->size->getId != $field->getId;         #32

$field = $weed->size;                        #25 # $weed->size->clone
#ok $weed->size->getId != $field->getId;         #26
#$field->setValue(123);

ok $weed->size = 2;                             #33
is $weed, 'DEF '.$weed->getName.' Weed {
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

is $weed, 'DEF '.$weed->getName.' Weed {
  size 9
}';

print '';
print $weed->style;

print '';
my $style2 = $weed->style;
print $style2 ;

#sub noop { shift }
#is noop($weed->style)->getId, $weed->style->getId;

#sub test_id { shift->getId }
#is test_id($weed->style), $weed->style->getId;

my $id1 = $weed->style->getId;
my $id2 = $weed->style->getId;
my $id3 = $weed->style->getId;
is $id1, $id2;
is $id1, $id3;
is $id2, $id3;
is $id2, $weed->getField('style')->getId;

#sub test_name{ shift->getName }
#is test_name($weed->style), $weed->style->getName;
#is test_name($weed->style), 'style';

$weed->style = 'BOLD';
#sub test_value { shift->getValue }
#is test_value($weed->style), $weed->style->getValue;
#is test_value($weed->style), 'BOLD';

#sub test_value2 { $_[0]->setValue('BOLDITALIC'); shift }
#is test_value2($weed->style), $weed->style;
#is test_value2($weed->style), '"BOLDITALIC"';

$weed->style->setValue('BOLD');
is $weed->style, 'BOLD';

is $styleId, $weed->style->getId;
is $sizeId,  $weed->size->getId;

1;
__END__

