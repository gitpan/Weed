# Specification of the External Interface for a VRML browser.
package VRML::Browser;
require 5.005;
use strict;
use Carp;

use LWP::Simple;

use VRML::BuiltIns;
use VRML::Constants;
use VRML::Parse;
use VRML::Generator qw($STYLE $MFIELD_BREAK $BREAK $SPACE $INDENT_SIZE);

use PML::File;
use Array;

my $BROWSERNAME = 'VRML::Browser by HO';
my $VERSION     = 0.1;

use overload
	'bool' => \&bool,
	'""'   => \&toString;

use AutoLoader;
use vars qw($AUTOLOAD);
sub AUTOLOAD {
	my $this = shift;
	my $name = $AUTOLOAD;  $name =~ s/.*:://;

	return $this->getProto($name);
}

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = {};
	bless $this, $class;

	my $args = args @_;

	$this->{name} = $BROWSERNAME;
	$this->{version} = $VERSION;

	$this->{doc_root} = argv $args->{doc_root};
	$this->{root}     = argv $args->{root};
	#$this->outputStyle(exists $args->{outputStyle} ? $args->{outputStyle} : 'compact');

	$this->{sceneGraph} = new MFNode;
	$this->clearScene;

	$this->_parse_built_in($self);

	if (exists $args->{string}) {
		my $vrml = $this->createVrmlFromString(@{argv $args->{string}});
		$this->addToSceneGraph(@{$vrml});
	}

	if (exists $args->{filename}) {
		my $vrml = $this->createVrmlFromFile(@{argv $args->{filename}});
		$this->addToSceneGraph(@{$vrml});
	}

	$this->outputStyle('compact');
	return $this;
}

sub _parse_built_in {
	my $this = shift;
	my $self = shift;

	if (ref $self) {
		$this->{built_in}  = $self->{built_in};
		$this->{built_ins} = $self->{built_ins};
	} else {
		my $parse = new VRML::Parse($this);
		$parse->vrmlSyntax($_) foreach @BUILT_INS;
	
		$this->{built_in}  = $parse->{proto};
		$this->{built_ins} = $parse->{protos};
	
		$this->{parseError} = $parse->error;
	}
	return 1;
}


# Get the "name" and "version" of the VRML browser (browser-specific)
sub getName {
	my $this = shift;
	return $this->{name};
}

sub getVersion {
	my $this = shift;
	return $this->{version};
}

# Get the current velocity of the bound viewpoint in meters/sec,
# if available, or 0.0 if not
sub getCurrentSpeed {
	my $this = shift;
	return 0.0;
}

# Get the current frame rate of the browser, or 0.0 if not available
sub getCurrentFrameRate {
	my $this = shift;
	return 0.0;
}

# Get the URL for the root of the current world, or an empty string
# if not available
sub getWorldURL {
	my $this = shift;
	return $this->{worldURL};
}

# Get the URL for the root of the current world, or an empty string
# if not available
sub setWorldURL {
	my $this = shift;
	return $this->{worldURL} = shift;
}

# Replace the current world with the passed array of nodes
sub replaceWorld {
	my $this  = shift;
	my $nodes = shift;
	return;
}

# Load the given URL with the passed parameters (as described
# in the Anchor node)
sub loadURL {
	my $this      = shift;
	my $url       = shift;
	my $parameter = shift;

	$this->clearScene;
	my $nodes = $this->createVrmlFromURL($url);
	unless (@{$this->{parseError}}) {
		$this->addToSceneGraph(@{$nodes});
		$this->setWorldURL($url);
	}
	return $nodes;
}

sub clearScene {
	my $this  = shift;

	$this->{encoding} = 'utf8';
	$this->{comment}  = '';

	@{$this->{sceneGraph}} = ();

	%{$this->{proto}}  = ();
	@{$this->{protos}} = ();
	%{$this->{node}}   = ();
	%{$this->{nodes}}  = ();
	%{$this->{route}}  = ();
	@{$this->{routes}} = ();

	$this->{description} = [];

	$this->{worldURL} = '';

	$this->{parseError} = [];
	return;
}


