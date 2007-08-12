package Weed::Namespace;
use Weed::Perl;

our $VERSION = '0.002';

sub import { X3DPackage->setNamespace($_[1]) }

sub unimport { X3DPackage->setNamespace('') }

1;
__END__
