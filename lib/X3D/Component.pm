package X3D::Component;
use Weed::Perl;

our $VERSION = '0.002';

use X3D '
X3DComponent : X3DBaseNode {
  SFString [] name  ""
  MFString [] nodeTypeName []
}
';

sub new {
	my $this = shift->X3DBaseNode::new;

	$this->getField("name")->setValue(shift);
	$this->getField("nodeTypeName")->setValue(shift);

	return $this;
}

print new X3DComponent( "Core", [ qw(
		  MetadataDouble
		  MetadataFloat
		  MetadataInteger
		  MetadataSet
		  MetadataString
		  WorldInfo
		  ) ] );

1;
__END__
