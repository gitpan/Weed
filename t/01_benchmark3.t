#!/usr/bin/perl -w
#package 01_benchmark3
use Test::More no_plan;
#use Benchmark ':hireswallclock';
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}
use Weed::Perl;

my $u = new X3DUniversal;
my $o = new X3DObject;
my $o2 = new X3DObject;

say $u;

ok $u->getId != $o->getId;
ok $o->getId != $o2->getId;

say $o;
say $o2;

say $o->getId;
say $o2->getId;
my $v;

__END__

timethis( 10_000_000, sub { $v = $o->perl::id } );
say $v;

timethis( 10_000_000, sub { $v = $o->getId } );
say $v;

