package VRML2::Route;
use strict;

BEGIN {
	use Carp;

	use VRML2::Generator;

	use VRML2::Console;
}

use overload
	'""' => \&toString;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this = {
		fromNode   => shift,
		eventOutId => shift,
		toNode     => shift,
		eventInId  => shift
	};
	bless $this, $class;
	
	return $this;
}

sub getFromNode   { $_[0]->{fromNode}   }
sub getEventOutId { $_[0]->{eventOutId} }
sub getToNode     { $_[0]->{toNode}     }
sub getEventInId  { $_[0]->{eventInId}  }

sub getEventOut { $_[0]->{eventOut} }
sub getEventIn  { $_[0]->{eventIn}  }

sub addRoute {
	my $this = shift;

	my $eventOut = $this->{fromNode}->getField($this->{eventOutId});
	if (ref $eventOut) {
		my $eventIn  = $this->{toNode}->getField($this->{eventInId});
		if (ref $eventIn) {
			if ($eventOut->getType eq $eventIn->getType) {

				$this->{eventOut} = $eventOut;
				$this->{eventIn}  = $eventIn;	

				$eventOut->addRoute($eventIn);
	
			} else {
				croak "ROUTE types do not match\n";
			}
		} else {
			my $toNodeId = $this->{toNode}->getName;
			croak
				"Unknown eventIn \"$this->{eventInId}\" in node \"$toNodeId\"\n",
				"Bad ROUTE specification\n";
		}
	} else {
		my $fromNodeId = $this->{fromNode}->getName;
		croak
			"Unknown eventOut \"$this->{eventOutId}\" in node \"$fromNodeId\"\n",
			"Bad ROUTE specification\n";
	}

}

sub deleteRoute {
	my $this = shift;
	$this->{eventOut}->deleteRoute($this->{eventIn});
}

sub toString {
	my $this = shift;
	my $string = '';

	$string .= 'ROUTE ';
	$string .= $this->{fromNode}->getName;
	$string .= '.';
	$string .= $this->{eventOut}->getName;
	$string .= '_changed' if ref($this->{eventOut}) eq 'exposedField';
	$string .= ' TO ';
	$string .= $this->{toNode}->getName;
	$string .= '.';
	$string .= 'set_' if ref($this->{eventIn}) eq 'exposedField';
	$string .= $this->{eventIn}->getName;

	return $string;
}
1;
__END__
