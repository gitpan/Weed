package Weed::Component::Core;
use strict;
use warnings;

our $VERSION = '0.0013';

use Weed '
X3DComponentCore : X3DComponent {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';

1;
__END__
