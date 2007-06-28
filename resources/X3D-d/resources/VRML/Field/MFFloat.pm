package VRML::Field::MFFloat;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::MField;
@ISA = qw(VRML::MField);

use VRML::Field::SFFloat;

sub setValue {
	my $this = shift;
	if (@_) {
		if (ref $_[0] eq 'ARRAY') {
			@{$this} = ();
			push @{$this}, @{$_} foreach @_;
		} else {
			@{$this} = map {
				ref $_ ? $_ : new SFFloat($_);
			} @_;
		}
	} else {
		@{$this} = ();
	}
	return $this;
}

1;
__END__
