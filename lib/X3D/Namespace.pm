package X3D::Namespace;

our $VERSION = '0.002';

use base 'Weed::Namespace';

sub import { Weed::Namespace->import('X3D') }

1;
__END__
