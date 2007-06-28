package VRML2::Browser;
use strict;

BEGIN {
	use Carp;
	use Exporter;

	use VRML2::Parser;
	use VRML2::Parser::Symbols qw($_header);

	use VRML2::standard;
	use VRML2::FieldTypes;

	use VRML2::Route;

	use VRML2::VrmlScript;

	use VRML2::Generator;

	use VRML2::Console;

	use vars qw(@ISA @EXPORT);
	@ISA = qw(Exporter);

	@EXPORT = qw(
		TRUE FALSE
		parseInt parseFloat
		NULL
		$Header
	);

}

our $DEBUG = 0;

my $Header = "#VRML V2.0 utf8";

use overload
	'""'   => \&toString;

sub new {
	print CONSOLE "\n" if $DEBUG;
	print CONSOLE "VRML2::Browser::new\n" if $DEBUG;
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = {
		comment      => '',
		standard     => {},
		cosmoworlds  => {},
		protosByName => {},
		protos       => [],
		nodesById    => {},
		nodesByName  => {},
		nodesByType  => {},
		sceneGraph   => new MFNode,
		routes       => [],
	};
	bless $this, $class;


	$this->{parser} = new VRML2::Parser($this);

	$this->_parse_standard($self);

	return $this;
}

sub _parse_standard {
	#print CONSOLE "VRML2::Browser::_parse_standard\n";
	my $this = shift;
	my $self = shift;

	if (ref $self) {
		$this->{standard} = $self->{standard};
	} else {
		print CONSOLE "\n" if $DEBUG;
		print CONSOLE "VRML2::Browser::_parse_standard VRML97\n" if $DEBUG;
		$this->{parser}->parse($this, $VRML97);
		$this->addError($this->{parser}->getError);
		$this->{standard} = $this->{parser}->getProtosByName;
		#print CONSOLE map {$_,"\n"} keys %{$this->{standard}};

		print CONSOLE "VRML2::Browser::_parse_standard COSMOWORLDS\n" if $DEBUG;
		$this->{parser}->setComment("CosmoWorlds V1.0");
		$this->{parser}->parse($this, $COSMOWORLDS);
		$this->addError($this->{parser}->getError);
		$this->{cosmoworlds} = $this->{parser}->getProtosByName;
		#print CONSOLE map {$_,"\n"} keys %{$this->{cosmoworlds}};

		print CONSOLE "VRML2::Browser::_parse_standard done\n" if $DEBUG;
	}
	return;
}

# Replace the current world with the passed list of nodes.
sub replaceWorld {
	my $this = shift;
	my $nodes = shift;

	foreach (@{$this->{sceneGraph}}) {
		$this->deleteNode($_);
	}

	@{$this->{sceneGraph}} = @{$nodes};
}


# Parse STRING into a VRML scene and return the list of root
# nodes for the resulting scene
sub createVrmlFromString {
	my $this = shift;
	my $vrmlSyntax = shift;
	return unless $vrmlSyntax;

	print CONSOLE "\n" if $DEBUG;
	print CONSOLE "VRML2::Browser::createVrmlFromString\n" if $DEBUG;

	$this->{parser}->setComment($this->{comment});
	my $vrmlScene = $this->{parser}->parse($this, $vrmlSyntax);
	$this->addError($this->{parser}->getError);

	print CONSOLE "VRML2::Browser::createVrmlFromString done\n" if $DEBUG;
	print CONSOLE "\n" if $DEBUG;

	# copy protos
	push @{$this->{protos}}, grep { ! exists $this->{protosByName}->{$_->getName} } @{$this->{parser}->getProtos};
	%{$this->{protosByName}} = (%{$this->{protosByName}}, %{$this->{parser}->getProtosByName});

	# loadExternprotos
	#$this->loadExternprotos($this->{parser}->getProtos);
	
	# copy routes
	my @routes  = grep {ref $_ eq 'VRML2::Route'} @{$vrmlScene};
	push @{$this->{routes}}, @routes;

	# add routes
	print CONSOLE "\n" if $DEBUG;
	print CONSOLE "VRML2::Browser::addRoutes\n" if $DEBUG;
	foreach (@routes) { $_->addRoute; }
	print CONSOLE "VRML2::Browser::addRoutes done\n" if $DEBUG;
	print CONSOLE "\n" if $DEBUG;

	return new MFNode(grep {ref $_ eq 'SFNode'} @{$vrmlScene});
}


