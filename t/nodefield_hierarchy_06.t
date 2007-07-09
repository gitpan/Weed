#!/usr/bin/perl -w
#package nodefield_hierarchy_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode = new SFNode( new TestNode );
#$testNode->sfdouble(123);

isa_ok $testNode->sfdouble,   'X3DField';
isa_ok $testNode->say,        'X3DField';
isa_ok $testNode->time,       'X3DField';
isa_ok $testNode->parseFloat, 'X3DField';
isa_ok $testNode->parseInt,   'X3DField';
isa_ok $testNode->getValue->getField("übelst"), 'X3DField';
isa_ok $testNode->getValue->getField("übe::lst"), 'X3DField';
#isa_ok $testNode->getValue->getField("3übe::lst"), 'X3DField';

#is $testNode->YES, YES;
#is $testNode->NO,  NO;

is $testNode->sfdouble->X3DPackage::toString,
  'SFDouble [
  Weed::FieldTypes::SFDouble [ Weed::FieldTypes::BaseFieldTypes::SFNumber [] ]
  X3DField [
    Weed::Field []
    X3DObject [
      Weed::Object []
      X3DUniversal [ Weed::Universal [] ]
    ]
  ]
]';

################################################################################
my $tw = 20;
my $m = $tw;
$m = ++$m + $m++;
$testNode->sfdouble = $tw;
is ++$testNode->sfdouble + $testNode->sfdouble++, $m;

$m = $tw;
$m = ++$m + $m++;
$testNode->sffloat = $tw;
is ++$testNode->sffloat + $testNode->sffloat++, $m;

1;
__END__

