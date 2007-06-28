package Weed::FieldTypes::MFString;

use Weed 'MFString : X3DArrayField { [] }';

sub toString {
	my $this = shift;

	my $string = '';

	my $value = $this->getValue;
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
