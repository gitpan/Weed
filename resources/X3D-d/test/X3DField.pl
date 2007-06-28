#!perl -w -I "~holger/perl"
use strict;
use warnings;

use rlib "../";

use X3DFieldDefinition;
use X3DConstants;

my $initializeOnly = new X3DFieldDefinition( initializeOnly, "SFVec3f",    "size", [ 2, 2, 2 ] );
my $inputOnly      = new X3DFieldDefinition( inputOnly,      "SFBool",     "set_bind" );
my $outputOnly     = new X3DFieldDefinition( outputOnly,     "SFTime",     "time" );
my $inputOutput    = new X3DFieldDefinition( inputOutput,    "SFRotation", "rotation", [ 0, 0, 1, 0 ] );

my $fdsize = new X3DFieldDefinition( inputOutput, "SFVec3f", "size", [ 2, 2, 2 ] );
my $fdspeed = new X3DFieldDefinition( inputOutput, "SFFloat", "speed", 1 );
my $fdchildren = new X3DFieldDefinition( inputOutput, "MFNode", "children", [] );

printf "%s\n", ref $fdsize;
printf "%s\n", $fdsize->getAccessType;
printf "%s\n", $fdsize->getType;
printf "%s\n", $fdsize->getName;

my $size = $fdsize->getField(undef);
printf "%s\n", ref $size;
printf "%s\n", $size->getAccessType;
printf "%s\n", $size->getType;
printf "%s\n", $size->getName;


#printf "%s\n", new SFDouble();
#printf "%s\n", new MFDouble();

1;
__END__
printf "%s\n", $size->getField(undef);
printf "%s\n", $speed->getField(undef);
printf "%s\n", $children->getField(undef);

printf "%s\n", new SFBool;
printf "%s\n", new SFVec3f;
my $n1 = new MetadataDouble();
my $n2 = new MetadataDouble();
my $n3 = new MetadataDouble();
$n1->name("a");
$n1->value(1);
$n2->name("b");
$n2->value(2);
$n3->name("c");
$n3->value(3);

$n1->getField("name")->addFieldCallback( "name",   $n2 );
$n1->getField("value")->addFieldCallback( "value", $n2 );
$n2->getField("name")->addFieldCallback( "name",   $n3 );
$n2->getField("value")->addFieldCallback( "value", $n3 );
printf "%s\n", $n1;
printf "%s\n", $n2;
printf "%s\n", $n3;
printf "\n";

$n1->name("fueralle");
$n1->value(1.234567890123456789);
$n1->name("füralle");
printf "%s\n", $n1;
printf "%s\n", $n2;
printf "%s\n", $n3;
printf "\n";

$n1->processEvents;
printf "%s\n", $n1;
printf "%s\n", $n2;
printf "%s\n", $n3;
printf "\n";

my $node = new X3DNode();

my $f           = new X3DFieldDefinition( initializeOnly, "f",  new SFBool(1) );
my $iO          = new X3DFieldDefinition( inputOnly,      "iO", new SFBool(1) );
my $oO          = new X3DFieldDefinition( outputOnly,     "iO", new SFBool(1) );
my $inputOutput = new X3DFieldDefinition( inputOutput,    "iO", new SFBool(1) );

$inputOutput->addFieldCallback( "getType",  $node );
$inputOutput->addFieldCallback( "metadata", $node );

$inputOutput->removeFieldCallback( "metadata", $node );

printf "%s\n", $f->getAccessType;
printf "%s\n", $iO->getAccessType;
printf "%s\n", $oO->getAccessType;
printf "%s\n", $inputOutput->getAccessType;

printf "\n";

printf "%s\n", $f->isWritable;
printf "%s\n", $iO->isWritable;
printf "%s\n", $oO->isWritable;
printf "%s\n", $inputOutput->isWritable;

printf "\n";

printf "%s\n", $f->isReadable;
printf "%s\n", $iO->isReadable;
printf "%s\n", $oO->isReadable;
printf "%s\n", $inputOutput->isReadable;

printf "\n";

my $f1 = new X3DFieldDefinition( 0, "b1", new SFBool, "Comment" );
my $f2 = new X3DFieldDefinition( 0, "b2", new SFBool(1) );

printf "%s\n", ref $f1;
printf "%s\n", ref $f2;
printf "%s\n", $f1;
printf "%s\n", $f2;

$f1->setValue(2);
printf "%s\n", $f1->getValue;
printf "%s\n", $f2->getValue;
printf "%s\n", $v;
printf "%s\n", $$v;


use Benchmark;
timethis(1000000, sub { $v = new X3D::Field::SFValue ( ) });
timethis(1000000, sub { $v = new X3D::Field::SFValue (1) });

