package VRML::Field::MFString;
use strict;
use Carp;

use vars qw(@ISA);
use VRML::MField;
@ISA = qw(VRML::MField);

use VRML::Generator qw($TIDY_SPACE mfield_break $DEEP);

use overload
	'""' => \&toString;

sub toString {
	my $this = shift;
	return "[$TIDY_SPACE]" unless @{ $this };

	my $string = '';
	if ($#{ $this }) {
		$DEEP++;
		$string = "[".mfield_break;
		$string .= join ",".mfield_break, map { "\"$_\"" } @{ $this };
		--$DEEP;
		$string .= mfield_break."]";
	} else {
		$string = "\"@{$this}\"";
	}

	return $string;
}

1;
__END__

use VRML::Field::SFString;

use Array;

sub setValue {
	my $this = shift;
	if (@_) {
		if (ref $_[0] eq 'ARRAY') {
			@{$this} = ();
			push @{$this}, @{$_} foreach @_;
		} else {
			@{$this} = map {
				ref $_ ? $_ : new SFString($_);
			} @_;
		}
	} else {
		@{$this} = ();
	}
	return $this;
}

sub escape {
	my $this = shift;
	my $args = args @_;
	return "[$TIDY_SPACE]" unless @{$this};

	my $string = '';
	if ($#{$this}) {
		$DEEP++;
		$string = "[".mfield_break;
		$string .= join ",".mfield_break, map { "\"".$_->escape($args)."\"" } @{$this};
		--$DEEP;
		$string .= mfield_break."]";
	} else {
		$string = $this->IS;
		$string = join "", map { "\"".$_->escape($args)."\"" } @{$this} unless $string;
	}

	return $string;
}
