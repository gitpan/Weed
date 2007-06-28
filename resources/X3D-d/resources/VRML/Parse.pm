package VRML::Parse;
require 5.005;
use strict;
use Carp;

use VRML::Constants;
use VRML::Field::FieldTypes qw($fieldType);

use VRML::Proto;
use VRML::Node::Node;
use VRML::Node::Script;

use vars qw(@ISA);
use VRML::Parse::Symbols;
@ISA = qw(VRML::Parse::Symbols);

sub new {
	#print STDERR "VRML::Parse::new \$VERBOSE set to $VERBOSE\n";
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = {};
	bless $this, $class;

	$this->{top} = $this;

	$this->{browser} = shift;
	$this->{worldURL} = '';

	$this->{vrmlSyntax} = '';
	$this->{file}       = '';
	$this->{error}      = [];

	$this->{encoding} = 'utf8';
	$this->{comment}  = '';

	$this->{proto}        = {};
	$this->{protos}       = [];

	$this->{node}         = {};
	$this->{nodes}        = {};

	$this->{routes}       = [];

	return $this;
}

sub vrmlSyntax {
	#print STDERR "VRML::Parse::vrmlSyntax\n";
	my $this = shift;
	$this->{vrmlSyntax} = shift;
	$this->{file} = $this->{vrmlSyntax};
	$this->{worldURL} = $this->{browser}->getWorldURL;

	#print STDERR "VRML::Parse::vrmlSyntax from ", $this->{worldURL}, "\n";
	#print STDERR "VRML::Parse::vrmlSyntax FileSize is ", length $this->{vrmlSyntax}, " Bytes \n";

	$this->{error} = [];
	if ($this->{vrmlSyntax} =~ m/^$header/s) {
		$this->{encoding} = $1 || '';
		$this->{comment}  = $3 || '';
	}

	#$this->removeComments;
	$this->comment;
	return $this->vrmlScene;
}

sub error {
	#print STDERR "VRML::Parse::error\n";
	my $this = shift;
	if (@_) {
		push @{$this->{error}}, @_;
		my $line;
		if ($this->{vrmlSyntax} =~ /^$whitespace*(.{0,50})/s) {
			my $some = $1;
			if ($this->{file} =~ /^(.*)\Q$some\E/s) {
				my @line = split "\n", $1;
				$line = @line || 1;
			}
		}
		
		my $error = "";
		$error .= "VRML::Parse read error\n";

		$error .= $this->{error}->[$#{$this->{error}}];
		if ($this->{vrmlSyntax} =~ /^($whitespace*([^\n]*?\n[^\n]*?\n[^\n]*?\n[^\n]*?\n[^\n]*?]*)\n|([^\n]*))/s) {
			$error .= " near >$2";
		}
		$error .= "\n";

		$error .= " Occurred at line $line in ".$this->{worldURL}."\n";

		print $error;
	} else {
		return @{$this->{error}}  ? (wantarray ? @{$this->{error}} : $this->{error}) : [];
	}
}

# General
sub vrmlScene {
	#print STDERR "VRML::Parse::vrmlScene\n";
	my $this = shift;
	my $statements = $this->statements;
	return $statements;
}

sub statements {
	#print STDERR "VRML::Parse::statements\n";
	my $this = shift;
	my $statement = $this->statement;
	my $statements = [];
	while (ref $statement) {
		push @{$statements}, $statement if ref($statement) =~ /^VRML::Node/;
		$statement = $this->statement;
	}
	return $statements;
}

sub statement {
	#print STDERR "VRML::Parse::statement\n";
	my $this = shift;

	my $nodeStatement  = $this->nodeStatement;
	if (ref $nodeStatement) {
		return $nodeStatement;
	}

	my $protoStatement = $this->protoStatement;
	if (ref $protoStatement) {
		return $protoStatement;
	}

	my $routeStatement = $this->routeStatement;
	if (ref $routeStatement) {
		return $routeStatement;
	}
	return;
}

sub nodeStatement {
	#print STDERR "VRML::Parse::nodeStatement\n";
	my $this = shift;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$DEF//s) {
		my $nodeNameId = $this->uniqueName($this->nodeNameId);
		if ($nodeNameId) {
			#print STDERR "VRML::Parse::nodeStatement DEF $nodeNameId\n";
			$this->{top}->{node}->{$nodeNameId} = $this->{vrmlSyntax} =~ /^$whitespace*Script/ ?
				new VRML::Node::Script($nodeNameId):
				new VRML::Node::Node($nodeNameId);

			my $node = $this->node($nodeNameId);
			if (ref $node) {
				%{ $this->{top}->{node}->{$nodeNameId} } = %{ $node };
				push @{$this->{top}->{nodes}->{$this->{top}->{node}->{$nodeNameId}->{proto}->{name}}}, $this->{top}->{node}->{$nodeNameId};
				return $this->{top}->{node}->{$nodeNameId};
			}
		}
	}

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$USE//s) {
		my $nodeNameId = $this->nodeNameId;
		#print STDERR "VRML::Parse::nodeStatement $USE $nodeNameId\n";

		my $clone = $this->{top}->{node}->{$nodeNameId}->clone;
		return $clone;
	}

	my $node = $this->node;
	if (ref $node) {
		push @{$this->{top}->{nodes}->{$node->{proto}->{name}}}, $node;
		return $node; 
	}

	return;
}

