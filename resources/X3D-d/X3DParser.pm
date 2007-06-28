 package X3DParser;
use strict;
use warnings;

use rlib "Components/Core";

use base qw(X3DNode);

use Carp qw(croak);
use X3DConstants;
use X3D::Parser::Symbols;

our $FieldDefinitions = [
	new X3DFieldDefinition( initializeOnly, 'name',     new SFString("X3D VRML Parser") ),
	new X3DFieldDefinition( initializeOnly, 'version',  new SFString("0.01") ),
	new X3DFieldDefinition( outputOnly,     'progress', new SFFloat(0) ),
	new X3DFieldDefinition( outputOnly,     'isActive', FALSE ),
];

sub initialize {    #X3DError::Debug;
	my ($this) = @_;
	$this->{string} = "";
	$this->{scene}  = [];

	#$this->getField("progress")->addFieldCallback( "println", $this->getBrowser );

	return;
}

sub update_progress {
	my $pos = pos( $_[0]->{string} ) || 0;
	$_[0]->progress( $pos / length( $_[0]->{string} ) );
	$_[0]->processEvents;
}

sub parseString {
	my ( $this, $string ) = @_;
	#X3DError::Debug length $string;
	$this->progress(0);
	$this->isActive(TRUE);
	$this->processEvents;

	$this->{string} = $string;

	my $scene = $this->scene;

	$this->progress(1);
	$this->isActive(FALSE);
	$this->processEvents;
	return $scene;
}

sub scene {
	my ($this) = @_;

	my $header              = $this->headerStatement;
	my $profileStatement    = $this->profileStatement;
	my $componentStatements = $this->componentStatements;

	my $scene = $this->getBrowser->createScene( $profileStatement, $componentStatements );
	if ( ref $scene ) {
		unshift @{ $this->{scene} }, $scene;

		my $metadataStatements = $this->metadataStatements;
		$scene->encoding("VRML");

		eval { $this->statements };

		$this->getError;

		shift @{ $this->{scene} };
		return $scene;
	}
	return;
}

sub getError {
	my ($this) = @_;

	$this->{string} =~ m/\G$_whitespace*$/sgco;    # spaces at end of string$
	my $pos = pos( $this->{string} ) || 0;

	return unless length( $this->{string} ) - $pos;

	unless ($@) {
		$this->{string} =~ m/\G$_whitespace*/sgco;
		$pos = pos( $this->{string} ) || 0;
	}

	my $start = rindex( $this->{string}, "\n", $pos ) + 1;
	my $end = index( $this->{string}, "\n", $start );
	my $line = substr $this->{string}, $start, $end - $start;

	my $begin = substr $this->{string}, 0, $pos;
	my $lineNumber = ( $begin =~ s/\n/\n/sgo ) + 1;

	eval { X3DError::UnknownStatement $line } unless $@;

	X3DError::carp "*" x 80;
	X3DError::carp "Parser error at - line $lineNumber:";
	X3DError::carp "$line";
	X3DError::carp " " x ( $pos - $start ) . "^";
	X3DError::carp $@;
	X3DError::carp "*" x 80;

	$@ = "";
	return;
}

sub getScene {
	my ($this) = @_;
	return $this->{scene}->[0];
}

sub headerStatement {
	my ($this) = @_;
	return;
}

sub profileStatement {
	my ($this) = @_;

	if ( $this->{string} =~ m/$_PROFILE/gc ) {
		my $profileNameId = $this->profileNameId;
		return $profileNameId if defined $profileNameId;
	}

	return "Core";
}

sub componentStatements {
	my ($this)              = @_;
	my $componentStatement  = $this->componentStatement;
	my $componentStatements = [];

	while ( defined $componentStatement ) {
		push @$componentStatements, $componentStatement;
		$componentStatement = $this->componentStatement;
	}

	return $componentStatements;
}

sub componentStatement {
	my ($this) = @_;

	return unless $this->{string} =~ m/$_COMPONENT/gc;

	my $componentNameId = $this->componentNameId;
	if ( defined $componentNameId ) {
		my $componentSupportLevel = $this->componentSupportLevel;
		if ( defined $componentSupportLevel ) {
			return $componentNameId;
		}
	}

	return;
}

sub metadataStatements {
	my ($this) = @_;
	my $metadataStatement = $this->metadataStatement;

	while ( ref $metadataStatement ) {
		$this->getScene->setMetaData(@$metadataStatement);
		$metadataStatement = $this->metadataStatement;
	}

	return;
}

sub metadataStatement {
	my ($this) = @_;

	return unless $this->{string} =~ m/$_META/gc;

	my $metakey = $this->metakey;
	if ( defined $metakey ) {
		my $metavalue = $this->metavalue;
		if ( defined $metavalue ) {
			return [ $metakey, $metavalue ];
		}
	}

	return;
}

sub statements {
	my $this = shift;
	1 while $this->statement;
	return;
}

sub statement {
	my $this = shift;
	#$this->update_progress;

	my $nodeStatement = $this->nodeStatement;
	return push @{ $this->getScene->rootNodes }, $nodeStatement if ref $nodeStatement;

	return 1 if ref $this->protoStatement;
	return 1 if ref $this->routeStatement;
	return;
}

