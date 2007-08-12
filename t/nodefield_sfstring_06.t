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

ok my $testNode  = new TestNode;
ok my $sfstringId = $testNode->sfstring->getId;
is $sfstringId, $testNode->sfstring->getId;

$testNode->sfstring = 'a~ha';
ok $testNode->sfstring eq 'a~ha';
is scalar $testNode->sfstring, 'a~ha';
is ~$testNode->sfstring, ~'a~ha';
is $testNode->sfstring .$testNode->sfstring , 'a~haa~ha';

$testNode->sfstring =~ s/~/-/;
ok $testNode->sfstring eq 'a-ha';
is scalar $testNode->sfstring, 'a-ha';
$testNode->sfstring =~ s/-/~/;
ok $testNode->sfstring eq 'a~ha';
is scalar $testNode->sfstring, 'a~ha';

my $sfstring = $testNode->sfstring;
is ref $sfstring, '';

is ref $testNode->sfstring, '';
is $sfstringId, $testNode->sfstring->getId;

1;
__END__
