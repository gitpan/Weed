package Weed::Symbols;
use Weed::Perl;

use base 'Exporter';

our @EXPORT = qw(
  $_in_
  $_out_

  $_tab_
  $_space_
  $_break_

  $_period_
  $_open_brace_
  $_close_brace_
  $_open_bracket_
  $_close_bracket_
  $_colon_
  $_comma_

  $_nan_
  $_inf_

  $_COMPONENT_
  $_DEF_
  $_EXPORT_
  $_EXTERNPROTO_
  $_FALSE_
  $_IMPORT_
  $_IS_
  $_META_
  $_NULL_
  $_PROFILE_
  $_PROTO_
  $_ROUTE_
  $_TO_
  $_TRUE_
  $_USE_

  $_inputOnly_
  $_outputOnly_
  $_inputOutput_
  $_initializeOnly_

  $_eventIn_
  $_eventOut_
  $_exposedField_
  $_field_
);

# concept
our $_in_  = 'in';
our $_out_ = 'out';

# General
our $_tab_   = ' ';
our $_space_ = ' ';
our $_break_ = "\n";

# Terminal symbols
our $_period_        = '.';
our $_open_brace_    = '{';
our $_close_brace_   = '}';
our $_open_bracket_  = '[';
our $_close_bracket_ = ']';
our $_colon_         = ':';
our $_comma_         = ',';

# Field Values Symbols
our $_nan_ = 'nan0x7ffffe00';
our $_inf_ = 'inf';

# X3D Classic VRML encoding lexical elements
# Keywords
our $_COMPONENT_   = 'COMPONENT';
our $_DEF_         = 'DEF';
our $_EXPORT_      = 'EXPORT';
our $_EXTERNPROTO_ = 'EXTERNPROTO';
our $_FALSE_       = 'FALSE';
our $_IMPORT_      = 'IMPORT';
our $_IS_          = 'IS';
our $_META_        = 'META';
our $_NULL_        = 'NULL';
our $_PROFILE_     = 'PROFILE';
our $_PROTO_       = 'PROTO';
our $_ROUTE_       = 'ROUTE';
our $_TO_          = 'TO';
our $_TRUE_        = 'TRUE';
our $_USE_         = 'USE';

our $_inputOnly_      = 'inputOnly';
our $_outputOnly_     = 'outputOnly';
our $_inputOutput_    = 'inputOutput';
our $_initializeOnly_ = 'initializeOnly';

our $_eventIn_      = 'eventIn';
our $_eventOut_     = 'eventOut';
our $_exposedField_ = 'exposedField';
our $_field_        = 'field';

1;
__END__
