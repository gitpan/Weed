package X3DMetadataObject;
use strict;
use warnings;

use rlib "../../";

use base qw(X3DObject);

use X3DFieldDefinition;
use X3DConstants;

=X3DMetadataObject { 
  SFString [in,out] name      ""
  SFString [in,out] reference "" 
}
=cut

our $FieldDefinitions = [
	new X3DFieldDefinition( inputOutput, 'name',      new SFString() ),
	new X3DFieldDefinition( inputOutput, 'reference', new SFString() )
];

1;
__END__
