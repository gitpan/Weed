package X3DBrowser;
use strict;
use warnings;

use rlib "Components/Core";

use base qw(X3DNode);

use X3DConstants;
use X3DScene;
use X3DParser;
use X3DConsole;

our $FieldDefinitions = [
	new X3DFieldDefinition( initializeOnly, 'name',                new SFString("X3DBrowser") ),
	new X3DFieldDefinition( initializeOnly, 'version',             new SFString("0.01") ),
	new X3DFieldDefinition( outputOnly,     'currentSpeed',        new SFDouble(0) ),
	new X3DFieldDefinition( outputOnly,     'currentFrameRate',    new SFDouble(0) ),
	new X3DFieldDefinition( inputOutput,    'description',         new SFString() ),
	new X3DFieldDefinition( initializeOnly, 'supportedProfiles',   new MFString() ),
	new X3DFieldDefinition( initializeOnly, 'supportedComponents', new MFString() ),
	new X3DFieldDefinition( initializeOnly, 'parser',           NULL, 'X3DParser' ),
	new X3DFieldDefinition( initializeOnly, 'executionContext', NULL, 'X3DExecutionContext' ),
	new X3DFieldDefinition( initializeOnly, 'console',          NULL, 'X3DConsole' ),
	new X3DFieldDefinition( initializeOnly, 'children', new MFNode(), 'X3DNode' ),
];

our $Browser;

sub createBrowser {
	my $self = shift;
	my ( $parameters, $properties ) = @_;
	my $browser = $self->new;
	$browser->call( "setBrowser", $browser );
	$browser->call("initialize");
	return $browser;
}

sub getBrowser {
	my $self = shift;
	my ( $parameters, $properties ) = @_;
	$Browser = $self->createBrowser( $parameters, $properties ) unless ref $Browser;
	return $Browser;
}

sub initialize {
	my ($this) = @_;

	$this->console( $this->createConsole );
	$this->parser( $this->createParser );

	$this->supportedProfiles(
		grep {
			eval { require "X3D/Profiles/$_.pm" }
		  }
		  map {
			s/\.pm//;
			$_
		  }
		  map {
			scandir($_)
		  } grep {
			-d $_
		  } map {
			"$_/X3D/Profiles"
		  } @INC
	);

	$this->supportedComponents(
		grep {
			eval { require "X3D/Components/$_.pm" }
		  }
		  map {
			my $d = $_;
			grep { -d "$d/$_" && -f "$d/$_.pm" } scandir($d)
		  } grep {
			-d $_
		  } map {
			"$_/X3D/Components"
		  } @INC
	);

	$this->{supportedProfiles}   = { map { $_ => 1 } $this->getSupportedProfiles };
	$this->{supportedComponents} = { map { $_ => 1 } $this->getSupportedComponents };

	return;
}

sub createParser {    #X3DError::Debug;
	my ($this) = @_;
	my $parser = new X3DParser;
	$parser->call( "setBrowser", $this );
	$parser->call("initialize");
	return new SFNode($parser);
}

sub createConsole {
	my ($this) = @_;
	my $console = new X3DConsole;
	$console->call( "setBrowser", $this );
	$console->call("initialize");
	return new SFNode($console);
}

sub scandir {
	my ($dir) = @_;
	my @files;
	opendir( DIR, $dir ) || return;
	@files = grep { !/^\./ } readdir(DIR);
	closedir DIR;
	return @files;
}

sub getName             { $_[0]->name->getValue }
sub getVersion          { $_[0]->version->getValue }
sub getCurrentSpeed     { $_[0]->currentSpeed->getValue }
sub getCurrentFrameRate { $_[0]->currentFrameRate->getValue }

sub getSupportedProfiles { $_[0]->supportedProfiles->getValue }

sub getProfile {
	my ( $this, $name ) = @_;
	return $name if exists $this->{supportedProfiles}->{$name};
}

sub getSupportedComponents { $_[0]->supportedComponents->getValue }

sub getComponent {
	my ( $this, $name ) = @_;
	return $name if exists $this->{supportedComponents}->{$name};
}

sub getParser           { $_[0]->parser->getValue }
sub getExecutionContext { $_[0]->executionContext->getValue }
sub currentScene        { $_[0]->executionContext->getValue }

sub createScene {
	my ( $this, $profileDeclaration, $componentDeclaration ) = @_;
	my $scene = new X3DScene;
	$scene->profile($profileDeclaration);
	$scene->components(@$componentDeclaration);
	$scene->call( "setBrowser", $this );
	$scene->call("initialize");
	return $scene;
}

sub replaceWorld {
	my ($this) = @_;
	return;
}

sub importDocument {
	my ($this) = @_;
	return;
}

sub loadURL {
	my ( $this, $url ) = @_;
	return;
}

sub setDescription {
	my ($this) = @_;
	return;
}

sub createX3DFromString {
	my ( $this, $string ) = ( shift, join "", @_ );
	my $scene = $this->getParser->parseString($string);
	return $scene;
}

sub createX3DFromStream {
	my ($this) = @_;
	return;
}

sub createX3DFromURL {
	my ($this) = @_;
	return;
}

#updateControl
sub beginUpdate {
	my ($this) = @_;
	return;
}

sub endUpdate {
	my ($this) = @_;
	return;
}

#registerBrowserInterest
sub addBrowserCallback {
	my ($this) = @_;
	return;
}

sub removeBrowserCallback {
	my ($this) = @_;
	return;
}

sub shareWorld {
	my ($this) = @_;
	return;
}

sub setSharedViewpoint {
	my ($this) = @_;
	return;
}

sub setSharedNavigation {
	my ($this) = @_;
	return;
}

sub getRenderingProperties {
	my ($this) = @_;
	return;
}

sub getBrowserProperties {
	my ($this) = @_;
	return;
}

#changeViewpoint
sub nextViewpoint {
	my ($this) = @_;
	return;
}

sub previousViewpoint {
	my ($this) = @_;
	return;
}

sub firstViewpoint {
	my ($this) = @_;
	return;
}

sub lastViewpoint {
	my ($this) = @_;
	return;
}

#print
sub println {
	my ( $this, $value ) = @_;
	if ( $this->console ) {
		$this->console->getValue->print($value);
		$this->console->getValue->processEvents;
	} else {
		printf "%s\n", $value;
	}
	return;
}

sub print {
	my ( $this, $value ) = @_;
	$this->println($value);
	return;
}

#dispose

1;
__END__
printf "%s\n", __PACKAGE__->new;
