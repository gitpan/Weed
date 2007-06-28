package X3D::Gtk2::TreeView;
use strict;
use warnings;

use Gtk2;
use Glib qw(TRUE FALSE);
use Carp qw(croak);

use X3D::Gtk2::TreeModel;
use X3D::Gtk2::CellRendererNode;
use X3D::Gtk2::CellRendererField;

use Glib::Object::Subclass Gtk2::TreeView::,;

#
# this is called everytime a new custom list object
# instance is created (we do that in new).
# Initialise the list structure's fields here.
#

sub INIT_INSTANCE {
	my ($this) = @_;

	$this->modify_base( 'normal', Gtk2::Gdk::Color->parse("#edebec") );

	my $model = new X3D::Gtk2::TreeModel;
	$this->set_model($model);

	#
	# Hide default expander
# 	{
# 		my $column = new Gtk2::TreeViewColumn;
# 		$column->set_visible(FALSE);
# 		$this->append_column($column);
# 		$this->set_expander_column($column);
# 	}

	#
	# Nodes
	{
		my $column = new Gtk2::TreeViewColumn;
		$column->set_title("Nodes");
		$this->append_column($column);

		my $nodeRenderer = new X3D::Gtk2::CellRendererNode;
		#$renderer->signal_connect( edited => \&on_name_edited, $model );
		#$renderer->set( editable => TRUE );
		$column->pack_start( $nodeRenderer, TRUE );
		$column->add_attribute( $nodeRenderer, visible => &X3D::Gtk2::TreeModel::COL_IS_NODE );
		$column->add_attribute( $nodeRenderer, node    => &X3D::Gtk2::TreeModel::COL_NODE );

		my $fieldRenderer = new X3D::Gtk2::CellRendererField;
		$column->pack_start( $fieldRenderer, TRUE );
		$column->add_attribute( $fieldRenderer,
			visible => &X3D::Gtk2::TreeModel::COL_IS_FIELD );
		$column->add_attribute( $fieldRenderer, field => &X3D::Gtk2::TreeModel::COL_FIELD );
	}

	#
	# Routes
	{
		my $column = new Gtk2::TreeViewColumn;
		$column->set_title("Routes");
		$this->append_column($column);

		my $renderer = new Gtk2::CellRendererText;
		$column->pack_start( $renderer, TRUE );
		$column->add_attribute( $renderer, text => &X3D::Gtk2::TreeModel::COL_ROUTE );
	}

}

&register_icons;

sub register_icon {
	my ( $stock_id, $path ) = @_;
	$path = "/home/holger/Desktop/holger/perl/X3D/Gtk2/$path";

	my $icon;
	eval { $icon = Gtk2::Gdk::Pixbuf->new_from_file($path) };
	if ($@) {
		croak("Unable to load icon at '$path': $@");
	}

	Gtk2::IconTheme->add_builtin_icon( $stock_id, 12, $icon );
}

sub register_icons {

	register_icon( 'X3DProto', 'pixmaps/X3DProto.xpm' );
	register_icon( 'X3DNode',  'pixmaps/X3DNode.xpm' );

	register_icon( 'MFBool',      'pixmaps/MFBool.xpm' );
	register_icon( 'MFColorRGBA', 'pixmaps/MFColorRGBA.xpm' );
	register_icon( 'MFColor',     'pixmaps/MFColor.xpm' );
	register_icon( 'MFDouble',    'pixmaps/MFDouble.xpm' );
	register_icon( 'MFFloat',     'pixmaps/MFFloat.xpm' );
	register_icon( 'MFImage',     'pixmaps/MFImage.xpm' );
	register_icon( 'MFInt32',     'pixmaps/MFInt32.xpm' );
	register_icon( 'MFNode',      'pixmaps/MFNode.xpm' );
	register_icon( 'MFRotation',  'pixmaps/MFRotation.xpm' );
	register_icon( 'MFString',    'pixmaps/MFString.xpm' );
	register_icon( 'MFTime',      'pixmaps/MFTime.xpm' );
	register_icon( 'MFVec2d',     'pixmaps/MFVec2d.xpm' );
	register_icon( 'MFVec2f',     'pixmaps/MFVec2f.xpm' );
	register_icon( 'MFVec3d',     'pixmaps/MFVec3d.xpm' );
	register_icon( 'MFVec3f',     'pixmaps/MFVec3f.xpm' );

	register_icon( 'SFBool',      'pixmaps/SFBool.xpm' );
	register_icon( 'SFColorRGBA', 'pixmaps/SFColorRGBA.xpm' );
	register_icon( 'SFColor',     'pixmaps/SFColor.xpm' );
	register_icon( 'SFDouble',    'pixmaps/SFDouble.xpm' );
	register_icon( 'SFFloat',     'pixmaps/SFFloat.xpm' );
	register_icon( 'SFImage',     'pixmaps/SFImage.xpm' );
	register_icon( 'SFInt32',     'pixmaps/SFInt32.xpm' );
	register_icon( 'SFNode',      'pixmaps/SFNode.xpm' );
	register_icon( 'SFRotation',  'pixmaps/SFRotation.xpm' );
	register_icon( 'SFString',    'pixmaps/SFString.xpm' );
	register_icon( 'SFTime',      'pixmaps/SFTime.xpm' );
	register_icon( 'SFVec2d',     'pixmaps/SFVec2d.xpm' );
	register_icon( 'SFVec2f',     'pixmaps/SFVec2f.xpm' );
	register_icon( 'SFVec3d',     'pixmaps/SFVec3d.xpm' );
	register_icon( 'SFVec3f',     'pixmaps/SFVec3f.xpm' );

}

1;
__END__
sub on_name_edited {
	my ( $cell, $pathstring, $newtext, $model ) = @_;
	my $path = Gtk2::TreePath->new_from_string($pathstring);
	my $iter = $model->get_iter($path);
	$model->set( $iter, &X3DGtk2TreeModel::COL_NAME, $newtext );
}

