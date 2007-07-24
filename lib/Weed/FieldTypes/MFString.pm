package Weed::FieldTypes::MFString;

our $VERSION = '0.009';

use Weed 'MFString : X3DArrayField { [] }';

sub sort { $_[0]->new( [ sort { $a cmp $b } @{ $_[0] } ] ) }

sub toString {
	my $this = shift;
	my $value = $this->getValue;

	my $string = '';

	if (@$value) {
		if ($#$value) {
			$string .= X3DGenerator->open_bracket;
			$string .= X3DGenerator->tidy_space;
			$string .= join X3DGenerator->comma . X3DGenerator->tidy_space,
				map { sprintf X3DGenerator->STRING, $_ } @$value;
			$string .= X3DGenerator->tidy_space;
			$string .= X3DGenerator->close_bracket;
		}
		else {
			$string .= sprintf X3DGenerator->STRING, $value->[0];
		}
	} else {
		$string .= X3DGenerator->open_bracket;
		$string .= X3DGenerator->tidy_space;
		$string .= X3DGenerator->close_bracket;
	}

	return $string;
}

1;
__END__