# Tells the browser to load a VRML scene from the passed URL or
# URLs. After the scene is loaded, an event is sent to the MFNode
# eventIn in node NODE named by the EVENT argument
sub createVrmlFromURL {
	my $this = shift;
	my $url  = shift;
	#print CONSOLE "VRML2::Browser::createVrmlFromURL $url\n";

	$url =~ s/^file://;

	my $vrmlSyntax = $this->fetchFile($url);

	carp "VRML2::Browser::createVrmlFromURL\ncould not fetch url $url\n" unless defined $vrmlSyntax;

	return $this->createVrmlFromString($vrmlSyntax);
}

sub fetchFile {
	#print CONSOLE "VRML2::Browser::fetchFile\n";
	my $this = shift;
	my $file = shift;
	$file = new SFFile($file);
	
	my $vrmlSyntax;
	if (-e $file) {
		#print CONSOLE "VRML2::Browser::fetchFile ", $file->filetype, "\n";
		$vrmlSyntax = $file->gzcat
			if $file->filetype eq "VrmlCompressed";
		$vrmlSyntax = $file->get unless $vrmlSyntax;
	}

	if ($vrmlSyntax =~ m/$_header/gc) {
		$this->{encoding} = $1 || '';
		$this->{comment}  = $3 || '' unless $this->{comment};
	} else {
		carp "VRML2::Browser::createVrmlFromURL\nFile does not have a valid header string\n";
	}

	if (defined $vrmlSyntax) {
		return $vrmlSyntax;
	} else {
		carp "VRML2::Browser::fetchFile\nCould not fetch file $file\n";
	}
}

sub loadExternprotos {
	print CONSOLE "\n" if $DEBUG;
	print CONSOLE "VRML2::Browser::loadExternProtos\n" if $DEBUG;
	my $this   = shift;
	my $protos = shift;

	foreach my $externproto (@{$protos}) {
		if (ref $externproto->getURL) {

			my $vrmlSyntax;
			foreach (@{$externproto->getURL}) {
				$vrmlSyntax = $this->fetchFile($_->getValue);
				last if $vrmlSyntax;
			}

			if ($vrmlSyntax) {
				#print CONSOLE "VRML2::Browser::loadProtos ", $externproto->getName,"\n";
				my $vrmlScene = $this->{parser}->parse($this, $vrmlSyntax);

				$this->addError($this->{parser}->getError);

				if (exists $this->{parser}->getProtosByName->{$externproto->getName}) {
					my $proto = $this->{parser}->getProtosByName->{$externproto->getName};

					$externproto->setInterface($proto->getInterface);
					$externproto->setBody($proto->getBody);
				}
			}
		}
	}
	print CONSOLE "VRML2::Browser::loadExternProtos done\n" if $DEBUG;
	print CONSOLE "\n" if $DEBUG;
}

sub addToSceneGraph {
	#print CONSOLE "VRML2::Browser::addToSceneGraph\n";
	my $this   = shift;
	my $nodes = shift;

	push @{$this->{sceneGraph}}, @{$nodes};
}

sub getSceneGraph {
	#print CONSOLE "VRML2::Browser::getSceneGraph\n";
	my $this = shift;
	$this->{sceneGraph};
}

#sub addProto {
#	my $this  = shift;
#	my $proto = shift;
#	#print CONSOLE "VRML2::Browser::addProto ".$proto->getName."\n";
#	$this->{_protos}->{$proto->getName} = $proto;
#}


sub getProto {
	my $this = shift;
	my $name = shift;
	#print CONSOLE "VRML2::Browser::getProto $name\n";

	if (exists $this->{standard}->{$name}) {
		#print CONSOLE "VRML2::Browser::getProto standard\n";
		return $this->{standard}->{$name};
	}

	if ($this->{comment} =~ /$_CosmoWorlds/) {
		if (exists $this->{cosmoworlds}->{$name}) {
			#print CONSOLE "VRML2::Browser::getProto cosmoworlds\n";
			return $this->{cosmoworlds}->{$name};
		}
	}

	if (exists $this->{protosByName}->{$name}) {
		#print CONSOLE "VRML2::Browser::getProto protos\n";
		return $this->{protosByName}->{$name};
	}

	#print CONSOLE "VRML2::Browser::getProto undef\n";
	return;
}

