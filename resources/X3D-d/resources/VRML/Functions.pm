package VRML::Functions;
require 5.005;
use strict;
use Carp;

BEGIN {
	use Exporter;
	use vars qw(@ISA @EXPORT);
	@ISA = qw(Exporter);
	@EXPORT = qw(parseInt parseFloat);
}

use VRML::Parse::Symbols qw($hex);

sub parseInt {
	my $int = shift;
	my $radix  = shift || 10;
	return $int =~ /^$hex/ ? hex($int) : int($int);
}

sub parseFloat {
	return shift;
}

1;
__END__
