package Weed::Component::Core::ChildNode;
use strict;
use warnings;

our $VERSION = '0.0013';

use Weed '
X3DChildNode : X3DNode { 
	SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';

1;
__END__
