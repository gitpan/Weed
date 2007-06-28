#!/usr/bin/perl -w
#package 01_generator
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Generator';
}

can_ok 'X3DGenerator', 'TRUE';
can_ok 'X3DGenerator', 'FALSE';
can_ok 'X3DGenerator', 'NULL';

can_ok 'X3DGenerator', 'tab';
can_ok 'X3DGenerator', 'space';
can_ok 'X3DGenerator', 'break';

can_ok 'X3DGenerator', 'indent';

can_ok 'X3DGenerator', 'inc';
can_ok 'X3DGenerator', 'dec';

can_ok 'X3DGenerator', 'tidy_space';
can_ok 'X3DGenerator', 'tidy_break';

can_ok 'X3DGenerator', 'tidy';
can_ok 'X3DGenerator', 'clean';

is (X3DGenerator->float_precision, 7);
is (X3DGenerator->double_precision, 15);

__END__
