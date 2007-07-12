package Weed::ParentHash;

our $VERSION = '0.0078';

use Weed 'X3DParentHash : X3DObjectHash ~{}';    # weak hash symbol ~{}

sub getValues { new X3DArray [ grep { $_ } values( %{ $_[0] } ) ] }

1;
__END__
