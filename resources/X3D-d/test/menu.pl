$vbox->pack_start( $this->get_menubar, FALSE, FALSE, 0 );

sub on_close {
	my ( $this, $action ) = @_;
	X3DError::Debug time;

	$this->getWidget->get_parent_window->hide;

	$this->exitTime(time);
	$this->processEvents;

	1;
}

sub get_menubar {
	my ($this) = @_;

	my @menu_entries = (
		#Fields for each action item:
		#[name, stock_id, value, label, accelerator, tooltip, callback]

		#file menus
		[ "EditMenu", undef, "_Edit" ],
		[ "Close", 'gtk-close', "_Close", "<control>W", "Close", sub { $this->on_close(@_) } ],

	);

	my $uimanager = Gtk2::UIManager->new;
	my $accelgroup = $uimanager->get_accel_group;
	#$window->add_accel_group($accelgroup);
	my $actions_basic = Gtk2::ActionGroup->new("actions_basic");
	$actions_basic->add_actions( \@menu_entries, undef );
	$uimanager->insert_action_group( $actions_basic, 0 );

	$uimanager->add_ui_from_string(join '', <DATA>);
	return $uimanager->get_widget('/MenuBar');
}

<ui>
  <menubar name='MenuBar'>
	 <menu action='EditMenu'> 
	   <menuitem action='Close'/>
	 </menu>
  </menubar>
</ui>


