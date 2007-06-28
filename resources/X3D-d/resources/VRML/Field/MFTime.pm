package VRML::Field::MFTime;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::MField;
@ISA = qw(VRML::MField);

use VRML::Field::SFTime;

sub setValue {
	my $this = shift;
	if (@_) {
		if (ref $_[0] eq 'ARRAY') {
			@{$this} = ();
			push @{$this}, @{$_} foreach @_;
		} else {
			@{$this} = map {
				ref $_ ? $_ : new SFTime($_);
			} @_;
		}
	} else {
		@{$this} = ();
	}
	return $this;
}

1;
__END__
