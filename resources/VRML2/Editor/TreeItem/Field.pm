package VRML2::Editor::TreeItem::Field;
use strict;

BEGIN {
	use Carp;

	use Gtk;

	use vars qw(@ISA);
	@ISA = qw(Gtk::TreeItem);
}

sub new {
	my ($self, $parent, $value) = @_;
	my $class = ref($self) || $self;

	#print __PACKAGE__, "::new\n";

	my $this = new Gtk::TreeItem();
	$this->set_user_data($value);
	$this->signal_connect('select', sub { $this->_select });
	$parent->append($this);
	
	bless $this, $class;
	return $this;
}

sub _select {
#	my ($this, $nodes) = @_;

	#print __PACKAGE__, "::select\n";
}

1;


__END__
