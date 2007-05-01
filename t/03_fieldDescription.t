#!/usr/bin/perl -w
#package 03_fieldDescription
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::FieldDescription';
}

is( X3DConstants->initializeOnly, 0 );
is( X3DConstants->inputOnly,      1 );
is( X3DConstants->outputOnly,     2 );
is( X3DConstants->inputOutput,    3 );

ok my $fieldDefinition = new X3DFieldDescription( "SFNode", "in", "out", "name", "NULL", "[X3DNode]" );
ok $fieldDefinition = new X3DFieldDescription( "MFNode", "in", undef, "name2", "[]", "[X3DNode]" );
ok $fieldDefinition = new X3DFieldDescription( "SFNode", undef, "out", "name2", "NULL", "[X3DNode]" );
ok $fieldDefinition = new X3DFieldDescription( "MFNode", undef, undef, "name2", "[]", "[X3DNode]" );

__END__
