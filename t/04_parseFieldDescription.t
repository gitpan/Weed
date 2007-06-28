#!/usr/bin/perl -w
#package 04_parseFieldDescription
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed::Parse::FieldDescription';
}
use Weed;

ok my $fieldDescription = Weed::Parse::FieldDescription::parse "SFNode [in,out] metadata NULL [X3DMetadataObject]";
ok @$fieldDescription;
is shift @{$fieldDescription->[0]}, 'SFNode';
is shift @{$fieldDescription->[0]}, YES;
is shift @{$fieldDescription->[0]}, YES;
is shift @{$fieldDescription->[0]}, 'metadata';
is shift @{$fieldDescription->[0]}, undef;
#is shift @{$fieldDescription->[0]}, '';

ok $fieldDescription = Weed::Parse::FieldDescription::parse "SFBool [in,out] metadata TRUE [X3DMetadataObject]";
ok @$fieldDescription;
is shift @{$fieldDescription->[0]}, 'SFBool';
is shift @{$fieldDescription->[0]}, YES;
is shift @{$fieldDescription->[0]}, YES;
is shift @{$fieldDescription->[0]}, 'metadata';
is shift @{$fieldDescription->[0]}, YES;
#is shift @{$fieldDescription->[0]}, '';

1;
__END__
