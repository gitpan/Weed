package VRML2::Editor::TreeItem::Field::SFTime;
use strict;

BEGIN {
	use Carp;
	
	use Gtk;
	use VRML2::Editor::TreeItem::Field;
	use VRML2::Parser::Symbols qw($_double);
	
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
	
    my $entry = new Gtk::Entry;
    $packer->add_defaults($entry, 'top', 'west', []);
    $entry->show;

	$entry->set_text($value->getValue);
	$entry->set_usize(66, 0);
	
	$entry->signal_connect('activate', sub { $this->on_enter; } );
	$entry->signal_connect('focus_out_event', sub { $this->on_enter(1); } );

    $this->{entry} = $entry;

	$this->parent->get_user_data->addFunction(
		'VRML2::Editor::TreeItem::Field::set_value',
		sub { $this->set_value(@_); }
	);

	bless $this, $class;
	return $this;
}

sub on_enter {
	my ($this, $focus) = @_;
	#print __PACKAGE__, "::on_enter\n";

	my $number = $this->{entry}->get_text;
	
    if ($number =~ /$_double/) {
		$number += 0;
		$this->get_user_data->setValue($number);
		$this->{entry}->set_text($this->get_user_data->toString) unless $focus;
		$this->parent->get_user_data->eventProcessed;
	}
}

sub set_value {
	my ($this, $value) = @_;

	#print __PACKAGE__, "::set_value\n";
    $this->{entry}->set_text($value->toString);
}

1;
__END__
