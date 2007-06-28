package VRML::BaseNode;
require 5.005;
use strict;
use Carp;

use overload
	"<=>" => \&ncmp,
	"bool" => \&bool,
	"cmp" => \&cmp,
	"ne" => \&ne,
	"eq" => \&eq,
	'""' => \&toString;

use VRML::Generator qw($TIDY_SPACE $TIDY_BREAK $BREAK $SPACE indent $SCRIPT_FIELD_CLASS $FIELD_TYPE $FIELD_TYPE $DEEP);

use AutoLoader;
use vars qw($AUTOLOAD);
sub AUTOLOAD {
	my $this = shift;
	my $name = $AUTOLOAD || shift; $name =~ s/.*:://;

	return $this->setField($name, @_) if @_;
	return $this->getField($name);
}

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this = {};
	$this->{id} = "$this";
	bless $this, $class;

	$this->{name} = shift || '';
	if (ref $self) {
		$this->{proto}   = $self->{proto};
		$this->{fields}  = [];
		$this->{browser} = $self->{browser};
		$this->{field}   = {};
		$this->{comment} = $self->{comment};
	} else {
		$this->{proto}   = shift;
		$this->{fields}  = shift || [];
		$this->{browser} = shift;
		$this->{field}->{$_->{name}} = $_ foreach (@{$this->{fields}});
		$this->{comment} = "";
	}

	$this->{clones} = [$this];

	return $this;
}

sub clone {
	my $this = shift;
	my $clone = $this->new;

	#print STDERR "BaseNode::clone ", $this->{name}, "\n";

	$clone->{id}     = $this->{id};
	$clone->{name}   = $this->{name}.' ['.$#{$this->{clones}}.']';
	$clone->{fields} = $this->{fields};
	$clone->{field}  = $this->{field};
	$clone->{clones} = $this->{clones};
	
	push @{$this->{clones}}, $clone;

	return $clone;
}

sub delete {
	my $this = shift;
	#print STDERR "BaseNode::delete $this->{name}\n";
	#print STDERR "BaseNode::delete $this\n", @{$this->{clones}};

	if ($this->{name} =~ /(.*?)\s*\[(\d+)\]$/) {
		$this->{name} = $1;
		splice @{$this->{clones}}, $2, 1 if $#{$this->{clones}};
		foreach (1 ... $#{$this->{clones}}) {
			$this->{clones}->[$_]->{name} = $1.' ['.$_.']';
		}
	} else {
		if ($#{$this->{clones}}) {
			splice @{$this->{clones}}, 0, 1;
			foreach (1 ... $#{$this->{clones}}) {
				$this->{clones}->[$_]->{name} = $this->{name}.' ['.$_.']';
			}
			$this->{clones}->[0]->{name} = $this->{name};
		} else {
			delete $this->{browser}->{node}->{$this->{name}};
		}
	}

	return $this;
}

sub clones {
	my $this = shift;
	return @{$this->{clones}};
}

sub setName {
	my $this = shift;
	my $name = shift || '';
	$this->{name} = $name;
	$this->{clones}->[0]->{name} = $name;
	foreach (1 ... $#{$this->{clones}}) {
		$this->{clones}->[$_]->{name} = $name.' ['.$_.']';
	}
}

sub getClones { $_[0]->{clones} }
sub getType { $_[0]->{clones}->[0]->{proto}->{name} }
sub getBrowser { $_[0]->{clones}->[0]->{browser} }
sub getName { $_[0]->{clones}->[0]->{name} }
sub getProto { $_[0]->{clones}->[0]->{proto} }

sub getEventIn      { $_[0]->getField(@_) }
sub getEventOut     { $_[0]->getField(@_) }
sub getExposedField { $_[0]->getField(@_) }

sub getComment { $_[0]->{comment} }
sub setComment { $_[0]->{comment} = $_[1] }

sub getField {
	my $this = shift;
	my $name = shift;
	if (exists $this->{field}->{$name}) {
		return $this->{field}->{$name}->{value};
	} elsif (exists $this->getProto->{field}->{$name}) {
		return $this->setField($name, $this->getProto->getProto->{field}->{$name}->{value});
	} else {
		if ($this->{name}) {
			croak "Node DEF ".$this->{name}." ".$this->getProto->{name}." field '$name' does not exist\n";
		} else {
			croak "Node ".$this->getProto->{name}." field '$name' does not exist\n";
		}
	} 
}

sub getFields {
	return $_[0]->{fields};
}

