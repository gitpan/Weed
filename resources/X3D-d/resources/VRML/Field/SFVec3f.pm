package VRML::Field::SFVec3f;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::Field;
@ISA = qw(VRML::Field);

use overload
	"<=>" => \&ncmp,
	"==" => \&neq,
	"!=" => \&nne,
	'""' => \&toString;

use Array;

sub setValue {
	my $this = shift;
	return $this->SUPER::setValue(@_ ? @_ : [ 0, 0, 0 ]);
}

sub getValue {
	my $this = shift;
	return [@{$this->SUPER::getValue}];
}

sub getX  { return ${$_[0]}->[0] +0 }
sub getY  { return ${$_[0]}->[1] +0 }
sub getZ  { return ${$_[0]}->[2] +0 }

sub x { 
	my $this = shift;
	${$this}->[0] = shift if @_;
	return ${$this}->[0];
}
sub y { 
	my $this = shift;
	${$this}->[1] = shift if @_;
	return ${$this}->[1];
}
sub z { 
	my $this = shift;
	${$this}->[2] = shift if @_;
	return ${$this}->[2];
}

sub length {
	my $this = shift;
	return (
		${$this}->[0] ** 2 +
		${$this}->[1] ** 2 +
		${$this}->[2] ** 2) ** 0.5;
}

sub ncmp {
	return $_[1] <=> $_[0]->length unless ref $_[1];
	return $_[1] <=> $_[0]->length unless ref $_[1] eq ref $_[0];
	return array_ncmp(${$_[0]}, ${$_[1]});
}

sub neq  { !($_[0] <=> $_[1]) }
sub nne  { $_[1] <=> $_[0] }

sub toString {
	my $this = shift;
	return sprintf "%s %s %s", @{ ${$this} };
}

1;
__END__
