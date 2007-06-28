package X3DBindableNode;
use strict;
use warnings;

use base qw(X3DChildNode);

use X3DConstants;

=X3DBindableNode : X3DChildNode {
  SFBool [in]     set_bind
  SFNode [in,out] metadata NULL [X3DMetadataObject]
  SFTime [out]    bindTime
  SFBool [out]    isBound
}
=cut

our $FieldDefinitions = [
	new X3DFieldDefinition( inputOnly,  'set_bind', new SFBool() ),
	new X3DFieldDefinition( outputOnly, 'bindTime', new SFTime() ),
	new X3DFieldDefinition( outputOnly, 'isBound',  FALSE ),
];

sub _set_bind {
}

1;
__END__
printf "%s\n", __PACKAGE__->new;
