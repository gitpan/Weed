#!/usr/bin/perl -w
#package 01_time
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Universal';
}

package test;
use Weed::Universal;

Test::More::ok Math::sum( map { time =~ m/\./ } 1 .. 170 ) <= 170 foreach 1 .. 10;

package main;
use Weed::Perl;

ok Math::sum( map { time =~ m/\./ } 1 .. 170 ) <= 170 foreach 1 .. 10;

__END__