package X3DGenerator;
use strict;
use warnings;

use Math;

our $NULL  = "NULL";
our $TRUE  = "TRUE";
our $FALSE = "FALSE";

our $BREAK  = "\n";
our $SPACE  = " ";
our $TAB    = "\t";
our $TSPACE = " ";
our $TBREAK = "\n";

our $INT32  = "%d";
our $FLOAT  = "%g";
our $DOUBLE = "%g";
our $STRING = "%s";

our $PRECISION;
our $DPRECISION;

our $INDENT_CHAR  = "\t";
our $INDENT_INDEX = 0;
our $INDENT       = "";

our $AllFields = 0;

our $AccessTypes = [ 'initializeOnly', 'inputOnly', 'outputOnly', 'inputOutput' ];

sub INC_INDENT {
	++$INDENT_INDEX;
	$INDENT = $INDENT_CHAR x $INDENT_INDEX;
}

sub DEC_INDENT {
	--$INDENT_INDEX;
	$INDENT = $INDENT_CHAR x $INDENT_INDEX;
}

sub INDENT_INDEX {
	$INDENT_INDEX = shift;
	$INDENT       = $INDENT_CHAR x $INDENT_INDEX;
}

sub INDENT_CHAR {
	$INDENT_CHAR = shift;
	$INDENT      = $INDENT_CHAR x $INDENT_INDEX;
}

sub PRECISION {
	$PRECISION  = Math::min(17, shift() + 1);
	$DPRECISION = Math::min(17, 2 * $PRECISION);

	$FLOAT  = "%0.${PRECISION}g";
	$DOUBLE = "%0.${DPRECISION}g";
}

sub TIDY {
	$TAB    = "\t";
	$SPACE  = " ";
	$TSPACE = " ";
	$BREAK  = "\n";
	$TBREAK = "\n";

	#INDENT_INDEX 0;
	INDENT_CHAR "  ";
}

sub CLEAN {
	$TAB    = " ";
	$SPACE  = " ";
	$TSPACE = "";
	$BREAK  = "\n";
	$TBREAK = "";

	#INDENT_INDEX 0;
	INDENT_CHAR "";
}

# STANDARD
PRECISION 8;
&CLEAN;
&TIDY;

1;
__END__
