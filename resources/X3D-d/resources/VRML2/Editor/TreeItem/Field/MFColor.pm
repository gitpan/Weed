package VRML2::Editor::TreeItem::Field::MFColor;
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
		my $item = new VRML2::Editor::TreeItem::Field::SFColor($parent, $_);
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
		$_->[0]->set_text($value->[$i]->[0]);
		$_->[1]->set_text($value->[$i]->[1]);
		$_->[2]->set_text($value->[$i]->[2]);
		++$i; 
	}
}

1;
__END__
