package Weed::Tie::Field;
use Weed::Perl;

use Tie::Scalar;
use base 'Tie::StdScalar';

sub TIESCALAR { bless \$_[1], $_[0] }

sub FETCH { ${ $_[0] }->getValue }

sub STORE { ${ $_[0] }->setValue($_[1]) }

1;
__END__

sub UNTIE {
	say 'UNTIE';
	return;
}

sub DESTROY {
	say 'DESTROY';
	undef ${ $_[0] };
}

sub new {
	my $self = shift;
	my $class = ref($self) || $self;
	
	my $value = @_ == 1 && ref($_[0]) eq 'ARRAY' ? shift : [];

	tie my (@this), $class, $value;
	my $this = bless \@this, $class;

	push @$this, @_;

	return $this;
}

sub TIEARRAY { bless \$_[1], $_[0] }

sub FETCHSIZE { scalar @${ $_[0] } }










use Carp;
use warnings::register;

sub new {
    my $pkg = shift;
    $pkg->TIESCALAR(@_);
}

# "Grandfather" the new, a la Tie::Hash

sub TIESCALAR {
    my $pkg = shift;
	if ($pkg->can('new') and $pkg ne __PACKAGE__) {
	warnings::warnif("WARNING: calling ${pkg}->new since ${pkg}->TIESCALAR is missing");
	$pkg->new(@_);
    }
    else {
	croak "$pkg doesn't define a TIESCALAR method";
    }
}

sub FETCH {
    my $pkg = ref $_[0];
    croak "$pkg doesn't define a FETCH method";
}

sub STORE {
    my $pkg = ref $_[0];
    croak "$pkg doesn't define a STORE method";
}

