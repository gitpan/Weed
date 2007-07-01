#!/usr/bin/perl -w
#package namespace_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}

my $perl = {};
my $weed = [];

no strict;
foreach my $subpkg ( sort keys( %{ *{"main::"} } ) )
{
	$perl->{$subpkg} = 1;
	#print "package main contains package '$subpkg'";
}

use_ok 'Weed';

foreach my $subpkg ( sort keys( %{ *{"main::"} } ) )
{
	push @$weed, $subpkg unless exists $perl->{$subpkg};
	#print "package main contains package '$subpkg'";

	if ( $subpkg =~ /::$/o ) {
		foreach my $subsubpkg ( sort keys( %{ *{"$subpkg"} } ) )
		{
			#print "  package $subpkg contains package ' $subsubpkg'";
		}
	}

}

print $_ foreach @$weed;

__END__

foreach my $subpkg ( sort keys(%{*{"main::"}}) )
{
	print "package main contains package '$subpkg'";
	foreach my $subsubpkg ( sort keys(%{*{"main::"}{HASH}->{$subpkg}}) )
	{
		print "package '$subpkg' contains package '$subsubpkg'";
	}
}

