package Weed::Tie::WeakHash;
use Weed::Perl;

our $VERSION = '0.009';

use Tie::Hash;
use base 'Tie::StdHash';

use Scalar::Util 'weaken';

sub new {
	tie my (%hash), shift;
	return \%hash;
}

sub STORE {
	$_[0]->{ $_[1] } = $_[2];
	weaken( $_[0]->{ $_[1] } );
}

1;
__END__
