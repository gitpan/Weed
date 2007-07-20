#!/usr/bin/perl -w
#package node_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
	use_ok 'TestNodeFields';
}

my $n = new TestNode();
my $s = new SFNode($n);

print $s->[29]++;
print $s->{sfvec2f}--;

print $n->getField('sfvec2f');

X3DGenerator->setTidyFields(NO);
print $n;

$s->sfvec2f += 2;
is $s->sfvec2f, '2 2';
$n->[29] += 2;
is $s->sfvec2f, '4 4';

print $n->[29]++;
print $n->[29]++;

print $n->[0];
print $n->[29]++;
print $n->[29]++;
isa_ok $n->[19], 'SFColorRGBA';
isa_ok $n->[29], 'SFVec2f';

print $_, ref $n->[$_] foreach 0 .. $#$n;

print $n->{sfvec3f}++;
print $n->{sfvec3f}++;

use Benchmark ':hireswallclock';

$n->{sfvec3f}++;

ok tied $n->{sfvec3f};

#timethis( 100_000, sub { $n->[29]++ } );    #29044.44/s
#timethis( 10_000, sub { $n->{sfvec2f}++ } ); #29044.44/s
#timethis( 100_000, sub { $s->sfvec2f++ } ); #29044.44/s

#timethis( 100_000, sub { $s->sfbool = YES } ); #29044.44/s
#timethis( -15, sub { $n->{sfbool} = YES } ); #110411.07/s
#timethis( -15, sub { $n->[17] = YES } ); #110444.85/s

# timethis( -10, sub { $n->{sffloat} = 1 } ); #110444.85/s
# timethis( -10, sub { $n->[21] = 1 } ); #110444.85/s
# timethis( -10, sub { $s->{sffloat} = 1 } ); #110444.85/s
# timethis( -10, sub { $s->[21] = 1 } ); #110444.85/s
1;
__END__

