package VRML::Field;
use strict;
use Carp;

use overload
	"<=>"  => \&ncmp,
	"=="   => \&neq,
	"!="   => \&nne,
	"cmp"  => \&cmp,
	"eq"   => \&eq,
	"ne"   => \&ne,
	"neg"  => \&neg,
	"abs"  => \&abs,
	"+"    => \&add,
	"-"    => \&sub,
	"*"    => \&mul,
	"/"    => \&div,
	'%'    => \&mod,
	"**"   => \&pow,
	"bool" => \&bool,
	"0+"   => \&numify,
	"cos"  => \&cos,
	"exp"  => \&exp,
	"log"  => \&log,
	"sin"  => \&sin,
	"sqrt" => \&sqrt,
	'""'   => \&toString;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $value;
	my $this = \$value;
	bless $this, $class;
	$this->setValue(@_);
	return $this;
}

sub ncmp { $_[1] <=> ${$_[0]} }
sub neq  { $_[1] == ${$_[0]} }
sub nne  { $_[1] != ${$_[0]} }
sub cmp  { $_[1] cmp ${$_[0]} }
sub eq   { $_[1] eq ${$_[0]} }
sub ne   { $_[1] ne ${$_[0]} }

sub neg  { $_[0]->new(-(${$_[0]})) }
sub abs  { $_[0]->new(CORE::abs ${$_[0]}) }
sub add  { $_[0]->new(${$_[0]} + $_[1]) }
sub sub  { $_[0]->new(${$_[0]} - $_[1]) }
sub mul  { $_[0]->new(${$_[0]} * $_[1]) }
sub div  { $_[0]->new(${$_[0]} / $_[1]) }
sub mod  { $_[0]->new(${$_[0]} % $_[1]) }
sub pow  { $_[0]->new(${$_[0]} ** $_[1]) }

sub numify { ${$_[0]} +0 }
sub bool { ${$_[0]} && 1 }

sub acos  { $_[0]->new() }
sub asin  { $_[0]->new() }
sub atan  { $_[0]->new() }
sub ceil  { $_[0]->new(int ${$_[0]} + 1) }
sub cos   { $_[0]->new(CORE::cos ${$_[0]}) }
sub exp   { $_[0]->new(CORE::exp ${$_[0]}) }
sub floor { $_[0]->new(int ${$_[0]}) }
sub log   { $_[0]->new(CORE::log ${$_[0]}) }
sub max   { $_[0]->new() }
sub min   { $_[0]->new() }
sub round { $_[0]->new( sprintf "%.".($_[1] || 0)."f", $_[0] ) }
sub sin   { $_[0]->new(CORE::sin ${$_[0]}) }
sub sqrt  { $_[0]->new(CORE::sqrt ${$_[0]}) }
sub tan   { $_[0]->new() }

sub getValue { ${$_[0]} }

sub setValue {
	my $this = shift;
	${$this} = @_ ? ($#_ ? [@_] : $_[0]) : "";
	return ${$this};
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
