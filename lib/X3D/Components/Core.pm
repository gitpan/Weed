package X3D::Components::Core;

our $VERSION = '0.003';

#Abstract types
use X3D::Components::Core::Node;
use X3D::Components::Core::ChildNode;
use X3D::Components::Core::BindableNode;
use X3D::Components::Core::MetadataObject;
use X3D::Components::Core::PrototypeInstance;
use X3D::Components::Core::SensorNode;
use X3D::Components::Core::InfoNode;

#Node reference
use X3D::Namespace;

use X3D::Components::Core::Nodes::MetadataDouble;
use X3D::Components::Core::Nodes::MetadataFloat;
use X3D::Components::Core::Nodes::MetadataInteger;
use X3D::Components::Core::Nodes::MetadataSet;
use X3D::Components::Core::Nodes::MetadataString;
use X3D::Components::Core::Nodes::WorldInfo;

no X3D::Namespace;

1;
__END__
