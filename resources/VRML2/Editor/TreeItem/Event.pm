package VRML2::Editor::TreeItem::Event;
use strict;

BEGIN {
	use Carp;

	use Gtk;

	use vars qw(@ISA);
	@ISA = qw(Gtk::TreeItem);
}

sub new {
	my ($self, $parent, $field) = @_;
	my $class = ref($self) || $self;

	#print __PACKAGE__, "::new\n";

	my $this = new_with_label Gtk::TreeItem($field->getName);
	$this->set_user_data($field);
	$this->signal_connect('select', sub { $this->_select });
	$parent->append($this);
	
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
