package Weed::ArrayField;

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
	my $this = shift;

	if ( 0 == @_ ) {
		$this->{value}->clear;
	}
	elsif ( 1 == @_ ) {
		if ( ref( $_[0] ) eq 'ARRAY' ) {
			$this->{value}->setValue( @{ $_[0] } );
		}
		elsif ( ref( $_[0] ) eq ref $this ) {
			$this->{value} = $_[0]->getValue->copy;
		}
		elsif ( ref( $_[0] ) eq ref $this->{value} ) {
			$this->{value} = $_[0]->copy;
		}
		else {
			$this->{value}->setValue(@_);
		}
	}
	else {
		$this->{value}->setValue(@_);
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
