package X3D::Scene;
use Weed::Perl;

our $VERSION = '0.002';

use X3D '
X3DScene : X3DNode, X3DExecutionContext {
  SFNode   [in,out] metadata             NULL        [X3DMetadataObject]
  SFString []       specificationVersion "3.0"       ["1.0", "3.0"]
  SFString []       encoding             "Scripted"  ["Scripted", "ASCII", "VRML", "XML", "Binary", "BIFS"]
  SFString []       profile              ""          ["", "VRML", "Core", "Interchange", "Interactive", "MPEG-4", "Immersive", "Full", "CADInterchange"]
  MFString []       components           []
  MFString []       worldURL             []
  MFNode   []       protos               []          [X3DPrototypeInstance]
  MFNode   []       externProtos         []          [X3DPrototypeInstance]
  MFNode   []       rootNodes            []          [X3DNode]  # Scene graph
  MFNode   []       routes               []          [X3DRoute] # Behaviour graph
}
';

sub getMetaData { X3DMessage->Debug;
	my ($this) = @_;
	return;
}

sub setMetaData {
	my ( $this, $metakey, $metavalue ) = @_;

	my $metadata = $this->createNode("MetadataString");
	$metadata->name($metakey);
	$metadata->value($metavalue);

	push @{ $this->getField('metadata')->value }, $metadata;

	return;
}

#namedNodeHandling
#rootNodeHandling

1;
__END__
