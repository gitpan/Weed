package X3D::Components::Core::Nodes::WorldInfo;

our $VERSION = '0.002';

use X3D 'WorldInfo : X3DInfoNode { 
  SFNode   [in,out] metadata NULL [X3DMetadataObject]
  MFString []       info     []
  SFString []       title    ""
}';

1;
__END__
