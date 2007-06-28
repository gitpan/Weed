package VRML::Field::SFNode;
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

use AutoLoader;
use vars qw($AUTOLOAD);
sub AUTOLOAD {
	my $this = shift;
	my $name = $AUTOLOAD;  $name =~ s/.*:://;

	return ${$this}->getName if $name eq 'name';
	return ${$this}->setField($name, @_) if @_;
	return ${$this}->getField($name);
}

# Each node may assign values to its eventIns and obtain the last output values of its eventOuts
# using the $sfNodeObjectName->eventNameIn($value) or
# $value = $sfNodeObjectName->eventOutName syntax.

sub clone {
	my $this = shift;
	return $this->new(${$this} ? ${$this}->clone : undef);
}

sub getType { ${$_[0]}->getType }
sub getName { ${$_[0]}->getName }

sub ncmp { $_[1] <=> ${$_[0]} }
sub neq  { $_[1] == ${$_[0]} }
sub nne  { $_[1] != ${$_[0]} }

sub toString {
	my $this = shift;
	return sprintf "%s", ${$this} || 'NULL';
}

1;
__END__
