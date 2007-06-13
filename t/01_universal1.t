#!/usr/bin/perl -w
#package 01_universal1
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Universal';
}

use Weed::Perl;

ok !@{ Weed::Universal->Weed::Package::array('ISA') };

is( ref( ( Weed::Universal->Weed::Package::can('import') )[0] ), 'CODE' );

ok !Weed::Universal->Weed::Package::can('blah');

ok Math::sum( ok map { time =~ m/\./ } 0 .. 17 );
ok Math::sum( ok map { &time =~ m/\./ } 0 .. 17 );

#ok(X3DUniversal::time);
#ok(&X3DUniversal::time);

#ok( X3DUniversal->time );
#ok( X3DUniversal->time );

#ok Math::sum( ok map { &X3DUniversal::time =~ m/\./ } 0 .. 17 );
#ok Math::sum( ok map { X3DUniversal::time =~ m/\./ } 0 .. 17 );
#ok Math::sum( ok map { X3DUniversal->time =~ m/\./ } 0 .. 17 );
#printf "%s\n", X3DUniversal->time;
#printf "%s\n", X3DUniversal->time;

__END__
