package X3DObject;
use strict;
use warnings;
use rlib "./";

use Attribute::Overload;
use Scalar::Util;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;

	my $this = bless {}, $class;
	$this->CREATE (@_);

	return $this;
}

sub CREATE {}

sub copy {
	my $this = shift;
	return;
}

sub clone {
	my $this = shift;
	return;
}

sub getId {
	my $this = shift;
	return Scalar::Util::refaddr($this);
}

sub getType {
	my $this = shift;
	return ref $this;
}

sub getReferenceCount {
	my $this = shift;
	return;
}

sub stringify : Overload("") {
	my $this = shift;
	return $this->STRINGIFY;
}

sub STRINGIFY {
	my $this = shift;
	return sprintf "%s", $this->getType;
}

sub dispose {
	my $this = shift;
	return;
}

sub DESTROY {
	my $this = shift;
	$this->dispose;
 	0;
}

1;
__END__
