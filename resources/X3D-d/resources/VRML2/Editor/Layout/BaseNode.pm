package VRML2::Editor::Layout::BaseNode;
use strict;

BEGIN {
	use Carp;

	use Gtk;

	use VRML2::Math qw(max);
	use VRML2::Editor::Layout::Event;

	use vars qw(@ISA $VERSION);
	@ISA = qw(Gnome::CanvasWidget);
}
sub new {
	my $self = shift;
	my $class = ref($self) || $self;

	my $layout = shift;
	my $node   = shift;

	my $vbox = new Gtk::VBox(0, 0);
	$vbox->show;

	my $this = $layout->{canvas}->root->new($layout->{canvas}->root, 'Widget',
		widget => $vbox,
		width  => 100,
		height => 16 * (@{$node->getProto->getInterface} + 1) + 6,
	);

	my $button = new_with_label Gtk::Button($node->getType);
	$button->signal_connect("pressed", sub { $this->on_pressed(@_) } );
	$button->signal_connect("released", sub { $this->on_released(@_) } );
	$button->signal_connect("motion_notify_event", sub { $this->on_motion(@_) } );
	$button->show;
	
	$vbox->add($button);

	my $i = 0;
	foreach (@{$node->getProto->getInterface}) {
		my $button = new VRML2::Editor::Layout::Event($this, $_, $i);
		$button->show;
		$vbox->add($button);
		$this->{event}->{$_->getName} = $button;
		++$i;
	}

	my $bottom = new Gtk::Button();
	$bottom->set_usize(0, 12);
	$bottom->signal_connect("pressed", sub { $this->on_pressed(@_) } );
	$bottom->signal_connect("released", sub { $this->on_released(@_) } );
	$bottom->signal_connect("motion_notify_event", sub { $this->on_motion(@_) } );
	$bottom->show;

	$vbox->add($bottom);
	
	$this->{layout} = $layout;
	$this->{node}   = $node;

	bless $this, $class;
	return $this;
}

sub getEvent {
	my $this = shift;
	my $name = shift;
	if (exists $this->{event}->{$name}) {
		return $this->{event}->{$name};
	}
}

sub on_pressed {
	my $this  = shift;

	print __PACKAGE__, "::on_pressed\n";

	$this->{start} = 1;

	my $x = $this->x;
	my $y = $this->y;
}

sub on_released {
	my $this  = shift;

	print __PACKAGE__, "::on_released\n";

	$this->widget->draw;
	$this->{layout}->resize;
}

sub on_motion {
	my $this  = shift;
	my $item  = shift;
	my $event = shift;

	my $x = $event->{x};
	my $y = $event->{y};

	
	if ($this->{start}) {
		$this->{start} = 0;
		@{$this->{offset}} = ($this->x - $x, $this->y - $y);
	} else {
		$this->moveTo($x + $this->{offset}->[0], $y + $this->{offset}->[1]);
	}
}


sub moveTo {
	my $this = shift;
	my $x = shift;
	my $y = shift;
	
	$this->x($x);
	$this->y($y);
	foreach my $event (values %{$this->{event}}) {
		foreach (values %{$event->{routes}}) {
			$event->setRoute($_);		
		}
	}
}

1;
__END__
sub on_event {
	my $this  = shift;
	my $item  = shift;
	my $event = shift;

	if ($event->{type} eq "button_press" and $event->{button} == 1) {
		$this->{bp} = 1; ($this->{bpx}, $this->{bpy}) = ($event->{x}, $event->{y});
	} elsif($event->{type} eq "button_release" and $event->{button} == 1) {
		$this->{bp} = 0;
	} elsif($event->{type} eq "motion_notify" and $this->{bp}) {
		my $dx = $event->{x} - $this->{bpx};
		my $dy = $event->{y} - $this->{bpy};

		$this->move($dx, $dy);
		$this->{bpx} += $dx;
		$this->{bpy} += $dy;
	}

	return 1;
}
