package X3D::Components::Core::Node;

our $VERSION = '0.01';

use X3D '
X3DNode : X3DBaseNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';

# node
sub initialize      { }
sub prepareEvents   { }
sub eventsProcessed { }

1;
__END__
