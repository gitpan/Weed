package X3D::Parser::Symbols;
use strict;
use warnings;

use base qw(Exporter);

our @EXPORT = qw(

  $_header
  $_whitespace
  $_comment

  $_COMPONENT
  $_DEF
  $_EXPORT
  $_EXTERNPROTO
  $_FALSE
  $_IMPORT
  $_IS
  $_META
  $_NULL
  $_PROFILE
  $_PROTO
  $_ROUTE
  $_TO
  $_TRUE
  $_USE

  $_inputOnly
  $_outputOnly
  $_inputOutput
  $_initializeOnly

  $_eventIn
  $_eventOut
  $_exposedField
  $_field

  $_period
  $_open_brace
  $_close_brace
  $_open_bracket
  $_close_bracket
  $_brackets

  $_Id
  $_double
  $_fieldType
  $_float
  $_int32
  $_string

  $_nan
  $_inf

  $_NodeTypeId
  $_ScriptNodeInterface_IS

  $_CosmoWorlds
  $_enum
);
#$Id

#$hex
#$float
#$int32
#$double

# General
our $header     = "#VRML V2.0 (utf8)([\x20\t]+(.*?)){0,1}[\n\r]";
our $whitespace = '[\x20\n,\t\r]';
our $comment    = '#(.*?)\n';

# Field Values Symbols
our $hex    = '0[xX][\da-fA-F]+';
our $float  = '[+-]?(?:(?:(?:\d*\.\d+)|(?:\d+(?:\.)?))(?:[eE][+-]?\d+)?)';
our $int32  = '[+-]?(?:(0[xX][\da-fA-F]+)|(?:\d+))';
our $double = $float;
our $string = '.*';
our $enum   = '[A-Z]+';

our $nan = 'nan0x7ffffe00';
our $inf = 'inf';

# X3D Classic VRML encoding lexical elements
# Keywords
our $COMPONENT      = 'COMPONENT';
our $DEF            = 'DEF';
our $EXPORT         = 'EXPORT';
our $EXTERNPROTO    = 'EXTERNPROTO';
our $FALSE          = 'FALSE';
our $IMPORT         = 'IMPORT';
our $IS             = 'IS';
our $META           = 'META';
our $NULL           = 'NULL';
our $PROFILE        = 'PROFILE';
our $PROTO          = 'PROTO';
our $ROUTE          = 'ROUTE';
our $TO             = 'TO';
our $TRUE           = 'TRUE';
our $USE            = 'USE';
our $inputOnly      = 'inputOnly';
our $outputOnly     = 'outputOnly';
our $inputOutput    = 'inputOutput';
our $initializeOnly = 'initializeOnly';

our $eventIn      = 'eventIn';
our $eventOut     = 'eventOut';
our $exposedField = 'exposedField';
our $field        = 'field';

# Field types
our @StandardFieldTypes   = qw(MFBool MFColor MFColorRGBA MFDouble MFFloat MFImage MFInt32 MFNode MFRotation MFString MFTime MFVec2d MFVec2f MFVec3d MFVec3f SFBool SFColor SFColorRGBA SFDouble SFFloat SFImage SFInt32 SFNode SFRotation SFString SFTime SFVec2d SFVec2f SFVec3d SFVec3f);
our @CosmoFieldTypes      = qw(SFEnum MFEnum);
our @ScriptFieldTypes     = qw(VrmlMatrix);
our @FieldTypes           = ( @StandardFieldTypes, @CosmoFieldTypes );
our @VrmlScriptFieldTypes = ( @StandardFieldTypes, @CosmoFieldTypes, @ScriptFieldTypes );
our $vrmlScriptFieldType  = join '|', @VrmlScriptFieldTypes;
our $fieldType            = join '|', @FieldTypes;

# Terminal symbols
our $period        = '\.';
our $open_brace    = '\{';
our $close_brace   = '\}';
our $open_bracket  = '\[';
our $close_bracket = '\]';

