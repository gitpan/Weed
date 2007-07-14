package Weed::Tie::ArrayLength;
use Weed::Perl;

our $VERSION = '0.0079';

use Tie::Scalar;
use base 'Tie::StdScalar';

sub TIESCALAR { bless \$_[1], $_[0] }

sub FETCH { ${ $_[0] }->getLength }

sub STORE { ${ $_[0] }->setLength($_[1]) }

1;
__END__
