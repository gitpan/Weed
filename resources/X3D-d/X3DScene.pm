package X3DScene;
use strict;
use warnings;

#use rlib "./";

use base qw(X3DExecutionContext);

use X3DConstants;

sub initialize {
	my ($this) = @_;
	$this->metadata( $this->createNode("MetadataSet") );
}

sub getMetaData {
	my ($this) = @_;
	return;
}

sub setMetaData {
	my ( $this, $metakey, $metavalue ) = @_;

	my $metadata = $this->createNode("MetadataString");
	$metadata->name($metakey);
	$metadata->value($metavalue);

	push @{ $this->metadata->getValue->value }, $metadata;

	return;
}

#namedNodeHandling
#rootNodeHandling

1;
__END__
printf "%s\n", __PACKAGE__->new;
