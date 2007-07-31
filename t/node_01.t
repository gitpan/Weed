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

{
	my $n = new TestNode();
	my $s = new SFNode($n);

	$n->{xxx} = 123;
	#print new X3DHash \%$n;

	print $n->getField('sfvec2f');

	X3DGenerator->setTidyFields(NO);
	#print $n;

	my %h;
	is int( \%h ), int( \%h );

	$s->sfvec2f = [ 1, 1 ];
	is $s->sfvec2f, '1 1';
	$s->sfvec2f = [ 2, 2 ];
	is $s->sfvec2f, '2 2';
	is $s->sfvec2f += 1, '3 3';
	is $s->sfvec2f, '3 3';

	#print ref ${ $s->getValue->getFields }->{tiedFields}->{'sfvec2f'};
	${ $s->getValue->getFields }->{tiedFields}->{'sfvec2f'} -= 1;
	is $s->sfvec2f, '2 2';

	#is $s->sfvec2f -= 1, '2 2';
	#is $s->sfvec2f, '2 2';
	is $s->sfvec2f += 1, '3 3';
	is $s->sfvec2f, '3 3';

	#isa_ok $n->[19], 'SFColorRGBA';
	#isa_ok $n->[29], 'SFVec2f';

	#use Benchmark ':hireswallclock';

	#timethis( -10, sub { $s->sfbool = YES } );    # 5722.02/s
	#timethis( -10, sub { $n->[17]->setValue(1) } );         # 153831.40/s
	#timethis( -10, sub { $n->{sfbool}->setValue(1) } );     # 158199.81/s

	#timethis( -10, sub { $s->sffloat = 1.2 } );    # 5159.32/s
	#timethis( -10, sub { $n->[21]->setValue(1.2) } );         # 61499.04/s
	#timethis( -10, sub { $n->{sffloat}->setValue(1.2) } );    # 62212.77/
	#timethis( -10, sub { $s->sffloat++ } );    # 2844.76/s

	#timethis( -10, sub { $s->sfvec2f = [ 1, 2 ] } );    # 4695.25/s
	#timethis( -10, sub { $n->[29]->setValue(      [ 1, 2 ] ) } );    # 29530.07/s
	#timethis( -10, sub { $n->{sfvec2f}->setValue( [ 1, 2 ] ) } );    # 29445.21/s
	#timethis( -10, sub { $s->sfvec2f++ } ); # 1882.94/s

	#print $_, ref $n->[$_] foreach 0 .. $#$n;
}

1;
__END__

