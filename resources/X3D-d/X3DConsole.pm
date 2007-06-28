package X3DConsole;
use strict;
use warnings;

use rlib "Components/Core";

use base qw(X3DChildNode);

use X3DConstants;

=X3DConsole : X3DChildNode {
}
=cut

our $FieldDefinitions = [ new X3DFieldDefinition( inputOutput, 'enabled', TRUE ), new X3DFieldDefinition( inputOnly, 'print', new MFString ), ];

sub _print {
	my ( $this, $value, $time ) = @_;
	printf "*** %s\n", join "\n    ", map { $_->getValue } @$value;
	return;
}

1;
__END__
printf "%s\n", __PACKAGE__->new;
