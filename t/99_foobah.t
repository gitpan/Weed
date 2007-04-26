#!/usr/bin/perl -w
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('FooBah');
}

__END__

printf "%s\n", getBrowser();
printf "%s\n", createBrowser();
printf "%s\n", createBrowser();
printf "%s\n", getBrowser();

ok getBrowser();

ok getBrowser() == getBrowser();
ok createBrowser() != getBrowser();
ok getBrowser() == getBrowser();
ok createBrowser() != getBrowser();

ok new SFNode;
ok new MFNode;
