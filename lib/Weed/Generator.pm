package Weed::Generator;

our $VERSION = '0.008';

use Weed 'X3DGenerator';

use Weed::Symbols;

our $OutputStyle;

our $TSPACE;
our $TBREAK;
our $TCOMMA;

our $INT32  = "%d";
our $FLOAT  = "%g";
our $DOUBLE = "%g";
our $STRING = "\"%s\"";

our $PRECISION;
our $DPRECISION;

our $INDENT;
our $INDENT_CHAR;
our $INDENT_INDEX = 0;

our $TidyFields = YES;

our $AccessTypesX3D  = [ $_initializeOnly_, $_inputOnly_, $_outputOnly_, $_inputOutput_ ];
our $AccessTypesVRML = [ $_field_,          $_eventIn_,   $_eventOut_,   $_exposedField_ ];

use constant TRUE  => $_TRUE_;
use constant FALSE => $_FALSE_;
use constant NULL  => $_NULL_;

use constant DEF => $_DEF_;

use constant tab   => $_tab_;
use constant space => $_space_;
use constant break => $_break_;

use constant period        => $_period_;
use constant open_brace    => $_open_brace_;
use constant close_brace   => $_close_brace_;
use constant open_bracket  => $_open_bracket_;
use constant close_bracket => $_close_bracket_;

use constant colon   => $_colon_;
use constant comma   => $_comma_;
use constant comment => $_comment_;

use constant in  => $_in_;
use constant out => $_out_;

sub tidy_space { $TSPACE }
sub tidy_break { $TBREAK }
sub tidy_comma { $TCOMMA }

sub INT32  { $INT32 }
sub FLOAT  { $FLOAT }
sub DOUBLE { $DOUBLE }
sub STRING { $STRING }
# indent
sub _INDENT { $INDENT_CHAR x $INDENT_INDEX }

sub _INDENT_INDEX {
	$INDENT_INDEX = $_[0];
	$INDENT       = &_INDENT;
}

sub _INDENT_CHAR {
	$INDENT_CHAR = $_[0];
	$INDENT      = &_INDENT;
}

sub indent { $INDENT }

sub inc {
	++$INDENT_INDEX;
	$INDENT = &_INDENT;
}

sub dec {
	--$INDENT_INDEX;
	$INDENT = &_INDENT;
}

# output
sub set_tidy {
	$OutputStyle = "TIDY";

	$TSPACE = &space;
	$TBREAK = &break;
	$TCOMMA = &comma;

	_INDENT_INDEX 0;
	_INDENT_CHAR &space x 2;
}

sub set_compact {
	$OutputStyle = "COMPACT";

	$TSPACE = &space;
	$TBREAK = &space;
	$TCOMMA = &comma;

	_INDENT_INDEX 0;
	_INDENT_CHAR NO;
}

sub set_clean {
	$OutputStyle = "CLEAN";

	$TSPACE = NO;
	$TBREAK = NO;
	$TCOMMA = &space;

	_INDENT_INDEX 0;
	_INDENT_CHAR NO;
}

sub getTidyFields { $TidyFields }
sub setTidyFields { $TidyFields = $_[1] }

# precision
use constant maxPrecision         => 17;
use constant minPrecisionOfFloat  => 6;
use constant minPrecisionOfDouble => 14;

sub getPrecisionOfFloat { $PRECISION - 1 }

sub setPrecisionOfFloat {
	$PRECISION = X3DMath::min( maxPrecision, $_[1] + 1 );
	$FLOAT = "%0.${PRECISION}g";
}

sub getPrecisionOfDouble { $DPRECISION - 1 }

sub setPrecisionOfDouble {
	$DPRECISION = X3DMath::min( maxPrecision, $_[1] + 1 );
	$DOUBLE = "%0.${DPRECISION}g";
}

sub getOutputStyle { $OutputStyle }

sub setOutputStyle {
	&set_tidy    if $_[1] eq "TIDY";
	&set_compact if $_[1] eq "COMPACT";
	&set_clean   if $_[1] eq "CLEAN";
}

# STANDARD
__PACKAGE__->setPrecisionOfFloat(7);
__PACKAGE__->setPrecisionOfDouble(15);
__PACKAGE__->setOutputStyle("CLEAN");
__PACKAGE__->setOutputStyle("TIDY");

1;
__END__
#__PACKAGE__->CLEAN;
