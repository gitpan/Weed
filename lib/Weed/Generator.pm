package Weed::Generator;
use strict;
use warnings;

our $VERSION = '0.0003';

use Weed;
use Weed::Generator::Symbols;

use constant DESCRIPTION => '
X3DGenerator : X3DChildNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';

sub new {
	my ( $self, $name ) = @_;
	my $this = $self->SUPER::new(__PACKAGE__);
	return $this;
}

1;
__END__