sub addNode {
	my $this = shift;
	my $node = shift;
	#print CONSOLE "VRML2::Browser::addNode ", ref $node, "\n";

	$this->{nodesById}->{$node->getId} = $node;

	my $type = $node->getType;
	if ($type) {
		$this->{nodesByType}->{$type}->{$node->getId} = $node;
	}

	my $name = $node->getName;
	if ($name) {
		$this->{nodesByName}->{$name} = $node;
	}
}

sub getNodeByName {
	my $this = shift;
	my $name = shift;

	if (exists $this->{nodesByName}->{$name}) {
		#print CONSOLE "VRML2::Browser::getNodeByName $name\n";
		return $this->{nodesByName}->{$name};
	}
	
	#print CONSOLE "VRML2::Browser::getNodeByName undef\n";
	return;
}

sub getNodeById {
	my $this = shift;
	my $id   = shift;

	if (exists $this->{nodesById}->{$id}) {
		#print CONSOLE "VRML2::Proto::getNodeById $name\n";
		return $this->{nodesById}->{$id};
	}
	
	#print CONSOLE "VRML2::Proto::getNodeById undef\n";
	return;
}

sub deleteNode {
	my $this = shift;
	my $node = shift;

	#print CONSOLE "VRML2::Browser::removeNode ", ref $node, "\n";

	# delete Routes
	if ($node->getName) {
		my $name = $node->getName;
		foreach (grep { $_->getToNode->getName eq $name } @{$this->{routes}}) {
			$_->deleteRoute;
		}
		@{$this->{routes}} = grep {
			$_->getFromNode->getName ne $name &&
			$_->getToNode->getName ne $name
		} @{$this->{routes}};
	}

	# delete sub Nodes
	if (ref $node->getBody) {
		foreach (@{$node->getBody}) {
			if ($_->getType eq "SFNode" && ref $_->getValue) {
				$this->deleteNode($_->getValue);
			} elsif ($_->getType eq "MFNode" && ref $_->getValue) {
				foreach (@{$_->getValue}) {
					 $this->deleteNode($_)
				}
				@{$_->getValue} = ();
			}
		}
	}

	if (exists $this->{nodesById}->{$node->getId}) {
		delete $this->{nodesById}->{$node->getId};
	}

	my $type = $node->getType;
	if ($type) {
		if (exists $this->{nodesByType}->{$type}->{$node->getId}) {
			delete $this->{nodesByType}->{$type}->{$node->getId};
			unless (%{$this->{nodesByType}->{$type}}) {
				delete $this->{protosByName}->{$type};
			}
		}
	}

	my $name = $node->getName;
	if ($name) {
		if (exists $this->{nodesByName}->{$name}) {
			delete $this->{nodesByName}->{$name};
		}
	}

	$node->remove;
}

sub addRoute {
	my $this  = shift;

	#print CONSOLE "VRML2::Browser::addRoute \n";

	my $fromNode   = shift;
	my $eventOutId = shift;
	my $toNode     = shift;
	my $eventInId  = shift;

	my $route = new VRML2::Route($fromNode, $eventOutId, $toNode, $eventInId);
	push @{$this->{routes}}, $route;
	
	return $route;
}

sub setError {
	my $this = shift;
	$this->{error} = shift;
}

sub addError {
	my $this = shift;
	$this->{error} .= shift;
}

sub getError {
	my $this = shift;
	return $this->{error};
}

sub parseError {
	my $this = shift;
	return $this->{error};
}

sub setComment {
	my $this = shift;
	$this->{comment} = shift;
}

sub getComment {
	my $this = shift;
	return $this->{comment};
}

sub header {
	my $this = shift;
	my $header =  '';
	$header .= $Header;
	$header .= " $this->{comment}" if $this->{comment};
	$header .= "\n";
}

sub toString {
	my $this = shift;

	return join $BREAK,
		$this->header,
		(grep { $this->{nodesByType}->{$_->getName} || !$_->getURL } @{ $this->{protos} }),
		@{ $this->{sceneGraph} },
		"",
		@{ $this->{routes} },
		""
	;
}

1;
__END__
