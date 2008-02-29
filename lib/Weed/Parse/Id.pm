package Weed::Parse::Id;
use Weed::Perl;

our $VERSION = '0.01';

use Weed::RegularExpressions qw.$_Id $_RestrictedId.;

use Exporter 'import';

our @EXPORT_OK = qw.Ids Id RestrictedIds RestrictedId.;

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
	my ($string) = @_;
	return $1 if $$string =~ m.$_Id.gc;
	return;
}

sub RestrictedIds {
	my ($string) = @_;
	my $Id       = &RestrictedId($string);
	my $Ids      = [];
	while ( defined $Id ) {
		push @$Ids, $Id;
		$Id = &RestrictedId($string);
	}
	return $Ids;
}

sub RestrictedId {
	my ($string) = @_;
	return $1 if $$string =~ m.$_RestrictedId.gc;
	return;
}

1;
__END__
