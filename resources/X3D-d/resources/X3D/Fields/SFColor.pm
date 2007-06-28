package VRML2::Field::SFColor;
use strict;

BEGIN {
	use Carp;

	use VRML2::Field;
	use VRML2::Array qw(array_ncmp);
	
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

sub r { $_[0]->setRed  ($_[1]) if $#_; return $_[0]->getRed   }
sub g { $_[0]->setGreen($_[1]) if $#_; return $_[0]->getGreen }
sub b { $_[0]->setBlue ($_[1]) if $#_; return $_[0]->getBlue  }

#sub h {  }
#sub s {  }
#sub v {  }

sub setRed    { $_[0]->[0] = "$_[1]"+0 || 0 }
sub setGreen  { $_[0]->[1] = "$_[1]"+0 || 0 }
sub setBlue   { $_[0]->[2] = "$_[1]"+0 || 0 }

sub getRed    { $_[0]->[0] }
sub getGreen  { $_[0]->[1] }
sub getBlue   { $_[0]->[2] }

sub toString {
	my $this = shift;
	return sprintf "%s %s %s", map {(sprintf $FLOAT, $_) +0} @{$this};
}

1;
__END__
