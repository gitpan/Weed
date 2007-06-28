package X3DField;
use strict;
use warnings;


sub new {
	my $self  = shift;
	my $class = ref($self) || $self;

	my $value = '';
	my $this  = bless \$value, $class;

	$this->setValue(@_);
	return $this;
}

sub copy {
}

sub getValue { ${$_[0]} }

sub setValue {
	my $this = shift;
	$$this = ref $_[0] ? ${$_[0]} : $_[0] if @_;
	return;
}

sub toString {
	my $this = shift;
	return sprintf "%s", $$this;
}

sub DESTROY {
	my $this = shift;
 	0;
}



1;
__END__
