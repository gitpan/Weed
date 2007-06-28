package X3DChildNode;
use strict;
use warnings;

use base qw(X3DNode);

#use X3DConstants;

=X3DChildNode : X3DNode { 
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
=cut

1;
__END__
printf "%s\n", __PACKAGE__->new;
