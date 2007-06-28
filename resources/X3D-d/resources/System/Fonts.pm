package System::Fonts;
use strict;

use File::Basename;
use Array;

# Font Converter
my $unixfont = "/usr/sbin/unixfont";
my $ttf2pt1 = "/usr/freeware/bin/ttf2pt1";
my $t1asm = "/usr/freeware/bin/t1asm";

my $makepsres = "/usr/bin/X11/makepsres";
my $type1xfonts = "/usr/bin/X11/type1xfonts";

my $ps2ascii = "/usr/freeware/bin/ps2ascii";

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = {};
	bless $this, $class;

	my $args = args @_;
	$this->debug($args->{debug});
	$this->path($args->{path} || "$ENV{HOME}/fonts") if $ENV{USER} ne 'root';
	$this->root('/usr/lib/DPS') if $ENV{USER} eq 'root';
	$this->foundry($args->{foundry});
	return $this;
}

sub path {
	my $this = shift;
	if (@_) {
		$this->_mkdir($this->{path} = shift);
		print "fonts path set to $this->{path}\n" if $this->{debug};
	
		$this->_mkdir($this->{tmp} = "$this->{path}/tmp");
		$this->_mkdir($this->{mac_fonts_path} = "$this->{path}/mac");
		$this->_mkdir($this->{pc_fonts_path} = "$this->{path}/ttf");

		$this->_mkdir($this->{dps_path} = "$this->{path}/dps");
		$this->_mkdir($this->{afm_path} = "$this->{path}/dps/afm");
		$this->_mkdir($this->{type1_path} = "$this->{path}/dps/type1");

		$this->_mkdir($this->{xfonts_path} = "$this->{path}/x-fonts");

		$this->_mkdir($this->{catalogs_path} = "$this->{path}/catalogs");
	}
	return $this->{path};
}

sub root {
	my $this = shift;
	if (@_) {
		$this->{path} = '/usr/lib/DPS';
		print "fonts path set to $this->{path}\n" if $this->{debug};
	
		$this->_mkdir($this->{tmp} = "$this->{path}/tmp");
		$this->{mac_fonts_path} = "$this->{path}/mac";
		$this->{pc_fonts_path} = "$this->{path}/pc";

		$this->{dps_path} = "$this->{path}";
		$this->{afm_path} = "$this->{path}/AFM";
		$this->{type1_path} = "$this->{path}/outline";

		$this->{xfonts_path} = "/usr/lib/X11/fonts";

		$this->{catalogs_path} = "$this->{path}/catalogs";
	}
	return $this->{path};
}

sub _mkdir {
	my $this = shift;
	my $path = shift;
	($this->{debug} && print "  creating $path\n") if mkdir "$path", 0777;
	return;
}

sub foundry {
	my $this = shift;
	$this->{foundry} = shift if @_;
	return $this->{foundry};
}

sub convert_mac_fonts {
	my $this = shift;
	print "converting mac fonts\n" if $this->{debug};
	foreach (@{$this->mac_fonts}) {
		my $font = $this->convert_mac_font($_);
	}
	return;
}

sub mac_fonts {
	my $this = shift;
	$this->{mac_fonts} = [$this->_scandir($this->{mac_fonts_path})];
	return $this->{mac_fonts};
}

sub _scandir {
	my $this = shift;
	my $path = shift;
	print "  scanning $path\n" if $this->{debug};

	opendir DIR, $path;
	my @files = sort grep {!/^\./} readdir DIR;
	closedir DIR;

	@files = map { my $d = $_; -d "$path/$_" ? map {"$d/$_"} $this->_scandir("$path/$_") : $_ } @files;

	print "    ".scalar(@files)." files found\n" if $this->{debug};
	return @files;
}

