#!/usr/bin/perl -w
#package name_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

my $n = 10;

foreach ( 1 .. $n ) {
	ok !( my $name = new X3DName );
	is $name->getValue, "";
	is $name, "_" . $name->getId;
}

foreach ( 1 .. $n ) {
	ok !( my $name = new X3DName );
	is $name->getValue, "";
	is $name, "_" . $name->getId;

	ok !( my $name1 = new X3DName );
	is $name1->getValue, "";
	is $name1, "_" . $name1->getId;

	is $name, "_" . $name->getId;

	ok $name == $name;
	ok $name == $name1;
	ok $name eq $name;
	is $name eq $name1, NO;
	ok $name ne $name1;
}

foreach ( 1 .. $n ) {
	ok !( my $name = new X3DName("") );
	is $name->getValue, "";
	is $name, "_" . $name->getId;
}

foreach ( 1 .. $n ) {
	ok !( my $name = new X3DName("") );
	is $name->getValue, "";
	is $name, "_" . $name->getId;

	ok !( my $name1 = new X3DName("") );
	is $name1->getValue, "";
	is $name1, "_" . $name1->getId;

	is $name, "_" . $name->getId;

	ok $name == $name;
	ok $name == $name1;
	ok $name eq $name;
	is $name eq $name1, NO;
	ok $name ne $name1;
}

foreach ( 1 .. $n ) {
	ok my $name = new X3DName("name");
	is $name->getValue, "name";
	is $name, "name_".$name->getId;
}

foreach ( 1 .. $n ) {
	ok my $name = new X3DName("name");
	is $name->getValue, "name";
	is $name, "name_" . $name->getId;

	ok my $name1 = new X3DName("name");
	is $name1->getValue, "name";
	is $name1, "name_" . $name1->getId;

	is $name, "name_" . $name->getId;

	ok $name == $name;
	ok $name == $name1;
	ok $name eq $name;
	is $name eq $name1, NO;
	ok $name ne $name1;
}

foreach ( 1 .. $n ) {
	ok my $name = new X3DName("name");
	is $name->getValue, "name";
	is $name, "name_" . $name->getId;

	ok my $name1 = new X3DName("name");
	is $name1->getValue, "name";
	is $name1, "name_" . $name1->getId;

	ok my $name2 = new X3DName("name");
	is $name2->getValue, "name";
	is $name2, "name_" . $name2->getId;

	is $name1, "name_" . $name1->getId;
	is $name,  "name_" . $name->getId;

	ok $name == $name;
	ok $name == $name1;
	ok $name == $name2;
	ok $name eq $name;
	is $name eq $name1, NO;
	is $name eq $name2, NO;
	ok $name ne $name1;
	ok $name ne $name2;
}

foreach ( 1 .. 10 ) {
	my $name  = new X3DName("name");
	my $name1 = new X3DName("name");
	my $name2 = new X3DName("name");
}

foreach ( 1 .. 1 ) {
	my @names;
	foreach ( 1 .. 10 ) {
		push @names, new X3DName("name");
	}
}

my $name  = new X3DName("name");
my $name1 = new X3DName("name");
my $name2 = new X3DName("name");
my $eman  = new X3DName("eman");

is $name,  "name_" . $name->getId;
is $name1, "name_" . $name1->getId;
is $name2, "name_" . $name2->getId;

ok $name != $eman;
ok $name != $eman;
ok $name != $eman;

ok $name ne $eman;
ok $name ne $eman;
ok $name ne $eman;

ok $name == $name;
ok $name == $name1;
ok $name == $name2;
ok $name eq $name;
is $name eq $name1, NO;
is $name eq $name2, NO;
ok $name ne $name1;
ok $name ne $name2;

foreach ( 1 .. $n ) {
	ok my $name = new X3DName("name");
	is $name->getValue, "name";
	ok $name == $name1;
	ok $name == $name2;
	ok $name ne $name1;
	ok $name ne $name2;
	ok $name != $eman;
	ok $name ne $eman;
}

ok $name == $name;
ok $name == $name1;
ok $name == $name2;
ok $name eq $name;
is $name eq $name1, NO;
is $name eq $name2, NO;
ok $name ne $name1;
ok $name ne $name2;

1;
__END__
