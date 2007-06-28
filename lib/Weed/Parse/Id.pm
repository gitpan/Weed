package Weed::Parse::Id;
use Weed::Perl;

use Weed::RegularExpressions;

use base 'Exporter';

our @EXPORT = qw(
  Ids
  Id
);

sub Ids {
	my ($string) = @_;
	my $Id       = &Id($string);
	my $Ids      = [];
	while ( defined $Id ) {
		push @$Ids, $Id;
		$Id = &Id($string);
	}
	return $Ids;
}

sub Id {
	my $string = shift;
	return $1 if $$string =~ m.$_Id.gc;
	return;
}

1;
__END__
