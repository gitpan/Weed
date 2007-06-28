package X3DExecutionContext;
use strict;
use warnings;

use rlib "Components/Core";

use base qw(X3DNode);

use X3DConstants;
use X3DRoute;

our $FieldDefinitions = [
	new X3DFieldDefinition( initializeOnly, 'specificationVersion', new SFString("3.0") ),
	new X3DFieldDefinition( initializeOnly, 'encoding',   new SFString("Scripted"), "Scripted|ASCII|VRML|XML|Binary|BIFS" ),
	new X3DFieldDefinition( initializeOnly, 'profile',    new SFString, "Core|Interchange|Interactive|MPEG-4|Immersive|Full"),
	new X3DFieldDefinition( initializeOnly, 'components', new MFString, "Core,CosmoWorlds,DIS,EnvironmentalEffects,EnvironmentalSensor,EventUtilities,Geometry2D,Geometry3D,Geospatial,Grouping,Gtk2,H-Anim,Interpolation,KeyDeviceSensor,Lighting,Navigation,Networking,NURBS,PointingDeviceSensor,Rendering,Scripting,Shape,Sound,Text,Texturing,Time,..."),
	new X3DFieldDefinition( initializeOnly, 'worldURL',       new SFString, "urn" ),
	new X3DFieldDefinition( initializeOnly, 'navigationInfo', new MFNode,   "NavigationInfo" ),
	new X3DFieldDefinition( initializeOnly, 'viewpoint',      new MFNode,   "Viewpoint" ),
	new X3DFieldDefinition( inputOutput,    'protos',         new MFNode,   "X3DProto" ),
	new X3DFieldDefinition( inputOutput,    'externProtos',   new MFNode,   "X3DExternProto" ),
	new X3DFieldDefinition( inputOutput,    'rootNodes',      new MFNode,   "X3DNode" ),
	new X3DFieldDefinition( inputOutput,    'routes',         new MFNode,   "X3DRoute" ),
];

sub initialize {
	my ($this) = @_;
	$this->{nodesById}  = {};
	$this->{namedNodes} = {};
	$this->{routesById} = {};
}

sub getSpecificationVersion { $_[0]->specificationVersion->getValue }
sub getEncoding             { $_[0]->encoding->getValue }
sub getProfile              { $_[0]->profile->getValue }
sub getComponents           { $_[0]->components->getValue }
sub getWorldURL             { $_[0]->worldURL->getValue }

=node
=cut

sub createNode {
	my ( $this, $nodeTypeName, $nodeName, $comments ) = @_;

	my $node = eval { $nodeTypeName->new( $nodeName, $comments ) };

	if ( ref $node ) {
		my $sfnode = new SFNode($node);

		$this->{nodesById}->{ $node->getId } = $sfnode;
		$this->{namedNodes}->{$nodeName} = $sfnode if $nodeName;

		$node->call( "setBrowser", $this->getBrowser );
		return $sfnode->copy;
	}
	return;
}

=namedNodeHandling
=cut

sub getNode {
	my ( $this, $name, $type ) = @_;
	return $this->getNamedNode($name)
	  || $this->getImportedNode($name)
	  || $this->getExportedNode($name);
}

sub getNamedNode {
	my ( $this, $name ) = @_;
	return $this->{namedNodes}->{$name}->copy if exists $this->{namedNodes}->{$name};
	return X3DError::UnknownNamedNode $name;
}

sub updateNamedNode {
	my ($this) = @_;
	return;
}

sub removeNamedNode {
	my ($this) = @_;
	return;
}

sub getImportedNode {
	my ($this) = @_;
	return;
}

sub updateImportedNode {
	my ($this) = @_;
	return;
}

sub removeImportedNode {
	my ($this) = @_;
	return;
}

=proto
=cut

sub createProto {
	my ($this) = @_;
	return;
}

sub getProtoDeclaration {
	my ($this) = @_;
	return;
}

#protoDeclarationHandling

sub getExternProtoDeclaration {
	my ($this) = @_;
	return;
}

#externprotoDeclarationHandling

=rootNodes
=cut

sub getRootNodes { wantarray ? $_[0]->rootNodes->getValue : $_[0]->rootNodes->getValue }

=route
=cut

sub getRoutes { wantarray ? $_[0]->routes->getValue : $_[0]->routes->getValue }

#dynamicRouteHandling

sub addRoute {
	my ( $this, $fromNode, $sourceFieldId, $toNode, $destinationFieldId ) = @_;

	my $sourceField = $fromNode->getValue->getField($sourceFieldId);
	if ( ref $sourceField ) {
		my $destinationField = $toNode->getValue->getField($destinationFieldId);

		if ( ref $destinationField ) {
			if ( $sourceField->getType eq $destinationField->getType ) {
				my $route = new X3DRoute( $fromNode, $sourceField, $toNode, $destinationField );
				push @{ $this->routes }, $route;
				$this->{routesById}->{ $route->getId } = $route;
				return $route;
			} else {
				X3DError::RouteTypesDoNotMatch;
			}
		} else {
			X3DError::RouteUnknownDestinationField $toNode, $destinationFieldId;
		}
	} else {
		X3DError::RouteUnknownSourceField $fromNode, $sourceFieldId;
	}

	return;
}

sub deleteRoute {
	my ( $this, $route ) = @_;
	delete $this->{routesById}->{ $route->getId };
	return;
}

#dispose

1;
__END__
printf "%s\n", __PACKAGE__->new;
