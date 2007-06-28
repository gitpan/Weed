package VRML2::Editor::TreeItem::Field::MFNode;
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
		my $item = new VRML2::Editor::TreeItem::Field::SFNode($parent, $_);
		$item->show;
	}
	
	bless $this, $class;
	return $this;
}

1;
__END__
