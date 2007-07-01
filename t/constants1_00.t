#!/usr/bin/perl -w
#package constants1_00
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

sub NULL ()  { X3DConstants->NULL }
sub FALSE () { X3DConstants->FALSE }
sub TRUE ()  { X3DConstants->TRUE }

ok TRUE;
ok !FALSE;
ok !TRUE == FALSE;
ok !FALSE == TRUE;
is TRUE,  'TRUE';
is FALSE, 'FALSE';

is my $bool1 = FALSE, FALSE;
is $bool1, 'FALSE';
$bool1->setValue(TRUE);

is $bool1, TRUE;
is FALSE, 'FALSE';

is my $bool2 = TRUE, TRUE;
is $bool2, 'TRUE';

isa_ok $bool2, 'SFBool';
print $bool2->Weed::Package::stringify;

ok $bool2 ? 1 : 0;

$bool2->setValue(0);
print $bool2;

ok $bool2 ? 0 : 1;

is "$bool2", "FALSE";
is $bool2, FALSE;
is TRUE, 'TRUE';

is my $sfnode = NULL, NULL;
is $sfnode, 'NULL';
$sfnode->setValue( new X3DBaseNode );

ok $sfnode;
is NULL, 'NULL';

NULL->setValue( new X3DBaseNode );

ok NULL->getId != NULL->getId;
ok FALSE->getId != FALSE->getId;
ok TRUE->getId != TRUE->getId;

ok( !X3DConstants->NULL );
ok( X3DConstants->TRUE );
ok( !X3DConstants->FALSE );

ok TRUE;
ok !FALSE;
ok !TRUE == FALSE;
ok !FALSE == TRUE;
is TRUE,  'TRUE';
is FALSE, 'FALSE';

1;
__END__

#$false = 1;
print Dumper $false;

is FALSE, X3DGenerator->FALSE;
is TRUE,  X3DGenerator->TRUE;

ok FALSE == FALSE;
ok !( FALSE == TRUE );
ok !( TRUE == FALSE );
ok TRUE == TRUE;



