#!perl -w -I "~holger/perl"
use strict;
use warnings;

use X3D;
use X3D::Components::Core;
use Benchmark;

#&test1;# new SFNode(undef)
#&test2;# ReferenceCount
#&test3;# getValue
#&test4; # setValue(getValue)
#&test5; # copy
&test6;    # Node -> Parents

sub test1 {
	my $false = SFNode->new->getValue;

	printf "%s\n", new SFNode($false);
	printf "%s\n", new SFNode(undef);
	printf "%s\n", new SFNode( !1 );
	printf "%s\n", new SFNode();

	my $sfnode;
	timethis( 1_000_000, sub { $sfnode = new SFNode() } );
	timethis( 100_000,   sub { $sfnode = new SFNode( new MetadataSet() ) } );
	timethis( 100_000, sub { $sfnode->setValue( new MetadataSet() ) } );

#timethis 1000000:  4 wallclock secs ( 2.64 usr +  0.01 sys =  2.65 CPU) @ 377358.49/s (n=1000000)
#timethis 100000: 30 wallclock secs (27.22 usr +  0.15 sys = 27.37 CPU) @ 3653.64/s (n=100000)
#timethis 100000: 31 wallclock secs (27.09 usr +  0.13 sys = 27.22 CPU) @ 3673.77/s (n=100000)
}

sub test2 {
	my $ms1 = new MetadataSet();
	my $ms2 = $ms1;

	my $sfnode1 = new SFNode($ms1);
	my $sfnode2 = $sfnode1->copy;
	printf "%s\n",      $sfnode1;
	printf "%s\n",      $sfnode2;
	printf "3 == %s\n", $sfnode1->getReferenceCount;
	printf "3 == %s\n", $sfnode2->getReferenceCount;
	printf "%s\n",      $ms1;
	printf "%s\n",      $ms2;
}

sub test3 {
	my $ms1     = new MetadataSet();
	my $sfnode1 = new SFNode($ms1);
	my $sfnode2 = $sfnode1->copy;
	my $ms2     = $sfnode1->getValue;

	timethis( 1_000_000, sub { $ms2 = $sfnode1->getValue } );
	printf "%s\n",      $sfnode1;
	printf "%s\n",      $sfnode2;
	printf "3 == %s\n", $sfnode1->getReferenceCount;
	printf "3 == %s\n", $sfnode2->getReferenceCount;
	printf "%s\n",      $ms1;
	printf "%s\n",      $ms2;
}

sub test4 {
	my $ms1     = new MetadataSet();
	my $sfnode1 = new SFNode($ms1);
	my $sfnode2 = $sfnode1->copy;
	my $ms2     = $sfnode1->getValue;

	timethis( 1_000_000, sub { $sfnode2->setValue( $sfnode1->getValue ) } );
	printf "%s\n",      $sfnode1;
	printf "%s\n",      $sfnode2;
	printf "3 == %s\n", $sfnode1->getReferenceCount;
	printf "3 == %s\n", $sfnode2->getReferenceCount;
	printf "%s\n",      $ms1;
	printf "%s\n",      $ms2;
}

sub test5 {
	my $ms1     = new MetadataSet();
	my $sfnode1 = new SFNode($ms1);
	my $sfnode2 = $sfnode1->copy;
	my $ms2     = $sfnode1->getValue;

	timethis( 1_000_000, sub { $sfnode2 = $sfnode1->copy } );
	printf "%s\n",      $sfnode1;
	printf "%s\n",      $sfnode2;
	printf "3 == %s\n", $sfnode1->getReferenceCount;
	printf "3 == %s\n", $sfnode2->getReferenceCount;
	printf "%s\n",      $ms1;
	printf "%s\n",      $ms2;
}

sub test6 {
	my $ms1 = new MetadataSet();
	printf "%s\n", $ms1;
	printf "%s\n", @{ $ms1->getParents } ? 1 : 0;

	$ms1->addParent($ms1);
	printf "%s\n", @{ $ms1->getParents } ? 1 : 0;
}

1;
__END__
 
my $h = {};

my $sfnode = new SFNode();
printf "%s\n", $sfnode;
printf "%s\n", defined $sfnode->getValue;
printf "%s\n", $sfnode->getReferenceCount;

#timethis(10000000, sub { $sfnode = new SFNode (undef) });
#timethis(10000000, sub { $sfnode = new SFNode () });

printf "%s\n", $sfnode;
printf "%s\n", $sfnode->getValue;
printf "%s\n", $sfnode->getReferenceCount;

my $ms = new MetadataSet();
$h->{n} = $ms;

printf "%s\n", $sfnode;
printf "3 = %s\n", $sfnode->getReferenceCount;

my $node    = $sfnode->getValue;
printf "4 = %s\n", $sfnode->getReferenceCount;
printf "%s\n", $node;

my $sfnode2 = $sfnode->copy;
$node    = $sfnode->getValue;
printf "5 = %s\n", $sfnode->getReferenceCount;
printf "5 = %s\n", $sfnode2->getReferenceCount;
printf "%s\n", $node;

printf "%s\n", $h->{n};
use Benchmark;
my $v = new SFString (1);
#timethis(1000000, sub { $v = new SFString ( ) });
