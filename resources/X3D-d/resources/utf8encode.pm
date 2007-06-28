package utf8encode;
use strict;

BEGIN {
	use Exporter;
	use vars qw(@ISA @EXPORT);
	@ISA = qw(Exporter);
	@EXPORT = qw(utf8encode);
}

sub utf8encode {
	my @strings = map {
	    s/([\x80-\xff])/
			ord($1) < 0xc0
			? "\xc2$1"
			: "\xc3".chr(ord($1) & 0xbf)
		/sge;
	    $_;
	} @_;
	return wantarray ? @strings : "@strings";
}

1;
__END__
