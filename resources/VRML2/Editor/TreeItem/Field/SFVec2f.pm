package VRML2::Editor::TreeItem::Field::SFVec2f;
use strict;

BEGIN {
	use Carp;
	
	use Gtk;
	use VRML2::Editor::TreeItem::Field;
	use VRML2::Parser::Symbols qw($_float);
	
	use vars qw(@ISA);
	@ISA = qw(VRML2::Editor::TreeItem::Field);
}

sub new {
	my ($self, $parent, $value) = @_;
	my $class = ref($self) || $self;

	#print __PACKAGE__, "::new\n";

	my $this = $self->SUPER::new($parent, $value);

    my $hbox = new Gtk::HBox(0, 0);
    $this->add($hbox);
    $hbox->show;

	
    {
		my $entry = new Gtk::Entry;
	    $hbox->add($entry);
	    $entry->show;
	
	    $entry->set_usize(66, 0);
		$entry->set_text($value->[0]);
		$entry->grab_focus;

		$entry->signal_connect('activate', sub { $this->on_enter(0); } );
		$entry->signal_connect('focus_out_event', sub { $this->on_enter(0, 1); } );
	
	    $hbox->set_child_packing($entry, 0, 0, 0, 'start');

	    $this->{entry}->[0] = $entry;
	}

    {
		my $entry = new Gtk::Entry;
	    $hbox->add($entry);
	    $entry->show;
	
	    $entry->set_usize(66, 0);
	    $entry->set_text($value->[1]);
		
		$entry->signal_connect('activate', sub { $this->on_enter(1); } );
		$entry->signal_connect('focus_out_event', sub { $this->on_enter(1, 1); } );
	
	    $hbox->set_child_packing($entry, 0, 0, 0, 'start');

	    $this->{entry}->[1] = $entry;
	}

	$this->parent->get_user_data->addFunction(
		'VRML2::Editor::TreeItem::Field::set_value',
		sub { $this->set_value(@_); }
	);

	bless $this, $class;
	return $this;
}

sub on_enter {
	my ($this, $index, $focus) = @_;
	#print __PACKAGE__, "::on_enter\n";

	my $number = $this->{entry}->[$index]->get_text;
	
    if ($number =~ /$_float/) {
		$number += 0;
		$this->get_user_data->[$index] = $number;
		$this->{entry}->[$index]->set_text($this->get_user_data->[$index]) unless $focus;
		$this->parent->get_user_data->eventProcessed;
	}
}

sub set_value {
	my ($this, $value) = @_;

	#print __PACKAGE__, "::set_value\n";
    $this->{entry}->[0]->set_text($value->[0]);
    $this->{entry}->[1]->set_text($value->[1]);
}

1;