sub nodeStatement {
	my $this = shift;

	if ( $this->{string} =~ m/$_DEF/gc ) {
		my $nodeNameId = $this->nodeNameId;
		if ( defined $nodeNameId ) {

			#X3DError::Debug "VRML2::Parser::nodeStatement DEF $nodeNameId\n";
			my $node = $this->node($nodeNameId);
			return $node if ref $node;

			X3DError::Error "Premature end of file after DEF";

		} else {
			X3DError::Error "No name given after DEF";
		}
	}

	if ( $this->{string} =~ m/$_USE/gc ) {
		my $nodeNameId = $this->nodeNameId;

		#X3DError::Debug "VRML2::Parser::nodeStatement USE $nodeNameId\n";

		if ( defined $nodeNameId ) {

			my $sfnode = $this->getScene->getNamedNode($nodeNameId);
			return $sfnode if ref $sfnode;

			X3DError::Error "Unknown reference '$nodeNameId'";

		} else {
			X3DError::Error "Expected nodeNameId after USE";
		}
	}

	my $node = $this->node;
	return $node if ref $node;

	return;
}

sub rootNodeStatement {
	my $this = shift;

	if ( $this->{string} =~ m/$_DEF/gc ) {
		my $nodeNameId = $this->nodeNameId;
		if ( defined $nodeNameId ) {

			#X3DError::Debug "VRML2::Parser::rootNodeStatement $nodeNameId\n";
			my $node = $this->node($nodeNameId);
			if ( ref $node ) {
				return $node;
			} else {
				X3DError::Error "Premature end of file after DEF";
			}

		} else {
			X3DError::Error "No name given after DEF";
		}
	}

	my $node = $this->node;
	return $node if ref $node;

	return;
}

sub protoStatement {
	my $this = shift;
	my $proto;

	$proto = $this->proto;
	unless ( ref $proto ) {
		$proto = $this->externproto;
	}

	if ( ref $proto ) {
		$this->addProto($proto);
		return $proto;
	}

	return;
}

sub protoStatements {
	my $this            = shift;
	my $protoStatement  = $this->protoStatement;
	my $protoStatements = [];
	while ( ref $protoStatement ) {
		push @$protoStatements, $protoStatement;
		$protoStatement = $this->protoStatement;
	}
	return $protoStatements;
}

sub proto {
	my $this = shift;

	if ( $this->{string} =~ m/$_PROTO/gc ) {
		my $nodeTypeId = $this->nodeTypeId;
		if ( defined $nodeTypeId ) {
			if ( $this->{string} =~ m/$_open_bracket/gc ) {
				my $interfaceDeclarations = $this->interfaceDeclarations;
				if (@$interfaceDeclarations) {
					if ( $this->{string} =~ m/$_close_bracket/gc ) {
						if ( $this->{string} =~ m/$_open_brace/gc ) {
							my $proto =
							  new VRML2::Proto( $this->{parent}, $nodeTypeId,
								$interfaceDeclarations );

							$this->{parent} = $proto;
							my $protoBody = $this->protoBody;
							$this->{parent} = $proto->getParent;

							if ( $this->{string} =~ m/$_close_brace/gc ) {

								#X3DError::Debug "VRML2::Parser::proto $nodeTypeId done\n";
								$proto->setBody($protoBody);
								return $proto;
							} else {
								X3DError::Error "Expected a '}' to end prototype definition";
							}
						} else {
							X3DError::Error "Expected a '{' to begin prototype definition";
						}

					} else {
						X3DError::Error "Expected a ']'";
					}

				}
			} else {
				X3DError::Error "Expected a '['";
			}

		} else {
			X3DError::Error "Invalid prototype definition name";
		}
	}

	return;
}

sub protoBody {
	my $this = shift;
	my $protoBody = [ undef, undef, undef ];
	$protoBody->[0] = $this->protoStatements;
	$protoBody->[1] = $this->rootNodeStatement;
	$protoBody->[2] = $this->statements;

	#X3DError::Debug "VRML2::Parser::protoBody done\n";
	return $protoBody;
}

sub interfaceDeclarations {
	my $this                  = shift;
	my $interfaceDeclaration  = $this->interfaceDeclaration;
	my $interfaceDeclarations = [];
	while ( ref $interfaceDeclaration ) {
		push @$interfaceDeclarations, $interfaceDeclaration;
		$interfaceDeclaration = $this->interfaceDeclaration;
	}
	return $interfaceDeclarations;
}

