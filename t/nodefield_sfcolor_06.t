#!/usr/bin/perl -w
#package nodefield_sfcolor_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode  = new SFNode( new TestNode );
ok my $sfcolorId = $testNode->sfcolor->getId;
is $sfcolorId, $testNode->sfcolor->getId;
isa_ok $testNode->sfcolor, 'SFColor';

ok !$testNode->sfcolor;

$testNode->sfcolor = [ 1, 0, 0 ];
is $testNode->sfcolor, "1 0 0";
ok $testNode->sfcolor;

isa_ok $testNode->sfcolor + [ 1, 0.2, 0 ], 'SFColor';
$testNode->sfcolor = $testNode->sfcolor + [ 1, 0.2, 0 ];
is $testNode->sfcolor, "1 0.2 0";

$testNode->sfcolor = $testNode->sfcolor + [ 1, 0, 0 ];
$testNode->sfcolor = [ -0.2, 0.2, 0.4 ] +$testNode->sfcolor;
is $testNode->sfcolor, "0.8 0.4 0.4";

is ref( $testNode->sfcolor + [ 1, 0, 0 ] ), 'SFColor';


#$this->{fields}->{$name};
#print ref $testNode->getValue->{fields}->{sfcolor};

#$testNode->getValue->{fields}->{sfcolor} *= 2;
$testNode->sfcolor *= 2;
is $testNode->sfcolor, "1 0.8 0.8";

$testNode->sfcolor /= 2;
is $testNode->sfcolor, "0.5 0.4 0.4";

$testNode->sfcolor /= 2;
$testNode->sfcolor *= 3;
$testNode->sfcolor /= 7;
$testNode->sfcolor += [ 0.1, 0.1, 0.1 ];
is $testNode->sfcolor, "0.207142857142857 0.185714285714286 0.185714285714286";

my $sfcolor = $testNode->sfcolor;
isa_ok $sfcolor, 'X3DField';
isa_ok $testNode->sfcolor, 'SFColor';

$testNode->sfcolor = new SFColor(1/2, 1/4, 1/8);
is $testNode->sfcolor, "0.5 0.25 0.125";

$testNode->sfcolor = new SFVec3f(1/4, 1/2, 1/8);
is $testNode->sfcolor, "0.25 0.5 0.125";

$testNode->sfcolor = new SFVec3d(1/2, 1/4, 1/8);
is $testNode->sfcolor, "0.5 0.25 0.125";

$testNode->sfcolor = new SFVec2d(1/2, 1/4);
isa_ok $testNode->sfcolor->getValue, 'Weed::Values::Color';
is $testNode->sfcolor, "0.5 0.25 0.125";

$testNode->sfcolor = new SFVec2f(1/4, 1/2);
is $testNode->sfcolor, "0.25 0.5 0.125";

$testNode->sfcolor = [1/2, 1/4, 1/8];
is $testNode->sfcolor, "0.5 0.25 0.125";

$testNode->sfcolor = [1/2, 1/4];
is $testNode->sfcolor, "0.5 0.25 0.125";

$testNode->sfcolor = [1/2];
is $testNode->sfcolor, "0.5 0.25 0.125";

$testNode->sfcolor = 0.3;
is $testNode->sfcolor, "0.3 0.25 0.125";

$testNode->sfcolor = new SFDouble(0.6);
is $testNode->sfcolor, "0.6 0.25 0.125";

$testNode->sfcolor = [1/2, 1/4];
is $testNode->sfcolor, "0.5 0.25 0.125";

$testNode->sfcolor = new SFDouble(0.6);
is $testNode->sfcolor, "0.6 0.25 0.125";


$testNode->sfcolor = new SFVec2f [1/16, 1/8];
is $testNode->sfcolor, "0.0625 0.125 0.125";

$testNode->sfcolor = new SFRotation;
is $testNode->sfcolor, "0 0 1";

$testNode->sfcolor = new SFRotation(1, 0, 0, 1);
is $testNode->sfcolor, "0 0 1";

$testNode->sfcolor = new SFRotation(1, 2, 3, 1);
is $testNode->sfcolor, '0.267261241912424 0.534522483824849 0.801783725737273';




is ref $testNode->sfcolor->getValue->[0], '';

is $testNode->sfcolor->getValue->[0] = 1, '1';
is $testNode->sfcolor->getValue->[1] = 2, '2';
is $testNode->sfcolor->getValue->[2] = 3, '3';
is $testNode->sfcolor->getValue->[0], '1';
is $testNode->sfcolor->getValue->[1], '2';
is $testNode->sfcolor->getValue->[2], '3';
is $testNode->sfcolor, "1 1 1";

is ref $testNode->sfcolor->getValue->[0], '';
is ref $testNode->sfcolor->getValue->[1], '';
is ref $testNode->sfcolor->getValue->[2], '';

is $sfcolorId, $testNode->sfcolor->getId;

#print $testNode->sfcolor->Weed::Package::stringify;

1;
__END__
no strict;
foreach my $subpkg ( sort keys(%{*{"main::"}}) )
{
	print "package main contains package '$subpkg'";
	foreach my $subsubpkg ( sort keys(%{*{"main::"}{HASH}->{$subpkg}}) )
	{
		print "package '$subpkg' contains package '$subsubpkg'";
	}
}

package abc;
print 1, $abc::XXX;

my $t = $testNode->getValue;
print Internals::SvREFCNT($t);


