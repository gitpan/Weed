package Weed::Tie::Field;
use Weed::Perl;

use Tie::Scalar;
use base 'Tie::StdScalar';

sub TIESCALAR { bless \$_[1], $_[0] }

sub FETCH { ${ $_[0] }->getClone }

sub STORE { ${ $_[0] }->setValue($_[1]) }

1;
__END__