sub convert_mac_font {
	my $this = shift;
	my $font = shift;

	my $fontdir = dirname($font);
	my $fontbase = $font;
	$fontbase = basename($fontbase);
	return if -e "$this->{type1_path}/$fontbase";

	print "  converting $font\n" if $this->{debug}>1;
	my $status = system "$unixfont '$this->{mac_fonts_path}/$font' >'$this->{tmp}/$fontbase' 2>/dev/null";
	unlink "core";

	my $new_font;
	if ($status || -z "$this->{tmp}/$fontbase") {
		print "    failed (unixfont error) could not convert font $font\n" if $this->{debug}>1;
		unlink "$this->{tmp}/$font";
		$font = '';
	} else {
		$new_font = $this->_rename($this->{tmp}, $fontbase);
		system "mv \"$this->{mac_fonts_path}/$font\" \"$this->{mac_fonts_path}/$fontdir/$new_font\"" if $fontbase && $fontbase ne $new_font;
	}
	return $new_font;
}

sub convert_pc_fonts {
	my $this = shift;
	print "converting pc fonts\n" if $this->{debug};
	foreach (@{$this->pc_fonts}) {
		my $font = $this->convert_pc_font($_);
	}
	return;
}

sub pc_fonts {
	my $this = shift;
	$this->{pc_fonts} = [$this->_scandir($this->{pc_fonts_path})];
	return $this->{pc_fonts};
}

sub convert_pc_font {
	my $this = shift;
	my $font = shift;

	my $fontdir = dirname($font);
	my $fontbase = $font; $fontbase =~ s/\.ttf//i;
	$fontbase = basename($fontbase);
	return if -e "$this->{type1_path}/$fontbase";

	print "  converting $font\n" if $this->{debug}>1;	

	my $status = system "$ttf2pt1 '$this->{pc_fonts_path}/$font' - 2>/dev/null | $t1asm >'$this->{tmp}/$fontbase' 2>/dev/null";
	unlink "core";

	my $new_font;
	if ($status || -z "$this->{tmp}/$fontbase") {
		print "    failed (ttf2pt1 | t1asm  error) could not convert font $font\n" if $this->{debug}>1;
		unlink "$this->{tmp}/$fontbase";
	} else {
		#my $ffile = "$this->{tmp}/$fontbase";
		#my $f = `cat $ffile`;
		#$f =~ s/^.*?%!PS/%!PS/s;
		#$f =~ s/([^\w])*$/{restore}if\n/s;

		#open FONT, ">$ffile";
		#print FONT $f;
		#close FONT;


		$new_font = $this->_rename($this->{tmp}, $fontbase);
		system "mv \"$this->{pc_fonts_path}/$font\" \"$this->{pc_fonts_path}/$fontdir/$new_font.ttf\"" if $fontbase && $fontbase ne $new_font;

	}
	return $new_font;
}

sub _rename {
	my $this = shift;
	my $path = shift;
	my $font = shift;

	my $new = `grep /FontName "$path/$font"`;
	$new =~ /\/FontName\s*\/(.*?)\s*def/; $new = $1;
	if ($font ne $new) {
		print "    renaming to $new\n" if $this->{debug}>1;
		unlink "$path/$new";
		system "mv \"$path/$font\" \"$path/$new\"";
		$font = $new;
	}

	return $font;
}

sub update_dps {
	my $this = shift;
	print "update dps\n" if $this->{debug};

	return unless $this->_update_type1;
	return unless $this->_update_DPSFontsUPR;
	return 1;
}

sub _update_type1 {
	my $this = shift;
	print "  moving fonts to type1\n" if $this->{debug};
	my $status = system "mv '$this->{tmp}/'* '$this->{type1_path}'";
	if ($status) {
		print "  failed (mv) could not move $this->{tmp}/* to $this->{type1_path}\n" if $this->{debug};
		return 1;
	}
	return 1;
}

sub _update_DPSFontsUPR {
	my $this = shift;
	print "  update DPSFonts.upr\n" if $this->{debug};
	unlink "$this->{dps_path}/DPSFonts.upr";			
	my $status = system "$makepsres -o '$this->{dps_path}/DPSFonts.upr' '$this->{type1_path}'";
	if ($status) {
		print "  failed (makepsres) could not update $this->{dps_path}/DPSFonts.upr\n" if $this->{debug};
		return;
	}
	return 1;
}

