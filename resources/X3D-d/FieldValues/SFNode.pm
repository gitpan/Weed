package SFNode;
use strict;
use warnings;

#use AutoSplit; autosplit('SFNode', './auto/', 0, 1, 1);

use rlib "../";

BEGIN {
	our $VERSION = '0.00';

	use DynaLoader;
	our @ISA = qw(DynaLoader);
	sub dl_load_flags { $^O eq 'darwin' ? 0x00 : 0x01 }

	# now load the XS code.
	__PACKAGE__->bootstrap($VERSION);
}

# Preloaded methods go here.

use X3DGenerator;
use X3DError;

use AutoLoader;
our $AUTOLOAD;

sub AUTOLOAD {
	my $this = shift;

	my $node = $this->getValue;
	return warn unless ref $node;

	$X3DNode::AUTOLOAD = $AUTOLOAD;
	return $node->AUTOLOAD(@_);
}

use overload
  "=="   => sub { $_[0]->getValue == $_[1]->getValue },
  "!="   => sub { $_[0]->getValue != $_[1]->getValue },
  "bool" => sub { ref $_[0]->getValue },
  '""' => \&toString,
  ;

sub deepCopy { die "SFNode::deepCopy not implemented yet" }

sub toString {    #X3DError::Debug;
	return $_[0]->getValue || $X3DGenerator::NULL;
}

1;
__END__

use Benchmark qw(timethis);
my $h = {};
my $f = new SFNode($h);
$f->setValue($h);
my $n = new SFNode($h);
printf "%s\n", $f->getReferenceCount;
printf "%s\n", $n == $n;

#my $n = new SFNode(10);

#timethis 4000000,  sub { new SFNode({}) };
#timethis 2000000, sub { $f->setValue({}) };

