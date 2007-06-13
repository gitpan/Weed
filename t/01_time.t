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

package main;
use Weed::Perl;

#ok Math::sum( map { ok( &time =~ m/\./ ) } 1 .. 170 );

ok !@{ Weed::Universal->Weed::Package::array('ISA') };

is( ref( ( Weed::Universal->Weed::Package::can('import') )[0] ), 'CODE' );

ok !Weed::Universal->Weed::Package::can('blah');

#ok(X3DUniversal::time);
#ok(&X3DUniversal::time);

#ok( X3DUniversal->time );
#ok( X3DUniversal->time );

#ok(X3DUniversal::TIME);
#ok(&X3DUniversal::TIME);

#Die Differenz einer Zahl und ihrer Quersumme ist immer durch 9 teilbar).

#ok my $n = Math::sum( map { ok( &X3DUniversal::time =~ m/\./ ) } 1 .. 170 );
#is Math::xsum($n), Math::x($n);
#ok Math::sum( map { ok( X3DUniversal::time  =~ m/\./ ) } 1 .. 170 );
#ok Math::sum( map { ok( X3DUniversal->time  =~ m/\./ ) } 1 .. 170 );
ok Math::sum( map { ok( &time  =~ m/\./ ) } 1 .. 170 );
ok Math::sum( map { ok( time  =~ m/\./ ) } 1 .. 170 );
#printf "%s\n", X3DUniversal->time;
#printf "%s\n", X3DUniversal->time;

__END__
