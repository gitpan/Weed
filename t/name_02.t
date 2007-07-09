#!/usr/bin/perl -w
#package name_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'Weed';
}

print int( {} );

my $name  = new X3DName("name");
my $name1 = new X3DName("name");
my $name2 = new X3DName("name");
my $eman  = new X3DName("eman");

is "$name",  "name_".$name->getId;
is "$name1", "name_".$name1->getId;
is "$name2", "name_".$name2->getId;

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

is "$name",  "name_".$name->getId;
is "$name1", "name_".$name1->getId;
is "$name2", "name_".$name2->getId;

is int($name), 3;
is int $name,  3;
is int $name1, 3;
is int $name2, 3;

$name1 = new X3DName("name");

is int($name), 3;
ok int($name) == int($name1);
ok int($name) == int($name2);
ok int($name1) == int($name2);
ok int($eman) != int($name2);

#print X3DName->DumpHash;
$name1 = undef;

is int($name), 2;
ok int($name) == int($name2);


$name2 = undef;

is int($name), 1;

$name->setValue("name");
is int($name), 1;

$name->setValue("name_234");
is int($name), 1;

$name->setValue("name__234");
is $name, "name__".$name->getId;
is int($name), 1;

$name = undef;
$eman = undef;

#print X3DName->DumpHash;


1;
__END__
