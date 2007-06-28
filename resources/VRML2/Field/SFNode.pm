package VRML2::Field::SFNode;
use strict;

#use AutoSplit; autosplit('SFNode.pm', 'auto/', 0, 1, 1);

BEGIN {
	use Carp;

	use VRML2::Field;

	use VRML2::Console;

	use vars qw(@ISA);
	@ISA = qw(VRML2::Field);
}

use overload
	"eq"   => \&eq,
	"ne"   => \&ne,

	"=="   => \&neq,
	"!="   => \&nne,

	'""' => \&toString;

use AutoLoader;
our $AUTOLOAD;
sub AUTOLOAD {
	my $this = shift;
	my $name = $AUTOLOAD;  $name =~ s/.*:://;

	return $this->getValue->setField($name, @_) if @_;
	return $this->getValue->getField($name)->getValue;
}

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this = {};
	$this->{id} = "$this";
	bless $this, $class;

	$this->{clones} = [$this];

	$this->setValue(@_);
	return $this;
}

sub copy {
	my $this  = shift;
	my $copy = $this->new();
	return $copy;
}

sub neq  { $_[0] eq $_[1] }
sub nne  { $_[0] ne $_[1] }

sub eq  { $_[1] eq (ref $_[0]->{value} ? $_[0]->{id} : 'NULL') }
sub ne  { $_[1] ne (ref $_[0]->{value} ? $_[0]->{id} : 'NULL') }

sub clone {
	my $this = shift;
	#print CONSOLE " VRML2::Field::SFNode::clone ", $this->getName, "\n";

	my $clone = $this->new($this->{value});
	
	$clone->{clones} = $this->{clones};
	push @{$this->{clones}}, $clone;

	return $clone;
}

sub remove {
	my $this = shift;

	my $clone;
	for (my $i = 0; $i < @{$this->{clones}}; ++$i) {
		if ($this->{clones}->[$i]->{id} eq $this->{id}) {
			$clone = $i;
			last;
		}
	}

	splice @{$this->{clones}}, $clone, 1 if defined $clone;
}


sub getId {
	my $this = shift;
	return $this->{clones}->[0]->{id};
}

sub setValue {
	my $this = shift;

	#print CONSOLE " VRML2::Field::SFNode::setValue ", ref $_[0], "\n";

	if (@_) {
		if (ref $_[0]) {
			$this->{value} = $_[0];
		} else {
			$this->{value} = undef;
		}
	} else {
		$this->{value} = undef;
	}

	return;
}

sub getValue {
	my $this = shift;
	return $this->{value};
}

sub getField {
	my $this = shift;
	if (ref $this->{value}) {
		$this->{value}->getField(@_);
	}
}

sub getProto {
	my $this = shift;
	if (ref $this->{value}) {
		$this->{value}->getProto(@_);
	}
}

sub getType {
	my $this = shift;
	if (ref $this->{value}) {
		$this->{value}->getType;
	}
}

sub getName {
	my $this = shift;
	if (ref $this->{value}) {
		$this->{value}->getName;
	}
}

sub getBody {
	my $this = shift;
	if (ref $this->{value}) {
		$this->{value}->getBody;
	}
}

sub toString {
	my $this = shift;
	#print CONSOLE " VRML2::Field::SFNode::toString\n";

	my $string = '';

	if (ref $this->{value}) {
		if ($#{$this->{clones}} && $this->{id} ne $this->{clones}->[0]->{id}) {
			$string .= "USE " . $this->getName;
		} else {
			$string .= $this->{value};
		}
	} else {
		$string .= 'NULL';
	}
	
	return $string;
}

sub DESTROY {
	#print " VRML2::Field::SFNode::DESTROY \n";
	1;
}

1;
__END__
package VRML::Field::SFNode;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::Field;
@ISA = qw(VRML::Field);

use overload
	"<=>" => \&ncmp,
	"==" => \&neq,
	"!=" => \&nne,
	'""' => \&toString;

use AutoLoader;
use vars qw($AUTOLOAD);
sub AUTOLOAD {
	my $this = shift;
	my $name = $AUTOLOAD;  $name =~ s/.*:://;

	return ${$this}->getName if $name eq 'name';
	return ${$this}->setField($name, @_) if @_;
	return ${$this}->getField($name);
}

# Each node may assign values to its eventIns and obtain the last output values of its eventOuts
# using the $sfNodeObjectName->eventNameIn($value) or
# $value = $sfNodeObjectName->eventOutName syntax.

sub clone {
	my $this = shift;
	return $this->new(${$this} ? ${$this}->clone : undef);
}

sub getType { ${$_[0]}->getType }
sub getName { ${$_[0]}->getName }

sub ncmp { $_[1] <=> ${$_[0]} }
sub neq  { $_[1] == ${$_[0]} }
sub nne  { $_[1] != ${$_[0]} }

sub toString {
	my $this = shift;
	return sprintf "%s", ${$this} || 'NULL';
}

1;
__END__
