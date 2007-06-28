package System::PeoplePages::Person;
use strict;
use Array;
use Image;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = {};
	bless $this, $class;

	my $args = args @_;
	$this->path($args->{path});
	$this->key($args->{key}) if exists $args->{key}; 
	return $this;
}

sub path {
	my $this = shift;
	$this->{path} = shift if @_;
	return $this->{path};
}

sub _parse {
	my $this = shift;
	my $key = shift;
	my $value = shift || '';

	$value = $1 if $this->{card} =~ /\Q$key\E:(.*?)\n/;
	my @value = split /[\^]/, "$value";
	$value =~ s/[\^]*//;

	return @value > 1 ? @value : $value;
}

sub parse {
	my $this = shift;
	my $key = shift || '';
	$key =~ tr/ /_/;

	$this->{card}  = -f "$this->{path}/$key" ? `cat '$this->{path}/$key'` : '';
	$this->{card} .= -f "$this->{path}/.$key" ? `cat '$this->{path}/.$key'` : '';

	$this->{key} = $key;
	$this->{name} = $this->_parse('Name');
	$this->{title} = $this->_parse('Title');
	$this->{company} = $this->_parse('Company');
	$this->{division} = $this->_parse('Division');
	$this->{building} = $this->_parse('Building');
	$this->{homepage} = $this->_parse('HomePage');
	$this->{homepage} =~ s/http:\/\///;

	$this->{office} = {
		email => $this->_parse('Office/Email Address'),
		inperson => $this->_parse('Office/InPerson Address'),
		phone => $this->_parse('Office/Phone'),
		fax => $this->_parse('Office/Fax'),
		address => argv $this->_parse('Office/Postal Address'),
	};
	$this->{home} = {
		email => $this->_parse('Home/Email Address'),
		inperson => $this->_parse('Home/InPerson Address'),
		phone => $this->_parse('Home/Phone'),
		fax => $this->_parse('Home/Fax'),
		address => argv $this->_parse('Home/Postal Address'),
	};
	$this->{picture} = "$this->{path}/".$this->_parse('Picture Path');

	$this->{nickname} = $this->_parse('NickName');
	$this->{date_of_birth} = argv ($this->_parse('DateOfBirth'));
	$this->{cellular} = $this->_parse('Cellular');
	$this->{region} = $this->_parse('Region');
	$this->{country} = $this->_parse('Country');
	$this->{comments} = argv $this->_parse('Comments');
	
	$this->{primary_location} = lc $this->_parse('Primary Location', 'office');
	$this->{secondary_location} = $this->{primary_location} eq 'home' ? 'office' : 'home';
	$this->{location} = $this->{primary_location};

	system "rm -r '$this->{path}/images'" if -e "$this->{path}/images";
	$this->{image} = '';
	if (-f $this->{picture}) {
		$this->{image} = "$this->{path}/.$this->{key}.gif";
		if (!-e $this->{image}) {
			my $img = new Image;
			$img->filename($this->{picture});
			$img->fit(20, 20);
			$img->zoom(filename => $this->{image});
		}
	} else {
		$this->{picture} = '';
	}

	return $this->{key};
}

sub key {
	my $this = shift;
	$this->parse(shift) if @_;
	return $this->{key};
}

#### Person Entities

sub name {
	my $this = shift;
	$this->{name} = shift if @_;
	return $this->{name};
}

sub firstname {
	my $this = shift;
	$this->{name} =~ /^\s*([^\s]+)/;
	return $1 || '';
}

sub lastname {
	my $this = shift;
	$this->{name} =~ /([^\s]+\s*$)/;
	return $1 || '';
}

sub title {
	my $this = shift;
	$this->{title} = shift if @_;
	return $this->{title};
}

sub company {
	my $this = shift;
	$this->{company} = shift if @_;
	return $this->{company};
}

sub division {
	my $this = shift;
	$this->{division} = shift if @_;
	return $this->{division};
}

sub building {
	my $this = shift;
	$this->{building} = shift if @_;
	return $this->{building};
}

sub homepage {
	my $this = shift;
	$this->{homepage} = shift if @_;
	return $this->{homepage};
}

sub location {
	my $this = shift;
	$this->{location} = shift if @_;
	return $this->{location};
}

sub primary_location {
	my $this = shift;
	$this->{primary_location} = shift if @_;
	return $this->{primary_location};
}

sub email {
	my $this = shift;
	$this->{$this->{location}}->{email} = shift if @_;
	return $this->{$this->{location}}->{email} || $this->{$this->{primary_location}}->{email} || $this->{$this->{secondary_location}}->{email};
}

sub inperson {
	my $this = shift;
	$this->{$this->{location}}->{inperson} = shift if @_;
	return $this->{$this->{location}}->{inperson} || $this->{$this->{primary_location}}->{inperson} || $this->{$this->{secondary_location}}->{inperson};
}

