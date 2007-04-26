#!/usr/bin/perl -w
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

is (X3DConstants->initializeOnly, 0);
is (X3DConstants->inputOnly,      1);
is (X3DConstants->outputOnly,     2);
is (X3DConstants->inputOutput,    3);

my $fieldDefinition1 = new X3DFieldDefinition( "SFNode", "in", "out", "name", "value", "range" );
ok $fieldDefinition1->isIn;
ok $fieldDefinition1->isOut;
is $fieldDefinition1->getAccessType, X3DConstants->inputOutput;
is $fieldDefinition1->getName, 'name';
is $fieldDefinition1->getValue, 'value';
is $fieldDefinition1->getRange, 'range';

my $fieldDefinition2 = new X3DFieldDefinition( "MFNode", "in", undef, "name2", "value2", "range2" );
ok $fieldDefinition2->isIn;
ok ! $fieldDefinition2->isOut;
is $fieldDefinition2->getAccessType, X3DConstants->inputOnly;
is $fieldDefinition2->getName, 'name2';
is $fieldDefinition2->getValue, 'value2';
is $fieldDefinition2->getRange, 'range2';

$fieldDefinition2 = new X3DFieldDefinition( "MFNode", undef, "out", "name2", "value2", "range2" );
ok ! $fieldDefinition2->isIn;
ok $fieldDefinition2->isOut;
is $fieldDefinition2->getAccessType, X3DConstants->outputOnly;
is $fieldDefinition2->getName, 'name2';
is $fieldDefinition2->getValue, 'value2';
is $fieldDefinition2->getRange, 'range2';

$fieldDefinition2 = new X3DFieldDefinition( "MFNode", undef, undef, "name2", "value2", "range2" );
ok ! $fieldDefinition2->isIn;
ok ! $fieldDefinition2->isOut;
is $fieldDefinition2->getAccessType, X3DConstants->initializeOnly;
is $fieldDefinition2->getName, 'name2';
is $fieldDefinition2->getValue, 'value2';
is $fieldDefinition2->getRange, 'range2';


ok my $field1 = $fieldDefinition1->createField;
is $field1->getAccessType, X3DConstants->inputOutput;

ok my $field2 = $fieldDefinition1->createField;
is $field2->getAccessType, X3DConstants->inputOutput;
ok $field2->isReadable;
ok $field2->isWritable;

ok $field1 != $field2;

__END__

ok my $field3 = new X3DField( "SFNode", inputOutput, NULL, "[X3DNode]" );
printf "%s\n", $field3;
is $field3->getAccessType, 3;
is $field3->getAccessType, inputOutput;
ok $field3->isReadable;
ok $field3->isWritable;
