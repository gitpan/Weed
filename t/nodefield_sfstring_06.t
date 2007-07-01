#!/usr/bin/perl -w
#package nodefield_sfstring_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode  = new SFNode( new TestNode );
ok my $sfstringId = $testNode->sfstring->getId;
is $sfstringId, $testNode->sfstring->getId;




my $sfstring = $testNode->sfstring;
isa_ok $sfstring, 'X3DField';

is $sfstringId, $testNode->sfstring->getId;
1;
__END__

