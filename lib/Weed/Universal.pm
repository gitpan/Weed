package Weed::Universal;
use Weed::Perl;

use Weed::Package "X3DUniversal";

use Weed::Math;

use Weed::Parse::Concept;
use Weed::Generator;

use Weed::RegularExpressions '$_supertype';

use Want ();

use overload
  'bool' => sub { YES },

  '==' => sub { &getId( $_[0] ) == $_[1] },
  '!=' => sub { &getId( $_[0] ) != $_[1] },

  'eq' => sub { "$_[0]" eq $_[1] },
  'ne' => sub { "$_[0]" ne $_[1] },
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
		$typeName->setDescription($description)
		  if $typeName->can('setDescription');

	}

	return;
}

sub new {
	my $type = Weed::Package::name(shift);
	my $this = bless {}, $type;
	Weed::Package::reverse_call( $this, "create", @_ );
	return $this;
}

sub getType { ref $_[0] }

*getId = \&Scalar::Util::refaddr;

sub getHierarchy { grep /$_supertype/, Weed::Package::self_and_superpath( $_[0] ) }

*toString = \&overload::StrVal;

sub DESTROY {    #X3DMessage->Debug(@_);
	Weed::Package::call( $_[0], "dispose" );
	0;
}

1;
__END__
