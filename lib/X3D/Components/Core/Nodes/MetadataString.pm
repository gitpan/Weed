package X3D::Components::Core::Nodes::MetadataString;

our $VERSION = '0.002';

use X3D 'MetadataString : X3DNode, X3DMetadataObject { 
  SFNode   [in,out] metadata  NULL [X3DMetadataObject]
  SFString [in,out] name      ""
  SFString [in,out] reference ""
  MFString [in,out] value     []
}';

1;
__END__
