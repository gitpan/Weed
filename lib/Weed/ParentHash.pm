package Weed::ParentHash;

our $VERSION = '0.0079';

use Weed 'X3DParentHash : X3DObjectHash {}';    # weak hash symbol ~{}

use Weed::Tie::WeakHash;

sub new {
	my $self = $_[0];
	my $type = ref($self) || $self;
	return bless Weed::Tie::WeakHash->new, $type;
}

sub getValues { new X3DArray [ grep { $_ } values( %{ $_[0] } ) ] }

1;
__END__
