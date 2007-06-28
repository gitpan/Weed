package VRML::Field::SFRotation;
use strict;
use Carp;

use Exporter;
use vars qw(@ISA @EXPORT);
use VRML::Field;
@ISA = qw(Exporter VRML::Field);
@EXPORT = qw(degrees);

use overload
	"<=>" => \&ncmp,
	"==" => \&neq,
	"!=" => \&nne,
	'""' => \&toString;

use Array;

sub setValue {
	my $this = shift;
	return $this->SUPER::setValue(@_ ? @_ : [ 0, 0, 1, 0 ]);
}

sub getValue {
	my $this = shift;
	return [@{$this->SUPER::getValue}];
}

sub x { return ${$_[0]}->[0] }
sub y { return ${$_[0]}->[1] }
sub z { return ${$_[0]}->[2] }
sub angle { return ${$_[0]}->[3] }

sub ncmp {
	return $_[1] <=> $_[0]->length unless ref $_[1];
	return $_[1] <=> $_[0]->length unless ref $_[1] eq ref $_[0];
	return array_ncmp(${$_[0]}, ${$_[1]});
}

sub neq  { !($_[0] <=> $_[1]) }
sub nne  { $_[1] <=> $_[0] }

sub toString {
	my $this = shift;
	return sprintf "%s %s %s %s", @{ ${$this} };
}

sub angle_degrees {
	my $this = shift;
	return $this->angle * 57.29578;
}

1;
__END__
