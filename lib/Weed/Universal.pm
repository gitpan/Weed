package Weed::Universal;
use Weed::Perl;

our $VERSION = '0.0078';

use Carp ();
use Want ();
use Hash::NoRef;

#use Weed::Math;
use Weed::RegularExpressions '$_supertype';
use Weed::Package;

use overload
  'bool' => sub { YES },

  'int' => sub { &getId( $_[0] ) },

  '<=>' => sub { $_[2] ? int( $_[1] ) <=> int( $_[0] ) : int( $_[0] ) <=> int( $_[1] ) },    #???

  'cmp' => sub { $_[2] ? $_[1] cmp "$_[0]" : "$_[0]" cmp $_[1] },

  '""' => 'toString',
  ;

sub import {
	shift;
	return unless @_;
	X3DPackage::createType( scalar caller, 'X3DUniversal', @_ );
}

BEGIN {
	X3DPackage::createType( __PACKAGE__, 'X3DUniversal', 'X3DUniversal { }', 'getReferenceCount' );
}

sub NEW {
	my $packageName = shift->X3DPackage::getName;
	X3DPackage::Scalar( $packageName, "Description" )->{new}->($packageName);
}

#*new = \&NEW;

sub getType { ref $_[0] }

*getId = \&Scalar::Util::refaddr;

*getReferenceCount = \&Hash::NoRef::SvREFCNT;

sub getHierarchy { grep /$_supertype/, X3DPackage::getSelfAndSuperpath( $_[0] ) }

*toString = \&overload::StrVal;

sub DESTROY () { 0 }

1;
__END__
