#!/usr/bin/perl -w
#package 02_foobah
use Test::More no_plan;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok('FooBah');
}

use Weed::Perl;
ok new FooBah;
ok my $fooBah = new FooBah("haBooF");

say;
say;
say $_ foreach 'FooBah'->Weed::Package::self_and_superpath;

say;
say;
say $_ foreach $fooBah->Weed::Package::self_and_superpath;

say;
say;
say $_ foreach $fooBah->Weed::Package::supertypes;

1;
__END__
