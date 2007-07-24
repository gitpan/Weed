package Weed::Tie::ArrayLength;
use Weed::Perl;

our $VERSION = '0.009';

use Tie::Scalar;
use base 'Tie::StdScalar';

sub TIESCALAR { bless \$_[1], $_[0] }

sub FETCH { @${ $_[0] } }

sub STORE { $#${ $_[0] } = $_[1] - 1 }

1;
__END__
