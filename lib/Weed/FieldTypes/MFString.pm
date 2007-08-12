package Weed::FieldTypes::MFString;

our $VERSION = '0.01';

use Weed 'MFString : X3DArrayField { [] }';

sub sort { $_[0]->new( [ sort { $a cmp $b } @{ $_[0] } ] ) }

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
			  map { sprintf X3DGenerator->STRING, $_ } @$this;
			$string .= X3DGenerator->tidy_indent ? X3DGenerator->tidy_break : X3DGenerator->tidy_space;
			X3DGenerator->dec;
			$string .= X3DGenerator->tidy_indent;
			$string .= X3DGenerator->close_bracket;
		}
		else {
			$string .= sprintf X3DGenerator->STRING, $this->[0];
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
