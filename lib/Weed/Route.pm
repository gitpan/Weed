package Weed::Route;
use strict;

our $VERSION = '0.002';

use Weed 'X3DRoute { }';

# sub create {
# 	my $this = shift;
# 	@$this{ "sourceNode", "sourceField", "destinationNode", "destinationField", "comment" } = @_;
# 	$this->{sourceField}->addFieldCallback( $this->{destinationField}->getName, $this->{destinationNode} );
#
# }

sub new {
	my $this = shift->X3DUniversal::new;

	my ( $sourceNode, $sourceFieldId, $destinationNode, $destinationFieldId ) = @_;

	my $sourceField = $sourceNode->getValue->getField($sourceFieldId);
	if ( ref $sourceField )
	{
		my $destinationField = $destinationNode->getValue->getField($destinationFieldId);
		if ( ref $destinationField )
		{
			if ( $sourceField->getType eq $destinationField->getType )
			{

				$this->{sourceNode}       = $sourceNode;
				$this->{sourceField}      = $sourceField;
				$this->{destinationNode}  = $destinationNode;
				$this->{destinationField} = $destinationField;

				#*
				$sourceField->addFieldCallback($destinationField);

				return $this;

			}
			else {
				Carp::croak
				  "ROUTE types do not match\n",
				  "Bad ROUTE specification\n";
			}
		}
		else {
			my $destinationNodeId = $destinationNode->getName;
			Carp::croak
			  "Unknown destination field \"$destinationFieldId\" in node \"$destinationNodeId\"\n",
			  "Bad ROUTE specification\n";
		}
	}
	else {
		my $sourceNodeId = $sourceNode->getName;
		Carp::croak
		  "Unknown source field \"$sourceFieldId\" in node \"$sourceNodeId\"\n",
		  "Bad ROUTE specification\n";
	}

	return;
}

sub getSourceNode       { $_[0]->{sourceNode} }
sub getSourceField      { $_[0]->{sourceField} }
sub getDestinationNode  { $_[0]->{destinationNode} }
sub getDestinationField { $_[0]->{destinationField} }

sub deleteRoute {
	my $this = shift;
	$this->{eventOut}->deleteRoute( $this->{eventIn} );
}

sub toString {
	my $this   = shift;
	my $string = "";

	$string .= X3DGenerator->ROUTE;
	$string .= X3DGenerator->space;
	$string .= $this->{sourceNode}->getValue->getName;
	$string .= X3DGenerator->period;
	$string .= $this->{sourceField}->getName;
	$string .= X3DGenerator->space;
	$string .= X3DGenerator->TO;
	$string .= X3DGenerator->space;
	$string .= $this->{destinationNode}->getValue->getName;
	$string .= X3DGenerator->period;
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
