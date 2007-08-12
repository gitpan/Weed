package Weed::ExecutionContext;
use Weed::Perl;

our $VERSION = '0.002';

use Weed '
X3DExecutionContext : X3DObject {
  SFString []       specificationVersion "3.0"       ["1.0", "3.0"]
  SFString []       encoding             "Scripted"  ["Scripted", "ASCII", "VRML", "XML", "Binary", "BIFS"]
  SFString []       profile              ""          ["", "VRML", "Core", "Interchange", "Interactive", "MPEG-4", "Immersive", "Full", "CADInterchange"]
  MFString []       components           []
  MFString []       worldURL             []
  MFNode   []       protos               []          [X3DPrototypeInstance]
  MFNode   []       externProtos         []          [X3DPrototypeInstance]
  MFNode   []       rootNodes            []          [X3DNode]
  MFNode   []       routes               []          [X3DRoute]
}
';

sub getSpecificationVersion { $_[0]->getField("specificationVersion")->getValue }

sub getEncoding { $_[0]->getField("encoding")->getValue }

sub getProfile { $_[0]->getField("profile")->getValue }

sub getComponents { $_[0]->getField("components")->getValue }

sub getWorldURL { $_[0]->getField("worldURL")->getValue }

sub getNode {
	my ($this) = @_;
	return;
}

sub createNode {
	my ( $this, $nodeTypeName ) = @_;

	my $node = eval { $nodeTypeName->new };

	if ( ref $node ) {
		my $sfnode = new SFNode($node);

		$this->{nodesById}->{ $node->getId } = $sfnode;

		#$node->call( "setBrowser", $this->getBrowser );
		return $sfnode->copy;
	}
	return;
}

sub createProto {
	my ($this) = @_;
	return;
}

#namedNodeHandling

sub getProtoDeclaration {
	my ($this) = @_;
	return;
}

#protoDeclarationHandling

sub getExternprotoDeclaration {
	my ($this) = @_;
	return;
}

#externprotoDeclarationHandling

sub getRootNodes { $_[0]->getField("rootNodes")->getValue }

sub getRoutes { $_[0]->getField("routes")->getValue }

#dynamicRouteHandling

1;
__END__