sub rootNodeStatement {
	#print STDERR "VRML::Parse::rootNodeStatement\n";
	my $this = shift;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$DEF//s) {
		my $nodeNameId = $this->uniqueName($this->nodeNameId);
		if ($nodeNameId) {
			#print STDERR "VRML::Parse::rootNodeStatement $nodeNameId\n";
			$this->{top}->{node}->{$nodeNameId} = new VRML::Node::Node($nodeNameId);
			my $node = $this->node($nodeNameId);
			if (ref $node) {
				%{ $this->{top}->{node}->{$nodeNameId} } = %{ $node };
				push @{$this->{top}->{nodes}->{$this->{top}->{node}->{$nodeNameId}->{proto}->{name}}}, $this->{top}->{node}->{$nodeNameId};
				return $this->{top}->{node}->{$nodeNameId};
			}
		}
	}

	my $node = $this->node;
	if (ref $node) {
		push @{$this->{top}->{nodes}->{$node->{proto}->{name}}}, $node;
		return $node; 
	}

	return;
}

sub protoStatement {
	#print STDERR "VRML::Parse::protoStatement\n";
	my $this = shift;
	
	my $proto = $this->proto || $this->externproto;
	if (ref $proto) {
		push @{$this->{top}->{protos}}, $proto if !$this->getProto($proto->{name});
		$this->{top}->{proto}->{$proto->{name}} = $proto;
		return $proto;
	}

	return;
}

sub protoStatements {
	#print STDERR "VRML::Parse::protoStatements\n";
	my $this = shift;
	my $protoStatement = $this->protoStatement;
	my $protoStatements = [];
	while (ref $protoStatement) {
		push @{$protoStatements}, $protoStatement;
		$protoStatement = $this->protoStatement;
	}
	return $protoStatements;
}

sub proto {
	#print STDERR "VRML::Parse::proto\n";
	my $this = shift;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$PROTO//s) {
		my $nodeTypeId = $this->nodeTypeId;
		if ($nodeTypeId && $this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket//s) {
			my $interfaceDeclarations = $this->interfaceDeclarations;
			if (@{$interfaceDeclarations} && $this->{vrmlSyntax} =~ s/^$whitespace*$close_bracket$whitespace*$open_brace//s) {
				my $proto = new VRML::Proto($nodeTypeId, $interfaceDeclarations, $this->{browser}, $this->{top});
	
				my $top = $this->{top}; $this->{top} = $proto;
				my $protoBody = $this->protoBody;
				$this->{top} = $top;
	
				if ($this->{vrmlSyntax} =~ s/^$whitespace*$close_brace//s) {
					#print STDERR "VRML::Parse::proto $nodeTypeId\n";
					$proto->{body} = $protoBody;
					return $proto;
				}
			}
		}
	}

	return;
}

sub protoBody {
	#print STDERR "VRML::Parse::protoBody\n";
	my $this = shift;
	my $protoBody;
	$protoBody->{protos}   = $this->protoStatements;
	$protoBody->{rootNode} = $this->rootNodeStatement;
	$protoBody->{nodes}    = $this->statements;
	return $protoBody;
}

sub interfaceDeclarations {
	#print STDERR "VRML::Parse::interfaceDeclarations\n";
	my $this = shift;
	my $interfaceDeclaration = $this->interfaceDeclaration;
	my $interfaceDeclarations = [];
	while (ref $interfaceDeclaration) {
		push @{$interfaceDeclarations}, $interfaceDeclaration;
		$interfaceDeclaration = $this->interfaceDeclaration;
	}
	return $interfaceDeclarations;
}