sub update_xfonts {
	my $this = shift;
	print "update x-fonts\n" if $this->{debug};

	return unless $this->_update_ps2xlfd_map;
	return unless $this->_update_foundry;
	return 1;
}

sub _update_ps2xlfd_map {
	my $this = shift;
	print "  update ps2xlfd_map\n" if $this->{debug};

	my $db = $this->read_catalog_db;

	my @map;
	foreach (@{$this->_type1}) {
		my $font = $this->_read_font_info($_);
		my $name = $font->{fullname};

		if (exists $db->{$name}) {
			foreach (@{$db->{$name}}) {
				$font->{foundry} = "$this->{foundry} $_";
				my $xfontname = $this->_xfontname($font);
				push @map, "$font->{name} $xfontname\n";
			}
			next;
		}

		$name =~ tr/-/ /; 
		if (exists $db->{$name}) {
			foreach (@{$db->{$name}}) {
				$font->{foundry} = "$this->{foundry} $_";
				my $xfontname = $this->_xfontname($font);
				push @map, "$font->{name} $xfontname\n";
			}
			next;
		}

		my $xfontname = $this->_xfontname($font);
		push @map, "$font->{name} $xfontname\n";
	}

	open MAP, ">$this->{xfonts_path}/ps2xlfd_map.$this->{foundry}";
	print MAP @map;
	close MAP;

	return 1;
}

sub _type1 {
	my $this = shift;
	print "    scanning $this->{dps_path}/DPSFonts.upr\n" if $this->{debug};

	my $outlinefonts = `cat '$this->{dps_path}/DPSFonts.upr'`;
	$outlinefonts =~ /FontOutline.*?FontOutline\n(.*?)\n\./sgo;
	$outlinefonts = $1;
	my @outlinefonts = map { my @v = split '='; "$this->{type1_path}/".$v[1] } split "\n", $outlinefonts;
	print "      ".scalar(@outlinefonts)." outline fonts found\n" if $this->{debug};

	return [@outlinefonts];
}

sub _xfontname {
	my $this = shift;
	my $font = shift;
	return "-$font->{foundry}-$font->{familyname}-$font->{weight}-$font->{slant}-$font->{setweight}-$font->{addstyle}-0-0-0-0-$font->{spacing}-0-$font->{registry}-$font->{encoding}";
}

sub _read_font_info {
	my $this = shift;
	my $path = shift;

	my $font = {};
	$font->{path} = $path;
	
	my $file = `cat '$font->{path}'`;

	$font->{foundry} = $this->{foundry};
	$font->{name} = $1          if $file =~ /\/FontName\s*\/(.*?)\s+def/s;
	$font->{fullname} = $1      if $file =~ /\/FullName\s+\((.*?)\)\s+/s;
	$font->{familyname} = $1    if $file =~ /\/FamilyName\s+\((.*?)\)\s+/s;
	$font->{weight} = lc $1     if $file =~ /\/Weight\s+\((.*?)\)\s+/s;
	$font->{italicAngle} = 0+$1 if $file =~ /\/ItalicAngle\s+([+-\.\d]+)\s+def/s;
	$font->{isFixedPitch} = $1	if $file =~ /\/isFixedPitch\s+(true|false)\s+def/s;
	$font->{psencoding} = $1    if $file =~ /\/Encoding\s+(.*?)\s+(def|array)/s;
	$font->{slant} = 'r';
	$font->{setweight} = 'normal';
	$font->{spacing} = $font->{isFixedPitch} eq 'true' ? 'm' : 'p';
	$font->{registry} = 'iso8859';
	$font->{encoding} = '1';
	$font->{addstyle} = '';

	$font->{weight} = 'medium' if $font->{weight} =~ /regular/i;

	$font->{slant} = 'i' if $font->{italicAngle};
	$font->{slant} = 'o' if $font->{name} =~ /Oblique/i;

	$font->{setweight} = 'sans'          if $font->{name} =~ /Sans/i;
	$font->{setweight} = 'narrow'        if $font->{name} =~ /Narrow/i;
	$font->{setweight} = 'condensed'     if $font->{name} =~ /Condensed/i;
	$font->{setweight} = 'semicondensed' if $font->{name} =~ /SemiCondensed/i;
	$font->{setweight} = 'titling'       if $font->{name} =~ /Titling/i;

	if ($font->{psencoding} eq '256') {
		$font->{registry} = 'adobe';
		$font->{encoding} = 'fontspecific';
	}

	return $font;
}

