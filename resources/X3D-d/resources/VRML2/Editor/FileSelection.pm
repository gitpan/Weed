package VRML2::Editor::FileSelection;
use strict;

BEGIN {
	use Carp;

	use Gtk;

	use vars qw(@ISA $VERSION);
	@ISA = qw(Gtk::FileSelection);
}

sub new {
	my $self = shift;
	my $class = ref($self) || $self;

	my $this = $self->SUPER::new(shift);
	$this->{function} = shift;

	$this->ok_button->signal_connect('clicked', sub { $this->on_ok });
	$this->cancel_button->signal_connect('clicked', sub { $this->on_cancel });

	bless $this, $class;
	return $this;
}

sub on_ok {
	my $this = shift;
	my $fn = $this->get_filename;

	if (-d $fn) {
	} else {
		$this->hide;
		$this->{function}($fn);
	}
}

sub on_cancel {
	my $this = shift;
	$this->hide;
}


1;
__END__
