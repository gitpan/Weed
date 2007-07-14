package Weed::Tie::Value::Rotation;
use Weed;

our $VERSION = '0.008';

use base 'Weed::Tie::Value::Vector';

use Weed::Parse::Double 'double';

sub STORE {
	my ( $this, $index ) = @_;
	my $value = double( \"$_[2]" ) || 0;

	return $this->{value}->setAngle($value) if 3 == $index;
	return $this->{value}->setX($value)     if 0 == $index;
	return $this->{value}->setY($value)     if 1 == $index;
	return $this->{value}->setZ($value)     if 2 == $index;

	return X3DMessage->IndexOutOfRange(2, @_);
}

sub FETCH {
	my ( $this, $index ) = @_;

	return $this->{value}->getAngle if 3 == $index;
	return $this->{value}->getX     if 0 == $index;
	return $this->{value}->getY     if 1 == $index;
	return $this->{value}->getZ     if 2 == $index;

	return X3DMessage->IndexOutOfRange(2, @_);
}

1;
__END__
