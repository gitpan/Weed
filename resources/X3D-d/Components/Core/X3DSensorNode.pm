package X3DSensorNode;
use strict;
use warnings;

use base qw(X3DChildNode);

use X3DConstants;

=X3DSensorNode  : X3DChildNode {
  SFBool [in,out] enabled  TRUE
  SFNode [in,out] metadata NULL [X3DMetadataObject]
  SFBool [out]    isActive
}
=cut

our $FieldDefinitions = [
	new X3DFieldDefinition( inputOutput, 'enabled',  TRUE ),
	new X3DFieldDefinition( outputOnly,  'isActive', FALSE )
];

sub _set_enabled {
}

1;
__END__
printf "%s\n", __PACKAGE__->new;