sub restrictedInterfaceDeclaration {
	my $this = shift;

	if ( $this->{string} =~ m/$_eventIn/gc ) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $eventInId = $this->eventInId;
			if ( defined $eventInId ) {

#X3DError::Debug "VRML2::Parser::restrictedInterfaceDeclaration eventIn $fieldType $eventInId\n";
				return new eventIn( $fieldType, $eventInId );
			} else {
				X3DError::Error "Expected name for field";
			}
		} else {
			X3DError::Error "Unknown event or field type: '", $this->Id, "'";
		}
	}

	if ( $this->{string} =~ m/$_eventOut/gc ) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $eventOutId = $this->eventOutId;
			if ( defined $eventOutId ) {

#X3DError::Debug "VRML2::Parser::restrictedInterfaceDeclaration eventOut $fieldType $eventOutId\n";
				return new eventOut( $fieldType, $eventOutId );
			} else {
				X3DError::Error "Expected name for field";
			}
		} else {
			X3DError::Error "Unknown event or field type: '", $this->Id, "'";
		}
	}

	if ( $this->{string} =~ m/$_field/gc ) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $fieldId = $this->fieldId;
			if ( defined $fieldId ) {
				my $fieldValue = $this->fieldValue($fieldType);
				if ( ref $fieldValue ) {

#X3DError::Debug "VRML2::Parser::restrictedInterfaceDeclaration field $fieldType $fieldId $fieldValue\n";
					return new field( $fieldType, $fieldId, $fieldValue );
				} else {
					X3DError::Error "Couldn't read value for field '", $fieldId, "'";
				}
			} else {
				X3DError::Error "Expected name for field";
			}
		} else {
			X3DError::Error "Unknown event or field type: '", $this->Id, "'";
		}
	}

	return;
}

sub interfaceDeclaration {
	my $this = shift;

	my $restrictedInterfaceDeclaration = $this->restrictedInterfaceDeclaration;
	return $restrictedInterfaceDeclaration if ref $restrictedInterfaceDeclaration;

	if ( $this->{string} =~ m/$_exposedField/gc ) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $fieldId = $this->fieldId;
			if ( defined $fieldId ) {
				my $fieldValue = $this->fieldValue($fieldType);
				if ( ref $fieldValue ) {

#X3DError::Debug "VRML2::Parser::interfaceDeclaration exposedField $fieldType $fieldId $fieldValue\n";
					return new exposedField( $fieldType, $fieldId, $fieldValue );
				} else {
					X3DError::Error "Couldn't read value for field '", $fieldId, "'";
				}
			} else {
				X3DError::Error "Expected name for field";
			}
		} else {
			X3DError::Error "Unknown event or field type: '", $this->Id, "'";
		}
	}

	return;
}

sub externproto {
	my $this = shift;

	if ( $this->{string} =~ m/$_EXTERNPROTO/gc ) {
		my $nodeTypeId = $this->nodeTypeId;
		if ( defined $nodeTypeId ) {
			if ( $this->{string} =~ m/$_open_bracket/gc ) {
				my $externInterfaceDeclarations = $this->externInterfaceDeclarations;
				if (@$externInterfaceDeclarations) {
					if ( $this->{string} =~ m/$_close_bracket/gc ) {
						my $URLList = $this->URLList;
						if ( ref $URLList ) {
							my $proto =
							  new VRML2::Proto( $this->{parent}, $nodeTypeId,
								$externInterfaceDeclarations );
							$proto->setURL($URLList);
							return $proto;
						} else {
							X3DError::Error "Expected URL list in EXTERNPROTO $nodeTypeId";
						}
					} else {
						X3DError::Error "Expected a ']'";
					}
				}
			} else {
				X3DError::Error "Expected a '['";
			}
		} else {
			X3DError::Error "Invalid prototype definition name";
		}
	}

	return;
}

sub externInterfaceDeclarations {
	my $this                        = shift;
	my $externInterfaceDeclaration  = $this->externInterfaceDeclaration;
	my $externInterfaceDeclarations = [];
	while ( ref $externInterfaceDeclaration ) {
		push @$externInterfaceDeclarations, $externInterfaceDeclaration;
		$externInterfaceDeclaration = $this->externInterfaceDeclaration;
	}
	return $externInterfaceDeclarations;
}

sub externInterfaceDeclaration {
	my $this = shift;

	if ( $this->{string} =~ m/$_eventIn/gc ) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $eventInId = $this->eventInId;
			if ( defined $eventInId ) {
   #X3DError::Debug "VRML2::Parser::externInterfaceDeclaration eventIn $fieldType $eventInId\n";
				return new eventIn( $fieldType, $eventInId );
			} else {
				X3DError::Error "Expected name for field";
			}
		} else {
			X3DError::Error "Unknown event or field type: '", $this->Id, "'";
		}
	}

	if ( $this->{string} =~ m/$_eventOut/gc ) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $eventOutId = $this->eventOutId;
			if ( defined $eventOutId ) {
 #X3DError::Debug "VRML2::Parser::externInterfaceDeclaration eventOut $fieldType $eventOutId\n";
				return new eventOut( $fieldType, $eventOutId );
			} else {
				X3DError::Error "Expected name for field";
			}
		} else {
			X3DError::Error "Unknown event or field type: '", $this->Id, "'";
		}
	}

	if ( $this->{string} =~ m/$_field/gc ) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $fieldId = $this->fieldId;
			if ( defined $fieldId ) {
	   #X3DError::Debug "VRML2::Parser::externInterfaceDeclaration field $fieldType $fieldId\n";
				return new field( $fieldType, $fieldId, );
			} else {
				X3DError::Error "Expected name for field";
			}
		} else {
			X3DError::Error "Unknown event or field type: '", $this->Id, "'";
		}
	}

	if ( $this->{string} =~ m/$_exposedField/gc ) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $fieldId = $this->fieldId;
			if ( defined $fieldId ) {
#X3DError::Debug "VRML2::Parser::externInterfaceDeclaration exposedField $fieldType $fieldId\n";
				return new exposedField( $fieldType, $fieldId, );
			} else {
				X3DError::Error "Expected name for field";
			}
		} else {
			X3DError::Error "Unknown event or field type: '", $this->Id, "'";
		}
	}

	return;
}

