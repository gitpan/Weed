#!/usr/bin/perl -w
#package parse_FieldDescription_04
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}
use Weed;

is ref eval { Weed::Parse::FieldDescription::parse "# SFNode [] metadata NU LL " }, 'ARRAY';
print $@;
ok not $@; ok eval { 1 };

ok not eval { Weed::Parse::FieldDescription::parse "SFNode [] metadata NU LL" };
print $@;
ok $@; ok eval { 1 };

ok not eval { Weed::Parse::FieldDescription::parse "+ SFNode [] metadata NU LL" };
print $@;
ok $@; ok eval { 1 };

is eval { Weed::Parse::FieldDescription::parse "SFNode [] metadata NU LL" }, undef;

ok Weed::Parse::FieldDescription::parse "SFNode [] metadata NULL";
ok Weed::Parse::FieldDescription::parse "SFNode [in] metadata";
ok Weed::Parse::FieldDescription::parse "SFNode [out] metadata";
ok Weed::Parse::FieldDescription::parse "SFNode [in,out] metadata NULL";

ok my $fieldDescription = Weed::Parse::FieldDescription::parse "SFNode [in,out] metadata NULL [X3DMetadataObject]";
ok @$fieldDescription;
is shift @{ $fieldDescription->[0] }, 'SFNode';
is shift @{ $fieldDescription->[0] }, YES;
is shift @{ $fieldDescription->[0] }, YES;
is shift @{ $fieldDescription->[0] }, 'metadata';
is shift @{ $fieldDescription->[0] }, undef;
is shift @{ $fieldDescription->[0] }, '[X3DMetadataObject]';

ok $fieldDescription = Weed::Parse::FieldDescription::parse "SFBool [in,out] metadata TRUE [X3DMetadataObject] ";
ok @$fieldDescription;
is shift @{ $fieldDescription->[0] }, 'SFBool';
is shift @{ $fieldDescription->[0] }, YES;
is shift @{ $fieldDescription->[0] }, YES;
is shift @{ $fieldDescription->[0] }, 'metadata';
is shift @{ $fieldDescription->[0] }, YES;
is shift @{ $fieldDescription->[0] }, '[X3DMetadataObject]';

ok $fieldDescription = Weed::Parse::FieldDescription::parse '
SFBool [in,out]  f1 TRUE
SFFloat [in,out] f2 2 

# comment

SFDouble [in,out] f3 3
# comment
# comment
SFString [in,out] f4 "4"
';
ok @$fieldDescription;
is shift @{ $fieldDescription->[0] }, 'SFBool';
is shift @{ $fieldDescription->[1] }, 'SFFloat';
is shift @{ $fieldDescription->[2] }, 'SFDouble';
is shift @{ $fieldDescription->[3] }, 'SFString';

1;
__END__

