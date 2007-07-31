package Weed::ParentHash;

our $VERSION = '0.011';

use Weed 'X3DParentHash : X3DHash {}';

use Weed::Tie::WeakHash;

use overload
  '@{}' => sub { $_[0]->getValues },
  ;

sub new {
	my $self = $_[0];
	my $type = ref($self) || $self;
	return bless Weed::Tie::WeakHash->new, $type;
}

sub getValues { new X3DArray [ grep { $_ } values( %{ $_[0] } ) ] }

sub add {
	my $this = shift;
	$this->{ $_[0]->getId } = $_[0] if defined $_[0];
	return;
}

sub remove {
	my $this = shift;
	delete $this->{ $_[0]->getId };
	return;
}

1;
__END__
sub add {
	my $this = shift;
	$this->{ $_->getId } = $_ foreach grep { defined $_ } @_;
	return;
}

sub remove {
	my $this = shift;
	delete $this->{ $_->getId }  foreach grep { defined $_ } @_;
	return;
}

