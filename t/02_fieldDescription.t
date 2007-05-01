#!/usr/bin/perl -w
#package 02_fieldDescription
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::FieldDescription';
}

is (X3DConstants->initializeOnly, 0);
is (X3DConstants->inputOnly,      1);
is (X3DConstants->outputOnly,     2);
is (X3DConstants->inputOutput,    3);

my $fieldDefinition1 = new X3DFieldDescription( "SFNode", "in", "out", "name", "NULL", "[X3DNode]" );
ok $fieldDefinition1->isIn;
ok $fieldDefinition1->isOut;
is $fieldDefinition1->getAccessType, X3DConstants->inputOutput;
is $fieldDefinition1->getName, 'name';
is $fieldDefinition1->getValue, 'NULL';
is $fieldDefinition1->getRange, '[X3DNode]';
printf "%s\n", $fieldDefinition1;

my $fieldDefinition2 = new X3DFieldDescription( "MFNode", "in", undef, "name2", "[ ]", "[X3DNode]" );
ok $fieldDefinition2->isIn;
ok ! $fieldDefinition2->isOut;
is $fieldDefinition2->getAccessType, X3DConstants->inputOnly;
is $fieldDefinition2->getName, 'name2';
is $fieldDefinition2->getValue, '[ ]';
is $fieldDefinition2->getRange, '[X3DNode]';
printf "%s\n", $fieldDefinition2;

$fieldDefinition2 = new X3DFieldDescription( "MFNode", undef, "out", "name2", "[ ]", "[X3DNode]" );
ok ! $fieldDefinition2->isIn;
ok $fieldDefinition2->isOut;
is $fieldDefinition2->getAccessType, X3DConstants->outputOnly;
is $fieldDefinition2->getName, 'name2';
is $fieldDefinition2->getValue, '[ ]';
is $fieldDefinition2->getRange, '[X3DNode]';
printf "%s\n", $fieldDefinition2;

$fieldDefinition2 = new X3DFieldDescription( "MFNode", undef, undef, "name2", "[ ]", "[X3DNode]" );
ok ! $fieldDefinition2->isIn;
ok ! $fieldDefinition2->isOut;
is $fieldDefinition2->getAccessType, X3DConstants->initializeOnly;
is $fieldDefinition2->getName, 'name2';
is $fieldDefinition2->getValue, '[ ]';
is $fieldDefinition2->getRange, '[X3DNode]';
printf "%s\n", $fieldDefinition2;

__END__
