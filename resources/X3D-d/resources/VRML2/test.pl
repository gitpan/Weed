#!/usr/freeware/bin/perl
use lib "/usr/people/holger/perl";

use strict;
use VRML2;

my $v1 = new SFString("A");
my $v2 = new SFString("B");

print $v1 cmp $v2;
print "\n";
print "A" cmp "B";
print "\n";

__END__

sub test {
	my $vrml = Browser->createVrmlFromString("Transform { }");
	Browser->addToSceneGraph($vrml);
	Browser->removeNode($vrml->[0]);
	
	splice @{Browser->getSceneGraph}, 0, 1;
}


&test;
print "done...\n";
#Browser->addToSceneGraph(@{$vrml});
#print Browser;


my $vrml = Browser->createVrmlFromString("
#VRML V2.0 utf8 CosmoWorlds V1.0
DEF _0 Script {
  eventOut     SFFloat  transparency_changed
  field        SFBool   sfboolValue	FALSE
  field        SFFloat  sffloatValue	0
  field        SFString sfstringValue	\"3\"
  field        MFString mfstringValue	[
    \"3\",
    \"3\"
  ]
  url \"vrmlscript:
function initialize () {
	transparency_changed = 0.8;
}
function eventsProcessed () {
	transparency_changed = 0.8;
}
\"
}
");
#my $mf = $vrml->[0]->getField('mfstringValue')->getValue;
#print $mf->getValue;


print ref $vrml->[0]->{body}->[2]->[1]->getField('startTime');
print ref $vrml->[0]->{body}->[2]->[1]->getField('set_startTime');
print ref $vrml->[0]->{body}->[2]->[1]->getField('set_startTime');

my $vrml = Browser->createVrmlFromURL("/usr/people/holger/vrml/test/xxx.wrl");
print map {"$_\n"} @{$vrml};


my $a = new SFVec2f(0, -1);
my $b = new SFVec2f(2, 3);
print $a->getValue, "\n";
print $a, "\n";
print $b, "\n";
print $b->length, "\n";
print $b->normalize->length, "\n";


my $vrml = Browser->createVrmlFromURL("/usr/people/holger/Desktop/solaris4/solaris.wrl");
print $vrml;


print "VRML2::FieldTypes\n";

my $a = new SFInt32(0);
my $b = new SFInt32(1);
my $c = new SFInt32();
$c = $a & $b;

print $a->getValue, "\n";
print $b->getValue, "\n";
print $c->getValue, "\n";

my $c;

$c = new SFInt32(++$a );
$c ++;

print $a->getValue, "\n";
print $b->getValue, "\n";
print $c->getValue, "\n";
