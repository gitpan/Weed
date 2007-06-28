package X3DObject;
use strict;
use warnings;

use rlib "./";

use Scalar::Util;
use Class::ISA;
use X3DError;

use overload
  "=="   => sub { $_[0]->getId == $_[1] },
  "!="   => sub { $_[0]->getId != $_[1] },
  'bool' => sub { 1 },
  '""'   => sub { $_[0]->toString };

sub new {
	my $self = shift;
	my $class = ref($self) || $self;
	return bless {}, $class;
}

sub getId   { Scalar::Util::refaddr( $_[0] ) }
sub getType { $_[0]->{type} }
sub getName { $_[0]->{name} }

sub toString { $_[0]->{type} }

sub dispose {
	my $this = shift;
	%$this = ();
}

sub DESTROY {    #X3DError::Debug ref $_[0];
	my $this = shift;
	$this->dispose if keys %$this;
	0;
}

no strict 'refs';

sub call {
	my $this   = shift;
	my $method = shift;
	&$_( $this, @_ ) foreach $this->getMethod($method);
	return;
}

sub getHierarchy { reverse( Class::ISA::self_and_super_path( ref $_[0] ) ) }

sub getData {
	my ( $this, $name ) = @_;
	my $property = sprintf "%s::_%s", ref $this, $name;

	unless ( defined $$property ) {
		$$property = [];
		push @$$property, map { @${"${_}::${name}"} }
		  grep { defined ${"${_}::${name}"} } $this->getHierarchy;
	}

	wantarray ? @$$property : $$property;
}

sub getMethod {
	my ( $this, $name ) = @_;
	my $property = sprintf "%s::_%s", ref $this, $name;

	unless ( defined $$property ) {
		$$property = [];
		push @$$property, map { \&{"${_}::${name}"} }
		  grep { exists &{"${_}::${name}"} } $this->getHierarchy;
	}

	wantarray ? @$$property : $$property;
}

use strict;

1;

#printf "%s\n", __PACKAGE__->new;
__END__
