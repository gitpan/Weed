#!/usr/bin/perl -w
#package 01_universal2
use Test::More no_plan;
#use Benchmark ':hireswallclock';
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Universal';
}

Weed::Universal::createType( 'main', 'X3DUniversal', 'X {}');

sub setDescription {
	printf "setDescription %s\n", "@_"; 
}

__END__
