package VRML2::Editor::Tree;
use strict;

BEGIN {
	use Carp;

	use Gtk;
	
	use VRML2;
	use VRML2::Editor::TreeItem::Node::Node;

	use vars qw(@ISA $VERSION);
	@ISA = qw(Gtk::Tree);
}

sub new {
	my $self = shift;
	my $class = ref($self) || $self;

	my $this = $self->SUPER::new;

	$this->set_user_data(Browser->getSceneGraph);
	$this->set_selection_mode('multiple');
	$this->set_view_mode('item');
	$this->set_view_lines(1);
	$this->show;

	bless $this, $class;
	return $this;
}

sub replaceWorld {
	my ($this, $nodes) = @_;
	#print __PACKAGE__, "::replaceWorld\n";

	foreach ($this->children) { $this->_remove($_) }

	Browser->replaceWorld($nodes);

	$this->addToSceneGraph($nodes);
}

sub createNode {
	my ($this, $name) = @_;
	#print __PACKAGE__, "::addNode\n";

	my $nodes = Browser->createVrmlFromString("$name { }");

	Browser->addToSceneGraph($nodes);
	$this->addToSceneGraph($nodes);

	return $nodes->[0];
}

sub addToSceneGraph {
	my ($this, $nodes) = @_;
	#print __PACKAGE__, "::addToSceneGraph\n";

	my $item = new VRML2::Editor::TreeItem::Field::MFNode($this, $nodes);
}

sub deleteNode {
	my ($this, $item) = @_;
	#print __PACKAGE__, "::deleteNode\n";

	my $parentValue = $item->parent->get_user_data;
	my $value       = $item->get_user_data;

	$this->_remove($item);

	if (ref $parentValue eq 'MFNode') {
		$parentValue->remove($value);
		Browser->deleteNode($value);
	} elsif (ref $parentValue eq 'SFNode') {
		$parentValue->setValue(undef);
	}

}

sub _remove {
	my ($this, @items) = @_;

	#print __PACKAGE__, "::_remove\n";

	foreach (@items) {
		if (exists $_->{subtree}) {
			$this->_remove($_->{subtree}->children);
			$_->{subtree}->set_user_data(undef);
		}
		$_->set_user_data(undef);
		$_->parent->remove($_);
		$_->destroy;
	}
}

sub createParentGroup {
	my ($this, $item) = @_;
	print __PACKAGE__, "::createParentGroup\n";

	my $parent = $item->parent;
	my $index  = $parent->get_user_data->getIndex($item->get_user_data);
	my $node   = $item->get_user_data;

	$this->_remove($item);

	my $nodes = Browser->createVrmlFromString("Transform { }");
	$parent->get_user_data->push($nodes);
	
	my $transform = $nodes->[0];
	$transform->getField('children')->getValue->push(new MFNode($node));
	
	my $transformItem = new VRML2::Editor::TreeItem::Field::SFNode($this, $transform, $index);

	$parent->get_user_data->[$index] = $transform;
}

1;

__END__
