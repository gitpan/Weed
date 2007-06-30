package Weed::ArrayField;
use Weed::Perl;

use Weed 'X3DArrayField : X3DField { [] }';

use overload
  'bool' => sub { @{ $_[0]->getValue } ? YES: NO },

  'int' => sub { $_[0]->length },
  '0+'  => sub { $_[0]->length },

  '!' => sub { !$_[0]->length },

  '<=>' => sub { $_[2] ? $_[1]->getValue <=> $_[0]->getValue : $_[0]->getValue <=> $_[1]->getValue },
  'cmp' => sub { $_[2] ? $_[1]->getValue cmp $_[0]->getValue : $_[0]->getValue cmp $_[1]->getValue },

  '@{}' => sub { $_[0]->getValue },
  ;

sub length { scalar @{ $_[0]->{value} } }

sub setValue {
	my ( $this, @value ) = @_;

	if ( 1 == @value && ref $value[0] eq 'Weed::Values::Array' ) {
		$this->{value} = $value[0];
	}
	else {
		$this->{value} = new Weed::Values::Array( @value ? [@value] : [] );
	}
}

sub toString {
	my $this = shift;

	my $string = '';

	my $value = $this->getValue;
	if (@$value) {
		if ($#$value) {
			$string .= X3DGenerator->open_bracket;
			$string .= X3DGenerator->tidy_space;
			$string .= join X3DGenerator->comma . X3DGenerator->tidy_space, @$value;
			$string .= X3DGenerator->tidy_space;
			$string .= X3DGenerator->close_bracket;
		}
		else {
			$string .= $value->[0];
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
