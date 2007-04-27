package Weed::Private;
use strict;
use warnings;

our $VERSION = '0.0006';

use Weed::Parser::Description;

use base 'Weed::Universal';

use constant DESCRIPTION => '';

sub import {
	my ($package) = @_;

	printf "import public *** %s\n", $package;

	my $description = $package->DESCRIPTION;

	return &Weed::Parser::Description::parse( $package, $description ) if $description;

	return;
}

sub private::getFieldDescriptions {
	my ($this) = @_;
	my $fieldDescriptions =  ${ $this->SCALAR("FieldDescriptions") };
	$fieldDescriptions = $this->SUPER->private::getFieldDescriptions
	  unless ref $fieldDescriptions;
	return $fieldDescriptions;
}

1;
__END__