sub setField {
	my $this = shift;
	my $name = shift;
	if (exists $this->{field}->{$name}) {
		return $this->{field}->{$name}->{value}->setValue(@_);
	} elsif (exists $this->getProto->{field}->{$name}) {
		my $field = {};
		$field->{class} = $this->getProto->{field}->{$name}->{class};
		$field->{type}  = $this->getProto->{field}->{$name}->{type};
		$field->{name}  = $name;

		# externproto works, obsolete later if proto will realy parse externproto
		unless (exists $this->getProto->{field}->{$name}->{value}) {
			my $value = $this->getProto->{field}->{$name}->{type}->new;
			$this->getProto->{field}->{$name}->{value} = $value;
		}

		$field->{value} = $this->getProto->{field}->{$name}->{value}->new;

		$this->{field}->{$name} = $field;
		push @{ $this->{fields} }, $field;
		
		if (@_) {
			if (!$#_ && $field->{type} eq ref $_[0]) {
				$field->{value}->setValue($_[0]->getValue);
				return $field->{value};
			}
		}


		$field->{value}->setValue(map {
			my $fieldValue = $_;
			if (ref $fieldValue eq "SFNode") {
				$fieldValue = $_ eq $this || exists $this->{browser}->{node}->{$_->name} ? $_->clone : $_;
			}
			$fieldValue;
		} @_ );
		
		return $field->{value};
	} else {
		if ($this->{name}) {
			croak "Node DEF ".$this->{name}." ".$this->getProto->{name}.": EventIn $name does not exists";
		} else {
			croak "Node ".$this->getProto->{name}.": EventIn $name does not exists" 
		}
	} 
}

# overload package methods
sub ncmp {
	if (ref $_[1]) {
		#print STDERR ref $_[0], " ncmp ", ref $_[1], "\n";
		return $_[1]->{id} cmp $_[0]->{id};
	}
	-1;
}
sub bool { ref $_[0]->getProto }
sub cmp  { $_[1] cmp $_[0]->{name}.$_[0]->{id} }
sub eq   { $_[1] eq  $_[0]->{name}.$_[0]->{id} }
sub ne   { $_[1] ne  $_[0]->{name}.$_[0]->{id} }


sub fieldsToString {											
	my $this = shift;									

	my $string = '';
	my @fields;				

	foreach (@{$this->{fields}}) {
		next unless exists $this->getProto->{field}->{$_->{name}};

		if (ref $_->{value} eq "REF") {
			push @fields, $_->{name} . " IS " . ${$_->{value}}->{name};
			next;
		}

		next if $_->{class} =~ /^eventIn|eventOut$/;
		next if $this->getProto->{field}->{$_->{name}}->{value} == $_->{value};

		my $field;
		$field .= $_->{name};

		if ($_->{class} =~ /^field|exposedField$/) {
			$field .= $SPACE;
			if (ref $_->{value} eq "SFString") {
				$field .= "\"$_->{value}\"";
			} else {
				$field .= $_->{value};
			}
		}

		push @fields, $field;
	}

	if (@fields) {
		$string .= $TIDY_BREAK.indent;
		$string .= join $BREAK.indent, @fields;
		$string .= $TIDY_BREAK;
	}

	return $string;
}

sub toString {											
	my $this = shift;									
	my $string = '';				
	return "DEEPREC" if $this->{r}++ > 100;

	return 'NULL' unless ref $this->getProto;

	if ($#{$this->{clones}}) {
		if ($this ne $this->{clones}->[0]) {
			$string = "USE".$SPACE.$this->{clones}->[0]->{name};
			$string = $string.$BREAK unless $DEEP;
			return "$string";
		}
	}

	#print STDERR "BaseNode::toString ", $this->getType, "\n";

	$string = $this->getType;
	$string = "DEF".$SPACE.$this->getName.$SPACE.$string if $this->getName;
	$string .= $TIDY_SPACE."{";
	$string .= "\n".$this->{comment} if $this->{comment};

	++$DEEP;
	my $fields = $this->fieldsToString;
	$string .= $fields;
	--$DEEP;

	$string .= $fields ? indent : $TIDY_SPACE;
	$string .= "}";

	$string .= $TIDY_BREAK unless $DEEP; 
	return $string;
}

sub DESTROY {
	my $this  = shift;
 	0;
}

1;
__END__
	if (@{$this->{fields}}) {
		$string .= $TIDY_BREAK.indent;
		$string .= join $BREAK.indent, grep {$_} map {
			my $value = '';
			if (exists $_->{value}) {
				if (exists $_->{is}) {
					$value .= $SPACE;
					$value .= "IS".$SPACE.$_->{is};
				} elsif ($this->getProto->{field}->{$_->{name}}->{class} =~ /^field|exposedField$/
					&& $this->getProto->getProto->{field}->{$_->{name}}->{value} != $_->{value}) {
					$value .= $SPACE;
					if (ref $_->{value} eq "SFString" && !$_->{value}->IS) {
						$value .= "\"";
						$value .= $_->{value};
						$value .= "\"";
					} elsif (ref $_->{value} eq "MFString" && !$_->{value}->IS) {
						$value .= $_->{value};
					} else {
						$value .= $_->{value};
					}
				}
			}

			$_->{name}.$value if $value

		} @{$this->{fields}};
	}
