package Weed::Tie::Value::Rotation;
use Weed;

our $VERSION = '0.009';

use base 'Weed::Tie::Value::Vector';

use Weed::Parse::Double 'double';

sub STORE {
	my ( $this, $index ) = @_;
	my $value = double( \"$_[2]" ) || 0;

	return $this->getValue->setAngle($value) if 3 == $index;
	return $this->getValue->setX($value)     if 0 == $index;
	return $this->getValue->setY($value)     if 1 == $index;
	return $this->getValue->setZ($value)     if 2 == $index;

	return X3DMessage->IndexOutOfRange(2, @_);
}

sub FETCH {
	my ( $this, $index ) = @_;

	return $this->getValue->getAngle if 3 == $index;
	return $this->getValue->getX     if 0 == $index;
	return $this->getValue->getY     if 1 == $index;
	return $this->getValue->getZ     if 2 == $index;

	return X3DMessage->IndexOutOfRange(2, @_);
}

1;
__END__
