package Weed::Parse::Comment;
use Weed::Perl;

our $VERSION = '0.002';

use Weed::RegularExpressions qw.$_comment.;

use Exporter 'import';

our @EXPORT_OK = qw.comment.;

sub comment {
	return $1 if ${ $_[0] } =~ m.$_comment.gc;
	return;
}

1;
__END__
