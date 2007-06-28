package VRML2::BaseNode;
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
		id     => undef,
		parent => undef,
		proto  => undef,
		name   => '',
		body   => [],
		fields => {},
	};
	$this->{id} = "$this";
	bless $this, $class;

	$this->{parent} = shift;

	$this->setName(shift);
	$this->setProto(shift);

	return $this;
}

sub getId { $_[0]->{id} }
sub setId { $_[0]->{id} = $_[1] }

sub getName { $_[0]->{name} }
sub setName { $_[0]->{name} = $_[1] }

sub getType { $_[0]->{proto}->getName }

sub getProto { $_[0]->{proto} }
sub setProto { $_[0]->{proto} = $_[1] }

sub getBody { $_[0]->{body} }
sub setBody {
	my $this = shift;
	$this->{body} = shift;

	foreach (@{$this->{body}}) {
		$this->{fields}->{$_->getName} = $_;
	}

	return;	
}

my $_set     = qr/^set_(.*)$/;
my $_changed = qr/^(.*?)_changed$/;

sub setField {
	my $this = shift;
	my $name = shift;

	my $field = $this->getField($name);
	#printf CONSOLE "VRML2::BaseNode::setField %s\n", ref $value;

	if ($field) {
		$field->getValue->setValue(@_);
	}
}

sub getField {
	my $this = shift;
	my $name = shift;

	my $copy = @_ ? shift : 1;

	#print CONSOLE "VRML2::BaseNode::getField $name\n";
	
	if (exists $this->{fields}->{$name}) {
		#print CONSOLE "VRML2::BaseNode::getField $name ", ref $this->{fields}->{$name}, "\n";

		#if (! ref $this->{fields}->{$name}->getValue && ref $this->{fields}->{$name} ne "eventIn") {
		#	my $field = $this->{proto}->getField($name);
		#	$this->{fields}->{$name}->setValue($field->copy->getValue);
		#}
		
		return $this->{fields}->{$name};
	}

	if ($name =~ m/$_set/) {
		my $set_name = $1;

		if (exists $this->{fields}->{$set_name} && ref($this->{fields}->{$set_name}) eq 'exposedField') {
			#print CONSOLE "VRML2::BaseNode::getField $name ", ref $this->{fields}->{$name}, "\n";
			return $this->{fields}->{$set_name};
		}
	}

	if ($name =~ m/$_changed/) {
		my $name_changed = $1;
		if (exists $this->{fields}->{$name_changed} && ref($this->{fields}->{$name_changed}) eq 'exposedField') {
			#print CONSOLE "VRML2::BaseNode::getField $name ", ref $this->{fields}->{$name}, "\n";
			return $this->{fields}->{$name_changed};
		}
	}

	
	# in work
	my $field = $this->{proto}->getField($name);
	if (ref $field) {
		$name = $field->getName;
		#print CONSOLE "VRML2::BaseNode::getField $name ", ref $field, "\n";
		
		if ($copy) {
			my $copy = $field->copy;
			$this->{fields}->{$name} = $copy;
			push @{$this->{body}}, $copy;
			return $copy;
		} else {
			return $field;
		}
	}

	#print CONSOLE "VRML2::BaseNode::getField undef\n";
	return;
}

sub toString {											
	my $this = shift;									
	my $string = '';				

	#print CONSOLE " VRML2::BaseNode::toString ". $this->{proto}->getName ."\n";

	$string .= "DEF $this->{name} " if $this->{name};
	$string .= $this->{proto}->getName;
	$string .= $TSPACE;
	$string .= "{";

	my @body = ();

	foreach (@{$this->getProto->getInterface}) {
		if (exists $this->{fields}->{$_->getName}) {
			if (
				ref $this->{fields}->{$_->getName}->getIsMapping
				 ||
				(defined $_->getValue && $_->getValue != $this->{fields}->{$_->getName}->getValue)
			) {
				push @body, $this->{fields}->{$_->getName};
			}
		}
	}

	if (@body) {

		$string .= $TBREAK;

		INC_INDENT;
		$string .= $INDENT;

		$string .= join $BREAK.$INDENT, map {
			if (ref $_->getIsMapping) {
				sprintf "%s IS %s", $_->getName, $_->getIsMapping->getName
			} else {
				sprintf "%s %s", $_->getName, $_->getValue;
			}
		} @body;

		$string .= $TBREAK;
		DEC_INDENT;
	
		$string .= $INDENT;

	} else {
		$string .= $TSPACE;
	}

	$string .= "}";
	
	return $string;
}

sub DESTROY {
	my $this  = shift;
 	0;
}

1;
__END__
