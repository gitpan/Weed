#!/usr/bin/perl -w
#package field_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}
use Weed::Perl;

ok my $baseNode = new X3DBaseNode;

is( X3DConstants->initializeOnly, 0 );
is( X3DConstants->inputOnly,      1 );
is( X3DConstants->outputOnly,     2 );
is( X3DConstants->inputOutput,    3 );

my $fieldDefinition1 = new X3DFieldDefinition( "SFNode", YES, YES, "name", undef, "range" );
ok $fieldDefinition1->isIn;
ok $fieldDefinition1->isOut;
is $fieldDefinition1->getAccessType, X3DConstants->inputOutput;
is $fieldDefinition1->getName,       'name';
is $fieldDefinition1->getValue,      undef;
is $fieldDefinition1->getRange,      'range';

ok !( my $sfnode1 = new SFNode );
is $sfnode1->getType,       "SFNode";
is $sfnode1->getName,       '';
is $sfnode1->getValue,      undef;
is $sfnode1->getAccessType, X3DConstants->inputOutput;
#ok $sfnode1->isReadable;
#ok $sfnode1->isWritable;

#$sfnode1->setAccessType( X3DConstants->initializeOnly );
#is $sfnode1->getAccessType, X3DConstants->initializeOnly;
#ok $sfnode1->isReadable;
#ok ! $sfnode1->isWritable, 't 21';

ok !( my $mfnode1 = new MFNode );
ok !$mfnode1->can("setName"), "t 4";

is $mfnode1 <=> $sfnode1, 0;
ok $sfnode1 == $sfnode1;
is $sfnode1 != $sfnode1, NO;

is "$mfnode1" cmp "$sfnode1", 1;
is $mfnode1 cmp $sfnode1, 1;

is "$sfnode1" cmp "$mfnode1", -1;
is $sfnode1 cmp $mfnode1, -1;

ok $mfnode1 ne $sfnode1;
ok $sfnode1 ne $mfnode1;
is $mfnode1 eq $sfnode1, NO;
is $sfnode1 eq $mfnode1, NO;

is $mfnode1 cmp $mfnode1, 0;
is $mfnode1 eq $mfnode1, YES;
is $mfnode1 ne $mfnode1, NO;

printf "%s\n", $mfnode1;
is $mfnode1->getType,       "MFNode";
is $mfnode1->getAccessType, X3DConstants->inputOutput;
is $mfnode1->getName,       '';

ok ref $fieldDefinition1;
ok !( my $field1 = $fieldDefinition1->createField($baseNode) );
is $field1->getAccessType, X3DConstants->inputOutput;
#printf "createField:  %s\n", $field1->get;
printf "toString:     %s\n", $field1;
printf "getHierarchy: %s\n", join ", ", $field1->getHierarchy;

ok !( my $field2 = $fieldDefinition1->createField($baseNode) );
is $field2->getAccessType, X3DConstants->inputOutput;
#ok $field2->isReadable;
#ok $field2->isWritable;

is $field1 != $field2, NO;
is $field1 ne $field2, NO;

ok $field1 == $field2;
ok $field1 eq $field2;

#$field2->setAccessType( X3DConstants->initializeOnly );
#is $field2->getAccessType, X3DConstants->initializeOnly;
#is $field1->getAccessType, X3DConstants->inputOutput;
#ok $field2->isReadable;
#ok !$field2->isWritable;

#$field2->setAccessType( X3DConstants->inputOnly );
##is $field2->getAccessType, X3DConstants->inputOnly;
#is $field1->getAccessType, X3DConstants->inputOutput;
#ok !$field2->isReadable;
#ok $field2->isWritable;

#$field2->setAccessType( X3DConstants->outputOnly );
#is $field2->getAccessType, X3DConstants->outputOnly;
#is $field1->getAccessType, X3DConstants->inputOutput;
#ok $field2->isReadable;
#ok !$field2->isWritable;

#$field2->setAccessType( X3DConstants->inputOutput );
#is $field2->getAccessType, X3DConstants->inputOutput;
#is $field1->getAccessType, X3DConstants->inputOutput;
#ok $field2->isReadable;
#ok $field2->isWritable;

__END__

ok my $field3 = new X3DField( "SFNode", inputOutput, NULL, "[X3DNode]" );
printf "%s\n", $field3;
is $field3->getAccessType, 3;
is $field3->getAccessType, inputOutput;
ok $field3->isReadable;
ok $field3->isWritable;

