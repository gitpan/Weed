#!/usr/bin/perl -w
#package nodefield_sfrotation_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'TestNodeFields';
}

ok my $testNode     = new TestNode;
ok my $sfrotationId = $testNode->sfrotation->getId;
is $sfrotationId, $testNode->sfrotation->getId;

is new SFRotation( 0.267261241912424, 0.534522483824849, 0.801783725737273, 0.4 ), '0.267261241912424 0.534522483824849 0.801783725737273 0.4';

#$testNode->sfrotation = new SFRotation(new SFVec3f(1,0,0), new SFVec3f(0,1,0));
#is $testNode->sfrotation, "0 0 1 0";

my $r = new X3DRotation();
is $r, "0 0 1 0";

is new SFRotation( 0, 0, 0, 0 ), "0 0 1 0";
is new SFRotation( undef, undef ), "0 0 1 0";
is new SFRotation( undef, undef, undef, undef ), "0 0 1 0";
is new SFRotation( undef, undef, undef, undef, undef, undef ), "0 0 1 0";

$testNode->sfrotation = new SFRotation();
is $testNode->sfrotation, "0 0 1 0";
ok !$testNode->sfrotation;

is $testNode->sfrotation->x,     0;
is $testNode->sfrotation->y,     0;
is $testNode->sfrotation->z,     1;
is $testNode->sfrotation->angle, 0;

is $testNode->sfrotation->[0], 0;
is $testNode->sfrotation->[1], 0;
is $testNode->sfrotation->[2], 1;
is $testNode->sfrotation->[3], 0;

is eval { $testNode->sfrotation->[4] }, undef;
ok $@ =~ /$0/;
is eval { $testNode->sfrotation->[-5] }, undef;
ok !$@;

is $testNode->sfrotation->angle = 45, 45;
is $testNode->sfrotation->angle, 45;
is $testNode->sfrotation, "0 0 1 45";

is $testNode->sfrotation->[3] = 45, 45;
is $testNode->sfrotation, "0 0 1 45";

ok $testNode->sfrotation;
isa_ok $testNode->sfrotation->getAxis, 'X3DVec3';
isa_ok $testNode->sfrotation->getAxis, 'X3DVec3';

$r->setAngle(45);
is $r, "0 0 1 45";

ok $testNode->sfrotation = [ 0.267261241912424, 0.534522483824849, 0.801783725737273, 0.4 ];
is $testNode->sfrotation, '0.267261241912424 0.534522483824849 0.801783725737273 0.4';

ok $testNode->sfrotation = [ [ 0.267261241912424, 0.534522483824849, 0.801783725737273 ], 0.4 ];
is $testNode->sfrotation, '0.267261241912424 0.534522483824849 0.801783725737273 0.4';

ok $testNode->sfrotation = [ new SFVec3d( 0.267261241912424, 0.534522483824849, 0.801783725737273 ), 0.4 ];
is $testNode->sfrotation, '0.267261241912424 0.534522483824849 0.801783725737273 0.4';

$r->setValue( [ 1, 2, 3 ], [ 4, 5, 6 ] );
ok $testNode->sfrotation = [ [ 1, 2, 3 ], [ 4, 5, 6 ] ];
ok $testNode->sfrotation = $testNode->sfrotation;
is $testNode->sfrotation, $r;

ok $testNode->sfrotation = [ new X3DVec3( [ 1, 2, 3 ] ), [ 4, 5, 6 ] ];
is $testNode->sfrotation, $r;

ok $testNode->sfrotation = [ [ 1, 2, 3 ], new X3DVec3( [ 4, 5, 6 ] ) ];
is $testNode->sfrotation, $r;

ok $testNode->sfrotation = [ new SFVec3f( [ 1, 2, 3 ] ), [ 4, 5, 6 ] ];
is $testNode->sfrotation, $r;

ok $testNode->sfrotation = [ [ 1, 2, 3 ], new SFVec3f( [ 4, 5, 6 ] ) ];
is $testNode->sfrotation, $r;

ok $testNode->sfrotation = [ new SFVec3d( [ 1, 2, 3 ] ), [ 4, 5, 6 ] ];
is $testNode->sfrotation, $r;

ok $testNode->sfrotation = [ [ 1, 2, 3 ], new SFVec3d( [ 4, 5, 6 ] ) ];
is $testNode->sfrotation, $r;

ok $testNode->sfrotation = [ [ 1, 2, 3 ], new SFVec4d( [ 4, 5, 6 ] ) ];
is $testNode->sfrotation, $r;

eval { $testNode->sfrotation = new MFDouble( 5, 2, 3, 4 ) };
ok $@;
#is $testNode->sfrotation, '5 2 3 4';

ok $testNode->sfrotation = [ $r, $r ];
is $testNode->sfrotation, $r;

my $sfrotation = $testNode->sfrotation;
isa_ok $sfrotation, 'X3DRotation';

is $sfrotationId, $testNode->sfrotation->getId;

1;
__END__
