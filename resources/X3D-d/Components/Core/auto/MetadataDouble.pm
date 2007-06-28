package MetadataDouble;
use strict;
use warnings;

use rlib "../", "../../../";

use X3DConstants;

use base qw(X3DNode X3DMetadataObject);

our $FieldDefinitions = [ new X3DFieldDefinition( inputOutput, 'value', new MFDouble() ) ];

1;
__END__
