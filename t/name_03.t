#!/usr/bin/perl -w
#package name_03
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

my $n1 = 3;
my $n2 = 12;

foreach ( 1 .. $n1 ) {
	my @names;

	new X3DName("name") for 1 ... $n2;

	push @names, new X3DName("name") for 1 ... $n2;

	foreach my $i ( 2 .. $n2 ) {
		push @names, new X3DName("name$i") for 1 ... $n2;
	}

	foreach my $i ( 2 .. $n2 ) {
		push @names, new X3DName("name_$i") for 1 ... $n2;
	}

	is int($names[0]), $n2**2;
	print scalar @names;

	foreach (@names) {
		$_->setValue($_);
	}

	is int($names[0]), $n2**2;
	#print X3DName->DumpHash;
}

#print X3DName->DumpHash;

1;
__END__
