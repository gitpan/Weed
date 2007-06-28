package VRML2::Editor::Outliner;
use strict;

BEGIN {
	use Carp;

	use Gtk;

	use VRML2::Editor::Tree;

	use vars qw(@ISA $VERSION);
	@ISA = qw(Gtk::ScrolledWindow);
}

sub new {
	my $self = shift;
	my $class = ref($self) || $self;

	my $this = $self->SUPER::new(undef, undef);

	$this->width(350);
	$this->height(500);

	$this->set_policy('always', 'always' );
	$this->border_width(0);
	$this->hscrollbar->set_update_policy('continuous');
	$this->vscrollbar->set_update_policy('continuous');

	#
	# Construct a GtkTree 'tree'
	$this->{tree} = new VRML2::Editor::Tree;
	$this->add_with_viewport($this->{tree});
	$this->{tree}->show;
	

	bless $this, $class;
	return $this;
}

sub replaceWorld {
	my $this = shift;

	#print __PACKAGE__, "::replaceWorld\n";

	$this->{tree}->replaceWorld(@_);
}

sub addToSceneGraph {
	my $this = shift;

	#print __PACKAGE__, "::addToSceneGraph\n";

	$this->{tree}->addToSceneGraph(@_);
}

sub deleteNode {
	my $this = shift;
	map {
		$this->{tree}->deleteNode($_)
	} grep {
		ref $_ eq 'VRML2::Editor::TreeItem::Field::SFNode'
	} $this->{tree}->selection;
}

sub deteachFromGroup {
	my $this = shift;
	map {
		$_ 
	} grep {
		ref $_ eq 'VRML2::Editor::TreeItem::Field::SFNode'
	} $this->{tree}->selection;
}

sub createParentGroup {
	my $this = shift;
	map {
		$this->{tree}->createParentGroup($_)
	} grep {
		ref $_ eq 'VRML2::Editor::TreeItem::Field::SFNode'
	} $this->{tree}->selection;
}

1;
__END__
