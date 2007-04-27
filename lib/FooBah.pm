package FooBah;
use strict;
use warnings;

our $VERSION = '0.0009';

use Weed;

use constant DESCRIPTION => 'X3D : X3DUniversum { }';

1;
__END__

use base 'Exporter';

our @EXPORT = qw{
  createBrowser
  getBrowser
};

my $Universum = new X3DUniversum(__PACKAGE__);

sub createBrowser { $Universum->createBrowser }
sub getBrowser    { $Universum->getBrowser }
