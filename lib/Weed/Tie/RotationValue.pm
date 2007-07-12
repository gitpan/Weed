package Weed::Tie::RotationValue;
use Weed;

our $VERSION = '0.0079';

use base 'Weed::Tie::VectorValue';

use Weed::Parse::Double 'double';

sub STORE {
	my ( $this, $index ) = @_;
	my $value = double( \"$_[2]" ) || 0;

	return $this->{array}->setAngle($value) if 3 == $index;
	return $this->{array}->setX($value)     if 0 == $index;
	return $this->{array}->setY($value)     if 1 == $index;
	return $this->{array}->setZ($value)     if 2 == $index;

	return X3DMessage->IndexOutOfRange(2, @_);
}

sub FETCH {
	my ( $this, $index ) = @_;

	return $this->{array}->getAngle if 3 == $index;
	return $this->{array}->getX     if 0 == $index;
	return $this->{array}->getY     if 1 == $index;
	return $this->{array}->getZ     if 2 == $index;

	return X3DMessage->IndexOutOfRange(2, @_);
}

1;
__END__
