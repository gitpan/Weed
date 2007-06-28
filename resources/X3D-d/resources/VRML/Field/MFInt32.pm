package VRML::Field::MFInt32;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::MField;
@ISA = qw(VRML::MField);

use VRML::Field::SFInt32;

sub setValue {
	my $this = shift;
	if (@_) {
		if (ref $_[0] eq 'ARRAY') {
			@{$this} = ();
			push @{$this}, @{$_} foreach @_;
		} else {
			@{$this} = map {
				ref $_ ? $_ : new SFInt32($_);
			} @_;
		}
	} else {
		@{$this} = ();
	}
	return $this;
}

1;
__END__
