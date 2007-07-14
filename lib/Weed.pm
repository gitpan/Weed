package Weed;
use Weed::Perl;

#use 5.008008;

our $VERSION = '0.0082';

use warnings::register;

sub import {
	shift;
	strict::import;
	warnings::import;
	#warnings::unimport('redefine');
	Weed::Perl->export_to_level(1);
	Weed::Package::createType( scalar caller, 'X3DUniversal', @_ );
}

use Weed::Environment;

1;
__END__

=head1 NAME

Weed - Don't use it. It's in development. For test purposes only!

=head1 CAVEATS

Don't use it. It's in development. For test purposes only!

=head1 SYNOPSIS

	use Weed;

=head1 DESCRIPTION

Importing Weed overloads CORE::time with Time::Hires::time. All possible restrictions and
all possible warnings are enabled.

=head1 EXPORTS

=head2 NO

Is not YES.

=head2 YES

Is not NO.

=head1 ENVIRONMENT

Type list ...

=head1 TYPE CREATION

=head2 SYNOPSIS

	package BasePackage;
	
	use Weed 'Scalar ()';
	use Weed 'Array []';
	use Weed 'Hash {}';
	
	use Weed 'Type : Supertype {}';
	use Weed 'Type : Supertype Supertypes {}';

Creates a new type in each case and binds this to the base package.

	sub new { shift->NEW }
	
	my $object = new Type;

=head2 INTERFACE

=head3 SET_DESCRIPTION(type, description)

Is called one time on import.

=head2 UNIVERSAL OBJECT

If you havn't specified any supertype then the following functions are available.

=head2 OVERLOADS

	bool => Returns YES.
	int  => Same as getId.
	<=>  => Compares two object ids.
	cmp  => Compares two objects stringwise.
	""   => Same as toString.

=head2 METHODS

=head3 NEW

Returns a new instance. A new type should specify its own 'new' method.

=head3 getType

Returns the type of the object as string.

=head3 getId

Returns the id of the object as integer.

=head3 getHierarchy

Returns an array reference.

=head3 toString

Same as overload::StrVal. A new type should specify its own 'toString' method.

=cut

PROBS

BaseNode createFields; have to do a ref() to the tied fields
