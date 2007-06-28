package X3DRoute;
use strict;
use warnings;

use rlib "Components/Core";

use base qw(X3DObject);

use X3DConstants;

sub create {
	my $this = shift;
	@$this{ "sourceNode", "sourceField", "destinationNode", "destinationField", "comment" } = @_;
	$this->{sourceField}->addFieldCallback( $this->{destinationField}->getName, $this->{destinationNode} );

}

sub getSourceNode       { $_[0]->{sourceNode} }
sub getSourceField      { $_[0]->{sourceField} }
sub getDestinationNode  { $_[0]->{destinationNode} }
sub getDestinationField { $_[0]->{destinationField} }

sub toString {
	my $this   = shift;
	my $string = "";

	$string .= "ROUTE";
	$string .= $X3DGenerator::SPACE;
	$string .= $this->{sourceNode}->getValue->getName;
	$string .= ".";
	$string .= $this->{sourceField}->getName;
	$string .= $X3DGenerator::SPACE;
	$string .= "TO";
	$string .= $X3DGenerator::SPACE;
	$string .= $this->{destinationNode}->getValue->getName;
	$string .= ".";
	$string .= $this->{destinationField}->getName;

	return $string;
}

1;
__END__
6.8 Route services
6.8.1 Route representation

Route services are implemented as the interface X3DRoute. This interface has four methods as defined in the remainder of this subclause.
6.8.2 getSourceNode

X3DNode X3DRoute.getSourceNode()
    throws InvalidOperationTimingException,
           InvalidRouteException

The node representation that is used at the source of the ROUTE is returned.
6.8.3 getSourceField

String X3DRoute.getSourceField()
    throws InvalidOperationTimingException,
           InvalidRouteException

The name of the source field in the source node is returned.

6.8.4 getDestinationNode

X3DNode X3DRoute.getDestinationNode()
    throws InvalidOperationTimingException,
           InvalidRouteException

The node representation that is used at the source of the ROUTE is returned.
6.8.5 getDestinationField

String X3DRoute.getDestinationField()
    throws InvalidOperationTimingException,
           InvalidRouteException

The name of the destination field in the node is returned.
6.8.6 dispose

void X3Route.dispose()
    throws InvalidOperationTimingException
