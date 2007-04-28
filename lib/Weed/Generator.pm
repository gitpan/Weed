package Weed::Generator;
use strict;
use warnings;

our $VERSION = '0.0011';

use Weed;

our $DESCRIPTION = 'X3DGenerator {}';

sub new {
	my ( $self, $name ) = @_;
	my $this = $self->SUPER::new(__PACKAGE__);
	return $this;
}

1;
__END__
