#!/usr/bin/perl -w
#package fieldDefinition_03
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

ok $fieldDefinition = new X3DFieldDefinition( "SFVec2f", NO, NO, "", new X3DVec2, "" );

my $node   = new X3DBaseNode;
my $vec2_1 = $fieldDefinition->createField($node);
my $vec2_2 = $fieldDefinition->createField($node);

is $vec2_1, "0 0";
is $vec2_2, "0 0";

$vec2_1->setValue( 1, 2 );
$vec2_2->setValue( 2, 3 );

is $vec2_1, "1 2";
is $vec2_2, "2 3";

my %tiedFields;

tie $tiedFields{v1}, 'Weed::Tie::Field', $vec2_2;
print "x"x23;
{
print $tiedFields{v1};
}
print "x"x23;
print $tiedFields{v1} *= 2;

sub l : lvalue { $tiedFields{v1} }
print ++l;
print l;

__END__

