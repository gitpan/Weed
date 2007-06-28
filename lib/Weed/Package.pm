package Weed::Package;
use Weed::Perl;
use Carp ();

#Symbol::delete_package wipes out a whole package namespace. Note this routine is not exported by default--you may want to import it explicitly.

use Class::ISA;

our $_space     = qr/\s+/so;
our $_type_name = qr/^([\$\@%&*]?)(.*)/so;

sub import {
	my $to = shift;

	return unless @_;
	#Carp::carp ( "Weed::Package::import" );

	my $alias = shift;

	#	unless ($to) {
	#		Carp::carp  "caller(1)", caller(1);
	#		$to = caller(1);
	#	}

	if ( $to eq __PACKAGE__ ) {    # use package 'newname', @import;
		my $original = caller;
		return Weed::Package::base( $alias, $original, @_ );
	} else {                       # Weed::Package::import
		return Weed::Package::_import( $to, $alias, @_ );
	}
}

sub name { ref( $_[0] ) || $_[0] }

sub exists { UNIVERSAL::can( $_[0], 'can' ) ? YES: NO }

sub superpath          { Class::ISA::super_path( Weed::Package::name(shift) ) }
sub self_and_superpath { Class::ISA::self_and_super_path( Weed::Package::name(shift) ) }

#&\w(\w|::)*>|<\w(\w|::)*(?=\s*[\(\);])

sub supertype {
	my @path = Class::ISA::super_path( Weed::Package::name(shift) );
	return shift @path;
}

sub supertypes {
	my $package = shift;

	if (@_) {
		$package->Weed::Package::base($_) foreach @_;
		return;
	} else {
		return @{ Weed::Package::isa($package) };
	}
}

sub create {
	my $name = shift;
	eval "package $name;\n";
	return Weed::Package::exists($name);
}

sub base {
	#Carp::carp ( "Weed::Package::alias" );
	my $name = Weed::Package::name(shift);
	my $base = shift;

	#unshift @{ Weed::Package::array( $name, "ISA" ) }, $base;
	my $expression = Weed::Package::expression( $name, $base, @_ );
	eval $expression;
	if ($@) {
		#printf "%s\n", $expression;
		Carp::croak $@;
		Carp::croak "Syntax error";
		return;
	}

	return YES;
}

# sub constants {
# 	my $package   = Weed::Package::name(shift);
# 	my %constants = @_;
# 	no strict 'refs';
# 	while ( my ( $name, $value ) = each %constants ) {
# 		my $full_name = "${package}::$name";
# 		*$full_name = sub () { $value };
# 	}
# }

*alias = \&base;

sub isa { Weed::Package::array( shift, 'ISA' ) }

no warnings;
sub say { Perl6::Say::say( Weed::Package::stringify(@_) ) }
use warnings;

sub expression {
	my $alias    = shift;
	my $original = shift;
	#Carp::carp ( "Weed::Package::expression", @_);

	my $expression;

	$expression .= "package $alias;\n";
	$expression .= "use $original;\n" if $original ne 'main' && !Weed::Package::exists($original);
	$expression .= "use base '$original';\n";

	if (@_) {
		$expression .= "use strict;\n";
		$expression .= "use warnings;\n";

		$expression .= Weed::Package::statements( $original, @_ );
	}

	#Carp::carp ( $expression );
	return $expression;
}

sub _import {
	my $alias    = shift;
	my $original = shift;

	my $expression;

	$expression .= "package $alias;\n";

	if (@_) {
		$expression .= "use strict;\n";
		$expression .= "use warnings;\n";

		unless ( Weed::Package::exists($original) ) {
			$expression .= "use $original;\n";
		}

		$expression .= Weed::Package::statements( $original, @_ );
	}

	printf "%s\n", $expression;
	eval $expression;

	if ($@) {
		#printf "%s\n", $expression;
		Carp::croak $@;
		Carp::croak "Syntax error";
		return;
	}

	return YES;
}

sub statements {
	my $original = shift;

	my $expression;

	return '' unless @_;

	foreach (@_) {

		if ( 'ARRAY' eq ref $_ ) {

			$expression .= Weed::Package::statements( $original, @$_ );

		} elsif ( 'HASH' eq ref $_ ) {
			while ( my ( $a, $o ) = each %$_ ) {
				if ( $a =~ m.$_type_name.gc && $1 ) {
					my $t = $1;
					$a = $2;
					if ( $o =~ m.$_type_name.gc ) {
						$t = $1 if $1;
						$expression .= get_rename_string( $a, $t, $original, $2 );
					} else {
						Carp::croak "Syntax error";
					}
				} else {
					$expression .= get_rename_string( $a, '&', $original, $o );
				}
			}
		} else {
			foreach ( split /$_space/, $_ ) {
				if ( m.$_type_name.gc && $1 ) {
					$expression .= get_rename_string( $2, $1, $original, $2 );
				} else {
					$expression .= get_rename_string( $_, '&', $original, $_ );
				}
			}
		}
	}

	return $expression;
}