sub restrictedInterfaceDeclaration {
	#print STDERR "VRML::Parse::restrictedInterfaceDeclaration\n";
	my $this = shift;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$eventIn//s) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $eventInId = $this->eventInId;
			if ($eventInId) {
				#print STDERR "VRML::Parse::restrictedInterfaceDeclaration eventIn $fieldType $eventInId\n";
				return {
					class => $eventIn,
					type  => $fieldType,
					name  => $eventInId
				};
			}
		}
	}

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$eventOut//s) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $eventOutId = $this->eventOutId;
			if ($eventOutId) {
				#print STDERR "VRML::Parse::restrictedInterfaceDeclaration eventOut $fieldType $eventOutId\n";
				return {
					class => $eventOut,
					type  => $fieldType,
					name  => $eventOutId
				};
			}
		}
	}

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$field//s) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $fieldId = $this->fieldId;
			if ($fieldId) {
				my $fieldValue = $this->fieldValue($fieldType);
				if (ref $fieldValue) {
					#print STDERR "VRML::Parse::restrictedInterfaceDeclaration field $fieldType $fieldId $fieldValue\n";
					return {
						class => $field,
						type  => $fieldType,
						name  => $fieldId,
						value => $fieldValue
					};
				}
			}
		}
	}

	return;
}

sub interfaceDeclaration {
	#print STDERR "VRML::Parse::interfaceDeclaration\n";
	my $this = shift;
	
	my $restrictedInterfaceDeclaration = $this->restrictedInterfaceDeclaration;
	return $restrictedInterfaceDeclaration if ref $restrictedInterfaceDeclaration;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$exposedField//s) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $fieldId = $this->fieldId;
			if ($fieldId) {
				my $fieldValue = $this->fieldValue($fieldType);
				if (ref $fieldValue) {
					#print STDERR "VRML::Parse::interfaceDeclaration exposedField $fieldType $fieldId $fieldValue\n";
					return {
						class => $exposedField,
						type  => $fieldType,
						name  => $fieldId,
						value => $fieldValue
					};
				}
			}
		}
	}

	return;
}

sub externproto {
	#print STDERR "VRML::Parse::externproto\n";
	my $this = shift;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$EXTERNPROTO//s) {
		my $nodeTypeId = $this->nodeTypeId;
		if ($nodeTypeId && $this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket//s) {
			my $externInterfaceDeclarations = $this->externInterfaceDeclarations;
			if (@{$externInterfaceDeclarations} && $this->{vrmlSyntax} =~ s/^$whitespace*$close_bracket//s) {
				my $proto = new VRML::Proto($nodeTypeId, $externInterfaceDeclarations, $this->{browser}, $this->{top});
				my $URLList = $this->URLList;
				if ($URLList) {
					$proto->setURL($URLList);
					return $proto;
				}
			}
		}
	}

	return;
}

sub externInterfaceDeclarations {
	#print STDERR "VRML::Parse::externInterfaceDeclarations\n";
	my $this = shift;
	my $externInterfaceDeclaration = $this->externInterfaceDeclaration;
	my $externInterfaceDeclarations = [];
	while (ref $externInterfaceDeclaration) {
		push @{$externInterfaceDeclarations}, $externInterfaceDeclaration;
		$externInterfaceDeclaration = $this->externInterfaceDeclaration;
	}
	return $externInterfaceDeclarations;
}

sub externInterfaceDeclaration {
	#print STDERR "VRML::Parse::externInterfaceDeclaration\n";
	my $this = shift;
	
	if ($this->{vrmlSyntax} =~ s/^$whitespace*$eventIn//s) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $eventInId = $this->eventInId;
			if ($eventInId) {
				#print STDERR "VRML::Parse::externInterfaceDeclaration eventIn $fieldType $eventInId\n";
				return {
					class => $eventIn,
					type  => $fieldType,
					name  => $eventInId
				};
			}
		}
	}

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$eventOut//s) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $eventOutId = $this->eventOutId;
			if ($eventOutId) {
				#print STDERR "VRML::Parse::externInterfaceDeclaration eventOut $fieldType $eventOutId\n";
				return {
					class => $eventOut,
					type  => $fieldType,
					name  => $eventOutId
				};
			}
		}
	}

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$field//s) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $fieldId = $this->fieldId;
			if ($fieldId) {
				#print STDERR "VRML::Parse::externInterfaceDeclaration field $fieldType $fieldId\n";
				return {
					class => $field,
					type  => $fieldType,
					name  => $fieldId
				};
			}
		}
	}

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$exposedField//s) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $fieldId = $this->fieldId;
			if ($fieldId) {
				#print STDERR "VRML::Parse::externInterfaceDeclaration exposedField $fieldType $fieldId\n";
				return {
					class => $exposedField,
					type  => $fieldType,
					name  => $fieldId
				};
			}
		}
	}

	return;
}

sub routeStatement {
	#print STDERR "VRML::Parse::routeStatement\n";
	my $this = shift;
	if ($this->{vrmlSyntax} =~ s/^$whitespace*$ROUTE$whitespace+($Id)$period($Id)$whitespace+$TO$whitespace+($Id)$period($Id)//s) {
		#print STDERR "VRML::Parse::routeStatement $1.$2 TO $3.$4\n";
		push @{$this->{top}->{routes}}, "ROUTE $1.$2 TO $3.$4\n";
		return { fromNode=>$1, eventOut=>$2, toNode=>$3, eventIn=>$4 };
	}
	return;
}

