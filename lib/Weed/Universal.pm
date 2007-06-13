package Weed::Universal;
use Weed::Perl;

use Weed::Package "X3DUniversal", "time";
use Weed::Object;

use Weed::Math;
use Weed::Constants;

use Weed::Parse::Concept;
use Weed::Generator;

use Weed::RegularExpressions '$_X3D';

use overload
  '=='   => sub { $_[1] == &getId( $_[0] ) },
  '!='   => sub { $_[1] != &getId( $_[0] ) },
  'eq'   => sub { $_[1] eq "$_[0]" },
  'ne'   => sub { $_[1] ne "$_[0]" },
  'bool' => sub { YES },
  'int'  => sub { &getId( $_[0] ) },
  '0+'   => sub { &getId( $_[0] ) },
  '""'   => sub { $_[0]->toString },
  ;

sub import {
	shift;
	return unless @_;
	Weed::Universal::createType( scalar caller, 'X3DUniversal', @_ );
}

sub new {
	my $type = Weed::Package::name(shift);
	my $this = bless {}, $type;
	Weed::Package::reverse_call( $this, "create", @_ );
	return $this;
}

*getId = \&Weed::Object::id;

*getType = \&Weed::Object::type;

*toString = \&Weed::Object::stringify;

sub createType {
	my ( $package, $base, $declaration, @imports ) = @_;

	#printf "X3DUniversal createType %s %s\n", $package, $base;

	my $description = parse::concept($declaration);
	if ( ref $description ) {

		my $typeName = $description->{name};

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

sub getHierarchy { grep /$_X3D/, Weed::Package::self_and_superpath( $_[0] ) }

sub DESTROY {
	Weed::Package::call( $_[0], "dispose" );
	0;
}

1;
__END__
