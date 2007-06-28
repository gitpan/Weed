package VRML2::Editor::TreeItem::Field::MFInt32;
use strict;

BEGIN {
	use Carp;
	
	use VRML2::Editor::TreeItem::MField;
	
	use vars qw(@ISA);
	@ISA = qw(VRML2::Editor::TreeItem::MField);
}

sub new {
	my ($self, $parent, $value) = @_;
	my $class = ref($self) || $self;

	#print __PACKAGE__, "::new\n";

	my $this = [];

	foreach (@{$value}) {
		my $item = new VRML2::Editor::TreeItem::Field::SFInt32($parent, $_);
		$item->show;
	}

	$parent->get_user_data->addFunction(
		'VRML2::Editor::TreeItem::Field::set_value',
		sub { $this->set_value($parent, @_); }
	);
	
	bless $this, $class;
	return $this;
}

sub set_value {
	my ($this, $parent, $value) = @_;

	#print __PACKAGE__, "::set_value\n";

    my $i = 0;
	foreach (map { $_->{entry} } $parent->children) {
		$_->set_text($value->[$i ++]->toString);
	}
}

1;
__END__
