package Weed::FieldTypes::MFBool;

our $VERSION = '0.01';

use Weed 'MFBool : X3DArrayField { [] }';

sub toString {
	my ($this) = @_;

	my $string = '';

	if (@$this) {
		if ($#$this) {
			$string .= X3DGenerator->open_bracket;
			X3DGenerator->inc;
			$string .= X3DGenerator->tidy_indent ? X3DGenerator->tidy_break : X3DGenerator->tidy_space;
			$string .= X3DGenerator->tidy_indent;
			$string .= join
			  X3DGenerator->tidy_comma .
			  ( X3DGenerator->tidy_indent ? X3DGenerator->tidy_break : X3DGenerator->tidy_space ) .
			  X3DGenerator->tidy_indent,
			  map { $_ ? X3DGenerator->TRUE : X3DGenerator->FALSE } @$this;
			$string .= X3DGenerator->tidy_indent ? X3DGenerator->tidy_break : X3DGenerator->tidy_space;
			X3DGenerator->dec;
			$string .= X3DGenerator->tidy_indent;
			$string .= X3DGenerator->close_bracket;
		}
		else {
			$string .= $this->[0] ? X3DGenerator->TRUE : X3DGenerator->FALSE;
		}
	}
	else {
		$string .= X3DGenerator->open_bracket;
		$string .= X3DGenerator->tidy_space;
		$string .= X3DGenerator->close_bracket;
	}

	return $string;
}
1;
__END__
