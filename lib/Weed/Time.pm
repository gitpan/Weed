package Weed::Time;
use strict;
use warnings;

our $VERSION = '0.001';

use Time::HiRes;

sub import {
	*CORE::GLOBAL::time = \&Time::HiRes::time
}

sub unimport {
	no strict 'refs';
	delete ${ *{"CORE::GLOBAL::"} }{time};
}

1;
__END__
