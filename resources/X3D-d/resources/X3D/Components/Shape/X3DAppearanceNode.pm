package X3DAppearanceNode;
use strict;
use warnings;

use rlib "../../";

#use X3DConstants;

use base qw(X3DNode);

=X3DChildNode : X3DNode { 
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
=cut

1;
__END__
