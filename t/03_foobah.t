#!/usr/bin/perl -w
#package 03_foobah
use Test::More no_plan;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('FooBah');
}

ok my $X3D = new FooBah("X3D");
is $X3D->getName, "X3D";
#ok $X3D->createBrowser;

1;
__END__
