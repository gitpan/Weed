package X3DGtk2Node;
use strict;
use warnings;
no strict 'refs';

use rlib "../Core", "Widgets";

use base qw(X3DChildNode);

use X3DConstants;

=X3DGtk2Node  : X3DChildNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
=cut

use Glib;
use Gtk2 -init;

1;
__END__
