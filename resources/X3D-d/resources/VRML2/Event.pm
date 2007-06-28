package VRML2::Event;
use strict;

BEGIN {
	use Carp;

	use VRML2::Generator;

	use VRML2::Console;
}

use overload
	'cmp'   => \&cmp,
	'""'   => \&toString;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this = {
		type  => '',
		name  => '',
		value => undef,
		is    => undef,

		routes    => {},
		functions => {},
	};
	$this->{id} = "$this";
	bless $this, $class;
	
	$this->setType(shift);
	$this->setName(shift);
	$this->setValue(shift);
	$this->setIsMapping(shift);
	
	return $this;
}

sub copy {
	my $this = shift;
	#print CONSOLE "VRML2::Event::copy $this->{type} $this->{name}\n";
	my $copy = $this->new(
		$this->{type},
		$this->{name},
		ref $this->{value} ? $this->{value}->copy : undef,
	);
	return $copy;
}

sub cmp {
	my $res = -1;
	if (ref ($_[0]) eq (ref $_[1])) {
		$res = 0;
	}
	elsif ((ref $_[0]) eq 'exposedField') {
		$res = 1;
	}

	return $res;
}

sub getId { $_[0]->{id} }

sub getType { $_[0]->{type} }
sub setType { $_[0]->{type} = $_[1] }

sub getName { $_[0]->{name} }
sub setName { $_[0]->{name} = $_[1] }

sub getValue { $_[0]->{value} }
sub setValue { $_[0]->{value} = $_[1] }

sub getIsMapping { $_[0]->{is} }
sub setIsMapping { $_[0]->{is} = $_[1] }

sub addRoute {
	my $this = shift;
	my $eventIn = shift;

	#print CONSOLE " VRML2::Event::addRoute ", $this->getName, "\n";

	if (exists $this->{routes}->{$eventIn->getId}) {
	} else {
		$this->{routes}->{$eventIn->getId} = $eventIn;
	}
}

sub deleteRoute {
	my $this = shift;
	my $eventIn = shift;

	#print CONSOLE " VRML2::Event::removeRoute ", $this->getName, "\n";

	if (exists $this->{routes}->{$eventIn->getId}) {
		delete $this->{routes}->{$eventIn->getId};
	}
}

sub addFunction {
	my $this = shift;
	my $name = shift;
	my $func = shift;

	#print CONSOLE " VRML2::Event::addFunction @_\n";

	$this->{functions}->{$name} = $func;
}

sub processEvent {
	my $this  = shift;
	my $from  = shift;
	my $value = shift;


	print CONSOLE " VRML2::Event::processEvent ", $this->getName, "\n";

	if ($this->{id} ne $from) {

		$this->{value}->setValue($value->getValue);
	
		while (my ($name, $func) = each %{$this->{functions}}) {
			#print CONSOLE " VRML2::Event::processEvent  ", $func, "\n";
			$func->($this->{value}, time);
		}

	}

	$this->eventProcessed($from);
}

sub eventProcessed {
	my $this = shift;
	my $from = shift || $this->{id};

	print CONSOLE " \n";
	print CONSOLE " VRML2::Event::eventProcessed ", $this->getName, "\n";

	while (my ($id, $field) = each %{$this->{routes}}) {
		#print CONSOLE " VRML2::Event::eventProcessed  ", $field->getName, "\n";
		if ($id ne $this->{id} && $id ne $from) {
			$field->processEvent($from, $this->{value});
		}
	}
}

sub toString {
	my $this = shift;
	#print CONSOLE " VRML2::Event::toString\n";

	if (ref $this->{is}) {
		my $string = '';

		my $space1 = -12 * length $TSPACE;
		my $space2 = -8 * length $TSPACE;

		$string = sprintf "%".$space1."s %".$space2."s %s IS %s",
			ref $this,
			$this->{type},
			$this->{name},
			$this->{is}->getName;

		return $string;
	}

	return;
}

1;
__END__