sub phone {
	my $this = shift;
	$this->{$this->{location}}->{phone} = shift if @_;
	return $this->{$this->{location}}->{phone} || $this->{$this->{primary_location}}->{phone} || $this->{$this->{secondary_location}}->{phone};
}

sub fax {
	my $this = shift;
	$this->{$this->{location}}->{fax} = shift if @_;
	return $this->{$this->{location}}->{fax} || $this->{$this->{primary_location}}->{fax} || $this->{$this->{secondary_location}}->{fax};
}

sub address {
	my $this = shift;
	$this->{$this->{location}}->{address} = argv @_ if @_;
	return join ($;, @{$this->{$this->{location}}->{address} || []})
	 || join ($;, @{$this->{$this->{primary_location}}->{address} || []})
	 || join ($;, @{$this->{$this->{secondary_location}}->{address} || []});
}

sub street {
	my $this = shift;
	my $nl = $;; $; = " ";
	return '' unless $this->address =~ /\s*(.*)\s+[A-Z]{0,2}-?\d+/s; $; = $nl;
	return $1;
}

sub city {
	my $this = shift;
	my $nl = $;; $; = "\n";
	return '' unless $this->address =~ /\n+[^\s]+\s+(.*)\s*$/s; $; = $nl;
	return $1;
}

sub zip {
	my $this = shift;
	my $nl = $;; $; = "\n";
	return '' unless $this->address =~ /\n+([^\s]+)\s+.*\s*$/s; $; = $nl;
	return $1;
}

sub image {
	my $this = shift;
	return $this->{image};
}

# extended

sub nickname {
	my $this = shift;
	$this->{nickname} = shift if @_;
	return $this->{nickname};
}

sub cellular {
	my $this = shift;
	$this->{cellular} = shift if @_;
	return $this->{cellular};
}

sub region {
	my $this = shift;
	$this->{region} = shift if @_;
	return $this->{region};
}

sub country {
	my $this = shift;
	$this->{country} = shift if @_;
	return $this->{country};
}

sub comments {
	my $this = shift;
	$this->{comments} = argv @_ if @_;
	return join $;, @{$this->{comments} || []};
}

sub date_of_birth {
	my $this = shift;
	$this->{date_of_birth} = argv(@_) if @_;
	return $this->{date_of_birth} || ['', '', ''];
}


sub update_key {
	my $this = shift;
	unlink "$this->{path}/$this->{key}";
	unlink "$this->{path}/.$this->{key}";

	my $key = $this->{name}; $key=~ s/^\s//; $key=~ s/\s$//; $key =~ s/\s/_/sg;
	return $this->{key} unless $key;

	my $i = 0;
	$this->{key} = $key;
	$this->{key} = "$key.".++$i while -e "$this->{path}/$this->{key}";

	return $this->{key};
}

sub save {
	my $this = shift;

	return unless $this->update_key;

	open FILE, ">$this->{path}/$this->{key}";
	print FILE "\%Creator:phonebook\n";
	print FILE "Name:$this->{name}\n";
	print FILE "Title:$this->{title}\n";
	print FILE "Company:$this->{company}\n";
	print FILE "Division:$this->{division}\n";
	print FILE "Building:$this->{building}\n";
	print FILE "HomePage:$this->{homepage}\n";
	print FILE "\%LocationList:Office/Home\n";
	print FILE "Primary Location:".ucfirst($this->{primary_location})."\n";
	print FILE "Office/Email Address:$this->{office}->{email}\n";
	print FILE "Office/InPerson Address:$this->{office}->{inperson}\n";
	print FILE "Office/Phone:$this->{office}->{phone}\n";
	print FILE "Office/Fax:$this->{office}->{fax}\n";
	print FILE "Office/Postal Address:".join("^", @{$this->{office}->{address}})."\n";
	print FILE "Home/Email Address:$this->{home}->{email}\n";
	print FILE "Home/InPerson Address:$this->{home}->{inperson}\n";
	print FILE "Home/Phone:$this->{home}->{phone}\n";
	print FILE "Home/Fax:$this->{home}->{fax}\n";
	print FILE "Home/Postal Address:".join("^", @{$this->{home}->{address}})."\n";
	print FILE "Picture Path:$this->{picture}\n" if $this->{picture};
	close FILE;

	open FILE, ">$this->{path}/.$this->{key}";
	print FILE "\%Creator:addressbook\n";
	print FILE "NickName:$this->{nickname}\n";
	print FILE "DateOfBirth:".join("^", @{$this->{date_of_birth}})."\n";
	print FILE "Cellular:$this->{cellular}\n";
	print FILE "Region:$this->{region}\n";
	print FILE "Country:$this->{country}\n";
	print FILE "Comments:".join("^", @{$this->{comments}})."\n";
	close FILE;
	return;
}

1;

=head1 NAME

Person - provides an interface to systems PeoplePages Database

=cut
__END__
