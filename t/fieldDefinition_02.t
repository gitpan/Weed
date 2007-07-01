#!/usr/bin/perl -w
#package fieldDefinition_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}
use Weed::Perl;

is( X3DConstants->initializeOnly, 0 );
is( X3DConstants->inputOnly,      1 );
is( X3DConstants->outputOnly,     2 );
is( X3DConstants->inputOutput,    3 );

my $fieldDefinition1 = new X3DFieldDefinition( "SFNode", YES, YES, "name", undef, "[X3DNode]" );
ok $fieldDefinition1->isIn;
ok $fieldDefinition1->isOut;
is $fieldDefinition1->getAccessType, X3DConstants->inputOutput;
is $fieldDefinition1->getName,       'name';
is $fieldDefinition1->getValue,      undef;
is $fieldDefinition1->getRange,      '[X3DNode]';
printf "%s\n", $fieldDefinition1;

my $fieldDefinition2 = new X3DFieldDefinition( "MFNode", YES, NO, "name2", new X3DArray([]), "[X3DNode]" );
ok $fieldDefinition2->isIn;
ok !$fieldDefinition2->isOut;
is $fieldDefinition2->getAccessType, X3DConstants->inputOnly;
is $fieldDefinition2->getName,       'name2';
is ref $fieldDefinition2->getValue, 'X3DArray';
is $fieldDefinition2->getRange, '[X3DNode]';
printf "%s\n", $fieldDefinition2;

$fieldDefinition2 = new X3DFieldDefinition( "MFNode", NO, YES, "name2", new X3DArray, "[X3DNode]" );
ok !$fieldDefinition2->isIn;
ok $fieldDefinition2->isOut;
is $fieldDefinition2->getAccessType, X3DConstants->outputOnly;
is $fieldDefinition2->getName,       'name2';
is ref $fieldDefinition2->getValue, 'X3DArray';
is $fieldDefinition2->getRange, '[X3DNode]';
printf "%s\n", $fieldDefinition2;

$fieldDefinition2 = new X3DFieldDefinition( "MFNode", NO, NO, "name2", new X3DArray([]), "[X3DNode]" );
ok !$fieldDefinition2->isIn;
ok !$fieldDefinition2->isOut;
is $fieldDefinition2->getAccessType, X3DConstants->initializeOnly;
is $fieldDefinition2->getName,       'name2';
is ref $fieldDefinition2->getValue, 'X3DArray';
is $fieldDefinition2->getRange, '[X3DNode]';
printf "%s\n", $fieldDefinition2;

__END__