sub URLList {
	#print STDERR "VRML::Parse::URLList\n";
	my $this = shift;
	return $this->mfstringValue;
}

# Nodes
sub node {
	#print STDERR "VRML::Parse::node\n";
	my $this = shift;
	my $name = shift;
	my $body = [];

	if ($this->{vrmlSyntax} =~ s/^$whitespace*($Id)$whitespace*$open_brace//s) {
		my $type = $1;
		my $proto = $this->getProto($type);
		return $this->error("Proto $type not loaded") unless $proto;
		#print STDERR "VRML::Parse::node DEF $name $type\n" && $name;
		#print STDERR "VRML::Parse::node $type\n" && !$name;

		if ($type eq 'Script') {
			$body = $this->scriptBody;
			if ($this->{vrmlSyntax} =~ s/^$whitespace*$close_brace//s) {
				return new VRML::Node::Script($name, $proto, $body, $this->{browser});
			}
		} else {
			my $comment = $this->comment;
			#print STDERR $comment;
			$body = $this->nodeBody($type);
			if ($this->{vrmlSyntax} =~ s/^$whitespace*$close_brace//s) {
				my $node = new VRML::Node::Node($name, $proto, $body, $this->{browser});
				$node->setComment($comment);
				return $node;
			}
		}
	}

	return;
}

sub nodeBody {
	#print STDERR "VRML::Parse::nodeBody\n";
	my $this = shift;
	my $type = shift;
	my $nodeBodyElement = $this->nodeBodyElement($type);
	my $nodeBody = [];
	while (ref $nodeBodyElement) {
		push @{$nodeBody}, $nodeBodyElement if ref $nodeBodyElement eq 'HASH';
		$nodeBodyElement = $this->nodeBodyElement($type);
	}
	return $nodeBody;
}

sub scriptBody {
	#print STDERR "VRML::Parse::scriptBody\n";
	my $this = shift;
	my $scriptBodyElement = $this->scriptBodyElement;
	return unless ref $scriptBodyElement;
	my $scriptBody = [];
	while (ref $scriptBodyElement) {
		push @{$scriptBody}, $scriptBodyElement if ref $scriptBodyElement eq 'HASH';
		$scriptBodyElement = $this->scriptBodyElement;
	}
	return $scriptBody;
}

sub scriptBodyElement {
	#print STDERR "VRML::Parse::scriptBodyElement\n";
	my $this = shift;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*($eventIn|$eventOut|$field)$whitespace+($fieldType)$whitespace+($Id)$whitespace+$IS//s) {
		my $is = $this->Id;
		my $fieldValue = {};
		bless $fieldValue, $2; # yeah, this rocks
		return { 
			class => $1,
			type  => $2,
			name  => $3,
			value => \$this->{top}->{field}->{$is}
		}
	}	

	my $restrictedInterfaceDeclaration = $this->restrictedInterfaceDeclaration;
	return $restrictedInterfaceDeclaration if ref $restrictedInterfaceDeclaration;

	my $nodeBodyElement = $this->nodeBodyElement('Script');
	return $nodeBodyElement if ref $nodeBodyElement;
	
	return;
}

sub nodeBodyElement {
	my $this = shift;
	my $type = shift;
	#print STDERR "VRML::Parse::nodeBodyElement\n";

	my $protoStatement = $this->protoStatement;
	return $protoStatement if ref $protoStatement;

	my $routeStatement = $this->routeStatement;
	return $routeStatement if ref $routeStatement;

	my $fieldId = $this->fieldId;
	return unless $fieldId;
	#print STDERR "VRML::Parse::nodeBodyElement $fieldId\n";

	my $proto = $this->getProto($type);

	return unless ref $proto;
	return unless exists $proto->{field}->{$fieldId};

	my $field = $proto->{field}->{$fieldId};

	if (ref $this->{top} eq 'VRML::Proto' && $this->{vrmlSyntax} =~ s/^$whitespace*$IS//s) {
		my $is = $this->Id;
		return {
			class => $field->{class},
			type  => $field->{type},
			name  => $fieldId,
			value => \$this->{top}->{field}->{$is}
		};
	}

	my $fieldValue = $this->fieldValue($field->{type});
	return unless ref $fieldValue;

	return {
		class => $field->{class},
		type  => $field->{type},
		name  => $fieldId,
		value => $fieldValue
	};
	return;
}

sub nodeNameId {
	#print STDERR "VRML::Parse::nodeNameId\n";
	my $this = shift;
	return $this->Id;
}

