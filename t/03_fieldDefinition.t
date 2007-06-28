#!/usr/bin/perl -w
#package 03_fieldDefinition
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

ok my $fieldDefinition = new X3DFieldDefinition( "SFNode", YES, YES, "name", '', "[X3DNode]" );
ok $fieldDefinition = new X3DFieldDefinition( "MFNode", YES, NO, "name2", [], "[X3DNode]" );
ok $fieldDefinition = new X3DFieldDefinition( "SFNode", NO, YES, "name2", '', "[X3DNode]" );
ok $fieldDefinition = new X3DFieldDefinition( "MFNode", NO, NO, "name2", [], "[X3DNode]" );

__END__
