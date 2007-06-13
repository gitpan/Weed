package Weed::ArrayField;

sub setDescription {
	my ( $this, $description ) = @_;
	printf "%s %s\n", $this, $description;
	#die;
}

use Weed 'X3DArrayField : X3DField { [] }';

1;
__END__
