#!/usr/bin/perl -w
#package 01_field
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

ok my $sfnode1 = new SFNode, "t 2";
is $sfnode1->getType, "SFNode";
is $sfnode1->getAccessType, X3DConstants->inputOutput;
ok $sfnode1->isReadable;
ok $sfnode1->isWritable;

$sfnode1->setAccessType( X3DConstants->initializeOnly );
is $sfnode1->getAccessType, X3DConstants->initializeOnly;
ok $sfnode1->isReadable;
ok ! $sfnode1->isWritable;

ok my $mfnode1 = new MFNode, "t 3";
ok !$mfnode1->can("setName"), "t 4";

ok $sfnode1 == $sfnode1;
ok $sfnode1 != $mfnode1;

printf "%s\n", $mfnode1;
is $mfnode1->getType,       "MFNode";
is $mfnode1->getAccessType, X3DConstants->inputOutput;
is $mfnode1->getName,       undef;

ok my $field1 = $fieldDefinition1->createField;
is $field1->getAccessType, X3DConstants->inputOutput;
#printf "createField:  %s\n", $field1->get;
printf "toString:     %s\n", $field1;
printf "getHierarchy: %s\n", join ", ", $field1->getHierarchy;

ok my $field2 = $fieldDefinition1->createField;
is $field2->getAccessType, X3DConstants->inputOutput;
ok $field2->isReadable;
ok $field2->isWritable;

ok $field1 != $field2;

$field2->setAccessType( X3DConstants->initializeOnly );
is $field2->getAccessType, X3DConstants->initializeOnly;
is $field1->getAccessType, X3DConstants->inputOutput;
ok $field2->isReadable;
ok !$field2->isWritable;

$field2->setAccessType( X3DConstants->inputOnly );
is $field2->getAccessType, X3DConstants->inputOnly;
is $field1->getAccessType, X3DConstants->inputOutput;
ok !$field2->isReadable;
ok $field2->isWritable;

$field2->setAccessType( X3DConstants->outputOnly );
is $field2->getAccessType, X3DConstants->outputOnly;
is $field1->getAccessType, X3DConstants->inputOutput;
ok $field2->isReadable;
ok !$field2->isWritable;

$field2->setAccessType( X3DConstants->inputOutput );
is $field2->getAccessType, X3DConstants->inputOutput;
is $field1->getAccessType, X3DConstants->inputOutput;
ok $field2->isReadable;
ok $field2->isWritable;

__END__

ok my $field3 = new X3DField( "SFNode", inputOutput, NULL, "[X3DNode]" );
printf "%s\n", $field3;
is $field3->getAccessType, 3;
is $field3->getAccessType, inputOutput;
ok $field3->isReadable;
ok $field3->isWritable;
