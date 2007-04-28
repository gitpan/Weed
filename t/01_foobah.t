#!/usr/bin/perl -w
#package 01_foobah
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('FooBah');
}

ok my $fooBah = new FooBah("haBooF");
isa_ok $fooBah, 'X3DObject';
can_ok $fooBah, 'getName';
can_ok $fooBah, 'getTypeName';
can_ok $fooBah, 'getType';
can_ok $fooBah, 'getId';

printf "%s\n", $fooBah;
printf "%s\n", join ", ", $fooBah->getHierarchy;
#printf "%s\n", $fooBah->getBrowser;

ok $fooBah = new FooBah();
printf "%s\n", $fooBah;
printf "%s\n", join ", ", $fooBah->getHierarchy;
#printf "%s\n", $fooBah->getBrowser;

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
