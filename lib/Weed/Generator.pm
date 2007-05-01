package Weed::Generator;
use strict;
use warnings;

use Math;
use Weed::Symbols;

use package "X3DGenerator";

our $TSPACE;
our $TBREAK;

our $INT32  = "%d";
our $FLOAT  = "%g";
our $DOUBLE = "%g";
our $STRING = "\"%s\"";

our $PRECISION;
our $DPRECISION;

our $INDENT;
our $INDENT_CHAR;
our $INDENT_INDEX = 0;

our $AllFields = 0;

our $AccessTypes = [ $_initializeOnly_, $_inputOnly_, $_outputOnly_, $_inputOutput_ ];

sub TRUE  { $_TRUE_ }
sub FALSE { $_FALSE_ }
sub NULL  { $_NULL_ }

sub tab   { $_tab_ }
sub space { $_space_ }
sub break { $_break_ }

sub period        { $_period_ }
sub open_brace    { $_open_brace_ }
sub close_brace   { $_close_brace_ }
sub open_bracket  { $_open_bracket_ }
sub close_bracket { $_close_bracket_ }
sub colon         { $_colon_ }
sub comma         { $_comma_ }

sub in  { $_in_ }
sub out { $_out_ }

sub nice_space { $TSPACE }
sub nice_break { $TBREAK }

sub INT32  { $INT32 }
sub FLOAT  { $FLOAT }
sub DOUBLE { $DOUBLE }
sub STRING { $STRING }

sub indent { $INDENT }

sub inc {
	++$INDENT_INDEX;
	$INDENT = $INDENT_CHAR x $INDENT_INDEX;
}

sub dec {
	--$INDENT_INDEX;
	$INDENT = $INDENT_CHAR x $INDENT_INDEX;
}

sub INDENT_INDEX {
	shift;
	$INDENT_INDEX = shift;
	$INDENT       = $INDENT_CHAR x $INDENT_INDEX;
}

sub INDENT_CHAR {
	shift;
	$INDENT_CHAR = shift;
	$INDENT      = $INDENT_CHAR x $INDENT_INDEX;
}

sub precision {
	shift;
	$PRECISION  = Math::min( 17, shift() + 1 );
	$DPRECISION = Math::min( 17, 2 * $PRECISION );

	$FLOAT  = "%0.${PRECISION}g";
	$DOUBLE = "%0.${DPRECISION}g";
}

sub nice {
	$TSPACE = &space;
	$TBREAK = &break;

	#INDENT_INDEX 0;
	INDENT_CHAR $_space_ x 2;
}

sub clean {
	$TSPACE = "";
	$TBREAK = "";

	#INDENT_INDEX 0;
	INDENT_CHAR "";
}

# STANDARD
__PACKAGE__->precision(8);
__PACKAGE__->nice;

1;
__END__
#__PACKAGE__->CLEAN;
