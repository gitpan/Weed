package VRML2::Field;
use strict;

BEGIN {
	use Carp;
}

use overload
#	"="    => \&copy,

	"<=>"  => \&ncmp,
	"=="   => \&neq,
	"!="   => \&nne,

	"|"    => \&or,
	"&"    => \&and,

	"neg"  => \&neg,
	"+"    => \&add,
	"-"    => \&sub,
	"*"    => \&mul,
	"/"    => \&div,
	'%'    => \&mod,
	"**"   => \&pow,
	"bool" => \&bool,
	"0+"   => \&numify,

	'""'   => \&toString;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $value = "";
	my $this = \$value;
	bless $this, $class;
	$this->setValue(@_);
	return $this;
}

sub copy {
	my $this = shift;
	my $copy = $this->new($this->getValue);
	return $copy;
}

sub ncmp { ${$_[0]} <=> $_[1] }
sub neq  { $_[1] == ${$_[0]} }
sub nne  { $_[1] != ${$_[0]} }

sub or   { $_[0]->new(${$_[0]} | $_[1]) }
sub and  { $_[0]->new(${$_[0]} & $_[1]) }

sub neg  { $_[0]->new(-(${$_[0]})) }
sub add  { $_[0]->new(${$_[0]} + $_[1]) }
sub sub  { $_[0]->new(${$_[0]} - $_[1]) }
sub mul  { $_[0]->new(${$_[0]} * $_[1]) }
sub div  { $_[0]->new(${$_[0]} / $_[1]) }
sub mod  { $_[0]->new(${$_[0]} % $_[1]) }
sub pow  { $_[0]->new(${$_[0]} ** $_[1]) }

sub numify { ${$_[0]} +0 }
sub bool { ${$_[0]} && 1 }

sub getValue { ${$_[0]} }

sub setValue ($$) {
	my $this = shift;
	${$this} = ref $_[0] ? ${$_[0]} : $_[0];
	return;
}

sub toString {
	my $this = shift;
	return sprintf "%s", ${$this};
}

sub DESTROY {
	my $this  = shift;
 	0;
}

1;
__END__
