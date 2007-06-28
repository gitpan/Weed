package VRML::Field::SFString;
use strict;
use Carp;
use Unicode::MapUTF8 qw (to_utf8 from_utf8);

use vars qw(@ISA);
use VRML::Field;
@ISA = qw(VRML::Field);

use overload
	"<=>" => \&ncmp,
	"=="  => \&neq,
	"!="  => \&nne,
	'""'  => \&toString;

sub setValue {
	my $this = shift;
	return ${$this} = $this->decode(@_);
}

sub encode {
	my $this = shift;

	my @strings = map {
	    my $toencode = $_;
		$toencode =~ s/\\/\\\\/sg;
		$toencode =~ s/"/\\"/sg;
		to_utf8({ -string => $toencode, -charset => 'ISO-8859-1' });
	} @_ ? @_ : (${$this});

	return $#strings ? @strings : join("", @strings);
}

sub decode {
	my $this = shift;
	my @strings = map {
	    my $todecode = $_;
	    $todecode = from_utf8({ -string => $todecode, -charset => 'ISO-8859-1' });
		$todecode =~ s/\\"/"/sg;
		$todecode =~ s/\\\\/\\/sg;
		$todecode;
	} @_ ? @_ : (${$this});

	return $#strings ? @strings : join("", @strings);
}

sub ncmp { $_[1] cmp ${$_[0]} }
sub neq  { $_[1] eq ${$_[0]} }
sub nne  { $_[1] ne ${$_[0]} }

sub toString {
	my $this = shift;
	return sprintf "%s", $this->encode;
}

1;
__END__