sub _update_foundry {
	my $this = shift;
	print "  update foundry $this->{foundry}\n" if $this->{debug};

	$this->_mkdir("$this->{xfonts_path}/$this->{foundry}");
	system "$type1xfonts ".($this->{debug}>1?'-v':'')." -t '$this->{type1_path}' -x '$this->{xfonts_path}/$this->{foundry}' -m '$this->{xfonts_path}/ps2xlfd_map.$this->{foundry}'";

	return 1;
}

sub scan_catalogs {
	my $this = shift;
	print "scaning catalogs\n" if $this->{debug};
	my $fonts;
	foreach (@{$this->catalogs}) {
		my @fonts = $this->_scan_catalog($_);

		my $catalog = $_;
		$catalog =~ s/(\.pdf)?$//;
		$catalog =~ tr/-_/ /;
		foreach (@fonts) {
			push @{$fonts->{$_}}, $catalog;
		}
	}

	$this->write_catalog_db($fonts);
	return $fonts;
}

sub catalogs {
	my $this = shift;
	$this->{catalogs} = [$this->_scandir($this->{catalogs_path})];
	return $this->{catalogs};
}

sub _scan_catalog {
	my $this = shift;
	my $catalog = shift;
	$catalog =~ s/(\.pdf)?$//;
	
	print "  scaning catalog $catalog\n" if $this->{debug};

	my $text = `$ps2ascii '$this->{catalogs_path}/$catalog.pdf'`;

	my @fonts;
	push @fonts, $1 while $text =~ s/^[\s\n]*(.*?)\n.*?\014//s;

	print "    ".scalar(@fonts)." fonts found\n" if $this->{debug};

	return @fonts;
}

sub write_catalog_db {
	my $this = shift;
	my $fonts = shift;
	my $name = shift || 'catalogs';
	open FILE, ">$this->{catalogs_path}/$name.txt";
	foreach (sort keys %{$fonts}) {
		print FILE "$_\n";
		foreach (sort @{$fonts->{$_}}) {
			print FILE "  $_\n";
		}
	}
	close FILE;
	return 1;
}

sub read_catalog_db {
	my $this = shift;
	my $fonts;
	my $name;
	
	open FILE, "$this->{catalogs_path}/catalogs.txt";
	while (<FILE>) {
		$name = $1 if /^([^\s].*?)\n/;
		push @{$fonts->{$name}}, $1 if /^\s\s(.*?)\n/;
	}
	close FILE;
	
	return $fonts;
}

sub create_showcasefont_map {
	my $this = shift;
	print "  update showcasefont_map\n" if $this->{debug};

	my $db = $this->read_catalog_db;

	my @map;
	foreach (@{$this->_type1}) {
		my $font = $this->_read_font_info($_);
	}

	open MAP, ">$this->{tmp}/showcasefont_map";
	print MAP @map;
	close MAP;

	return 1;
}

sub debug {
	my $this = shift;
	$this->{debug} = shift || 0 if @_;
	print "\ndebug set to $this->{debug}\n" if $this->{debug};
	return $this->{debug};
}

sub DESTROY {
	my $this = shift;
	print "done...\n" if $this->{debug};
	0;
}

sub xset_fp {
	my $this = shift;
	system "xset fp default";
	system "xset +fp '$this->{xfonts_path}/$this->{foundry}'";
	return;
}

1;

=head1 NAME

Default - provide 

=cut

__END__