sub routeStatement {
	my $this = shift;
	if ( $this->{string} =~ m/$_ROUTE/gc ) {
		if ( $this->{string} =~ m/$_Id/gc ) {
			my $fromNodeId = $1;
			my $fromNode   = $this->getScene->getNamedNode($fromNodeId);

			if ( ref $fromNode ) {
				if ( $this->{string} =~ m/$_period/gc ) {
					if ( $this->{string} =~ m/$_Id/gc ) {
						my $eventOutId = $1;

						if ( $this->{string} =~ m/$_TO/gc ) {
							if ( $this->{string} =~ m/$_Id/gc ) {
								my $toNodeId = $1;
								my $toNode   = $this->getScene->getNamedNode($toNodeId);

								if ( ref $toNode ) {
									if ( $this->{string} =~ m/$_period/gc ) {
										if ( $this->{string} =~ m/$_Id/gc ) {
											my $eventInId = $1;

											return $this->getScene->addRoute( $fromNode,
												$eventOutId, $toNode, $eventInId );

										} else {
											X3DError::BadRouteSpecification;
										}
									} else {
										X3DError::BadRouteSpecification;
									}
								} else {
									X3DError::BadRouteSpecification;
								}
							} else {
								X3DError::BadRouteSpecification;
							}
						} else {
							X3DError::BadRouteSpecification;
						}
					} else {
						X3DError::BadRouteSpecification;
					}
				} else {
					X3DError::BadRouteSpecification;
				}
			} else {
				X3DError::BadRouteSpecification;
			}
		}
	}
	return;
}

sub URLList {
	my $this = shift;
	return $this->mfstringValue;
}

# Nodes
sub node {
	my $this       = shift;
	my $nodeNameId = shift;

	if ( $this->{string} =~ m/$_NodeTypeId/gc ) {
		my $type = $1;
		if ( $this->{string} =~ m/$_open_brace/gc ) {
			my $comments = $this->comments;
			my $sfnode = $this->getScene->createNode( $type, $nodeNameId, $comments );
			if ( ref $sfnode ) {
				my $node = $sfnode->getValue;
				my $fields;

				if ( $type eq 'Script' ) {
					$fields = $this->scriptBody($node);
				} else {
					$fields = $this->nodeBody($node);
				}

				if ( $this->{string} =~ m/$_close_brace/gc ) {
					$node->call( "setFields", $fields );
					$node->call("initialize");
					return $sfnode;
				} else {
					X3DError::Error "Expected '}'";
				}
			} else {
				X3DError::UnknownClass $type;
			}
		} else {
			X3DError::Error "Expected '{'";
		}
	}

	#X3DError::Debug "VRML2::Parser::node undef\n";
	return;
}

sub nodeBody {
	my $this            = shift;
	my $node            = shift;
	my $nodeBody        = [];
	my $nodeBodyElement = $this->nodeBodyElement($node);
	while ( ref $nodeBodyElement ) {
		push @$nodeBody, $nodeBodyElement if ref $nodeBodyElement;
		$nodeBodyElement = $this->nodeBodyElement($node);
	}
	return $nodeBody;
}

sub scriptBody {
	my $this              = shift;
	my $node              = shift;
	my $scriptBody        = [];
	my $scriptBodyElement = $this->scriptBodyElement($node);
	while ( ref $scriptBodyElement ) {
		push @$scriptBody, $scriptBodyElement if ref $scriptBodyElement;
		$scriptBodyElement = $this->scriptBodyElement($node);
	}
	return $scriptBody;
}

sub scriptBodyElement {
	my $this = shift;
	my $node = shift;

	if ( $this->{string} =~ m/$_ScriptNodeInterface_IS/gc ) {
		my $fieldClass = $1;
		my $fieldType  = $2;
		my $fieldId    = $3;

		my $field = { type => $fieldType, name => $fieldId };
		bless $field, $fieldClass;

		#X3DError::Debug "VRML2::Parser::scriptBodyElement", ref $field,"\n";

		if ( ref $this->{parent} ne 'VRML2::Browser' ) {
			my $is      = $this->Id;
			my $isField = $this->{parent}->getField($is);

			if ( ref $isField ) {
				if ( $field ge $isField ) {
					if ( $field->getType eq $isField->getType ) {
						return $field->new( $fieldType, $fieldId, $isField->getValue,
							$isField );
					} else {
						X3DError::Error "Field ", $field->getName, " and ", $isField->getName,
						  " in PROTO ", $this->{parent}->getName, " have different types";
					}
				} else {
					X3DError::Error "Field ", $field->getName, " and ", $isField->getName,
					  " in PROTO ", $this->{parent}->getName,
					  " are incompatible as an IS mapping";
				}
			} else {
				X3DError::Error "No such event or field '$is' inside PROTO ",
				  $this->{parent}->getName, "";
			}
		} else {
			X3DError::Error "IS statement outside PROTO definition";
		}

	}

	my $restrictedInterfaceDeclaration = $this->restrictedInterfaceDeclaration;
	return $restrictedInterfaceDeclaration if ref $restrictedInterfaceDeclaration;

	my $nodeBodyElement = $this->nodeBodyElement($node);
	return $nodeBodyElement if ref $nodeBodyElement;

	return;
}

