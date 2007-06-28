#!/usr/bin/perl -w
#package 01_namespace
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

no strict;
foreach my $subpkg ( sort keys(%{*{"main::"}}) )
{
	print "package main contains package '$subpkg'";
}

print '';

foreach my $subpkg ( sort keys(%{*{"main::"}}) )
{
	print "package main contains package '$subpkg'";
	foreach my $subsubpkg ( sort keys(%{*{"main::"}{HASH}->{$subpkg}}) )
	{
		print "package '$subpkg' contains package '$subsubpkg'";
	}
}
