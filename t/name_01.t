#!/usr/bin/perl -w
#package name_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Name';
}

#print $Weed::Name::Description;
ok my $name = new X3DName();

print $name->Weed::Package::stringify;
#is $name->getValue, "";

1;
__END__