sub nodeBodyElement {
	my $this = shift;
	my $node = shift;

	#X3DError::Debug "VRML2::Parser::nodeBodyElement\n";

	my $protoStatement = $this->protoStatement;
	return $protoStatement if ref $protoStatement;

	my $routeStatement = $this->routeStatement;
	return $routeStatement if ref $routeStatement;

	my $fieldId = $this->fieldId;
	if ( defined $fieldId ) {

		#X3DError::Debug "VRML2::Parser::nodeBodyElement $fieldId\n";

		my $field = $node->getField($fieldId);
		if ( ref $field ) {

			if ( $this->{string} =~ m/$_IS/gc ) {
				if ( ref $this->{parent} ne 'VRML2::Browser' ) {
					my $is = $this->Id;

					#X3DError::Debug "VRML2::Parser::nodeBodyElement IS mapping", $is, "\n";
					my $isField = $this->{parent}->getField($is);
					if ( ref $isField ) {
						if ( $field ge $isField ) {
							if ( $field->getType eq $isField->getType ) {
								return $field->new( $field->getType, $fieldId,
									$isField->getValue, $isField );
							} else {
								X3DError::Error "Field ", $field->getName, " and ",
								  $isField->getName, " in PROTO ", $this->{parent}->getName,
								  " have different types";
							}
						} else {
							X3DError::Error "Field ", $field->getName, " and ",
							  $isField->getName, " in PROTO ", $this->{parent}->getName,
							  " are incompatible as an IS mapping";
						}
					} else {
						X3DError::Error "No such event or field '$is' inside PROTO ",
						  $this->{parent}->getName, "";
					}
				} else {
					X3DError::Error "IS statement outside PROTO definition";
				}
			}

			my $fieldValue = $this->fieldValue( $field->getType );
			if ( ref $fieldValue ) {
				$field->setValue($fieldValue);
				return $field;
			} else {
				X3DError::Error "Couldn't read value for field '$fieldId'";
			}

		} else {
			croak;
		}
	}

	#X3DError::Debug "VRML2::Parser::nodeBodyElement undef\n";
	return;
}

sub profileNameId {
	my $this = shift;
	return $this->Id;
}

sub componentNameId {
	my $this = shift;
	return $this->Id;
}

sub componentSupportLevel {
	my $this = shift;
	return $this->int32;
}

sub metakey {
	my $this = shift;
	return $this->string;
}

sub metavalue {
	my $this = shift;
	return $this->string;
}

sub nodeNameId {
	my $this = shift;
	return $this->Id;
}

sub nodeTypeId {
	my $this = shift;
	return $this->Id;
}

sub fieldId {
	my $this = shift;
	return $this->Id;
}

sub eventInId {
	my $this = shift;
	return $this->Id;
}

sub eventOutId {
	my $this = shift;
	return $this->Id;
}

sub Id {
	my $this = shift;
	return $1 if $this->{string} =~ m/$_Id/gc;
	return;
}

sub comments {
	my $this     = shift;
	my $comment  = $this->comment;
	my $comments = [];
	while ( defined $comment ) {
		push @$comments, $comment;
		$comment = $this->comment;
	}
	return $comments;
}

sub comment {
	my $this = shift;
	return $1 if $this->{string} =~ m/$_comment/gc;
	return;
}

# Fields
sub fieldType {
	my $this = shift;
	return $1 if $this->{string} =~ m/$_fieldType/gc;
	return;
}

sub fieldValue {
	my $this      = shift;
	my $fieldType = shift;

	if ( index( $fieldType, 'SF' ) == 0 ) {
		return $this->sfboolValue     if $fieldType eq 'SFBool';
		return $this->sfcolorValue    if $fieldType eq 'SFColor';
		return $this->sfdoubleValue   if $fieldType eq 'SFDouble';
		return $this->sffloatValue    if $fieldType eq 'SFFloat';
		return $this->sfimageValue    if $fieldType eq 'SFImage';
		return $this->sfint32Value    if $fieldType eq 'SFInt32';
		return $this->sfnodeValue     if $fieldType eq 'SFNode';
		return $this->sfrotationValue if $fieldType eq 'SFRotation';
		return $this->sfstringValue   if $fieldType eq 'SFString';
		return $this->sftimeValue     if $fieldType eq 'SFTime';
		return $this->sfvec2dValue    if $fieldType eq 'SFVec2d';
		return $this->sfvec2fValue    if $fieldType eq 'SFVec2f';
		return $this->sfvec3dValue    if $fieldType eq 'SFVec3d';
		return $this->sfvec3fValue    if $fieldType eq 'SFVec3f';
	} else {
		return $this->mfcolorValue    if $fieldType eq 'MFColor';
		return $this->mfdoubleValue   if $fieldType eq 'MFDouble';
		return $this->mffloatValue    if $fieldType eq 'MFFloat';
		return $this->mfint32Value    if $fieldType eq 'MFInt32';
		return $this->mfnodeValue     if $fieldType eq 'MFNode';
		return $this->mfrotationValue if $fieldType eq 'MFRotation';
		return $this->mfstringValue   if $fieldType eq 'MFString';
		return $this->mftimeValue     if $fieldType eq 'MFTime';
		return $this->mfvec2fValue    if $fieldType eq 'MFVec2f';
		return $this->mfvec3fValue    if $fieldType eq 'MFVec3f';
	}

	#	if ( $this->{comment} =~ /$_CosmoWorlds/ ) {
	#		my $version = $1;
	#		return $this->sfenumValue if $fieldType eq 'SFEnum';
	#		return $this->mfenumValue if $fieldType eq 'MFEnum';
	#	}

	return;
}

