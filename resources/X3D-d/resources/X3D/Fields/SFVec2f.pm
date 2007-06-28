package VRML2::Field::SFVec2f;
use strict;

BEGIN {
	use Carp;

	use VRML2::Field;
	use VRML2::Array qw(array_ncmp);
	use VRML2::Math qw();

	use VRML2::Generator;

	use vars qw(@ISA);
	@ISA = qw(VRML2::Field);
}

use overload
	"<=>" => \&ncmp,
	"=="  => \&neq,
	"!="  => \&nne,
	'""' => \&toString;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = [];

	bless $this, $class;
	$this->setValue(@_);
	return $this;
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
		} else {
			$this->[0] = $_[0] || 0;
			$this->[1] = $_[1] || 0;
		}
	} else {
		$this->[0] = 0;
		$this->[1] = 0;
	}
}

sub getValue { [ @{$_[0]} ] }

sub normalize {
	my $this   = shift;
	my $length = $this->length;
	return $this->new(map {$_ / $length} @{$this});
}

sub length {
	my $this = shift;
	return sqrt(
		$this->[0] * $this->[0] +
		$this->[1] * $this->[1]
	);
}

sub toString {
	my $this = shift;
	return sprintf "%s %s", map {(sprintf $FLOAT, $_) +0} @{$this};
}

1;
