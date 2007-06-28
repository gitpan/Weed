package VRML2::Editor::TreeItem::BaseNode;
use strict;

BEGIN {
	use Carp;

	use Gtk;

	use VRML2::Editor::TreeItem::EventTypes;

	use vars qw(@ISA);
	@ISA = qw(Gtk::TreeItem);
}

sub new {
	my ($self, $parent, $node, $index) = @_;
	my $class = ref($self) || $self;

	$index = -1 unless defined $index;
	
	#print __PACKAGE__, "::new\n";

	my $this;

	if (ref $node) {
		$this = new_with_label Gtk::TreeItem($node->getName . " " . $node->getType);
		#$parent->append($this);
		$parent->insert($this, $index);
		$this->show;
	
		# [+/-] Box
		my $subtree = new Gtk::Tree();
		$this->set_subtree($subtree);
		$this->signal_connect('expand', sub { $this->on_expand($subtree) });
		$this->signal_connect('collapse', sub { $this->on_collapse($subtree) });
	
		$this->{subtree} = $subtree;
	} else {
		$this = new_with_label Gtk::TreeItem('NULL');
		#$parent->append($this);
		$parent->insert($this, $index);
		$this->show;
	}

	bless $this, $class;
	return $this;
}

sub on_expand {
	my ($this, $parent) = @_;

	my $node = $this->get_user_data;
	
	#print __PACKAGE__, "::expandNode\n";

    if ($parent->children) {
		if ($parent->get_user_data eq 'openall') {
			foreach ($parent->children) {
				$_->show;
			}
		} else {
			foreach ($parent->children) {
				my $field = $_->get_user_data;
				if ($field->getValue != $node->getProto->getField($field->getName)->getValue) {
					$_->show;
				}
			}
		}
	} else {
		foreach (@{$node->getProto->getInterface}) {
			my $field = $node->getField($_->getName);

			my $item;
			if (ref $_ eq 'eventIn') {
				$item = new VRML2::Editor::TreeItem::Event::eventIn($parent, $field);
			} elsif (ref $_ eq 'eventOut') {
				$item = new VRML2::Editor::TreeItem::Event::eventOut($parent, $field);
			} elsif (ref $_ eq 'exposedField') {
				$item = new VRML2::Editor::TreeItem::Event::exposedField($parent, $field);
				if ($field->getType eq "SFNode" || $field->getType eq "MFNode") {
					$item->expand;
				}
			} elsif (ref $_ eq 'field') {
				$item = new VRML2::Editor::TreeItem::Event::field($parent, $field);
				if ($field->getType eq "SFNode" || $field->getType eq "MFNode") {
					$item->expand;
				}
			}

			if ($node->getField($_->getName)->getValue != $_->getValue) {
				$item->show;
			}
		}
	}
	
}

sub on_collapse {
	my ($this, $parent) = @_;

	#print __PACKAGE__, "::collapseNode\n";

	foreach ($parent->children) {
		 $_->hide;
	}

	if ($parent->get_user_data) {
		$parent->set_user_data('');

		foreach ($parent->children) {
			 $parent->unselect_child($_);
		}
	} else {
		$parent->set_user_data('openall');
		$this->expand;
	}

}

1;


__END__