sub sfboolValue {
	my $this = shift;
	return new SFBool(1) if $this->{string} =~ m/$_TRUE/gc;
	return new SFBool    if $this->{string} =~ m/$_FALSE/gc;
	return;
}

sub sfcolorValue {
	my $this = shift;
	my ( $r, $g, $b );
	$r = $this->float;
	if ( defined $r ) {
		$g = $this->float;
		if ( defined $g ) {
			$b = $this->float;
			if ( defined $b ) {
				return new SFColor( $r, $g, $b );
			}
		}
	}
	return;
}

sub sfdoubleValue {
	my $this   = shift;
	my $double = $this->float;
	return new SFDouble($double) if defined $double;
	return;
}

sub sffloatValue {
	my $this  = shift;
	my $float = $this->float;
	return new SFFloat($float) if defined $float;
	return;
}

sub float {
	my $this = shift;
	return $1 if $this->{string} =~ m/$_float/gc;
	return 0  if $this->{string} =~ m/$_nan/gc;

	#return ...  if $this->{string} =~ m/$_inf/gc;
	#X3DError::Debug "VRML2::Parser::float undef\n";
	return;
}

sub sfimageValue {
	my $this = shift;
	my ( $width, $height, $components );
	my $pixels = [];

	$width = $this->int32;
	if ( defined $width ) {
		$height = $this->int32;
		if ( defined $height ) {
			$components = $this->int32;
			if ( defined $components ) {
				my $size = $height * $width;
				for ( my $i = 0 ; $i < $size ; ++$i ) {
					my $pixel = $this->int32;
					last unless defined $pixel;
					push @$pixels, $pixel;
				}
				return new SFImage( $width, $height, $components, $pixels );
			}
		}
	}

	return;
}

sub sfint32Value {
	my $this  = shift;
	my $int32 = $this->int32;
	return new SFInt32($int32) if defined $int32;
	return;
}

sub int32 {
	my $this = shift;
	return defined $2 ? hex($1) : $1 if $this->{string} =~ m/$_int32/gc;
	return;
}

sub sfnodeValue {
	my $this          = shift;
	my $nodeStatement = $this->nodeStatement;
	return $nodeStatement if ref $nodeStatement;
	return new SFNode if $this->{string} =~ m/$_NULL/gc;
	return;
}

sub sfrotationValue {
	my $this = shift;
	my ( $x, $y, $z, $angle );

	$x = $this->float;
	if ( defined $x ) {
		$y = $this->float;
		if ( defined $y ) {
			$z = $this->float;
			if ( defined $z ) {
				$angle = $this->float;
				if ( defined $angle ) {
					return new SFRotation( $x, $y, $z, $angle );
				}
			}
		}
	}

	return;
}

sub sfstringValue {
	my $this   = shift;
	my $string = $this->string;
	return new SFString($string) if defined $string;
	return;
}

sub string {
	my $this = shift;
	return $1 if $this->{string} =~ m/$_string/gc;
	return;
}

sub sftimeValue {
	my $this = shift;
	my $time = $this->double;
	return new SFTime($time) if defined $time;
	return;
}

sub double {
	my $this = shift;
	return $1 if $this->{string} =~ m/$_double/gc;
	return;
}

