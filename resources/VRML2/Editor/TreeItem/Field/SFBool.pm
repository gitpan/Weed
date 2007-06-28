package VRML2::Editor::TreeItem::Field::SFBool;
use strict;

BEGIN {
	use Carp;
	
	use Gtk;
	use VRML2::Editor::TreeItem::Field;
	
	use vars qw(@ISA);
	@ISA = qw(VRML2::Editor::TreeItem::Field);
}

sub new {
	my ($self, $parent, $value) = @_;
	my $class = ref($self) || $self;

	#print __PACKAGE__, "::new\n";

	my $this = $self->SUPER::new($parent, $value);

    my $packer = new Gtk::Packer;
    $this->add($packer);
    $packer->show;
	
	my $button = new_with_label Gtk::Button($value->toString);
    $packer->add_defaults($button, 'top', 'west', []);
    $button->show;

	$button->width(60);

	$button->signal_connect('clicked', sub { $this->on_clicked($button); } );

	$this->parent->get_user_data->addFunction(
		'VRML2::Editor::TreeItem::Field::set_value',
		sub { $this->set_value($button, @_); }
	);

	bless $this, $class;
	return $this;
}

sub on_clicked {
	my ($this, $button) = @_;
	#print __PACKAGE__, "::on_clicked\n";

	print $button->child->get, "\n";

	$this->get_user_data->setValue(!$this->get_user_data->getValue);
    $button->child->set($this->get_user_data->toString);
	$this->parent->get_user_data->eventProcessed;
}

sub set_value {
	my ($this, $button, $value) = @_;

	#print __PACKAGE__, "::set_value\n";
    $button->child->set($value->toString);
}

1;
__END__
