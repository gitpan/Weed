package X3D::Components::Core::BindableNode;

our $VERSION = '0.002';

use X3D 'X3DBindableNode : X3DChildNode {
  SFBool [in]     set_bind
  SFNode [in,out] metadata NULL [X3DMetadataObject]
  SFTime [out]    bindTime
  SFBool [out]    isBound
}';

1;
__END__
