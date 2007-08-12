package X3D::Components::Core::Nodes::MetadataInteger;

our $VERSION = '0.003';

use X3D 'MetadataInteger : X3DNode, X3DMetadataObject { 
  SFNode   [in,out] metadata  NULL [X3DMetadataObject]
  SFString [in,out] name      ""
  SFString [in,out] reference ""
  MFInt32  [in,out] value     []
}';

1;
__END__
