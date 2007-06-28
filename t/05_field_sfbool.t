#!/usr/bin/perl -w
#package 05_field_sfbool
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

use Weed::Perl;

sub FALSE { X3DConstants->FALSE }
sub TRUE  { X3DConstants->TRUE }

is FALSE, 'FALSE';
is TRUE,  'TRUE';

is( X3DConstants->FALSE ? 1 : 0, 0);
is( X3DConstants->TRUE ? 1 : 0, 1 );

ok FALSE == FALSE;
ok !( FALSE == TRUE );
ok !( TRUE == FALSE );
ok TRUE == TRUE;

ok !( FALSE != FALSE );
ok FALSE != TRUE;
ok TRUE != FALSE;
ok !( TRUE != TRUE );

is FALSE == FALSE, 1;
is !( FALSE == TRUE ), 1;
is !( TRUE == FALSE ), 1;
is TRUE == TRUE, 1;

is FALSE != FALSE, '';
is !( FALSE != TRUE ), '';
is !( TRUE != FALSE ), '';
is TRUE != TRUE, '';

is (TRUE  && TRUE,  'TRUE');
is (0 && 1,  0);
is (FALSE && TRUE,  'FALSE');
is (TRUE  && FALSE, 'FALSE');
is (FALSE && FALSE, 'FALSE');

is TRUE ^ TRUE,   0;
is FALSE ^ TRUE,  1;
is TRUE ^ FALSE,  1;
is FALSE ^ FALSE, 0;

is my $bool = FALSE, FALSE;
$bool->setValue(TRUE);

is $bool, TRUE;
is FALSE, 'FALSE';

__END__
