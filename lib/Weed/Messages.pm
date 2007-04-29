package Weed::Messages;
use strict;
use warnings;

sub Weed::UnknownObjectId { warn sprintf "Unknown object id '%s'", $_[0] }

1;
__END__

sub Warning { carp Message($string) }

sub Message {
	return carp sprintf "%s\n", ;
}

#my ( $package, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext, $is_require, $hints, $bitmask ) = caller(1);
sub package    { ( caller(2) )[0] }
sub subroutine { ( caller(2) )[3] }
