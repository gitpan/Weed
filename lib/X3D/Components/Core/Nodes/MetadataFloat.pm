package X3D::Components::Core::Nodes::MetadataFloat;

our $VERSION = '0.002';

use Weed 'MetadataFloat : X3DNode, X3DMetadataObject { 
  SFNode   [in,out] metadata  NULL [X3DMetadataObject]
  SFString [in,out] name      ""
  SFString [in,out] reference ""
  MFFloat  [in,out] value     []
}';

1;
__END__
