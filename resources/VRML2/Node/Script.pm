package VRML2::Node::Script;
use strict;

BEGIN {
	use Carp;

	use VRML2::Generator;

	use VRML2::Console;
	
	use vars qw(@ISA);
	use VRML2::BaseNode;
	@ISA = qw(VRML2::BaseNode);
}

use overload
	'""' => \&toString;


sub toString {											
	my $this = shift;									
	my $string = '';				

	#print CONSOLE " VRML2::Node::Script::toString ". $this->{proto}->getName ."\n";
	
	$string .= "DEF $this->{name} " if $this->{name};
	$string .= $this->{proto}->getName;
	$string .= $TSPACE;
	$string .= "{";

	if (@{$this->{body}}) {

		$string .= $TBREAK;

		INC_INDENT;
		foreach (@{$this->{body}}) {
			if (ref $this->{proto}->getField($_->getName)) {
				if (ref $_->getIsMapping) {
					$string .= sprintf "$INDENT%s IS %s$BREAK", $_->getName, $_->getIsMapping->getName;
				} else {
					$string .= sprintf "$INDENT%s %s$BREAK", $_->getName, $_->getValue;
				}
			} else {
				$string .= $INDENT;
				$string .= $_;
				$string .= $BREAK;
			}
		}
		DEC_INDENT;
	
		$string .= $INDENT;

	} else {
		$string .= $TSPACE;
	}

	$string .= "}";
	
	return $string;
}

1;
__END__
