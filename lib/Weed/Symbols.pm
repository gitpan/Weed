package Weed::Symbols;
use strict;
use warnings;

use base 'Exporter';

our @EXPORT = qw(
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