sub nodeTypeId {
	#print STDERR "VRML::Parse::nodeTypeId\n";
	my $this = shift;
	return $this->Id;
}

sub fieldId {
	#print STDERR "VRML::Parse::fieldId\n";
	my $this = shift;
	return $this->Id;
}

sub eventInId {
	#print STDERR "VRML::Parse::EventInId\n";
	my $this = shift;
	return $this->Id;
}

sub eventOutId {
	#print STDERR "VRML::Parse::EventOutId\n";
	my $this = shift;
	return $this->Id;
}

sub Id {
	#print STDERR "VRML::Parse::Id\n";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ s/^$whitespace*($Id)//s;
	return;
}

# Fields
sub fieldType {
	#print STDERR "VRML::Parse::fieldType\n";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ s/^$whitespace*($fieldType)//s;
	return;
}

sub fieldValue {
	#print STDERR "VRML::Parse::fieldValue\n";
	my $this = shift;
	my $fieldType = shift;
	if ( index($fieldType, 'SF') == 0 ) {
		return $this->sfboolValue     if $fieldType eq 'SFBool';
		return $this->sfcolorValue    if $fieldType eq 'SFColor';
		return $this->sffloatValue    if $fieldType eq 'SFFloat';
		return $this->sfimageValue    if $fieldType eq 'SFImage';
		return $this->sfint32Value    if $fieldType eq 'SFInt32';
		return $this->sfnodeValue     if $fieldType eq 'SFNode';
		return $this->sfrotationValue if $fieldType eq 'SFRotation';
		return $this->sfstringValue   if $fieldType eq 'SFString';
		return $this->sftimeValue     if $fieldType eq 'SFTime';
		return $this->sfvec2fValue    if $fieldType eq 'SFVec2f';
		return $this->sfvec3fValue    if $fieldType eq 'SFVec3f';
	} else {
		return $this->mfcolorValue    if $fieldType eq 'MFColor';
		return $this->mffloatValue    if $fieldType eq 'MFFloat';
		return $this->mfint32Value    if $fieldType eq 'MFInt32';
		return $this->mfnodeValue     if $fieldType eq 'MFNode';
		return $this->mfrotationValue if $fieldType eq 'MFRotation';
		return $this->mfstringValue   if $fieldType eq 'MFString';
		return $this->mftimeValue     if $fieldType eq 'MFTime';
		return $this->mfvec2fValue    if $fieldType eq 'MFVec2f';
		return $this->mfvec3fValue    if $fieldType eq 'MFVec3f';
	}

	if ($this->{comment} =~ /$CosmoWorlds/) {
		my $version = $1;
		return $this->sfenumValue if $fieldType eq 'SFEnum';
		return $this->mfenumValue if $fieldType eq 'MFEnum';
	}

	return;
}

sub sfboolValue {
	#print STDERR "VRML::Parse::sfboolValue\n";
	my $this = shift;
	return new SFBool(TRUE)  if $this->{vrmlSyntax} =~ s/^$whitespace*$TRUE//s;
	return new SFBool        if $this->{vrmlSyntax} =~ s/^$whitespace*$FALSE//s;
	return;
}

sub sfcolorValue {
	#print STDERR "VRML::Parse::sfcolorValue\n";
	my $this = shift;
	my ($r, $g, $b);
	$r = $this->float;
	if (defined $r) {
		$g = $this->float;
		if (defined $g) {
			$b = $this->float;
			if (defined $b) {
				return new SFColor($r, $g, $b);
			}
		}
	}
	return;
}

sub sffloatValue {
	#print STDERR "VRML::Parse::sffloatValue\n";
	my $this = shift;
	my $float = $this->float;
	return new SFFloat($float) if defined $float;
	return;
}

sub float {
	#print STDERR "VRML::Parse::float\n";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ s/^$whitespace*($float)//s;
	return 0  if $this->{vrmlSyntax} =~ s/^$whitespace*($nan)//s;
	return;
}

sub floats {
	#print STDERR "VRML::Parse::floats\n";
	my $this = shift;
	return (split /$whitespace+/, $1) if $this->{vrmlSyntax} =~ s/^$whitespace*((($float|$nan)$whitespace+)+($float|$nan)?)//s;
	return ();
}

sub sfimageValue {
	#print STDERR "VRML::Parse::sfimageValue\n";
	my $this = shift;
	my ($width, $height, $components);
	my $pixels = [];

	$width = $this->int32;
	if (defined $width) {
		$height = $this->int32;
		if (defined $height) {
			$components = $this->int32;
			if (defined $components) {
				my $size = $height * $width;
				for (my $i=0; $i < $size; ++$i) {
					my $pixel = $this->int32;
					last unless defined $pixel;
					push @{$pixels}, $pixel;
				}
				return new SFImage($width, $height, $components, $pixels);
			}
		}
	}

	return;
}

