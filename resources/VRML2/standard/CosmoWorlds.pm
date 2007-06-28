package VRML2::standard::CosmoWorlds;
use strict;

BEGIN {
	use Carp;
	
	use vars qw(@ISA @EXPORT);
	use Exporter;
	@ISA = qw(Exporter);
	@EXPORT = qw($COSMOWORLDS);
}

use vars @EXPORT;
$COSMOWORLDS = join '', <DATA>;

1;
__DATA__
#VRML V2.0 utf8 CosmoWorlds V1.0

PROTO CoKeyframeAnimation [
  field        SFVec3f  bboxCenter      0 0 0
  field        SFVec3f  bboxSize        -1 -1 -1
  field        SFFloat duration    10
  field        SFInt32 framesPerSecond 10
  eventIn      MFNode   addChildren
  eventIn      MFNode   removeChildren
  exposedField MFNode children []
]
{
}

PROTO CoHermiteScalarInterpolator [
  exposedField MFFloat	key 0
  eventIn      SFFloat	set_fraction
  exposedField MFEnum	keyTypes    HERMITE
  exposedField SFBool loop FALSE
  field        SFFloat numFrames 100
  exposedField MFFloat keyValue    0
  eventOut	   SFFloat value_changed
]
{
}

PROTO CoHermiteColorInterpolator [
  exposedField MFFloat	key 0
  eventIn      SFFloat	set_fraction
  exposedField MFEnum	keyTypes    HERMITE
  exposedField SFBool loop FALSE
  field        SFFloat numFrames 100
  exposedField MFColor keyValue    0 0 0
  eventOut	   SFColor value_changed
]
{
}

PROTO CoHermiteOrientationInterpolator [
  exposedField MFFloat	key 0
  eventIn      SFFloat	set_fraction
  exposedField MFEnum	keyTypes    HERMITE
  exposedField SFBool loop FALSE
  field        SFFloat numFrames 100
  exposedField MFRotation keyValue    0 0 1 0
  eventOut	   SFRotation value_changed
]
{
}

PROTO CoHermitePosition2Interpolator [
  exposedField MFFloat	key 0
  eventIn      SFFloat	set_fraction
  exposedField MFEnum	keyTypes    HERMITE
  exposedField SFBool loop FALSE
  field        SFFloat numFrames 100
  exposedField MFVec2f keyValue    0 0
  eventOut	   SFVec2f value_changed
]
{
}

PROTO CoHermitePositionInterpolator [
  exposedField MFFloat	key 0
  eventIn      SFFloat	set_fraction
  exposedField MFEnum	keyTypes    HERMITE
  exposedField SFBool loop FALSE
  field        SFFloat numFrames 100
  exposedField MFVec3f keyValue    0 0 0
  eventOut	   SFVec3f value_changed
]
{
}

PROTO CoHermiteCoordinateInterpolator [
  exposedField MFFloat	key 0
  eventIn      SFFloat	set_fraction
  exposedField MFEnum	keyTypes    HERMITE
  exposedField SFBool loop FALSE
  field        SFFloat numFrames 100
  exposedField MFVec3f keyValue    0 0 0
  eventOut	   SFVec3f value_changed
]
{
}

PROTO CoTextGraph [
  field        SFInt32 textType 0
  exposedField MFString	string []
  field        SFString fontName "defaultFont"
  field        SFBool isBeveled TRUE
  field        MFVec2f bevelCoords [ 0 0, 1.44 1.2, 1.44 0 ]
  field        SFBool renderAlternateImage FALSE
  field        SFNode fontStyle NULL
  field        SFNode alternateImage NULL
  field        SFNode alternateRep NULL
]
{
}
