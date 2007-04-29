package Weed::Parser::Symbols;
use strict;
use warnings;

use Weed::Symbols;
use base 'Weed::Symbols';

our @EXPORT = qw(

  $_break
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

  $_ObjectDescription
  $_FieldDescription
);
#$Id

#$hex
#$float
#$int32
#$double

# General
our $break      = "[\n\r]";
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

# Field types
our @StandardFieldTypes = qw(MFBool MFColor MFColorRGBA MFDouble MFFloat MFImage MFInt32 MFNode MFRotation MFString MFTime MFVec2d MFVec2f MFVec3d MFVec3f SFBool SFColor SFColorRGBA SFDouble SFFloat SFImage SFInt32 SFNode SFRotation SFString SFTime SFVec2d SFVec2f SFVec3d SFVec3f);
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
our $colon         = '\:';

# Other Symbols
our $IdFirstChar = '[^\x30-\x39\x00-\x20\x22\x23\x27\x2b\x2c\x2d\x2e\x5b\x5c\x5d\x7b\x7d\x7f]{1}';
our $IdRestChars = '[^\x00-\x20\x22\x23\x27\x2c\x2e\x5b\x5c\x5d\x7b\x7d\x7f]';
our $Id          = "$IdFirstChar$IdRestChars*";

# General
our $_break      = qr/$break/so;
our $_header     = qr/\A$header/so;
our $_comment    = qr/\G$whitespace*$comment/so;
our $_whitespace = qr/$whitespace/so;

# VRML lexical elements
# Keywords
our $_COMPONENT      = qr/\G$whitespace*$_COMPONENT_/so;
our $_DEF            = qr/\G$whitespace*$_DEF_$whitespace+/so;
our $_EXPORT         = qr/\G$whitespace*$_EXPORT_/so;
our $_EXTERNPROTO    = qr/\G$whitespace*$_EXTERNPROTO_$whitespace+/so;
our $_FALSE          = qr/\G$whitespace*$_FALSE_/so;
our $_IMPORT         = qr/\G$whitespace*$_IMPORT_/so;
our $_IS             = qr/\G$whitespace*$_IS_$whitespace+/so;
our $_META           = qr/\G$whitespace*$_META_/so;
our $_NULL           = qr/\G$whitespace*$_NULL_/so;
our $_PROFILE        = qr/\G$whitespace*$_PROFILE_/so;
our $_PROTO          = qr/\G$whitespace*$_PROTO_$whitespace+/so;
our $_ROUTE          = qr/\G$whitespace*$_ROUTE_$whitespace+/so;
our $_TO             = qr/\G$whitespace+$_TO_$whitespace+/so;
our $_TRUE           = qr/\G$whitespace*$_TRUE_/so;
our $_USE            = qr/\G$whitespace*$_USE_/so;
our $_inputOnly      = qr/\G$whitespace*$_inputOnly_$whitespace+/so;
our $_outputOnly     = qr/\G$whitespace*$_outputOnly_$whitespace+/so;
our $_inputOutput    = qr/\G$whitespace*$_inputOutput_$whitespace+/so;
our $_initializeOnly = qr/\G$whitespace*$_initializeOnly_$whitespace+/so;
our $_eventIn        = qr/\G$whitespace*$_eventIn_$whitespace+/so;
our $_eventOut       = qr/\G$whitespace*$_eventOut_$whitespace+/so;
our $_exposedField   = qr/\G$whitespace*$_exposedField_$whitespace+/so;
our $_field          = qr/\G$whitespace*$_field_$whitespace+/so;

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

our $_NodeTypeId = qr/\G$whitespace*($Id)(?=$whitespace*$open_brace)/so;
our $_ScriptNodeInterface_IS = qr/\G$whitespace*($_eventIn_|$_eventOut_|$_field_)$whitespace+($fieldType)$whitespace+($Id)$whitespace+$_IS_/so;

# CosmoWorlds
our $CosmoWorlds = 'CosmoWorlds\x20V(.*)';

our $_CosmoWorlds = qr/^$CosmoWorlds$/so;
our $_enum        = qr/\G$whitespace*($enum)/so;

our $_nan = qr/\G$whitespace*($_nan_)/so;
our $_inf = qr/\G$whitespace*($_inf_)/so;

# Field type

our $in  = "(?:in)";
our $out = "(?:out)";

our $_ObjectDescription = qr/^\G$whitespace*($Id)(?:$whitespace*$colon$whitespace*($string?))?$whitespace*$open_brace$whitespace*($string?)$whitespace*$close_brace$whitespace*$/so;
our $_FieldDescription = qr/^\G$whitespace*($Id)$whitespace*$open_bracket($in?)$whitespace*($out?)$close_bracket$whitespace*($Id)$whitespace+($string)/so;

1;
__END__