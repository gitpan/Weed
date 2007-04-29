package Weed::Prototype;
use strict;
use warnings;

use Weed '
X3DPrototype : X3DChildNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';

sub getTypeName { $_[0]->getName }
sub setTypeName { $_[0]->setName( $_[1] ) }

1;
__END__
