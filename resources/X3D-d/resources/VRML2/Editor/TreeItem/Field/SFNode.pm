package VRML2::Editor::TreeItem::Field::SFNode;
use strict;

BEGIN {
	use Carp;
	
	use VRML2::Editor::TreeItem::Node::Node;
	use VRML2::Editor::TreeItem::Field;
	
	use vars qw(@ISA);
	@ISA = qw(
		VRML2::Editor::TreeItem::Node::Node
		VRML2::Editor::TreeItem::Field
	);
}

use vars qw(@stringtargets);
@stringtargets = (
	{ target => "Node", flags => 0, info => 0 },
);

sub new {
	my ($self, $parent, $value, $index) = @_;
	my $class = ref($self) || $self;

	#print __PACKAGE__, "::new\n";

	my $this = $self->SUPER::new($parent, $value->getValue, $index);
	$this->set_user_data($value);

	$this->signal_connect('select', sub { $this->on_select });

	$this->drag_source_set ([-button1_mask, -button3_mask], [-copy, -move], @stringtargets);
	$this->signal_connect ("drag_data_get", sub {
		my ($widget, $context, $data, $info, $time) = @_;
		$data->set ($data->target, 8, $value->getId);
	});

	
	bless $this, $class;
	return $this;
}

sub on_select {
#	my ($this, $nodes) = @_;

	#print __PACKAGE__, "::_select\n";
}



1;
__END__
