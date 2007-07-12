package Weed::Package;
use Weed::Perl;

our $VERSION = '0.0078';

#use Package::Generator;
#Symbol::delete_package wipes out a whole package namespace. Note this routine is not exported by default--you may want to import it explicitly.

use Package::Alias X3DPackage => __PACKAGE__;

use Carp ();
use Class::ISA;

use Weed::Parse::Concept;

our $_space     = qr/\s+/so;
our $_type_name = qr/^([\$\@%&*]?)(.*)/so;

sub import {
	my $to = shift;

	return unless @_;
	#Carp::carp ( "X3DPackage::import" );

	my $alias = shift;

	#	unless ($to) {
	#		Carp::carp  "caller(1)", caller(1);
	#		$to = caller(1);
	#	}

	if ( $to eq __PACKAGE__ ) {    # use package 'newname', @import;
		my $original = caller;
		return X3DPackage::base( $alias, $original, @_ );
	}
	else {                         # X3DPackage::import
		return X3DPackage::_import( $to, $alias, @_ );
	}
}

sub exists { UNIVERSAL::can( $_[0], 'can' ) ? YES: NO }

sub createType {
	my ( $package, $base, $declaration, @imports ) = @_;

	#printf "X3DUniversal createType %s %s\n", $package, $base;

	my $description = Weed::Parse::Concept::parse($declaration);
	if ( ref $description ) {

		my $typeName = $description->{typeName};

		X3DPackage::setBase( $typeName, $package, @imports );
		X3DPackage::setSupertypes( $typeName,
			@{ $description->{supertypes} } ?
			  @{ $description->{supertypes} } :
			  $base
		);
		X3DPackage::setBase( $typeName, $description->{base} );

		#printf "X3DUniversal createType %s : %s %s\n", $typeName, $package, $base;
		X3DPackage::Scalar( $typeName, "Description" ) = $description;

		$typeName->setDescription($description)
		  if $typeName->can('setDescription');

	} else {
		Carp::croak "Error Parse::Concept: '$declaration'\n", $@ if $@;
	}

	return;
}

sub getName { ref( $_[0] ) || $_[0] }

sub getSuperpath          { Class::ISA::super_path( X3DPackage::getName(shift) ) }
sub getSelfAndSuperpath { Class::ISA::self_and_super_path( X3DPackage::getName(shift) ) }

#&\w(\w|::)*>|<\w(\w|::)*(?=\s*[\(\);])

sub getSupertype {
	my @path = Class::ISA::super_path( X3DPackage::getName(shift) );
	return shift @path;
}

sub getSupertypes { X3DPackage::Array( shift, 'ISA' ) }

sub setSupertypes {
	my $package = shift;
	$package->X3DPackage::setBase($_) foreach @_;
	return;
}

#sub create {
#	my $name = shift;
#	eval "package $name;\n";
#	return X3DPackage::exists($name);
#}

sub setBase {
	#Carp::carp ( "X3DPackage::alias" );
	my $name = X3DPackage::getName(shift);
	my $base = shift;

	return if !$base || $name eq $base;

	#unshift @{ X3DPackage::array( $name, "ISA" ) }, $base;
	my $expression = X3DPackage::expression( $name, $base, @_ );
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
# 	my $package   = X3DPackage::getName(shift);
# 	my %constants = @_;
# 	no strict 'refs';
# 	while ( my ( $name, $value ) = each %constants ) {
# 		my $full_name = "${package}::$name";
# 		*$full_name = sub () { $value };
# 	}
# }

#*alias = \&base;

sub expression {
	my $alias    = shift;
	my $original = shift;
	#Carp::carp ( "X3DPackage::expression", @_);

	my $expression;

	$expression .= "package $alias;\n";
	$expression .= "use $original;\n" if $original ne 'main' && !X3DPackage::exists($original);
	$expression .= "use base '$original';\n";

	if (@_) {
		$expression .= "use strict;\n";
		$expression .= "use warnings;\n";

		$expression .= X3DPackage::statements( $original, @_ );
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

		unless ( X3DPackage::exists($original) ) {
			$expression .= "use $original;\n";
		}

		$expression .= X3DPackage::statements( $original, @_ );
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

			$expression .= X3DPackage::statements( $original, @$_ );

		}
		elsif ( 'HASH' eq ref $_ ) {
			while ( my ( $a, $o ) = each %$_ ) {
				if ( $a =~ m.$_type_name.gc && $1 ) {
					my $t = $1;
					$a = $2;
					if ( $o =~ m.$_type_name.gc ) {
						$t = $1 if $1;
						$expression .= get_rename_string( $a, $t, $original, $2 );
					}
					else {
						Carp::croak "Syntax error";
					}
				}
				else {
					$expression .= get_rename_string( $a, '&', $original, $o );
				}
			}
		}
		else {
			foreach ( split /$_space/, $_ ) {
				if ( m.$_type_name.gc && $1 ) {
					$expression .= get_rename_string( $2, $1, $original, $2 );
				}
				else {
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

sub Scalar : lvalue {
	my ( $this, $name ) = @_;
	my $property = sprintf '%s::%s', $this->X3DPackage::getName, $name;
	$$property;
}

use warnings;

sub Array : lvalue {
	my ( $this, $name ) = @_;
	my $property = sprintf '%s::%s', $this->X3DPackage::getName, $name;
	@$property;
}

sub Hash : lvalue {
	my ( $this, $name ) = @_;
	my $property = sprintf '%s::%s', $this->X3DPackage::getName, $name;
	%$property;
}

# sub can {
# 	my ( $this, $name ) = @_;
# 	my $property = sprintf "%s::%s::can::%s", __PACKAGE__, $this->X3DPackage::getName, $name;
# 
# 	unless ( defined $$property ) {
# 		$$property = [];
# 		push @$$property, map { \&{"${_}::${name}"} }
# 		  grep { exists &{"${_}::${name}"} } X3DPackage::getSelfAndSuperpath($this);
# 	}
# 
# 	return @$$property;
# }

use strict 'refs';

#sub call {
#	my ( $this, $name ) = ( shift, shift );
#	return map { &$_( $this, @_ ) } X3DPackage::can( $this, $name );
#}

#sub reverse_call {
#	my ( $this, $name ) = ( shift, shift );
#	return map { &$_( $this, @_ ) } reverse X3DPackage::can( $this, $name );
#}

#sub sub { ( caller( ( $_[1] || 0 ) + 1 ) )[3] }

sub toString {
	my $package = shift;
	my $level   = shift || 1;
	my $string  = '';

	$string .= $package->X3DPackage::getName;

	my $hierarchy = \X3DPackage::Array( $package, 'ISA' );

	$string .= ' ';
	$string .= '[';

	if (@$hierarchy) {

		if ($#$hierarchy) {
			$string .= "\n";
			$string .= '  ' x $level;
		} else {
			$string .= ' ';
		}

		$string .= join "\n" . ( '  ' x $level ), map {
			$_->X3DPackage::toString( $level + 1 );
		} @$hierarchy;

		if ($#$hierarchy) {
			$string .= "\n";
			$string .= '  ' x ( $level - 1 );
		}
		else {
			$string .= ' ';
		}
	}

	$string .= ']';

	return $string;
}

1;
__END__