# Set the description of the current world in a browser-specific
# manner. To clear the description, pass an empty string as argument
sub setDescription {
	my $this = shift;
	return $this->{description} = shift;
}

sub description {
	my $this = shift;
	$this->{description} = shift if @_;
	return $this->{description};
}

# Parse STRING into a VRML scene and return the list of root
# nodes for the resulting scene
sub createVrmlFromString {
	my $this = shift;
	return unless @_;

	my $vrmlSyntax = join '', @_;

	my $parse = new VRML::Parse($this);
	my $nodes = $parse->vrmlSyntax($vrmlSyntax);
	$this->{parseError} = $parse->error;
	$this->_parseIntoScene($parse) unless @{$this->{parseError}};

	return new MFNode(map {ref $_ eq "SFNode" ? $_ : new SFNode($_) } @{$nodes});
}

sub _parseIntoScene {
	my $this  = shift;
	my $parse = shift;

	$this->{proto} = { %{ $this->{proto} }, %{ $parse->{proto} } };
	push @{ $this->{protos} }, @{ $parse->{protos} };

	foreach my $name (keys %{$parse->{node}}) {
		$parse->{node}->{$name}->setName($this->uniqueName($name));
		$this->{node}->{$parse->{node}->{$name}->getName} = $parse->{node}->{$name};
	}
	$this->{nodes} = { %{ $this->{nodes} }, %{ $parse->{nodes}  } };

	push @{ $this->{routes} }, @{ $parse->{routes} };

	$this->{encoding} = $parse->{encoding} unless $this->{encoding};
	$this->{comment}  = $parse->{comment}  unless $this->{comment};

	return;
}

# Tells the browser to load a VRML scene from the passed URL or
# URLs. After the scene is loaded, an event is sent to the MFNode
# eventIn in node NODE named by the EVENT argument
sub createVrmlFromURL {
	my $this  = shift;
	my $url   = shift;
	$url =~ s/^file://;

	my $vrmlSyntax = get("$url") || $this->fetchFile("$url");

	carp "VRML::Browser::createVrmlFromURL\ncould not fetch url $url\n" unless defined $vrmlSyntax;

	return $this->createVrmlFromString($vrmlSyntax);
}

# Tells the browser to load a VRML scene from the passed FILE or
# FILEs. Parse FILE into a VRML scene and return the list of root
# nodes for the resulting scene
sub createVrmlFromFile {
	my $this = shift;
	my $vrmlSyntax;

	foreach (@_) {
		$vrmlSyntax .= $this->fetchFile("$_");
		$this->setWorldURL($_);
	}
	return $this->createVrmlFromString($vrmlSyntax);
}

sub fetchFile {
	my $this = shift;
	my $file = shift;
	$file = new PML::File($file);
	
	my $vrmlSyntax;
	$vrmlSyntax = $file->gzcat
		if $file->filetype eq "VRML Data File (Compressed)";
	$vrmlSyntax = $file->fetch unless $vrmlSyntax;

	if (defined $vrmlSyntax) {
		return $vrmlSyntax;
	} else {
		carp "VRML::Browser\nCould not fetch file $file\n";
	}
}

# Get a DEFed node by name. Nodes given names in the root scene
# graph must be made available to this method. DEFed nodes in inlines,
# as well as DEFed nodes returned from createVrmlFromString/URL, may
# or may not be made available to this method, depending on the
# browser's implementation
sub getNode {
	my $this = shift;
	my $name = shift;
	return $this->{node}->{$name} if $name;
}

sub getNodes {
	my $this = shift;
	my $type = shift;
	return $this->{nodes}->{$type} if exists $this->{nodes}->{$type};
}

# Add and delete, respectively, a route between the specified eventOut
sub addRoute {
	my $this         = shift;
	my $fromNode     = shift;
	my $fromEventOut = shift;
	my $toNode       = shift;
	my $toEventIn    = shift;
	return;
}

