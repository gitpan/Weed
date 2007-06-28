package X3DField;
use strict;
use warnings;

use rlib "./";

use base qw'X3DObject Exporter';

our $AccessTypes = [
	'initializeOnly',
	'inputOnly',
	'outputOnly',
	'inputOutput',
];
use enum qw(initializeOnly inputOnly outputOnly inputOutput);

our @EXPORT = qw(
	@AccessType
	initializeOnly inputOnly outputOnly inputOutput
);

sub CREATE {
	my $this = shift;
	$this->{accessType}  = shift;
	$this->{name}        = shift;
	$this->{value}       = shift;
	$this->{description} = shift;
}

sub clone {
	my $this = shift;
	return $this->new($this->{accessType}, $this->{name}, $this->{value}->copy);
}

sub getAccessType { $_[0]->{accessType} }
sub getType       { ref $_[0]->{value}  }
sub getName       { $_[0]->{name}       }
sub getValue      { $_[0]->{value}      }

sub setValue {
	my $this = shift;
	$$this = ref $_[0] ? ${$_[0]} : $_[0] if @_;
	return;
}

sub registerFieldInterest {
	my $this = shift;
	return;
}

sub STRINGIFY {
	my ($this) = @_;
	my $string = "";
	
	$string .= $this->getName;
	$string .= " ";
	$string .= $this->getValue;
	
	return $string;
}

1;
__END__
