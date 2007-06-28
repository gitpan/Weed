package VRML2::Editor::Layout::Event;
use strict;

BEGIN {
	use Carp;

	use Gtk;
	use VRML2;

	use vars qw(@ISA $VERSION);
	@ISA = qw(Gtk::HBox);
}

use vars qw(@stringtargets);
@stringtargets = (
	{ target => "eventOut", flags => 0, info => 0 },
);

sub new {
	my $self = shift;
	my $class = ref($self) || $self;

	my $parent = shift;
	my $field  = shift;
	my $index  = shift;

	my $this = $self->SUPER::new(0, 0);

	if (ref $field eq "eventIn" || ref $field eq "exposedField") {
		my $in = new Gtk::Button();
    	$in->set_usize(6, 0); 
		$in->show;
		$this->pack_start($in, 0, 0, 0);

		$in->drag_dest_set('all', [-copy, -move],
			{ target => $field->getType, flags => 0, info => 0 }
		);
		$in->signal_connect(drag_data_received => sub { $this->on_drag_data_received(@_) } );
	}

	my $button = new_with_label Gtk::Button($field->getName);
	$button->show;
	$this->pack_start($button, 1, 1, 0);

	if (ref $field eq "eventOut" || ref $field eq "exposedField") {
		my $out = new Gtk::Button();
	    $out->set_usize(6, 0); 
		$out->show;
		$this->pack_start($out, 0, 0, 0);
	
		$out->drag_source_set ([-button1_mask, -button3_mask], [-copy, -move],
			{ target => $field->getType, flags => 0, info => 0 }
		);
		$out->signal_connect ("drag_data_get", sub {
			my ($widget, $context, $data, $info, $time) = @_;
			$data->set($data->target, 8, $parent->{node}->getId . '.' . $field->getName);
		});
	}

	$this->{parent} = $parent;
	$this->{field}  = $field;
	$this->{index}  = $index;

	bless $this, $class;
	return $this;
}

sub addRoute {
	my $this = shift;
	my $route = shift;
	$this->setRoute($route);
	my $id = $route->{route}->getFromNode->getId . '.' . $route->{route}->getEventOut->getName;
	$this->{routes}->{$id} = $route;
}

sub setRoute {
	my $this = shift;
	my $route = shift;
	if ($route->{route}->getFromNode->getId eq $this->{parent}->{node}->getId) {
		$route->from(
			$this->{parent}->x + $this->{parent}->width,
			$this->{parent}->y + ($this->{index}+1) * 16 + 8,
		)
	}
	elsif ($route->{route}->getToNode->getId eq $this->{parent}->{node}->getId) {
		$route->to(
			$this->{parent}->x,
			$this->{parent}->y + ($this->{index}+1) * 16 + 8,
		)
	}
}

sub on_drag_data_received {
	my $this = shift;

	print __PACKAGE__, "::on_drag_data_received\n";

	my ($widget, $context, $x, $y, $data, $info, $time) = @_;
	my $type = Gtk::Gdk::Atom->name($data->type);

	print "on_drag_data_received: $x, $y, $data, $info, $time, $type, ", $data->data, ", ".$data->format."\n";

	if ($data->data =~ /(.*?)\.(.*)/) {
		my ($nodeId, $fieldId) = ($1, $2);
		my $node = Browser->getNodeById($nodeId);
		if ($node != $this->{parent}->{node}) {
			my $widget = $this->{parent}->{layout}->getNode($nodeId);
			print ref $widget, "\n";

			#my $route = new VRML2::Editor::Layout::Route($this->{parent}->{layout}, $_);

			#$widget->getEvent($_->getEventOut->getName)->addRoute($route);
			#$this->{parent}->getEvent($_->getEventIn->getName)->addRoute($route);

			$context->finish(1, 0, $time);
		} else {
			$context->finish(0, 0, $time);
		}
	} else {
		$context->finish(0, 0, $time);
	}
}

1;
__END__