sub deleteRoute {
	my $this         = shift;
	my $fromNode     = shift;
	my $fromEventOut = shift;
	my $toNode       = shift;
	my $toEventIn    = shift;
	return;
}

# Get built-in Protos
sub built_ins {
	my $this = shift;
	return @{ $this->{built_ins} };
}

# Get a PROTO node by name. PROTOs given names in the root scene
# graph must be made available to this method. PROTO nodes in inlines,
# as well as PROTO nodes returned from createVrmlFromString/URL, may
# or may not be made available to this method, depending on the
# browser's implementation
sub getProto {
	my $this = shift;
	my $name = shift || return;
	return $this->{built_in}->{$name} if exists $this->{built_in}->{$name};
	return $this->{proto}->{$name} if exists $this->{proto}->{$name};
}

sub getProtos {
	my $this = shift;
	return wantarry ? @{ $this->{protos} } : $this->{protos};
}

sub removeProto {
	my $this = shift;
	my $name = shift || return;
	
	my $i = array_index($this->{protos}, $this->{proto}->{$name});
	splice @{$this->{protos}}, $i, 1
		if $i > -1;
	delete $this->{proto}->{$name}
		if exists $this->{proto}->{$name};
}

sub getSceneGraph {
	my $this = shift;
	return @{ $this->{sceneGraph} };
}

sub addToSceneGraph {
	my $this  = shift;
	my @nodes = map {
		ref $_ eq "ARRAY" ?
		@{$_} :
		(ref $_ eq "MFNode" ?
			@{$_->getValue} :			
			$_
		)
	} @_;

	push @{ $this->{sceneGraph} }, @nodes;
	return @nodes;
}

sub sceneGraph {
	my $this = shift;
	@{ $this->{sceneGraph} } = @_ if @_;
	return $this->{sceneGraph};
}

sub uniqueName {
	my $this = shift;
	my $name = shift || '';
	return $name unless exists $this->{node}->{$name};
	my $i = 0;
	$name =~ s/_\d*$//;
	++$i while exists $this->{node}->{"$name\_$i"};
	return "$name\_$i";
}

sub parseError {
	my $this = shift;
	return wantarray ? @{$this->{parseError}} : $this->{parseError};
}

sub outputStyle {
	my $this  = shift;
	my $style = shift || 'tidy';
	&VRML::Generator::initialize;
	if ($style eq 'compact') {
		$STYLE = $style;
		$MFIELD_BREAK = '';
	} elsif ($style eq 'clean') {
		$STYLE = $style;
		$BREAK = $SPACE;
		$INDENT_SIZE  = 0;
		$MFIELD_BREAK = '';
	}
	&VRML::Generator::strict;
	return $style;
}

sub save {
	my $this = shift;
	my $fn   = shift || $this->getWorldURL;
	if ($fn) {
		if (open FILE, ">$fn") {
			$this->setWorldURL($fn);
			print FILE $this;
			close FILE;
			return 1;
		}
	}
}

sub compressed {
	my $this = shift;
	my $args = args @_;
	unless (exists $args->{filename}){
		$args->{filename} = "/tmp/$$";
		$this->save(filename => $args->{filename});
	}

	return `/usr/sbin/gzip -fc < $args->{filename}`;
}

sub mime_type {
	my $this = shift;
	VRML::Constants::mime_type;
}

sub header {
	my $this = shift;
	$this->{comment} =~ /CosmoWorlds/ ? VRML::Constants::cosmo_header : VRML::Constants::header;
}

sub tail {
	my $this = shift;
	return "\n#";
}

sub bool { 1 }

sub toString {
	my $this = shift;
	#print STDERR $this->{name}, "\n";

	$this->outputStyle($this->outputStyle);

	return $this->header.join('',
			@{ $this->{protos} },
			@{ $this->{sceneGraph} },
			@{ $this->{routes} },
		);
}

1;
__END__
