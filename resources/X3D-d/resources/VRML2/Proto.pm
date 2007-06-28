package VRML2::Proto;
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
		parent          => undef,
		_protos         => {},
		protos          => {},
		nodesById       => {},
		nodesByName     => {},
		name            => '',
		externInterface => [],
		interface       => [],
		fields          => {},
		body            => [],
		URL             => undef,
	};
	bless $this, $class;
	
	$this->setParent(shift);
	$this->setName(shift);
	$this->setInterface(shift);
	
	return $this;
}

sub getParent { $_[0]->{parent} }
sub setParent { $_[0]->{parent} = $_[1] }

sub getName { $_[0]->{name} }
sub setName { $_[0]->{name} = $_[1] }

sub getInterface { $_[0]->{interface} }
sub setInterface {
	my $this = shift;

	#print CONSOLE "VRML2::Proto::setInterface ", $this->getName, "\n";

	$this->{interface} = shift;

	foreach (@{$this->{interface}}) {
		#print CONSOLE "VRML2::Proto::setInterface ", $_, "\n";
		$this->{fields}->{$_->getName} = $_;
	}

	return;
}

sub getBody { $_[0]->{body} }
sub setBody {
	my $this = shift;
	$this->{body} = shift;

	my @routes  = grep {ref $_ eq 'VRML2::Route'} @{$this->{body}->[2]};
	foreach (@routes) { $_->addRoute; }
}


sub getURL { $_[0]->{URL} }
sub setURL {
	my $this = shift;
	$this->{URL} = shift;
	$this->{externInterface} = $this->{interface};
}

sub addProto {
	my $this = shift;
	my $proto = shift;
	##print CONSOLE "VRML2::Proto::addProto ", $proto->getName, "\n";
	$this->{_protos}->{$proto->getName} = $proto;
	return;
}

sub getProto {
	my $this = shift;
	my $name = shift;

	##print CONSOLE "VRML2::Proto::getProto $name ", ref $this->{parent}, "\n";
	if (exists $this->{_protos}->{$name}) {
		return $this->{_protos}->{$name};
	}
	
	return $this->{parent}->getProto($name);
}

sub addNode {
	my $this  = shift;
	my $node = shift;
	##print CONSOLE "VRML2::Proto::addNode ".$node->getName."\n";

	$this->{nodesById}->{$node->getId} = $node;

	my $name = $node->getName;
	if ($name) {
		$this->{nodesByName}->{$name} = $node;
	}
}

sub getNodeByName {
	my $this = shift;
	my $name = shift;

	if (exists $this->{nodesByName}->{$name}) {
		##print CONSOLE "VRML2::Proto::getNodeByName $name\n";
		return $this->{nodesByName}->{$name};
	}
	
	##print CONSOLE "VRML2::Proto::getNodeByName undef\n";
	return;
}

sub getNodeById {
	my $this = shift;
	my $id   = shift;

	if (exists $this->{nodesById}->{$id}) {
		##print CONSOLE "VRML2::Proto::getNodeById $name\n";
		return $this->{nodesById}->{$id};
	}
	
	##print CONSOLE "VRML2::Proto::getNodeById undef\n";
	return;
}

my $_set     = qr/^set_(.*)$/;
my $_changed = qr/^(.*?)_changed$/;

sub getField {
	my $this = shift;
	my $name = shift;
	
	if (exists $this->{fields}->{$name}) {
		#print CONSOLE "VRML2::Proto::getField $name ", ref $this->{fields}->{$name}, "\n";
		return $this->{fields}->{$name};
	}

	if ($name =~ m/$_set/) {
		my $set_name = $1;
		if (exists $this->{fields}->{$set_name} && ref($this->{fields}->{$set_name}) eq 'exposedField') {
			#print CONSOLE "VRML2::Proto::getField $name ", ref $this->{fields}->{$name}, "\n";
			return $this->{fields}->{$set_name};
		}
	}

	if ($name =~ m/$_changed/) {
		my $name_changed = $1;
		if (exists $this->{fields}->{$name_changed} && ref($this->{fields}->{$name_changed}) eq 'exposedField') {
			#print CONSOLE "VRML2::Proto::getField $name ", ref $this->{fields}->{$name}, "\n";
			return $this->{fields}->{$name_changed};
		}
	}

	#print CONSOLE "VRML2::Proto::getField undef\n";
	return;
}

sub addRoute {
	my $this = shift;
	$this->{parent}->addRoute(@_);
}

sub toString {
	my $this = shift;
	my $string = '';

	#print CONSOLE " VRML2::Proto::toString $this->{name}\n";

	if (ref $this->{URL}) {
		$string .= 'EXTERNPROTO';
	} else {
		$string .= 'PROTO';
	}

	$string .= $SPACE;
	$string .= $this->{name};
	$string .= $TSPACE;
	# interface
	$string .= '[';
	$string .= $TBREAK;
	INC_INDENT;
	$string .= $INDENT;

	if (ref $this->{URL}) {
		$string .= join $BREAK.$INDENT, @{$this->{externInterface}};
	} else {
		$string .= join $BREAK.$INDENT, @{$this->{interface}};
	}

	$string .= $TBREAK;
	DEC_INDENT;
	$string .= $INDENT;
	$string .= ']';
	$string .= $TBREAK;

	if (ref $this->{URL}) {
		# URL
		INC_INDENT;
		$string .= $INDENT;
		$string .= $this->{URL};
		$string .= $TBREAK;
		DEC_INDENT;
	} else {
		# body
		$string .= $INDENT;
		$string .= '{';
		$string .= $TBREAK;
		INC_INDENT;
		# protoStatements
		if (@{$this->{body}->[0]}) {
			$string .= $INDENT;
			foreach (@{$this->{body}->[0]}) {
				$string .= $_;
				$string .= $TBREAK;
			}
		}
		# rootNodeStatement
		if (ref $this->{body}->[1]) {
			$string .= $INDENT;
			$string .= $this->{body}->[1];
			$string .= $TBREAK;
		}
		# statements
		if (@{$this->{body}->[2]}) {
			$string .= $TBREAK;
			my $statement = 1;
			foreach (@{$this->{body}->[2]}) {
				if (ref $_ eq 'VRML2::Proto') {
					$string .= $TBREAK unless $statement == 1;
					$string .= $INDENT;
					$string .= $_;
					$string .= $TBREAK;
					$statement = 1;
				} elsif (ref $_ eq 'VRML2::Route') {
					$string .= $TBREAK unless $statement;
					$string .= $INDENT;
					$string .= $_;
					$string .= $TBREAK;
					$statement = 2;
				} else {
					$string .= $TBREAK if $statement == 2;
					$string .= $INDENT;
					$string .= $_;
					$string .= $TBREAK;
					$statement = 0;
				}
			}
			if ($statement == 1) {
				$string = substr $string, 0, -length $TBREAK;
			}
		}
		DEC_INDENT;
		$string .= $INDENT;
		$string .= '}';
		$string .= $TBREAK;
	}

	return $string;
}

1;
__END__
