package Weed::ParentHash;

our $VERSION = '0.01';

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
	$this->{ $_->getId } = $_ foreach @_;
	return;
}

sub remove {
	my $this = shift;
	delete $this->{ $_->getId } foreach @_;
	return;
}

1;
__END__
