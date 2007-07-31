package X3D::Components::Core::Nodes::MetadataSet;

our $VERSION = '0.002';

use X3D 'MetadataSet : X3DNode, X3DMetadataObject { 
  SFNode   [in,out] metadata  NULL [X3DMetadataObject]
  SFString [in,out] name      ""
  SFString [in,out] reference ""
  MFNode   [in,out] value     [] [X3DMetadataObject]
}';

1;
__END__
