package Weed;
use Weed::Perl;

our $VERSION = '0.0034';

sub import {
	shift;
	strict::import;
	warnings::import;
	Weed::Universal::createType( scalar caller, 'X3DObject', @_ );
}

use Weed::Environment;

1;
__END__

=head1 NAME

Weed - 

=head1 DESCRIPTION

=head1 SYNOPSIS

	package MyPackage;
	use Weed;
	1;

	package main;
	use MyPackage;
	my $object = new MyPackage($name);
	print $object;

or

	package MyPackage;
	
	use Weed '
	MyPackage : X3DNode {
		MFString  [in,out]  string  ""
	}
	';
	
	sub initialize {
		my ($this) = @_;
		
		my $string = new MFString($this);
		
		$this->string($string);      # both statement produce the same result
		$this->set_string($string);  # the node field 'string' is set to the content of $string
		                             # and _string is called
		
		$this->_string($string);  # calls _string directly whitout setting the field
	}
	
callback function names begin begin whith a underscore '_' followed by the field name
	
	sub _string {
		my ($this, $value, $time) = @_;
		printf "%s\n", $value;
	}

=head1 INTERFACE

=head2 setDescription($package, $description)

=head2 initialize($this)

=head2 shutdown($this)

=head1 SEE ALSO

L<Weed::Seed>

L<Weed::Field>, L<Weed::ArrayField>

L<Math::Vectors>

=head1 AUTHOR

Holger Seelig  holger.seelig@yahoo.de

=head1 COPYRIGHT

Das ist freie Software; du kannsts sie weiter verteilen und/oder ver�ndern
nach den gleichen Bedingungen wie L<Perl|perl> selbst.

=cut
