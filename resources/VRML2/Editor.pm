package VRML2::Editor;

BEGIN {
	use strict;
	use Carp;
	#use Gnome;

	use VRML2;
	use VRML2::Editor::Outliner;
	use VRML2::Editor::Layout;
	use VRML2::Editor::FileSelection;

	use vars qw(@ISA $VERSION);
	@ISA     = qw(Gnome::App);
	$VERSION = 0.01;
}

my $Title = "VrmlEditor";
#my $Pixmaps = "/usr/people/holger/perl/VRML2/Editor/pixmaps";

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = $class->SUPER::new(__PACKAGE__, $Title);
	bless $this, $class;
	
    $this->{fileImport} = new VRML2::Editor::FileSelection('Import File',  sub { $this->fileImport(@_) });
    $this->{fileSaveAs} = new VRML2::Editor::FileSelection('Save As File', sub { $this->fileSaveAs(@_) });

	$this->init_menu;
	$this->init_contents;


	$this->signal_connect(destroy => sub { $this->fileQuit } );
	$this->show;

	return $this;
}

sub init_menu {
	my $this = shift;
	$this->SUPER::create_menus(
		{type => 'subtree', label => '_File', subtree => [
			['item', '_New',    undef, sub { $this->fileNew }],
			['separator'],
			['item', '_Import', undef, sub { $this->fileImport }],
			['separator'],
			['item', '_SaveAs', undef, sub { $this->fileSaveAs }],
			['separator'],
			['item', '_Quit',   undef, sub { $this->fileQuit }],
		]},
		{type => 'subtree', label => '_Edit', subtree => [
			['item', '_Delete', undef, sub { $this->editDelete }],
			['separator'],
			['item', '_Deteach From Group', undef, sub { $this->deteachFromGroup }],
			['item', '_Create Parent Group', undef, sub { $this->editCreateParentGroup }],
		]},
	);
}

sub init_contents {
	my $this = shift;

    my $hbox = new Gtk::HPaned(); 
	$hbox->show;
	$this->set_contents($hbox);

	#$this->{layout} = new VRML2::Editor::Layout();
	#$this->{layout}->show;
	#$hbox->add($this->{layout});

	$this->{outliner} = new VRML2::Editor::Outliner();
	$this->{outliner}->show;
	$hbox->add($this->{outliner});

}

sub fileNew {
	my $this = shift;
	$this->{outliner}->replaceWorld(new MFNode());
}

sub fileImport {
	my $this = shift;
	my $file = shift;

	#print __PACKAGE__, "::fileImport $file\n";

	if ($file) {
		my $children = Browser->createVrmlFromURL($file);
		Browser->addToSceneGraph($children);
		$this->{outliner}->addToSceneGraph($children);
	} else {
		$this->{fileImport}->show;
	}
}

sub fileSaveAs {
	my $this = shift;
	my $file = shift;

	#print __PACKAGE__, "::fileSaveAs $file\n";

	if ($file) {
		open FILE, ">$file";
		print FILE Browser;
		close FILE;
	} else {
		$this->{fileSaveAs}->show;
	}
}

sub fileQuit {
	my $this = shift;
	Gtk->main_quit;
}

sub editDelete {
	my $this = shift;
	$this->{outliner}->deleteNode;
}

sub deteachFromGroup {
	my $this = shift;
	$this->{outliner}->createParentGroup;
}

sub editCreateParentGroup {
	my $this = shift;
	$this->{outliner}->createParentGroup;
}

1;


__END__