sub sfint32Value {
	#print STDERR "VRML::Parse::sfint32Value\n";
	my $this = shift;
	my $int32 = $this->int32;
	return new SFInt32($int32) if defined $int32;
	return;
}

sub int32 {
	#print STDERR "VRML::Parse::int32\n";
	my $this = shift;
	return defined $3 ? hex($1) : $1 if $this->{vrmlSyntax} =~ s/^$whitespace*($int32)//s;
	return;
}

sub int32s {
	#print STDERR "VRML::Parse::int32s\n";
	my $this = shift;
	return (split /$whitespace+/, $1) if $this->{vrmlSyntax} =~ s/^$whitespace*(($int32$whitespace+)+($int32)?)//s;
	return ();
}

sub sfnodeValue {
	#print STDERR "VRML::Parse::sfnodeValue\n";
	my $this = shift;
	my $nodeStatement = $this->nodeStatement;
	return new SFNode($nodeStatement) if ref $nodeStatement;
	return new SFNode if $this->{vrmlSyntax} =~ s/^$whitespace*$NULL//s;
	return;
}

sub sfrotationValue {
	#print STDERR "VRML::Parse::sfrotationValue\n";
	my $this = shift;
	my ($x, $y, $z, $angle);

	$x = $this->float;
	if (defined $x) {
		$y = $this->float;
		if (defined $y) {
			$z = $this->float;
			if (defined $z) {
				$angle = $this->float;
				if (defined $angle) {
					return new SFRotation($x, $y, $z, $angle);
				}
			}
		}
	}

	return;
}

sub sfstringValue {
	#print STDERR "VRML::Parse::sfstringValue\n";
	my $this = shift;
	my $string = $this->string;
	return new SFString($string) if defined $string;
	return;
}

sub string {
	#print STDERR "VRML::Parse::string\n";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ s/^$whitespace*"($string?)(?<!\\)"//s;
	return;
}

sub sftimeValue {
	#print STDERR "VRML::Parse::sftimeValue\n";
	my $this = shift;
	my $time = $this->double;
	return new SFTime($time) if defined $time;
	return;
}

sub double {
	#print STDERR "VRML::Parse::double\n";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ s/^$whitespace*($double)//s;
	return;
}

sub mftimeValue {
	#print STDERR "VRML::Parse::mftimeValue\n";
	my $this = shift;

	my $sftimeValue = $this->sftimeValue;
	return new MFTime($sftimeValue) if ref $sftimeValue;

	return new MFTime if $this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket$whitespace*$close_bracket//s;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket//s) {
		my $sftimeValues = $this->sftimeValues;
		return new MFTime($sftimeValues) if @{$sftimeValues} && $this->{vrmlSyntax} =~ s/^$whitespace*$close_bracket//s;
	}

	return;
}

sub sftimeValues {
	#print STDERR "VRML::Parse::sftimeValues\n";
	my $this = shift;
	my $sftimeValue = $this->sftimeValue;
	my $sftimeValues = [];
	while (ref $sftimeValue) {
		push @{$sftimeValues}, $sftimeValue;
		$sftimeValue = $this->sftimeValue;
	}
	return $sftimeValues;
}

sub sfvec2fValue {
	#print STDERR "VRML::Parse::sfvec2fValue\n";
	my $this = shift;
	my ($x, $y);

	$x = $this->float;
	if (defined $x) {
		$y = $this->float;
		if (defined $y) {
			return new SFVec2f($x, $y);
		}
	}

	return;
}

sub sfvec3fValue {
	#print STDERR "VRML::Parse::sfvec3fValue\n";
	my $this = shift;
	my ($x, $y, $z);

	$x = $this->float;
	if (defined $x) {
		$y = $this->float;
		if (defined $y) {
			$z = $this->float;
			if (defined $z) {
				return new SFVec3f($x, $y, $z);
			}
		}
	}

	return;
}

sub mfcolorValue {
	#print STDERR "VRML::Parse::mfcolorValue\n";
	my $this = shift;

	my $sfcolorValue = $this->sfcolorValue;
	return new MFColor($sfcolorValue) if ref $sfcolorValue;

	return new MFColor if $this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket$whitespace*$close_bracket//s;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket//s) {
		my $sfcolorValues = $this->sfcolorValues;
		return new MFColor($sfcolorValues) if @{$sfcolorValues} && $this->{vrmlSyntax} =~ s/^$whitespace*$close_bracket//s;
	}

	return;
}

sub sfcolorValues {
	#print STDERR "VRML::Parse::sfcolorValues\n";
	my $this = shift;
	my $sfcolorValues = [];

	my @floats = $this->floats;
	for (my ($i, $p) = (0, 0); $i < @floats / 3; ++$i, $p = $i * 3) {
		push @{$sfcolorValues}, new SFColor($floats[$p], $floats[$p+1], $floats[$p+2]);
	}

	return $sfcolorValues;
}

