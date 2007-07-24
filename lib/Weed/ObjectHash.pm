package Weed::ObjectHash;

use Weed 'X3DObjectHash : X3DHash { }';

our $VERSION = '0.009';

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
