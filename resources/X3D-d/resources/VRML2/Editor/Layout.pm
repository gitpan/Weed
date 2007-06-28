package VRML2::Editor::Layout;
use strict;

BEGIN {
	use Carp;

	use Gtk;
	use Gnome;

	use VRML2;
	use VRML2::Math qw(max);
	use VRML2::Editor::Layout::BaseNode;
	use VRML2::Editor::Layout::Route;

	use vars qw(@ISA $VERSION);
	@ISA = qw(Gtk::ScrolledWindow);
}

use vars qw(@stringtargets);
@stringtargets = (
	{ target => "Node",     flags => 0, info => 0 },
);

sub new {
	my $self = shift;
	my $class = ref($self) || $self;

	my $this = $self->SUPER::new(undef, undef);

	$this->set_policy('always', 'always' );
	$this->border_width(0);
	$this->hscrollbar->set_update_policy('continuous');
	$this->vscrollbar->set_update_policy('continuous');

	$this->set_usize(600, 400);

	# Construct a GnomeCanvas 'canvas'
	my $canvas = new Gnome::Canvas;
	#$canvas->set_usize(600, 400);
	$canvas->set_scroll_region(0, 0, 1.8e308, 1.8e308);
    #$canvas->set_pixels_per_unit(1 );

	$canvas->add_events('button1-motion-mask');
	$canvas->drag_dest_set('all', [-copy, -move], @stringtargets);
	$canvas->signal_connect(drag_data_received => sub { $this->on_drag_data_received(@_) } );

	$this->add_with_viewport($canvas);
	$canvas->show;

	$this->{canvas} = $canvas;

	bless $this, $class;
	return $this;
}

sub resize {
	my $this  = shift;
	my ($x1, $y1, $x2, $y2) = $this->{canvas}->root->get_bounds;
	($x2, $y2) = (max($x2, $_[0]), max($y2, $_[1])) if @_;
	$this->{canvas}->set_usize($x2, $y2);
}

sub addNode {
	my $this = shift;
	my $id   = shift;
	my $widget = shift;

	$this->{nodes}->{$id} = $widget;
}

sub getNode {
	my $this = shift;
	my $id   = shift;
	if (exists $this->{nodes}->{$id}) {
		return $this->{nodes}->{$id};
	}
}

sub on_drag_data_received {
	my $this = shift;

	print __PACKAGE__, "::on_drag_data_received\n";

	my ($widget, $context, $x, $y, $data, $info, $time) = @_;
	my $type = Gtk::Gdk::Atom->name($data->type);

	#print "$$: _drag_data_received: $context, $x, $y, $data, $info, $time, $type, ".$data->data.", ".$data->format."\n";
 
	my $node = Browser->getNodeById($data->data);
	if (ref $node) {
		my $widget = $this->getNode($node->getId);
		unless ($widget) {
			$widget = new VRML2::Editor::Layout::BaseNode($this, $node);
		}
		
		$this->resize($x + $widget->width, $y + $widget->height);

		
		unless ($this->getNode($node->getId)) {
			$this->addNode($node->getId, $widget);

			my @routes = grep {
				($_->getFromNode->getId eq $node->getId && $this->getNode($_->getToNode->getId))
				 ||
				($_->getToNode->getId eq $node->getId && $this->getNode($_->getFromNode->getId))
			} @{Browser->{routes}};

			foreach (@routes) {
				my $route = new VRML2::Editor::Layout::Route($this, $_);

				$this->getNode($_->getFromNode->getId)->getEvent($_->getEventOut->getName)->addRoute($route);
				$this->getNode($_->getToNode->getId)->getEvent($_->getEventIn->getName)->addRoute($route);
			}

		}

		$widget->moveTo($x, $y);

		$context->finish(1, 0, $time);
	} else {
		$context->finish(0, 0, $time);
	}
}

1;
__END__
