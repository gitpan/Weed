package Weed::Universal;
use Weed::Perl;

our $VERSION = '0.009';

use Carp ();
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
	X3DPackage::createType( __PACKAGE__, 'X3DUniversal', 'X3DUniversal { }', 'getId getReferenceCount' );
}

sub _new {
	my $packageName = shift->X3DPackage::getName;
	$packageName->X3DPackage::Scalar("Description")->{new}->( $packageName, @_ );
}

sub getType { ref $_[0] }

sub getId { Scalar::Util::refaddr $_[0] }

*getReferenceCount = \&Hash::NoRef::SvREFCNT;

sub getHierarchy { grep /$_supertype/, X3DPackage::getSelfAndSuperpath( $_[0] ) }

*toString = \&overload::StrVal;

1;
__END__