sub mftimeValue {
	my $this = shift;

	my $sftimeValue = $this->sftimeValue;
	return new MFTime($sftimeValue) if ref $sftimeValue;

	return new MFTime if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sftimeValues = $this->sftimeValues;
		return new MFTime($sftimeValues)
		  if @$sftimeValues && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sftimeValues {
	my $this         = shift;
	my $sftimeValue  = $this->sftimeValue;
	my $sftimeValues = [];
	while ( ref $sftimeValue ) {
		push @$sftimeValues, $sftimeValue;
		$sftimeValue = $this->sftimeValue;
	}
	return $sftimeValues;
}

sub sfvec2fValue {
	my $this = shift;
	my ( $x, $y );

	$x = $this->float;
	if ( defined $x ) {
		$y = $this->float;
		if ( defined $y ) {
			return new SFVec2f( $x, $y );
		}
	}

	return;
}

sub sfvec2dValue {
	my $this = shift;
	my ( $x, $y );

	$x = $this->double;
	if ( defined $x ) {
		$y = $this->double;
		if ( defined $y ) {
			return new SFVec2d( $x, $y );
		}
	}

	return;
}

sub sfvec3fValue {
	my $this = shift;
	my ( $x, $y, $z );

	$x = $this->float;
	if ( defined $x ) {
		$y = $this->float;
		if ( defined $y ) {
			$z = $this->float;
			if ( defined $z ) {
				return new SFVec3f( $x, $y, $z );
			}
		}
	}

	return;
}

sub sfvec3dValue {
	my $this = shift;
	my ( $x, $y, $z );

	$x = $this->double;
	if ( defined $x ) {
		$y = $this->double;
		if ( defined $y ) {
			$z = $this->double;
			if ( defined $z ) {
				return new SFVec3d( $x, $y, $z );
			}
		}
	}

	return;
}

sub mfboolValue {
	my $this = shift;

	my $sfboolValue = $this->sfboolValue;
	return new MFBool($sfboolValue) if ref $sfboolValue;

	return new MFBool if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sfboolValues = $this->sfboolValues;
		return new MFBool($sfboolValues)
		  if @$sfboolValues && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfboolValues {
	my $this         = shift;
	my $sfboolValue  = $this->sfboolValue;
	my $sfboolValues = [];
	while ( ref $sfboolValue ) {
		push @$sfboolValues, $sfboolValue;
		$sfboolValue = $this->sfboolValue;
	}
	return $sfboolValues;
}

sub mfcolorValue {
	my $this = shift;

	my $sfcolorValue = $this->sfcolorValue;
	return new MFColor($sfcolorValue) if ref $sfcolorValue;

	return new MFColor if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sfcolorValues = $this->sfcolorValues;
		return new MFColor($sfcolorValues)
		  if @$sfcolorValues && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfcolorValues {
	my $this          = shift;
	my $sfcolorValue  = $this->sfcolorValue;
	my $sfcolorValues = [];
	while ( ref $sfcolorValue ) {
		push @$sfcolorValues, $sfcolorValue;
		$sfcolorValue = $this->sfcolorValue;
	}
	return $sfcolorValues;
}

sub mfdoubleValue {
	my $this = shift;

	my $sfdoubleValue = $this->sfdoubleValue;
	return new MFDouble($sfdoubleValue) if ref $sfdoubleValue;

	return new MFDouble if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sfdoubleValues = $this->sfdoubleValues;
		return new MFDouble($sfdoubleValues)
		  if @$sfdoubleValues && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfdoubleValues {
	my $this           = shift;
	my $sfdoubleValue  = $this->sfdoubleValue;
	my $sfdoubleValues = [];
	while ( ref $sfdoubleValue ) {
		push @$sfdoubleValues, $sfdoubleValue;
		$sfdoubleValue = $this->sfdoubleValue;
	}
	return $sfdoubleValues;
}

sub mffloatValue {
	my $this = shift;

	my $sffloatValue = $this->sffloatValue;
	return new MFFloat($sffloatValue) if ref $sffloatValue;

	return new MFFloat if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sffloatValues = $this->sffloatValues;
		return new MFFloat($sffloatValues)
		  if @$sffloatValues && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sffloatValues {
	my $this          = shift;
	my $sffloatValue  = $this->sffloatValue;
	my $sffloatValues = [];
	while ( ref $sffloatValue ) {
		push @$sffloatValues, $sffloatValue;
		$sffloatValue = $this->sffloatValue;
	}
	return $sffloatValues;
}

sub mfint32Value {
	my $this = shift;

	my $sfint32Value = $this->sfint32Value;
	return new MFInt32($sfint32Value) if ref $sfint32Value;

	return new MFInt32 if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sfint32Values = $this->sfint32Values;
		return new MFInt32($sfint32Values)
		  if @$sfint32Values && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfint32Values {
	my $this          = shift;
	my $sfint32Value  = $this->sfint32Value;
	my $sfint32Values = [];
	while ( ref $sfint32Value ) {
		push @$sfint32Values, $sfint32Value;
		$sfint32Value = $this->sfint32Value;
	}
	return $sfint32Values;
}

sub mfnodeValue {
	my $this = shift;

	my $node = $this->nodeStatement;
	return new MFNode($node) if ref $node;

	return new MFNode if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $nodes = $this->nodeStatements;
		return new MFNode($nodes)
		  if @$nodes && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub nodeStatements {
	my $this           = shift;
	my $nodeStatement  = $this->nodeStatement;
	my $nodeStatements = [];
	while ( ref $nodeStatement ) {
		push @$nodeStatements, $nodeStatement;
		$nodeStatement = $this->nodeStatement;
	}
	return $nodeStatements;
}

sub mfrotationValue {
	my $this = shift;

	my $sfrotationValue = $this->sfrotationValue;
	return new MFRotation($sfrotationValue) if ref $sfrotationValue;

	return new MFRotation if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sfrotationValues = $this->sfrotationValues;
		return new MFRotation($sfrotationValues)
		  if @$sfrotationValues && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfrotationValues {
	my $this             = shift;
	my $sfrotationValue  = $this->sfrotationValue;
	my $sfrotationValues = [];
	while ( ref $sfrotationValue ) {
		push @$sfrotationValues, $sfrotationValue;
		$sfrotationValue = $this->sfrotationValue;
	}
	return $sfrotationValues;
}

sub mfstringValue {
	my $this = shift;

	my $sfstringValue = $this->sfstringValue;
	return new MFString($sfstringValue) if ref $sfstringValue;

	return new MFString if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sfstringValues = $this->sfstringValues;
		return new MFString($sfstringValues)
		  if @$sfstringValues && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfstringValues {
	my $this           = shift;
	my $sfstringValue  = $this->sfstringValue;
	my $sfstringValues = [];
	while ( ref $sfstringValue ) {
		push @$sfstringValues, $sfstringValue;
		$sfstringValue = $this->sfstringValue;
	}
	return $sfstringValues;
}

sub mfvec2dValue {
	my $this = shift;

	my $sfvec2dValue = $this->sfvec2dValue;
	return new MFVec2d($sfvec2dValue) if ref $sfvec2dValue;

	return new MFVec2d if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sfvec2dValues = $this->sfvec2dValues;
		return new MFVec2d($sfvec2dValues)
		  if @$sfvec2dValues && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfvec2dValues {
	my $this          = shift;
	my $sfvec2dValue  = $this->sfvec2dValue;
	my $sfvec2dValues = [];
	while ( ref $sfvec2dValue ) {
		push @$sfvec2dValues, $sfvec2dValue;
		$sfvec2dValue = $this->sfvec2dValue;
	}
	return $sfvec2dValues;
}

sub mfvec2fValue {
	my $this = shift;

	my $sfvec2fValue = $this->sfvec2fValue;
	return new MFVec2f($sfvec2fValue) if ref $sfvec2fValue;

	return new MFVec2f if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sfvec2fValues = $this->sfvec2fValues;
		return new MFVec2f($sfvec2fValues)
		  if @$sfvec2fValues && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfvec2fValues {
	my $this          = shift;
	my $sfvec2fValue  = $this->sfvec2fValue;
	my $sfvec2fValues = [];
	while ( ref $sfvec2fValue ) {
		push @$sfvec2fValues, $sfvec2fValue;
		$sfvec2fValue = $this->sfvec2fValue;
	}
	return $sfvec2fValues;
}

sub mfvec3dValue {
	my $this = shift;

	my $sfvec3dValue = $this->sfvec3dValue;
	return new MFVec3d($sfvec3dValue) if ref $sfvec3dValue;

	return new MFVec3d if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sfvec3dValues = $this->sfvec3dValues;
		return new MFVec3d($sfvec3dValues)
		  if @$sfvec3dValues && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfvec3dValues {
	my $this          = shift;
	my $sfvec3dValue  = $this->sfvec3dValue;
	my $sfvec3dValues = [];
	while ( ref $sfvec3dValue ) {
		push @$sfvec3dValues, $sfvec3dValue;
		$sfvec3dValue = $this->sfvec3dValue;
	}
	return $sfvec3dValues;
}

sub mfvec3fValue {
	my $this = shift;

	my $sfvec3fValue = $this->sfvec3fValue;
	return new MFVec3f($sfvec3fValue) if ref $sfvec3fValue;

	return new MFVec3f if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sfvec3fValues = $this->sfvec3fValues;
		return new MFVec3f($sfvec3fValues)
		  if @$sfvec3fValues && $this->{string} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfvec3fValues {
	my $this          = shift;
	my $sfvec3fValue  = $this->sfvec3fValue;
	my $sfvec3fValues = [];
	while ( ref $sfvec3fValue ) {
		push @$sfvec3fValues, $sfvec3fValue;
		$sfvec3fValue = $this->sfvec3fValue;
	}
	return $sfvec3fValues;
}

# Fields CosmoWorlds
sub sfenumValue {
	my $this = shift;
	my $enum = $this->enum;
	return new SFEnum($enum) if defined $enum;
}

sub enum {
	my $this = shift;
	return $1 if $this->{string} =~ m/$_enum/gc;
	return;
}

sub mfenumValue {
	my $this = shift;

	my $sfenumValue = $this->sfenumValue;
	return new MFEnum($sfenumValue) if ref $sfenumValue;

	return new MFEnum if $this->{string} =~ m/$_brackets/gc;

	if ( $this->{string} =~ m/$_open_bracket/gc ) {
		my $sfenumValues = $this->sfenumValues;
		return new MFEnum($sfenumValues)
		  if @$sfenumValues && $this->{string} =~ m/$_close_bracket/gc;
	}
	return;
}

sub sfenumValues {
	my $this         = shift;
	my $sfenumValue  = $this->sfenumValue;
	my $sfenumValues = [];
	while ( ref $sfenumValue ) {
		push @$sfenumValues, $sfenumValue;
		$sfenumValue = $this->sfenumValue;
	}
	return $sfenumValues;
}

1;
__END__
printf "%s\n", __PACKAGE__->new;