sub mffloatValue {
	#print STDERR "VRML::Parse::mffloatValue\n";
	my $this = shift;

	my $sffloatValue = $this->sffloatValue;
	return new MFFloat($sffloatValue) if ref $sffloatValue;

	return new MFFloat if $this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket$whitespace*$close_bracket//s;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket//s) {
		my $sffloatValues = $this->sffloatValues;
		return new MFFloat($sffloatValues) if @{$sffloatValues} && $this->{vrmlSyntax} =~ s/^$whitespace*$close_bracket//s;
	}

	return;
}

sub sffloatValues {
	#print STDERR "VRML::Parse::sffloatValues\n";
	my $this = shift;
	return  [map { new SFFloat($_) } $this->floats];
}

sub mfint32Value {
	#print STDERR "VRML::Parse::mfin32Value\n";
	my $this = shift;

	my $sfint32Value = $this->sfint32Value;
	return new MFInt32($sfint32Value) if ref $sfint32Value;

	return new MFInt32 if $this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket$whitespace*$close_bracket//s;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket//s) {
		my $sfint32Values = $this->sfint32Values;
		return new MFInt32($sfint32Values) if @{$sfint32Values} && $this->{vrmlSyntax} =~ s/^$whitespace*$close_bracket//s;
	}

	return;
}

sub sfint32Values {
	#print STDERR "VRML::Parse::sfint32Values\n";
	my $this = shift;
	return  [map { new SFInt32($_) } $this->int32s];
}

sub mfnodeValue {
	#print STDERR "VRML::Parse::mfnodeValue\n";
	my $this = shift;

	my $node = $this->nodeStatement;
	return new MFNode(new SFNode ($node)) if ref $node;

	return new MFNode if $this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket$whitespace*$close_bracket//s;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket//s) {
		my $nodes = $this->nodeStatements;
		return new MFNode(map {new SFNode ($_) } @{$nodes})
			if @{$nodes} && $this->{vrmlSyntax} =~ s/^$whitespace*$close_bracket//s;
	}

	return;
}

sub nodeStatements {
	#print STDERR "VRML::Parse::nodeStatements\n";
	my $this = shift;
	my $nodeStatement = $this->nodeStatement;
	my $nodeStatements = [];
	while (ref $nodeStatement) {
		push @{$nodeStatements}, $nodeStatement;
		$nodeStatement = $this->nodeStatement;
	}
	return $nodeStatements;
}

sub mfrotationValue {
	#print STDERR "VRML::Parse::mfrotationValue\n";
	my $this = shift;

	my $sfrotationValue = $this->sfrotationValue;
	return new MFRotation($sfrotationValue) if ref $sfrotationValue;

	return new MFRotation if $this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket$whitespace*$close_bracket//s;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket//s) {
		my $sfrotationValues = $this->sfrotationValues;
		return new MFRotation($sfrotationValues) if @{$sfrotationValues} && $this->{vrmlSyntax} =~ s/^$whitespace*$close_bracket//s;
	}

	return;
}

sub sfrotationValues {
	#print STDERR "VRML::Parse::sfrotationValues\n";
	my $this = shift;
	my $sfrotationValues = [];

	my @floats = $this->floats;
	for (my ($i, $p) = (0, 0); $i < @floats / 4; ++$i, $p = $i * 4) {
		push @{$sfrotationValues}, new SFRotation($floats[$p], $floats[$p+1], $floats[$p+2], $floats[$p+3]);
	}

	return $sfrotationValues;
}

sub mfstringValue {
	#print STDERR "VRML::Parse::mfstringValues\n";
	my $this = shift;

	my $sfstringValue = $this->sfstringValue;
	return new MFString($sfstringValue) if ref $sfstringValue;

	return new MFString if $this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket$whitespace*$close_bracket//s;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket//s) {
		my $sfstringValues = $this->sfstringValues;
		return new MFString($sfstringValues) if @{$sfstringValues} && $this->{vrmlSyntax} =~ s/^$whitespace*$close_bracket//s;
	}

	return;
}

sub sfstringValues {
	#print STDERR "VRML::Parse::sfstringValues\n";
	my $this = shift;
	my $sfstringValue = $this->sfstringValue;
	my $sfstringValues = [];
	while (ref $sfstringValue) {
		push @{$sfstringValues}, $sfstringValue;
		$sfstringValue = $this->sfstringValue;
	}
	return $sfstringValues;
}

