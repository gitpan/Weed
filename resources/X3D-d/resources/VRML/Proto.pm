package VRML::Proto;
require 5.005;
use strict;
use Carp;

use overload
	"eq"   => \&eq,
	'bool' => \&bool,
	'""'   => \&to_string;

use VRML::Generator qw($TIDY_SPACE $TIDY_BREAK $SPACE $BREAK indent $FIELD_CLASS $FIELD_TYPE $FIELD_NAME $DEEP);
use VRML::Node::Node;

use AutoLoader;
use vars qw($AUTOLOAD);
sub AUTOLOAD {
	my $this = shift;
	my $name = $AUTOLOAD;  $name =~ s/.*:://;

	croak "PROTO ".$this->{name}." field $name does not exists" unless exists $this->{field}->{$name};

	my $field = $this->{field}->{$name};
	$field->{value}->setValue(@_) if @_;

	return $field->{value};
}

sub new {
	my $self  = shift;
	if (ref $self) {
		my $node = new VRML::Node::Node(shift, $self, undef, $self->{browser});

		$node->{name} = $self->{browser}->uniqueName unless $node->{name};

		push @{$self->{browser}->{nodes}->{$self->{name}}}, $node;
		$self->{browser}->{node}->{$node->{name}} = $node;

		return new SFNode($node);
	} else {
		my $class = $self;
		my $this = {};
		bless $this, $class;

		$this->{name} = shift || '';

		$this->{interfaceDeclarations} = shift || [];
		$this->{browser} = shift;
		$this->{top}  = shift;
		$this->{body} = shift || {
			protos   => [],
			rootNode => [],
			nodes    => []
		};
		$this->{url} = undef;

		$this->{parse}  = undef;

		$this->{proto}  = {};
		$this->{protos} = [];
		$this->{node}   = {};
		$this->{nodes}  = {};
		$this->{routes} = [];

		$this->{fields} = $this->{interfaceDeclarations};
		$this->{field}->{$_->{name}} = $_ foreach (@{$this->{fields}});

		return $this;
	}

}

sub getBrowser { $_[0]->{browser} }
sub getName { $_[0]->{name} }
sub getType { $_[0]->{url} ? "EXTERNPROTO" : "PROTO" }

sub getField {
	my $this = shift;
	my $name = shift || return;
	return $this->{field}->{$name} if exists $this->{field}->{$name};
}

sub getFields {
	return $_[0]->{fields};
}

sub getURL { $_[0]->{url} }

sub getProto {
	my $this = shift;
	return $this if $this->getType eq "PROTO";
	unless ($this->{parse}) {
		$this->{parse} = $this->{browser}->new;
		$this->{parse}->loadURL(@{$this->getURL});
	}
	return $this->{parse}->getProto($this->getName);
}

sub setField {
	my $this = shift;
	my $name  = shift || return;
	my $field = shift;
	return $this->{field}->{$name} = $field;
}

sub setURL {
	my $this = shift;
	$this->{url} = shift;
}

sub bool { $_[0]->{name} && 1 }
sub eq   { $_[1] eq $_[0]->getName }

sub to_string {
	my $this = shift;
	my $string;

	$string = indent.($this->getType).$SPACE.$this->{name}."$TIDY_SPACE\[";

	++$DEEP; 
	$string .= $TIDY_BREAK.indent if @{$this->{fields}};
	$string .= join $BREAK.indent, map {
		(sprintf $FIELD_CLASS, $_->{class}).
		(sprintf $FIELD_TYPE, $_->{type}).
		(sprintf $FIELD_NAME, $_->{name}).
		((!$this->{url} && exists $_->{value} && $_->{class} =~ /^field|exposedField$/)&&
			((ref $_->{value} eq "SFString")?
			"\"".$_->{value}."\"":$_->{value}))
	} @{$this->{fields}};
	--$DEEP;

	$string .= $TIDY_BREAK.indent.']';

	if ($this->{url}) {
		$DEEP++;
		$string .= $TIDY_BREAK.indent.$this->{url};
		--$DEEP;
	} else {
		$string .= $TIDY_BREAK.indent.'{'.$TIDY_BREAK;
	
		if (@{ $this->{body}->{protos} }) {
			$DEEP++;
			my $protos = join $TIDY_BREAK.indent, @{ $this->{body}->{protos} };
			--$DEEP;
			$string .= $protos;
		}
	
		if ($this->{body}->{rootNode}) {
			$DEEP++;
			my $node = $this->{body}->{rootNode};
			$string .= indent.$node.$TIDY_BREAK;
			--$DEEP;
		}
	
		if (@{ $this->{body}->{nodes} }) {
			$DEEP++;
			my $nodes = join $TIDY_BREAK.$TIDY_BREAK.indent, @{ $this->{body}->{nodes} };
			$string .= $TIDY_BREAK.indent.$nodes.$TIDY_BREAK;
			--$DEEP;
		}

		if (@{ $this->{routes} }) {
			$DEEP++;
			my $routes = join indent, @{ $this->{routes} };
			$string .= $TIDY_BREAK.indent.$routes;
			--$DEEP;
		}
	
		$string .= indent.'}';
	}
	$string .= $TIDY_BREAK;
	$string .= $TIDY_BREAK; 
	$string .= $TIDY_BREAK; 
	return $string;
}

sub DESTROY {
	my $this  = shift;
 	0;
}

1;
__END__
