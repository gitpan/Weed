package Weed::Seed;
use strict;
use warnings;

our $VERSION = '0.001';

use base 'Weed::Private';

use Weed::Generator::Symbols qw($seed_);

use overload
  '==' => sub { $_[1] == $_[0]->getId },
  '!=' => sub { $_[1] != $_[0]->getId },
  'eq' => sub { $_[1] eq "$_[0]" },
  'ne' => sub { $_[1] ne "$_[0]" },
  ;

use constant DESCRIPTION => 'X3DObject { }';

sub new {
	my ( $self, $type ) = @_;
	my $this = $self->NEW({});

	$this->{id}      = $this->ID;
	$this->{type}    = $type || $this->PACKAGE;
	$this->{comment} = '';

	return $this;
}

sub getId : Overload(0+) { $_[0]->{id} }

sub getType { $_[0]->{type} }

sub getComment { $_[0]->{comment} }

sub getHierarchy { grep /^X3D/o, $_[0]->PATH }

sub toString : Overload("") { sprintf $seed_, $_[0]->getType }

1;
__END__
