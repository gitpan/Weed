#!/usr/bin/perl -w
#package hierarchy_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

no strict;
my $weed = new X3DArray [ sort map { s/\:\:$//o; $_ } grep /^X3D|MF|SF/o, keys( %{ *{"main::"} } ) ];
use strict;
#print $weed;

print reverse $_->getHierarchy foreach grep { $_->can('getHierarchy') } @$weed;

package xxx;
use Weed 'fds';

print fds->X3DPackage::toString;
1;
__END__


my $DEBUG = 0;

SKIP: {
	skip "Not necessary" unless $DEBUG;


	print $_ foreach @$weed;

	my $pack = "CORE::GLOBAL";
	foreach my $subpkg ( sort keys( %{ *{"$pack\::"} } ) )
	{
		print "package $pack contains package '$subpkg'";
		foreach my $subsubpkg ( sort keys( %{ *{"main::"}{HASH}->{$subpkg} } ) )
		{
			print "package '$subpkg' contains package '$subsubpkg'";
		}
	}

}

