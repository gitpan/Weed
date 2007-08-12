package Weed::FieldDefinition;

our $VERSION = '0.013';

use Weed 'X3DFieldDefinition : X3DObject { }';

use Want      ();
use Sub::Name ();

use overload 'eq' => sub {
	return YES if !defined( $_[0]->getValue ) && !defined( $_[1]->getValue );
	return NO if defined( $_[0]->getValue ) ^ defined( $_[1]->getValue );
	return $_[0]->getValue eq $_[1];
};

sub new {
	my $this = shift->X3DObject::new;
	@$this{qw'type in out name value range'} = @_;
	return $this;
}

sub getType { $_[0]->{type} }

sub isIn { $_[0]->{in} }

sub isOut { $_[0]->{out} }

sub getAccessType { ( $_[0]->{out} << 1 ) | $_[0]->{in} }

sub getName { $_[0]->{name} }

sub getValue { $_[0]->{value} }

sub getRange { $_[0]->{range} }

sub createField {
	my ( $this, $node ) = @_;

	my $field = $this->getType->X3DObject::new;

	$field->getParents->add($node);
	$field->setDefinition($this);

	$field->create;

	return $field;
}

sub createFieldClosure {
	my $this    = shift;
	my $name    = $this->getName;
	my $package = $this->getName;

	return Sub::Name::subname "$package\::$name" => sub  : lvalue {
		#X3DMessage->Debug( $_[0], caller(0) );
		my $this = shift;

		#X3DMessage->DirectOutputIsFALSE, return unless $this->{directOutput};

		if ( Want::want('RVALUE') ) {
			my $field = $this->getField($name);
			Want::rreturn $field if Want::want 'ARRAY';
			Want::rreturn $field->getClone->getValue;
		}

		if ( Want::want('ASSIGN') ) {
			$this->getField($name)->setValue( Want::want('ASSIGN') );
			Want::lnoreturn;
		}

		if ( Want::want('CODE') ) {
			my $value = $this->getField($name)->getClone->getValue;
			return $value;
		}

		return $this->getFields->getField( $name, $this ) if Want::want('REF');

		$this->getFields->getTiedField( $name, $this )    # für: += ++ ...
	  }
}

#	MFNode   [in,out] children       []       [X3DChildNode]
sub toString {
	my ($this) = @_;
	my $type = $this->getType;

	my $string = '';
	$string .= $type;
	$string .= X3DGenerator->space;

	$string .= X3DGenerator->open_bracket;
	$string .= join X3DGenerator->comma, grep { $_ }
	  $this->isIn  && X3DGenerator->in,
	  $this->isOut && X3DGenerator->out;
	$string .= X3DGenerator->close_bracket;

	$string .= X3DGenerator->tidy_space if $this->getAccessType != X3DConstants->inputOutput;
	$string .= join '', map { X3DGenerator->tidy_space x length $_ } grep { $_ }
	  !$this->isIn  && X3DGenerator->in,
	  !$this->isOut && X3DGenerator->out;

	$string .= X3DGenerator->space;
	$string .= $this->getName;

	$string .= X3DGenerator->space;

	my $value = $this->getValue;
	if ( UNIVERSAL::isa( $value, 'X3DArray' ) )
	{
		$string .= @$value ?
		  join X3DGenerator->space, @$value
		  :
		  X3DGenerator->open_bracket . X3DGenerator->close_bracket;
	}
	else {
		if ( $type eq 'SFBool' ) {
			$string .= $value ? X3DGenerator->TRUE : X3DGenerator->FALSE;
		}
		elsif ( $type eq 'SFString' ) {
			$string .= sprintf X3DGenerator->STRING, $value;
		}
		elsif ( $type eq 'SFNode' ) {
			$string .= $value || X3DGenerator->NULL;
		}
		else {
			$string .= $value;
		}
	}

	$string .= X3DGenerator->tab;
	$string .= $this->getRange;

	return $string;
}

1;
__END__