# Other Symbols
our $IdFirstChar = '[^\x30-\x39\x00-\x20\x22\x23\x27\x2b\x2c\x2d\x2e\x5b\x5c\x5d\x7b\x7d\x7f]{1}';
our $IdRestChars = '[^\x00-\x20\x22\x23\x27\x2c\x2e\x5b\x5c\x5d\x7b\x7d\x7f]';
our $Id          = "$IdFirstChar$IdRestChars*";

# General
our $_header     = qr/\A$header/so;
our $_comment    = qr/\G$whitespace*$comment/so;
our $_whitespace = qr/\G$whitespace*/so;

# VRML lexical elements
# Keywords
our $_COMPONENT      = qr/\G$whitespace*$COMPONENT/so;
our $_DEF            = qr/\G$whitespace*$DEF$whitespace+/so;
our $_EXPORT         = qr/\G$whitespace*$EXPORT/so;
our $_EXTERNPROTO    = qr/\G$whitespace*$EXTERNPROTO$whitespace+/so;
our $_FALSE          = qr/\G$whitespace*$FALSE/so;
our $_IMPORT         = qr/\G$whitespace*$IMPORT/so;
our $_IS             = qr/\G$whitespace*$IS$whitespace+/so;
our $_META           = qr/\G$whitespace*$META/so;
our $_NULL           = qr/\G$whitespace*$NULL/so;
our $_PROFILE        = qr/\G$whitespace*$PROFILE/so;
our $_PROTO          = qr/\G$whitespace*$PROTO$whitespace+/so;
our $_ROUTE          = qr/\G$whitespace*$ROUTE$whitespace+/so;
our $_TO             = qr/\G$whitespace+$TO$whitespace+/so;
our $_TRUE           = qr/\G$whitespace*$TRUE/so;
our $_USE            = qr/\G$whitespace*$USE/so;
our $_inputOnly      = qr/\G$whitespace*$inputOnly$whitespace+/so;
our $_outputOnly     = qr/\G$whitespace*$outputOnly$whitespace+/so;
our $_inputOutput    = qr/\G$whitespace*$inputOutput$whitespace+/so;
our $_initializeOnly = qr/\G$whitespace*$initializeOnly$whitespace+/so;
our $_eventIn        = qr/\G$whitespace*$eventIn$whitespace+/so;
our $_eventOut       = qr/\G$whitespace*$eventOut$whitespace+/so;
our $_exposedField   = qr/\G$whitespace*$exposedField$whitespace+/so;
our $_field          = qr/\G$whitespace*$field$whitespace+/so;

# Terminal symbols
our $_period        = qr/\G$period/so;
our $_open_brace    = qr/\G$whitespace*$open_brace/so;
our $_close_brace   = qr/\G$whitespace*$close_brace/so;
our $_open_bracket  = qr/\G$whitespace*$open_bracket/so;
our $_close_bracket = qr/\G$whitespace*$close_bracket/so;
our $_brackets      = qr/\G$whitespace*$open_bracket$whitespace*$close_bracket/so;

# Other Symbols
our $_Id        = qr/\G$whitespace*($Id)/so;
our $_double    = qr/\G$whitespace*($double)/so;
our $_fieldType = qr/\G$whitespace*($fieldType)/so;
our $_float     = qr/\G$whitespace*($float)/so;
our $_int32     = qr/\G$whitespace*($int32)/so;
our $_string    = qr/\G$whitespace*"($string?)(?<!\\)"/so;

our $_NodeTypeId             = qr/\G$whitespace*($Id)(?=$whitespace*$open_brace)/so;
our $_ScriptNodeInterface_IS = qr/\G$whitespace*($eventIn|$eventOut|$field)$whitespace+($fieldType)$whitespace+($Id)$whitespace+$IS/so;

# CosmoWorlds
our $CosmoWorlds = 'CosmoWorlds\x20V(.*)';

our $_CosmoWorlds = qr/^$CosmoWorlds$/so;
our $_enum        = qr/\G$whitespace*($enum)/so;

our $_nan = qr/\G$whitespace*($nan)/so;
our $_inf = qr/\G$whitespace*($inf)/so;

# Field type

1;
__END__
