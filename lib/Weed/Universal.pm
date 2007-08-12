package Weed::Universal;
use Weed::Perl;

our $VERSION = '0.014';

use Carp ();
use Hash::NoRef;

#use Weed::Math;
use Weed::Package;

use overload
  'bool' => sub { YES },

  '0+'  => 'getId',
  'int' => 'getId',

  '<=>' => sub { $_[2] ? int( $_[1] ) <=> int( $_[0] ) : int( $_[0] ) <=> int( $_[1] ) },    #???

  'cmp' => sub { $_[2] ? $_[1] cmp "$_[0]" : "$_[0]" cmp $_[1] },

  '""' => 'toString',
  ;

#sub import {
#	my $namespace = shift;
#	return unless @_;
#	X3DPackage::createType( $namespace, scalar caller, 'X3DUniversal', @_ );
#}

BEGIN {
	X3DPackage::createType( __PACKAGE__, 'X3DUniversal', 'X3DUniversal { }', 'getId getReferenceCount' );
}

sub new {
	my $packageName = shift->X3DPackage::getName;
	$packageName->X3DPackage::Scalar("Description")->{new}->( $packageName, @_ );
}

sub getId { Scalar::Util::refaddr( $_[0] ) }

sub getType { $_[0]->X3DPackage::Scalar("Description")->{typeName} }

sub getHierarchy { my $i = 0; X3DArray->new( [ grep { X3DMath::even( $i++ ) } @{ X3DPackage::getPath( $_[0] ) } ] ) }

*getReferenceCount = \&Hash::NoRef::SvREFCNT;

*toString = \&overload::StrVal;

1;
__END__
