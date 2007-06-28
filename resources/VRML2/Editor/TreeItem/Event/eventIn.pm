package VRML2::Editor::TreeItem::Event::eventIn;
use strict;

BEGIN {
	use Carp;

	use Gtk;

	use VRML2::Editor::TreeItem::Event;

	use vars qw(@ISA);
	@ISA = qw(VRML2::Editor::TreeItem::Event);
}

sub new {
	my ($self, $parent, $field) = @_;
	my $class = ref($self) || $self;

	#print __PACKAGE__, "::new\n";

	my $this = $self->SUPER::new($parent, $field);

	bless $this, $class;
	return $this;
}

sub _expand {
	my ($this, $parent, $node) = @_;

	#print __PACKAGE__, "::expand\n";
}

sub _collapse {
#	my ($this, $subtree, $nodes) = @_;

	#print __PACKAGE__, "::collapse\n";
}

sub _select {
#	my ($this, $nodes) = @_;

	#print __PACKAGE__, "::select\n";
}

1;


__END__
