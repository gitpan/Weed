package VRML2::Editor::TreeItem::Event::exposedField;
use strict;

BEGIN {
	use Carp;

	use Gtk;

	use VRML2::Editor::TreeItem::Event;
	use VRML2::Editor::TreeItem::FieldTypes;

	use vars qw(@ISA);
	@ISA = qw(VRML2::Editor::TreeItem::Event);
}

sub new {
	my ($self, $parent, $field) = @_;
	my $class = ref($self) || $self;

	#print __PACKAGE__, "::new\n";

	my $this = $self->SUPER::new($parent, $field);

	# [+/-] Box
	my $subtree = new Gtk::Tree();
	$subtree->set_user_data($field);
	$this->set_subtree($subtree);
	$this->signal_connect('expand', sub { $this->_expand($subtree, $field) });
	$this->signal_connect('collapse', sub { $this->_collapse($subtree) });
	
	$this->{subtree} = $subtree;

	bless $this, $class;
	return $this;
}

sub _expand {
	my ($this, $parent) = @_;

	my $field = $this->get_user_data;

	#print __PACKAGE__, "::expand\n";

    if ($parent->children) {
		foreach ($parent->children) {
			$_->show;
		}
	} else {
		my $item;

		# Field
		if ($field->getType eq 'SFBool') {
			$item = new VRML2::Editor::TreeItem::Field::SFBool($parent, $field->getValue);
		} elsif ($field->getType eq 'SFColor') {
			$item = new VRML2::Editor::TreeItem::Field::SFColor($parent, $field->getValue);
		} elsif ($field->getType eq 'SFFloat') {
			$item = new VRML2::Editor::TreeItem::Field::SFFloat($parent, $field->getValue);
		} elsif ($field->getType eq 'SFImage') {
			$item = new VRML2::Editor::TreeItem::Field::SFImage($parent, $field->getValue);
		} elsif ($field->getType eq 'SFInt32') {
			$item = new VRML2::Editor::TreeItem::Field::SFInt32($parent, $field->getValue);
		} elsif ($field->getType eq 'SFNode') {
			$item = new VRML2::Editor::TreeItem::Field::SFNode($parent, $field->getValue);
		} elsif ($field->getType eq 'SFTime') {
			$item = new VRML2::Editor::TreeItem::Field::SFTime($parent, $field->getValue);
		} elsif ($field->getType eq 'SFRotation') {
			$item = new VRML2::Editor::TreeItem::Field::SFRotation($parent, $field->getValue);
		} elsif ($field->getType eq 'SFString') {
			$item = new VRML2::Editor::TreeItem::Field::SFString($parent, $field->getValue);
		} elsif ($field->getType eq 'SFVec2f') {
			$item = new VRML2::Editor::TreeItem::Field::SFVec2f($parent, $field->getValue);
		} elsif ($field->getType eq 'SFVec3f') {
			$item = new VRML2::Editor::TreeItem::Field::SFVec3f($parent, $field->getValue);
		}

		# MField
		elsif ($field->getType eq 'MFColor') {
			$item = new VRML2::Editor::TreeItem::Field::MFColor($parent, $field->getValue);
		} elsif ($field->getType eq 'MFEnum') {
			$item = new VRML2::Editor::TreeItem::Field::MFEnum($parent, $field->getValue);
		} elsif ($field->getType eq 'MFFloat') {
			$item = new VRML2::Editor::TreeItem::Field::MFFloat($parent, $field->getValue);
		} elsif ($field->getType eq 'MFInt32') {
			$item = new VRML2::Editor::TreeItem::Field::MFInt32($parent, $field->getValue);
		} elsif ($field->getType eq 'MFNode') {
			$item = new VRML2::Editor::TreeItem::Field::MFNode($parent, $field->getValue);
		} elsif ($field->getType eq 'MFRotation') {
			$item = new VRML2::Editor::TreeItem::Field::MFRotation($parent, $field->getValue);
		} elsif ($field->getType eq 'MFString') {
			$item = new VRML2::Editor::TreeItem::Field::MFString($parent, $field->getValue);
		} elsif ($field->getType eq 'MFTime') {
			$item = new VRML2::Editor::TreeItem::Field::MFTime($parent, $field->getValue);
		} elsif ($field->getType eq 'MFVec2f') {
			$item = new VRML2::Editor::TreeItem::Field::MFVec2f($parent, $field->getValue);
		} elsif ($field->getType eq 'MFVec3f') {
			$item = new VRML2::Editor::TreeItem::Field::MFVec3f($parent, $field->getValue);
		}

		# CosmoWorlds
		elsif ($field->getType eq 'SFEnum') {
			$item = new VRML2::Editor::TreeItem::Field::SFEnum($parent, $field->getValue);
		} elsif ($field->getType eq 'MFEnum') {
			$item = new VRML2::Editor::TreeItem::Field::MFEnum($parent, $field->getValue);
		}

		$item->show;
	}
}

sub _collapse {
	my ($this, $parent) = @_;

	#print __PACKAGE__, "::collapseNode\n";

	foreach ($parent->children) {
		 $_->hide;
	}
}

sub _select {
#	my ($this, $nodes) = @_;

	#print __PACKAGE__, "::select\n";
}

1;


__END__
