package Weed::Universum;

use Weed '
X3DUniversum : X3DGroupingNode {
  MFNode  [in]     addChildren
  MFNode  [in]     removeChildren
  MFNode  [in,out] children       []       [X3DChildNode]
  SFNode  [in,out] metadata       NULL     [X3DMetadataObject]
  SFVec3f []       bboxCenter     0 0 0    (-\u221e,\u221e)
  SFVec3f []       bboxSize       -1 -1 -1 [0,\u221e) or \u22121 \u22121 \u22121
}
';

sub create {
	my ( $this ) = @_;
	$this->Weed::Package::reverse_call('initialize');
}

sub createBrowser {
	my ($this) = @_;
	my $browser = new X3DBrowser;
	$this->addChildren($browser);
	return $browser;
}

sub getBrowser {
	my ($this) = @_;
	return $this->children ? $this->children->[0] : $this->createBrowser;
}

1;
__END__
