package VRML::YAODL;
require 5.005;
use strict;
use Carp;

use Exporter;
use vars qw(@ISA @EXPORT);
@ISA = qw(Exporter);
@EXPORT = qw(vrml2yaodl);

use PML;

sub vrml2yaodl {
	my $vrml = shift;
	return "#YAODL\n\n" . Nodes($vrml) . "\n";
}

sub Nodes {
	my $vrml = shift;
	my @yaodl;

	foreach my $node (@{$vrml}) {
		my $type = $node->getType;
		print STDERR "$type\n";
		(push(@yaodl, Group($node)), 			next)	if $type eq "Group";
		(push(@yaodl, Transform($node)),		next)	if $type eq "Transform";
		(push(@yaodl, Shape($node)), 			next)	if $type eq "Shape";
	}

	return join "\n", @yaodl;
}


sub Group {
	my $node = shift;
	my $nodes = Nodes($node->children);
	return $nodes ? "(group\n$nodes\n)," : "";
}


sub Transform {
	my $node = shift;
	my $nodes = Nodes($node->children);
	return $nodes ? "(group
(group $nodes),
:
(translates " . (sprintf "%01.8f %01.8f %01.8f", $node->translation->x, $node->translation->y, $node->translation->z) . "),
(rotates " . (sprintf "%01.8f %01.8f %01.8f %01.8f", -$node->rotation->angle_degrees, $node->rotation->x, $node->rotation->z, $node->rotation->y) . "),
(scales " . (sprintf "%01.8f %01.8f %01.8f", $node->scale->x, $node->scale->y, $node->scale->z) . "),
)," : "";
}

sub Shape {
	my $shape = shift;
	return Geometry($shape->geometry, $shape->appearance);
}

sub Geometry {
	my $geometry   = shift;
	my $appearance = shift;
	return "" unless $geometry;
	print STDERR $geometry->getType, "\n";

	return (
		$geometry->getType =~ /Indexed/ ? Indexed($geometry, $appearance) :
		""
	)
}

sub Indexed {
	my $geometry = shift;
	my $appearance = shift;

	my $vertices = "";
	foreach my $point (@{$geometry->coord->point}) {
		$vertices .= sprintf "%01.8f %01.8f %01.8f\t", $point->x, $point->y, $point->z;
	}

	my $indices = "";
	foreach my $index (@{$geometry->coordIndex}) {
		$indices .= $index == -1 ? "," : " $index";
	}
	$indices =~ s/,$//;

	my $normals = "";
	if ($geometry->normal) {
		foreach my $normal (@{$geometry->normal->vector}) {
			$normals  .= sprintf "%01.8f %01.8f %01.8f\t", $normal->x, $normal->y, $normal->z;
		}
	}

	my $texCoord = "";
	if ($geometry->texCoordIndex) {
		foreach my $index (@{$geometry->texCoordIndex}) {
			$texCoord .= $index == -1 ? "\t" : (sprintf "%01.8f %01.8f ", $geometry->texCoord->point->[$index]->x, $geometry->texCoord->point->[$index]->y);
		}
	}

	my $url = $appearance->texture ? $appearance->texture->url->[0] : "";
	$url =~ s/file://;
	$url = "$ENV{PWD}/$url" if $url && $url !~ /^\//;

	return "
(indexpolygons
	(vertices $vertices
	" . ($normals && $geometry->normalPerVertex ? ":\n" : "") . "
	" . ($normals && $geometry->normalPerVertex ? "(normals $normals)," : "") . "
	),
	(indices $indices),
	" . ($normals && !$geometry->normalPerVertex || $url ? ":\n" : "") . "
	" . ($normals && !$geometry->normalPerVertex ? "(normals $normals)," : "") . "
	" . ($url ? "(textures \"$url\"),
	(sContours \"spheremap\", \"object\"),
	(tContours \"spheremap\", \"object\"),
	" : "") . "
),
";
}

1;
__END__