sub mfvec2fValue {
	#print STDERR "VRML::Parse::mfvec2fValue\n";
	my $this = shift;

	my $sfvec2fValue = $this->sfvec2fValue;
	return new MFVec2f($sfvec2fValue) if ref $sfvec2fValue;

	return new MFVec2f if $this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket$whitespace*$close_bracket//s;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket//s) {
		my $sfvec2fValues = $this->sfvec2fValues;
		return new MFVec2f($sfvec2fValues) if @{$sfvec2fValues} && $this->{vrmlSyntax} =~ s/^$whitespace*$close_bracket//s;
	}

	return;
}

sub sfvec2fValues {
	#print STDERR "VRML::Parse::sfvec2fValues\n";
	my $this = shift;
	my $sfvec2fValues = [];

	my @floats = $this->floats;
	for (my ($i, $p) = (0, 0); $i < @floats / 2; ++$i, $p = $i * 2) {
		push @{$sfvec2fValues}, new SFVec2f($floats[$p], $floats[$p+1]);
	}

	return $sfvec2fValues;
}

sub mfvec3fValue {
	#print STDERR "VRML::Parse::mfvec3fValue\n";
	my $this = shift;

	my $sfvec3fValue = $this->sfvec3fValue;
	return new MFVec3f($sfvec3fValue) if ref $sfvec3fValue;

	return new MFVec3f if $this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket$whitespace*$close_bracket//s;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket//s) {
		my $sfvec3fValues = $this->sfvec3fValues;
		return new MFVec3f($sfvec3fValues) if @{$sfvec3fValues} && $this->{vrmlSyntax} =~ s/^$whitespace*$close_bracket//s;
	}

	return;
}

sub sfvec3fValues {
	#print STDERR "VRML::Parse::sfvec3fValues\n";
	my $this = shift;
	my $sfvec3fValues = [];

	my @floats = $this->floats;
	for (my ($i, $p) = (0, 0); $i < @floats / 3; ++$i, $p = $i * 3) {
		push @{$sfvec3fValues}, new SFVec3f($floats[$p], $floats[$p+1], $floats[$p+2]);
	}

	return $sfvec3fValues;
}

# Fields CosmoWorlds
sub sfenumValue {
	#print STDERR "VRML::Parse::sfenumValue\n";
	my $this = shift;
	my $enum = $this->enum;
	return new SFEnum($enum) if defined $enum;
}

sub enum {
	#print STDERR "VRML::Parse::enum\n";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ s/^$whitespace*($enum)//s;
	return;
}

sub mfenumValue {
	#print STDERR "VRML::Parse::mfenumValue\n";
	my $this = shift;

	my $sfenumValue = $this->sfenumValue;
	return new MFEnum($sfenumValue) if ref $sfenumValue;

	return new MFEnum if $this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket$whitespace*$close_bracket//s;

	if ($this->{vrmlSyntax} =~ s/^$whitespace*$open_bracket//s) {
		my $sfenumValues = $this->sfenumValues;
		return new MFEnum($sfenumValues) if @{$sfenumValues} && $this->{vrmlSyntax} =~ s/^$whitespace*$close_bracket//s;
	}
	return;
}

sub sfenumValues {
	#print STDERR "VRML::Parse::sfenumValues\n";
	my $this = shift;
	my $sfenumValue = $this->sfenumValue;
	my $sfenumValues = [];
	while (ref $sfenumValue) {
		push @{$sfenumValues}, $sfenumValue;
		$sfenumValue = $this->sfenumValue;
	}
	return $sfenumValues;
}

sub comment {
	#print STDERR "VRML::Parse::removeComments ";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ s/^$comment//s;
	return "";
}

#
sub removeComments {
	#print STDERR "VRML::Parse::removeComments ";
	my $this = shift;
	my $comments = $this->{vrmlSyntax} =~ s/$comment//sg || 0;
	#print STDERR "$comments ", $comments == 1 ? "Comment" : "Comments"," removed\n";
	return;
}

sub getProto {
	#print STDERR "VRML::Parse::getProto\n";
	my $this = shift;
	my $name = shift;
	my $top = $this->{top};

	while (ref $top eq 'VRML::Proto') {
	#print STDERR join " ", keys  %{$top->{proto}}, " $top->{name} VRML::Parse::getProto\n";
		return $top->{proto}->{$name} if exists $top->{proto}->{$name};
		$top = exists $top->{top} ? $top->{top} : $this;
	}

	return $this->{proto}->{$name} if exists $this->{proto}->{$name};
	return $this->{browser}->getProto($name);
	return;
}

sub uniqueName {
	my $this = shift;
	my $name = shift || '';
	return $name unless exists $this->{top}->{node}->{$name};

	my $i = 0;
	$name =~ s/_\d*$//;
	++$i while exists $this->{top}->{node}->{"$name\_$i"};
	return "$name\_$i";
}

1;
__END__