sub get_rename_string {
	my ( $name, $type, $package, $original ) = @_;

	#Carp::carp  sprintf "\t*%s = \\%s;\n", ( $alias, $original ) if $original =~ /::/so;

	return sprintf "\t*%s = \\%s;\n", ( $name, $original ) if $original =~ /::/so;

	return sprintf "\t*%s = \\%s%s::%s;\n", ( $name, $type, $package, $original );
}

##

no strict 'refs';
no warnings;

sub scalar {
	my ( $this, $name ) = @_;
	my $property = sprintf '%s::%s', $this->Weed::Package::name, $name;
	return \$$property;
}

use warnings;

sub array {
	my ( $this, $name ) = @_;
	my $property = sprintf '%s::%s', $this->Weed::Package::name, $name;
	return \@$property;
}

sub hash {
	my ( $this, $name ) = @_;
	my $property = sprintf '%s::%s', $this->Weed::Package::name, $name;
	return \%$property;
}

sub can {
	my ( $this, $name ) = @_;
	my $property = sprintf "%s::%s::can::%s", __PACKAGE__, $this->Weed::Package::name, $name;

	unless ( defined $$property ) {
		$$property = [];
		push @$$property, map { \&{"${_}::${name}"} }
		  grep { exists &{"${_}::${name}"} } Weed::Package::self_and_superpath($this);
	}

	return @$$property;
}

use strict 'refs';

sub call {
	my ( $this, $name ) = ( shift, shift );
	return map { &$_( $this, @_ ) } Weed::Package::can( $this, $name );
}

sub reverse_call {
	my ( $this, $name ) = ( shift, shift );
	return map { &$_( $this, @_ ) } reverse Weed::Package::can( $this, $name );
}

sub sub { ( caller( ( $_[1] || 0 ) + 1 ) )[3] }

sub stringify {
	my $package = shift;
	my $level   = shift || 1;
	my $string  = '';

	$string .= $package->Weed::Package::name;

	my $hierarchy = $package->Weed::Package::isa;

	$string .= ' ';
	$string .= '[';

	if (@$hierarchy) {
		$string .= ' ';

		if ($#$hierarchy) {
			$string .= "\n";
			$string .= '  ' x $level;
		}

		$string .= join "\n" . ( '  ' x $level ), map {
			$_->Weed::Package::stringify( $level + 1 );
		} @$hierarchy;

		if ($#$hierarchy) {
			$string .= "\n";
			$string .= '  ' x ( $level - 1 );
		} else {
			$string .= ' ';
		}
	}

	$string .= ']';

	return $string;
}

=head1 NAME

package - makes an alias of the current package

=head1 REQUIRES

L<Class::ISA>, L<Carp>

=head1 SYNOPSIS

	package Original;
	use package "YourNameForOriginal";
	
	sub sub_from_original { 123 }
	
	YourNameForOriginal->Weed::Package::import("Weed::Package::XYZ", 'sub_from_XYZ');
	
	my $value = YourNameForOriginal->sub_from_original;
	my $ref   = \&YourNameForOriginal::sub_from_XYZ;

and

	package main;
	
	AA->Weed::Package::base('Original');
	BB->Weed::Package::base('Original');
	
	CC->Weed::Package::supertypes(qw'BB AA');
	
	my $value = AA->sub_from_original;

=head1 METHODS

=head2 use

	use package $name, @import;

makes an alias of the current package with the name $name and imports the symbols in @import.

=head2 name($object)

Weed::Package::name returns the package name of $object or $object;

	sub new {
		bless {}, Weed::Package::name(shift);
	}

=head2 exists($name)

Weed::Package::exists checks if package $name is loaded or an alias exists 

	return $name->new(123) if Weed::Package::exists($name);

=head2 base($package, $base, @import)

Weed::Package::base sets the base $base for package $package
and imports the symbols in import in the namespace of package
if package not exists then a namespace $package is created

	Weed::Package::base($package, $base);
	
	Weed::Package::base($package, $base, '$var');
	
	Weed::Package::base($package, $base, [{'@as' => '@it', '@like' => '@it'}, qw'sub function'], 'routine', ['ggg'];

=head2 import($to, $from, @import)

imports the symbols in @import from $from to $to

	Foo->Weed::Package::import('from', {'foo' => 'new'} );

=head2 superpath($package|$object)

superpath returns an ordered list of package names.

	 @path = Weed::Package::superpath($package);
	 @path = Weed::Package::superpath($object);

=head2 supertypes($package|$object)

returns the supertypes of $package or $object if the package is created with 'package'

	say join ' ', CC->Weed::Package::supertypes;

=head2 supertypes($package|$object, @supertypes)

creates a new namespace $name and sets the supertypes

	 CC->Weed::Package::supertypes('BB', 'AA');

=head1 AUTHOR

Holger Seelig  holger.seelig@yahoo.de

=head1 COPYRIGHT

This is free software; you can redistribute it and/or modify it
under the same terms as L<Perl|perl> itself.

=cut

1;
__END__
