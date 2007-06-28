package X3DField;
use strict;
use warnings;

use rlib "./";

use base qw(X3DObject);


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
