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

print $u;

ok $u->getId != $o->getId;
ok $o->getId != $o2->getId;

print $o;
print $o2;

print $o->getId;
print $o2->getId;
my $v;

__END__

timethis( 10_000_000, sub { $v = $o->perl::id } );
print $v;

timethis( 10_000_000, sub { $v = $o->getId } );
print $v;

