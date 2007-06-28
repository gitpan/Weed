package VRML2::Parser::Symbols;
use strict;

BEGIN {
	use Carp;
	use Exporter;

	use vars qw(@ISA @EXPORT);
	@ISA = qw(Exporter);

	@EXPORT = qw(
		$_CosmoWorlds

		$_header
		$_comment
		
		$_float
		$_int32
		$_double
		$_string
		$_enum

		$_nan
		$_inf

		$_DEF
		$_EXTERNPROTO
		$_FALSE
		$_IS
		$_NULL
		$_PROTO
		$_ROUTE
		$_TO
		$_TRUE
		$_USE

		$_eventIn
		$_eventOut
		$_exposedField
		$_field

		$_fieldType

		$_period
		$_open_brace
		$_close_brace
		$_open_bracket
		$_close_bracket
		$_brackets

		$_Id
		$_NodeTypeId
		$_ScriptNodeInterface_IS

		$Id

		$hex
		$float
		$int32
		$double
	);
}

use vars @EXPORT, qw(
	$CosmoWorlds

	$header
	$whitespace
	$comment

	$hex
	$float
	$int32
	$double
	$string
	$enum

	$nan
	$inf

	$DEF
	$EXTERNPROTO
	$FALSE
	$IS
	$NULL
	$PROTO
	$ROUTE
	$TO
	$TRUE
	$USE
	$eventIn
	$eventOut
	$exposedField
	$field

	@StandardFieldTypes  
	@CosmoFieldTypes     
	@ScriptFieldTypes    
	@FieldTypes          
	@VrmlScriptFieldTypes
	$vrmlScriptFieldType 
	$fieldType           

	$period
	$open_brace
	$close_brace
	$open_bracket
	$close_bracket
	$brackets

	$IdFirstChar
	$IdRestChars
	$Id
);


# CosmoWorlds
$CosmoWorlds = 'CosmoWorlds\x20V(.*)';

# General
$header 	= "#VRML V2.0 (utf8)([\x20\t]+(.*?)){0,1}[\n\r]";
$comment	= '\#.*?\n';
$whitespace = '[\x20\n,\t\r]';

# Field Values Symbols
$hex	= '0[xX][0-9a-fA-F]+';
$float  = '[+-]?((([0-9]*\.[0-9]+)|([0-9]+(\.)?))([eE][+-]?[0-9]+)?)';
$int32  = '[+-]?((0[xX][0-9a-fA-F]+)|([0-9]+))';
$double = '[+-]?((([0-9]*\.[0-9]+)|([0-9]+(\.)?))([eE][+-]?[0-9]+)?)';
$string = '.*';
$enum	= '[A-Z]+';

$nan     = 'nan0x7ffffe00';
$inf     = 'inf';

# VRML lexical elements
# Keywords
$DEF          = 'DEF';
$EXTERNPROTO  = 'EXTERNPROTO';
$FALSE        = 'FALSE';
$IS           = 'IS';
$NULL         = 'NULL';
$PROTO        = 'PROTO';
$ROUTE        = 'ROUTE';
$TO           = 'TO';
$TRUE         = 'TRUE';
$USE          = 'USE';
$eventIn      = 'eventIn';
$eventOut     = 'eventOut';
$exposedField = 'exposedField';
$field        = 'field';

# Field types
@StandardFieldTypes   = qw(SFBool SFImage SFTime MFTime SFColor MFColor SFFloat MFFloat SFInt32 MFInt32 SFNode MFNode SFRotation MFRotation SFString MFString SFVec2f MFVec2f SFVec3f MFVec3f);
@CosmoFieldTypes      = qw(SFEnum MFEnum);
@ScriptFieldTypes     = qw(VrmlMatrix);
@FieldTypes           = (@StandardFieldTypes, @CosmoFieldTypes);
@VrmlScriptFieldTypes = (@StandardFieldTypes, @CosmoFieldTypes, @ScriptFieldTypes);
$vrmlScriptFieldType  = join '|', @VrmlScriptFieldTypes;
$fieldType            = join '|', @FieldTypes;

# Terminal symbols
$period 	   = '\.';
$open_brace    = '\{';
$close_brace   = '\}';
$open_bracket  = '\[';
$close_bracket = '\]';

# Other Symbols
$IdFirstChar = '[^\x30-\x39\x00-\x20\x22\x23\x27\x2b\x2c\x2d\x2e\x5b\x5c\x5d\x7b\x7d\x7f]{1}'; 
$IdRestChars = '[^\x00-\x20\x22\x23\x27\x2c\x2e\x5b\x5c\x5d\x7b\x7d\x7f]'; 
$Id = "$IdFirstChar$IdRestChars*"; 


# regex
# CosmoWorlds
$_CosmoWorlds = qr/^$CosmoWorlds$/so;

# General

$_header  = qr/\A$header/so;
$_comment = qr/$whitespace+\#.*?(?=\n)/so;

# Field Values Symbols
$_float  = qr/\G$whitespace*($float)/so;
$_int32  = qr/\G$whitespace*($int32)/so;
$_double = qr/\G$whitespace*($double)/so;
$_string = qr/\G$whitespace*"($string?)(?<!\\)"/so;
$_enum   = qr/\G$whitespace*($enum)/so;

$_nan = qr/\G$whitespace*($nan)/so;
$_inf = qr/\G$whitespace*($inf)/so;

# VRML lexical elements
# Keywords
$_DEF          = qr/\G$whitespace*$DEF$whitespace+/so;
$_EXTERNPROTO  = qr/\G$whitespace*$EXTERNPROTO$whitespace+/so;
$_FALSE        = qr/\G$whitespace*$FALSE/so;
$_IS           = qr/\G$whitespace*$IS$whitespace+/so;
$_NULL         = qr/\G$whitespace*$NULL/so;
$_PROTO        = qr/\G$whitespace*$PROTO$whitespace+/so;
$_ROUTE        = qr/\G$whitespace*$ROUTE$whitespace+/so;
$_TO           = qr/\G$whitespace+$TO$whitespace+/so;
$_TRUE         = qr/\G$whitespace*$TRUE/so;
$_USE          = qr/\G$whitespace*$USE/so;
$_eventIn      = qr/\G$whitespace*$eventIn$whitespace+/so;
$_eventOut     = qr/\G$whitespace*$eventOut$whitespace+/so;
$_exposedField = qr/\G$whitespace*$exposedField$whitespace+/so;
$_field        = qr/\G$whitespace*$field$whitespace+/so;

# Field type
$_fieldType = qr/\G$whitespace*($fieldType)/so;

# Terminal symbols
$_period       = qr/\G$period/so;
$_open_brace    = qr/\G$whitespace*$open_brace/so;
$_close_brace   = qr/\G$whitespace*$close_brace/so;
$_open_bracket  = qr/\G$whitespace*$open_bracket/so;
$_close_bracket = qr/\G$whitespace*$close_bracket/so;
$_brackets      = qr/\G$whitespace*$open_bracket$whitespace*$close_bracket/so;

# Other Symbols
$_Id = qr/\G$whitespace*($Id)/so;
$_NodeTypeId = qr/\G$whitespace*($Id)(?=$whitespace*$open_brace)/so;
$_ScriptNodeInterface_IS = qr/\G$whitespace*($eventIn|$eventOut|$field)$whitespace+($fieldType)$whitespace+($Id)$whitespace+$IS/so;
