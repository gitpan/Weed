#!/usr/bin/perl -w
#package 01_benchmark4
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

ok $u->getType ne $o->getType;
ok $o->getType eq $o2->getType;

say $o;
say $o2;

say $o->getType;
say $o2->getType;
__END__

my $v;

timethis( 2, sub { $v = $u->getType } );
say $v;

timethis( 2, sub { $v = $o->getType } );
say $v;


timethis( 10_000_000, sub { $v = object::type($o) } );
say $v;

timethis( 10_000_000, sub { $v = $o->getType } );
say $v;
