package X3DGenerator;
use strict;
use warnings;

use base qw(Exporter);
	
our %EXPORT_TAGS = (
	variables => [qw/
		$TAB
		$SPACE
		$TSPACE
		$BREAK
		$TBREAK
	
		$INDENT
	
		$FLOAT
		$DOUBLE
	/],
	functions => [qw/
		INC_INDENT
		DEC_INDENT
		INDENT_CHAR
	
		PRECISION
	
		TIDY
		CLEAN
	/],
);

our @EXPORT_OK = map { @$_ } values %EXPORT_TAGS;
$EXPORT_TAGS{all} = \@EXPORT_OK;

our ($INDENT_INDEX, $INDENT_CHAR, $PRECISION, $DPRECISION);
our ($TAB, $SPACE, $TSPACE, $BREAK, $TBREAK, $INDENT, $FLOAT, $DOUBLE);

# INDENT
sub INC_INDENT {
	++$INDENT_INDEX;
	$INDENT = $INDENT_CHAR x $INDENT_INDEX;
};

sub DEC_INDENT {
	--$INDENT_INDEX;
	$INDENT = $INDENT_CHAR x $INDENT_INDEX;
};

sub INDENT_INDEX {
	$INDENT_INDEX = shift;
	$INDENT = $INDENT_CHAR x $INDENT_INDEX;
};

sub INDENT_CHAR {
	$INDENT_CHAR = shift;
	$INDENT = $INDENT_CHAR x $INDENT_INDEX;
};


# PRECISION
sub PRECISION {
	$PRECISION = shift;
	$DPRECISION = 2*$PRECISION;

	$FLOAT  = "%0.".$PRECISION."g";
	$DOUBLE = "%0.".$DPRECISION."g";
};


# TIDY
sub TIDY {
	$TAB    = "\t";
	$SPACE  = " ";
	$TSPACE = " ";
	$BREAK  = "\n";
	$TBREAK = "\n";
	
	INDENT_INDEX 0;
	INDENT_CHAR  "  ";
};

sub CLEAN {
	$TAB    = " ";
	$SPACE  = " ";
	$TSPACE = "";
	$BREAK  = " ";
	$TBREAK = "";
	
	INDENT_INDEX 0;
	INDENT_CHAR  "";
};

# STANDARD
PRECISION 12;
&CLEAN;
&TIDY;

1;
__END__
