package VRML2::Editor::Layout::Route;
use strict;

BEGIN {
	use Carp;

	use Gtk;

	use vars qw(@ISA);
	@ISA = qw(Gnome::CanvasLine);
}
sub new {
	my $self = shift;
	my $class = ref($self) || $self;

	my $layout = shift;
	my $route  = shift;

	my $points = [0,0, 0,0, 0,0, 0,0];
	my $this = $layout->{canvas}->root->new($layout->{canvas}->root, 'Line',
		points     => $points,
		last_arrowhead => 1,
		arrow_shape_a => 8,
		arrow_shape_b => 8,
		arrow_shape_c => 4,
	);

	$this->{points} = $points;
	$this->{route}  = $route;

	bless $this, $class;
	return $this;
}

sub from {
	my $this = shift;
	if (@_) {
		($this->{points}->[0], $this->{points}->[1]) = @_;
		my $offset = ($this->{points}->[6] - $this->{points}->[0]) / 3;
		$this->{points}->[2] = $this->{points}->[0] + ($offset <  6 ?  6 : $offset);
		$this->{points}->[3] = $this->{points}->[1];
		$this->{points}->[4] = $this->{points}->[6] - ($offset < 12 ? 12 : $offset);
		$this->points($this->{points});
	}
	return ($this->{points}->[0], $this->{points}->[1]);
}

sub to {
	my $this = shift;
	if (@_) {
		($this->{points}->[6], $this->{points}->[7]) = @_;
		my $offset = ($this->{points}->[6] - $this->{points}->[0]) / 3;
		$this->{points}->[4] = $this->{points}->[6] - ($offset < 12 ? 12 : $offset);
		$this->{points}->[5] = $this->{points}->[7];
		$this->{points}->[2] = $this->{points}->[0] + ($offset <  6 ?  6 : $offset);
		$this->points($this->{points});
	}
	return ($this->{points}->[6], $this->{points}->[7]);
}

1;
__END__
