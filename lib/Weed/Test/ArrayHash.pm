package Weed::Test::ArrayHash;

use Weed 'X3DArrayHash <>';

use overload
  #  'bool' => 'length',
  #  'int'  => 'length',
  ;

sub new {
	my $this = shift->NEW;
	#$this->setValue(@_);
	return $this;
}

sub toString {
	my $this = shift;

	return "< >" unless @$this || keys %$this;

	my $string = "";

	$string .= '<';
	$string .= keys %$this ? "\n" : " ";

	if (@$this) {
		$string .= "  " if keys %$this;
		$string .= "[";
		$string .= " ";
		$string .= join ', ', @$this;
		$string .= " ";
		$string .= "]";
		$string .= keys %$this ? "\n" : " ";
	}

	if ( keys %$this ) {
		$string .= "  ";
		$string .= "{";
		$string .= "\n";
		while ( my ( $key, $value ) = each %$this ) {
			$string .= "    ";
			$string .= $key;
			$string .= ' ';
			$string .= '=>';
			$string .= ' ';
			$string .= $value;
			$string .= "\n";
		}
		$string .= "  ";
		$string .= "}";
		$string .= "\n";
	}

	$string .= '>';
	$string .= "\n" if keys %$this;

	return $string;
}

1;
__END__

print X3DArrayHash->X3DPackage::toString;

print new X3DArrayHash;
print new X3DArrayHash;

