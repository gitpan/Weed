package MetadataSet;
use strict;
use warnings;

use rlib "../";

use base qw(X3DNode X3DMetadataObject);

use X3DConstants;

our $FieldDefinitions = [ new X3DFieldDefinition( inputOutput, 'value', new MFNode() ) ];

1;
__END__
