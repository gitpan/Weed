#!/usr/bin/perl -w
#package parse_comment_0
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Parse::Comment';
}

my ( $s );

$s = '# comment';
is Weed::Parse::Comment::comment( \$s ), ' comment';

$s = "# comment\n
# comment2\n
fsd
";
is Weed::Parse::Comment::comment( \$s ), ' comment';
is Weed::Parse::Comment::comment( \$s ), ' comment2';
is Weed::Parse::Comment::comment( \$s ), undef;

__END__

