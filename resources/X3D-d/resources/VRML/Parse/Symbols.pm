package VRML::Parse::Symbols;
require 5.005;
use strict;
use Carp;

BEGIN {
	use Exporter;
	use vars qw(@ISA @EXPORT);
	@ISA = qw(Exporter);
	@EXPORT = qw(
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
}

use vars @EXPORT;

# CosmoWorlds
$CosmoWorlds = 'CosmoWorlds\x20V(.*)';

# General
$header 	= "#VRML V2.0 (utf8)([\x20\t]+(.*?)){0,1}[\n\r]";
$whitespace = '[\x20\n,\t\r]';
$comment	= '\n?([\x20\n,\t\r]*\#.*?)\n';

# Field Values Symbols
$hex	= '0[xX][0-9a-fA-F]+';
$float  = '[+-]?((([0-9]*\.[0-9]+)|([0-9]+(\.)?))([eE][+-]?[0-9]+)?)';
$int32  = '[+-]?((0[xX][0-9a-fA-F]+)|([0-9]+))';
$double = '[+-]?((([0-9]*\.[0-9]+)|([0-9]+(\.)?))([eE][+-]?[0-9]+)?)';
$string = '.*';
$enum	= '[A-Z]+';

$nan    = 'nan0x7ffffe00';

# VRML lexical elements
# Keywords
$DEF = 'DEF';
$EXTERNPROTO = 'EXTERNPROTO';
$FALSE = 'FALSE';
$IS = 'IS';
$NULL = 'NULL';
$PROTO = 'PROTO';
$ROUTE = 'ROUTE';
$TO = 'TO';
$TRUE = 'TRUE';
$USE = 'USE';
$eventIn = 'eventIn';
$eventOut = 'eventOut';
$exposedField = 'exposedField';
$field = 'field';

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


