package VRML2::Field::SFVec3f;
use strict;

BEGIN {
	use Carp;

	use VRML2::Field;
	use VRML2::Array qw(array_ncmp);
	use VRML2::Math qw();

	use VRML2::Generator;

	use VRML2::Console;
	
	use vars qw(@ISA);
	@ISA = qw(VRML2::Field);
}

use overload
	"<=>" => \&ncmp,
	"=="  => \&neq,
	"!="  => \&nne,

	"neg" => \&negate,
	"-"   => \&subtract,
	"+"   => \&add,
	"*"   => \&multiply,
	"/"   => \&divide,
	#"."   => \&dot,
	"x"   => \&cross,

	'""' => \&toString;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = [];

	bless $this, $class;
	$this->setValue(@_);
	return $this;
}

sub copy {
	return new SFVec3f(@{$_[0]});
}

sub ncmp {
	return array_ncmp($_[0], $_[1]);
}

sub neq  { !($_[0] <=> $_[1]) }
sub nne  { ($_[0] <=> $_[1]) && 1 }


sub setValue {
	my $this = shift;
	if (@_) {
		if (ref $_[0]) {
			$this->[0] = $_[0]->[0] || 0;
			$this->[1] = $_[0]->[1] || 0;
			$this->[2] = $_[0]->[2] || 0;
		} else {
			$this->[0] = $_[0] || 0;
			$this->[1] = $_[1] || 0;
			$this->[2] = $_[2] || 0;
		}
	} else {
		$this->[0] = 0;
		$this->[1] = 0;
		$this->[2] = 0;
	}
}

sub getValue { [ @{$_[0]} ] }

sub x { $_[0]->[0] }
sub y { $_[0]->[1] }
sub z { $_[0]->[2] }


sub negate {
	my $this = shift;
	return $this->new(
		-$this->[0],
		-$this->[1],
		-$this->[2],
	);
}

sub add {
	my $this = shift;
	my $value = shift;
	return $this->new(
		$this->[0] + $value->[0],
		$this->[1] + $value->[1],
		$this->[2] + $value->[2],
	);
}

sub subtract {
	my $this = shift;
	my $value = shift;
	return $this->new(
		$this->[0] - $value->[0],
		$this->[1] - $value->[1],
		$this->[2] - $value->[2],
	);
}

sub multiply {
	my $this = shift;
	my $value = shift;
	return $this->new(
		$this->[0] * $value,
		$this->[1] * $value,
		$this->[2] * $value,
	);
}

sub divide {
	my $this = shift;
	my $value = shift;
	return $this->new(
		$this->[0] / $value,
		$this->[1] / $value,
		$this->[2] / $value,
	);
}

sub dot {
	my $this  = shift;
	my $value = shift;
	return 
		$this->[0] * $value->[0] +
		$this->[1] * $value->[1] +
		$this->[2] * $value->[2]
	;
}

sub cross {
	my $this = shift;
	my $value = shift;
	return $this->new(
		$this->[1] * $value->[2] - $this->[2] * $value->[1],
		$this->[2] * $value->[0] - $this->[0] * $value->[2],
		$this->[0] * $value->[1] - $this->[1] * $value->[0],
	);
}

sub length {
	my $this = shift;
	return sqrt(
		$this->[0] ** 2 +
		$this->[1] ** 2 +
		$this->[2] ** 2
	);
}

sub normalize {
	my $this   = shift;
	return $this->divide($this->length);
}

sub toString {
	my $this = shift;
	#print CONSOLE " VRML2::Field::SFVec3f::toString\n";

	return sprintf "%s %s %s", map {(sprintf $FLOAT, $_) +0} @{$this};
}

1;
