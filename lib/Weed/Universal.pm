package Weed::Universal;
use Weed::Perl;

use Carp ();
use Want ();

use Weed::Package;
use Weed::Math;
use Weed::Parse::Concept;
use Weed::RegularExpressions '$_supertype';

use overload
  'bool' => sub { YES },

  '<=>' => sub { $_[2] ? &getId( $_[1] ) <=> &getId( $_[0] ) : &getId( $_[0] ) <=> &getId( $_[1] ) },
  'cmp' => sub { $_[2] ? $_[1] cmp "$_[0]" : "$_[0]" cmp $_[1] },

  '""' => 'toString',
  ;

sub import {
	shift;
	return unless @_;
	Weed::Universal::createType( scalar caller, 'X3DUniversal', @_ );
}

sub createType {
	my ( $package, $base, $declaration, @imports ) = @_;

	#printf "X3DUniversal createType %s %s\n", $package, $base;

	my $description = Weed::Parse::Concept::parse($declaration);
	if ( ref $description ) {

		my $typeName = $description->{typeName};

		Weed::Package::base( $typeName, $package, @imports );
		Weed::Package::supertypes( $typeName,
			@{ $description->{supertypes} } ?
			  @{ $description->{supertypes} } :
			  $base
		);

		#printf "X3DUniversal createType %s : %s %s\n", $typeName, $package, $base;
		${ Weed::Package::scalar( $typeName, "Description" ) } = $description;

		$typeName->setDescription($description)
		  if $typeName->can('setDescription');

	} else {
		Carp::croak "Error Parse::Concept: '$declaration'\n", $@ if $@;
	}

	return;
}

BEGIN {
	Weed::Universal::createType( __PACKAGE__, 'X3DUniversal', 'X3DUniversal { }' );
}

sub NEW {
	my $packageName = shift->Weed::Package::name;
	bless &{ ${ Weed::Package::scalar( $packageName, "Description" ) }->{value} }, $packageName;
}

sub new { shift->NEW }

sub getType { ref $_[0] }

*getId = \&Scalar::Util::refaddr;

sub getHierarchy { grep /$_supertype/, Weed::Package::self_and_superpath( $_[0] ) }

*toString = \&overload::StrVal;

sub DESTROY { 0 }

1;
__END__
