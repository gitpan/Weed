package X3D::Components::Core::SensorNode;

our $VERSION = '0.002';

use X3D 'X3DSensorNode  : X3DChildNode {
  SFBool [in,out] enabled  TRUE
  SFNode [in,out] metadata NULL [X3DMetadataObject]
  SFBool [out]    isActive
}';

1;
__END__
