#!perl -w -I "~holger/perl"
use strict;
use warnings;

use X3D;
use X3D::Components::Core;

my $node = new X3DNode("meineNode");
my $metadataDouble = new MetadataDouble("meineNode");

printf "%s\n", $node;
printf "%s\n", $metadataDouble;
printf "%s\n", new MetadataFloat;
printf "%s\n", new MetadataInteger;
printf "%s\n", new MetadataSet;
printf "%s\n", new MetadataString;


printf "0 == %s\n", $node == $metadataDouble;
printf "1 != %s\n", $node != $metadataDouble;

printf "1 == %s\n", $node == $node;
printf "0 != %s\n", $node != $node;

printf "0 == %s\n", new SFNode($node) == new SFNode($metadataDouble);
printf "1 != %s\n", new SFNode($node) != new SFNode($metadataDouble);

printf "1 == %s\n", new SFNode($node) == new SFNode($node);
printf "0 != %s\n", new SFNode($node) != new SFNode($node);

my $s1;
my $s2;

{
$s1 = new SFNode(new MetadataDouble("meineNode"));
$s2 = new SFNode($s1->getValue);
}
printf "2 == %s\n", $s1->getReferenceCount;

my $mfnode = new MFNode($s1,$s2);
printf "%s\n", ref $mfnode->[0];
printf "%s\n", ref $mfnode->[0]->getValue;

printf "4 == %s\n", $s1->getReferenceCount;

push @$mfnode, $s1, $s2;
printf "%s\n", ref $mfnode->[2];
printf "%s\n", ref $mfnode->[2]->getValue;

printf "1 == %s\n", $mfnode->[0] == $mfnode->[2];
printf "1 == %s\n", $mfnode->[0] == $mfnode->[1];

my $node2 =  $s1->getValue;

printf "7 == %s\n", $s1->getReferenceCount;
printf "7 == %s\n", $s2->getReferenceCount;
printf "7 == %s\n", $s1->getReferenceCount;
printf "7 == %s\n", $s2->getReferenceCount;

printf "%s\n", $node2->getType;

my $ms = new SFNode(new MetadataString("mS"));
push @$mfnode, $ms;
printf "0 == %s\n", $mfnode->index($s1);
printf "0 == %s\n", $mfnode->index($s2);
printf "4 == %s\n", $mfnode->index($ms);
printf "4 == %s\n", $mfnode->index($ms->copy);

printf "id == %s\n", $ms->getValue->getId;
printf "%s\n", $ms;
printf "%s\n", $ms->copy;
printf "%s\n", $ms->getReferenceCount;

$ms->setValue($node2);
printf "%s\n", $ms->getReferenceCount;
printf "%s\n", $ms->copy;
printf "%s\n", $ms->getReferenceCount;


1;
__END__
