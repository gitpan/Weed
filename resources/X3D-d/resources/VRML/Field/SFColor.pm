package VRML::Field::SFColor;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::Field;
use VRML::Field::SFFloat;
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
	my $this   = shift;
	return [@{$this->SUPER::getValue}];
}

sub r { $_[0]->setRed  ($_[1]) if $#_; return $_[0]->getRed   }
sub g { $_[0]->setGreen($_[1]) if $#_; return $_[0]->getGreen }
sub b { $_[0]->setBlue ($_[1]) if $#_; return $_[0]->getBlue  }

#sub setValue {
#	my $this   = shift;
#	unless (${$this} = $this->IS(@_)) {
#		if (@_) {
#			croak "SFColor only ".@_." arguments, must be 0 or 3" if @_ < 3;
#			${$this} = [ "$_[0]"+0, "$_[1]"+0, "$_[2]"+0 ];
#		} else {
#			${$this} = [ 0, 0, 0 ];
#		}
#	}
#	return ${$this};
#}

sub setRed    { return ${$_[0]}->[0] = "$_[1]"+0 || 0 }
sub setGreen  { return ${$_[0]}->[1] = "$_[1]"+0 || 0 }
sub setBlue   { return ${$_[0]}->[2] = "$_[1]"+0 || 0 }

sub getRed    { return ${$_[0]}->[0] }
sub getGreen  { return ${$_[0]}->[1] }
sub getBlue   { return ${$_[0]}->[2] }

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
