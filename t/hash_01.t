#!/usr/bin/perl -w
#package hash_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

ok !new X3DHash;

ok !( my $hash = new X3DHash );
$hash->{'aa'} = 'bb';
ok $hash;
is $hash->getSize, 1;
is $hash->getKeys->getLength, 1;

ok !$@;
eval { ++$hash->getKeys->getLength };
ok $@; $@ = undef;

ok !$@;

__END__
