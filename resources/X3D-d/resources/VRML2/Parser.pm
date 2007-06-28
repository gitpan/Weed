package VRML2::Parser;
use strict;

BEGIN {
	use Carp;
	use Exporter;

	use VRML2::Parser::Symbols;
	use VRML2::Parser::Errors;
	use VRML2::Console;

	use VRML2::Proto;
	use VRML2::EventTypes;
	use VRML2::FieldTypes;
	use VRML2::Node::Node;
	use VRML2::Node::Script;
	use VRML2::Route;

	use vars qw(@ISA @EXPORT);
	@ISA = qw(
		VRML2::Parser::Symbols
		VRML2::Parser::Errors
		Exporter
	);
	
	@EXPORT = qw($_CosmoWorlds);
}

sub new {
	#print CONSOLE "\n";
	#print CONSOLE "VRML2::Parser::new\n";
	my $self  = shift;
	my $class = ref($self) || $self;
	my $this  = {
		comment => '',
	};
	bless $this, $class;

	return $this;
}

# General
sub parse {
	#print CONSOLE "VRML2::Parser::parse\n";
	my $this = shift;

	$this->{parent}     = shift;
	$this->{vrmlSyntax} = join '', @_;

	$this->{protos}       = [];
	$this->{protosByName} = {};
	$this->{routes}       = {};

	$this->setError();

	$this->removeComments;
	
	my $vrmlScene;
	eval {
		$vrmlScene = $this->vrmlScene;
	};
	$this->setError($@) if $@;
	$this->setError("Unknown statement \"$1\"\n") if ($this->{vrmlSyntax} =~ m/\G\s*([^\s]+)/sgc);
	
	#print CONSOLE "VRML2::Parser::parse done\n";

	return $vrmlScene;

	# no vrml header
	return;
}

sub removeComments {
	#print CONSOLE "VRML2::Parser::removeComments\n";
	my $this = shift;
	$this->{vrmlSyntax} =~ s/$_header//gc;
	$this->{vrmlSyntax} =~ s/$_comment//gc;
	return;
}


# General
sub vrmlScene {
	#print CONSOLE "VRML2::Parser::vrmlScene\n";
	my $this = shift;
	my $statements = $this->statements;
	return $statements;
}

sub statements {
	#print CONSOLE "VRML2::Parser::statements\n";
	my $this = shift;
	my $statement = $this->statement;
	my $statements = [];
	while (ref $statement) {
		push @{$statements}, $statement;
		$statement = $this->statement;
	}
	return $statements;
}

sub statement {
	#print CONSOLE "VRML2::Parser::statement\n";
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
	#print CONSOLE "VRML2::Parser::nodeStatement\n";
	my $this = shift;

	if ($this->{vrmlSyntax} =~ m/$_DEF/gc) {
		my $nodeNameId = $this->nodeNameId;
		if ($nodeNameId) {
			#print CONSOLE "VRML2::Parser::nodeStatement DEF $nodeNameId\n";
			my $node = $this->node($nodeNameId);
			if (ref $node) {
				return $node;
			} else {
				croak "Premature end of file after DEF\n";
			}

		} else {
			croak "No name given after DEF\n";
		}
	}

	if ($this->{vrmlSyntax} =~ m/$_USE/gc) {
		my $nodeNameId = $this->nodeNameId;
		#print CONSOLE "VRML2::Parser::nodeStatement USE $nodeNameId\n";

		if ($nodeNameId) {
			my $node = $this->{parent}->getNodeByName($nodeNameId);
			if (ref $node) {
				my $clone = $node->clone;
				return $clone;
			} else {
				croak "Unknown reference \"$nodeNameId\"\n";
			}
		} else {
			croak "Expected nodeNameId after USE\n";
		}
	}

	my $node = $this->node;
	if (ref $node) {
		return $node; 
	}

	return;
}

sub rootNodeStatement {
	#print CONSOLE "VRML2::Parser::rootNodeStatement\n";
	my $this = shift;

	if ($this->{vrmlSyntax} =~ m/$_DEF/gc) {
		my $nodeNameId = $this->nodeNameId;
		if ($nodeNameId) {
			#print CONSOLE "VRML2::Parser::rootNodeStatement $nodeNameId\n";
			my $node = $this->node($nodeNameId);
			if (ref $node) {
				return $node;
			} else {
				croak "Premature end of file after DEF\n";
			}

		} else {
			croak "No name given after DEF\n";
		}
	}

	my $node = $this->node;
	if (ref $node) {
		return $node; 
	}

	return;
}

sub protoStatement {
	#print CONSOLE "VRML2::Parser::protoStatement\n";
	my $this = shift;
	my $proto;
	
	$proto = $this->proto;
	unless (ref $proto) {
		$proto = $this->externproto;
	}

	if (ref $proto) {
		$this->addProto($proto);
		return $proto;
	}

	return;
}

sub protoStatements {
	#print CONSOLE "VRML2::Parser::protoStatements\n";
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
	#print CONSOLE "VRML2::Parser::proto\n";
	my $this = shift;

	if ($this->{vrmlSyntax} =~ m/$_PROTO/gc) {
		my $nodeTypeId = $this->nodeTypeId;
		if ($nodeTypeId) {
			if ($this->{vrmlSyntax} =~ m/$_open_bracket/gc) {
				my $interfaceDeclarations = $this->interfaceDeclarations;
				if (@{$interfaceDeclarations}) {
					if ($this->{vrmlSyntax} =~ m/$_close_bracket/gc) {
						if ($this->{vrmlSyntax} =~ m/$_open_brace/gc) {
							my $proto = new VRML2::Proto($this->{parent}, $nodeTypeId, $interfaceDeclarations);
		
							$this->{parent} = $proto;
							my $protoBody = $this->protoBody;
							$this->{parent} = $proto->getParent;
		
							if ($this->{vrmlSyntax} =~ m/$_close_brace/gc) {
								#print CONSOLE "VRML2::Parser::proto $nodeTypeId done\n";
								$proto->setBody($protoBody);
								return $proto;
							}  else {
								croak "Expected a '}' to end prototype definition\n";
							}
						} else {
							croak "Expected a '{' to begin prototype definition\n";
						}

					} else {
						croak "Expected a ']'\n";
					}

				}
			} else {
				croak "Expected a '['\n";
			}

		} else {
			croak "Invalid prototype definition name\n";
		}
	}

	return;
}

sub protoBody {
	#print CONSOLE "VRML2::Parser::protoBody\n";
	my $this = shift;
	my $protoBody = [undef, undef, undef];
	$protoBody->[0] = $this->protoStatements;
	$protoBody->[1] = $this->rootNodeStatement;
	$protoBody->[2] = $this->statements;
	#print CONSOLE "VRML2::Parser::protoBody done\n";
	return $protoBody;
}

sub interfaceDeclarations {
	#print CONSOLE "VRML2::Parser::interfaceDeclarations\n";
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
	#print CONSOLE "VRML2::Parser::restrictedInterfaceDeclaration\n";
	my $this = shift;

	if ($this->{vrmlSyntax} =~ m/$_eventIn/gc) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $eventInId = $this->eventInId;
			if ($eventInId) {
				#print CONSOLE "VRML2::Parser::restrictedInterfaceDeclaration eventIn $fieldType $eventInId\n";
				return new eventIn (
					$fieldType,
					$eventInId
				);
			} else {
				croak "Expected name for field\n";
			}
		} else {
			croak "Unknown event or field type: \"", $this->Id, "\"\n";
		}
	}

	if ($this->{vrmlSyntax} =~ m/$_eventOut/gc) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $eventOutId = $this->eventOutId;
			if ($eventOutId) {
				#print CONSOLE "VRML2::Parser::restrictedInterfaceDeclaration eventOut $fieldType $eventOutId\n";
				return new eventOut (
					$fieldType,
					$eventOutId
				);
			} else {
				croak "Expected name for field\n";
			}
		} else {
			croak "Unknown event or field type: \"", $this->Id, "\"\n";
		}
	}

	if ($this->{vrmlSyntax} =~ m/$_field/gc) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $fieldId = $this->fieldId;
			if ($fieldId) {
				my $fieldValue = $this->fieldValue($fieldType);
				if (ref $fieldValue) {
					#print CONSOLE "VRML2::Parser::restrictedInterfaceDeclaration field $fieldType $fieldId $fieldValue\n";
					return new field (
						$fieldType,
						$fieldId,
						$fieldValue
					);
				} else {
					croak "Couldn't read value for field \"", $fieldId,"\"\n";
				}
			} else {
				croak "Expected name for field\n";
			}
		} else {
			croak "Unknown event or field type: \"", $this->Id, "\"\n";
		}
	}

	return;
}

sub interfaceDeclaration {
	#print CONSOLE "VRML2::Parser::interfaceDeclaration\n";
	my $this = shift;
	
	my $restrictedInterfaceDeclaration = $this->restrictedInterfaceDeclaration;
	return $restrictedInterfaceDeclaration if ref $restrictedInterfaceDeclaration;

	if ($this->{vrmlSyntax} =~ m/$_exposedField/gc) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $fieldId = $this->fieldId;
			if ($fieldId) {
				my $fieldValue = $this->fieldValue($fieldType);
				if (ref $fieldValue) {
					#print CONSOLE "VRML2::Parser::interfaceDeclaration exposedField $fieldType $fieldId $fieldValue\n";
					return new exposedField (
						$fieldType,
						$fieldId,
						$fieldValue
					);
				} else {
					croak "Couldn't read value for field \"", $fieldId,"\"\n";
				}
			} else {
				croak "Expected name for field\n";
			}
		} else {
			croak "Unknown event or field type: \"", $this->Id, "\"\n";
		}
	}

	return;
}
sub externproto {
	#print CONSOLE "VRML2::Parser::externproto\n";
	my $this = shift;

	if ($this->{vrmlSyntax} =~ m/$_EXTERNPROTO/gc) {
		my $nodeTypeId = $this->nodeTypeId;
		if ($nodeTypeId) {
			if ($this->{vrmlSyntax} =~ m/$_open_bracket/gc) {
				my $externInterfaceDeclarations = $this->externInterfaceDeclarations;
				if (@{$externInterfaceDeclarations}) {
					if ($this->{vrmlSyntax} =~ m/$_close_bracket/gc) {
						my $URLList = $this->URLList;
						if (ref $URLList) {
							my $proto = new VRML2::Proto($this->{parent}, $nodeTypeId, $externInterfaceDeclarations);
							$proto->setURL($URLList);
							return $proto;
						}  else {
							croak "Expected URL list in EXTERNPROTO $nodeTypeId\n";
						}
					} else {
						croak "Expected a ']'\n";
					}
				}
			} else {
				croak "Expected a '['\n";
			}
		} else {
			croak "Invalid prototype definition name\n";
		}
	}

	return;
}

sub externInterfaceDeclarations {
	#print CONSOLE "VRML2::Parser::externInterfaceDeclarations\n";
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
	#print CONSOLE "VRML2::Parser::externInterfaceDeclaration\n";
	my $this = shift;
	
	if ($this->{vrmlSyntax} =~ m/$_eventIn/gc) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $eventInId = $this->eventInId;
			if ($eventInId) {
				#print CONSOLE "VRML2::Parser::externInterfaceDeclaration eventIn $fieldType $eventInId\n";
				return new eventIn (
					$fieldType,
					$eventInId
				);
			} else {
				croak "Expected name for field\n";
			}
		} else {
			croak "Unknown event or field type: \"", $this->Id, "\"\n";
		}
	}

	if ($this->{vrmlSyntax} =~ m/$_eventOut/gc) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $eventOutId = $this->eventOutId;
			if ($eventOutId) {
				#print CONSOLE "VRML2::Parser::externInterfaceDeclaration eventOut $fieldType $eventOutId\n";
				return new eventOut (
					$fieldType,
					$eventOutId
				);
			} else {
				croak "Expected name for field\n";
			}
		} else {
			croak "Unknown event or field type: \"", $this->Id, "\"\n";
		}
	}

	if ($this->{vrmlSyntax} =~ m/$_field/gc) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $fieldId = $this->fieldId;
			if ($fieldId) {
				#print CONSOLE "VRML2::Parser::externInterfaceDeclaration field $fieldType $fieldId\n";
				return new field (
					$fieldType,
					$fieldId,
				);
			} else {
				croak "Expected name for field\n";
			}
		} else {
			croak "Unknown event or field type: \"", $this->Id, "\"\n";
		}
	}

	if ($this->{vrmlSyntax} =~ m/$_exposedField/gc) {
		my $fieldType = $this->fieldType;
		if ($fieldType) {
			my $fieldId = $this->fieldId;
			if ($fieldId) {
				#print CONSOLE "VRML2::Parser::externInterfaceDeclaration exposedField $fieldType $fieldId\n";
				return new exposedField (
					$fieldType,
					$fieldId,
				);
			} else {
				croak "Expected name for field\n";
			}
		} else {
			croak "Unknown event or field type: \"", $this->Id, "\"\n";
		}
	}

	return;
}

sub routeStatement {
	#print CONSOLE "VRML2::Parser::routeStatement\n";
	my $this = shift;
	if ($this->{vrmlSyntax} =~ m/$_ROUTE/gc) {
		if ($this->{vrmlSyntax} =~ m/$_Id/gc) {
			my $fromNodeId = $1;
			my $fromNode   = $this->{parent}->getNodeByName($fromNodeId);

			if (ref $fromNode) {
				if ($this->{vrmlSyntax} =~ m/$_period/gc) {
					if ($this->{vrmlSyntax} =~ m/$_Id/gc) {
						my $eventOutId = $1;
						my $eventOut   = $fromNode->getField($eventOutId, 0);

						if (ref $eventOut) {
							if ($this->{vrmlSyntax} =~ m/$_TO/gc) {
								if ($this->{vrmlSyntax} =~ m/$_Id/gc) {
									my $toNodeId = $1;
									my $toNode   = $this->{parent}->getNodeByName($toNodeId);

									if (ref $toNode) {
										if ($this->{vrmlSyntax} =~ m/$_period/gc) {
											if ($this->{vrmlSyntax} =~ m/$_Id/gc) {
												my $eventInId = $1;
												my $eventIn   = $toNode->getField($eventInId, 0);

												if (ref $eventIn) {
													if ($eventOut->getType eq $eventIn->getType) {
															return new VRML2::Route($fromNode, $eventOutId, $toNode, $eventInId);
													} else {
														croak "ROUTE types do not match\n";
													} 

												} else {
													croak
														"Unknown eventIn \"$eventInId\" in node \"$toNodeId\"\n",
														"Bad ROUTE specification\n";
												}

											} else {
												croak "Bad ROUTE specification\n";
											}
											
										} else {
											croak "Bad ROUTE specification\n";
										}

									} else {
										croak
											"Unknown node \"$toNodeId\"\n",
											"Bad ROUTE specification\n";
									}

								} else {
									croak "Bad ROUTE specification\n";
								}

							} else {
								croak "Bad ROUTE specification\n";
							}

						} else {
							croak
								"Unknown eventOut \"$eventOutId\" in node \"$fromNodeId\"\n",
								"Bad ROUTE specification\n";
						}

					} else {
						croak "Bad ROUTE specification\n";
					}

				} else {
					croak "Bad ROUTE specification\n";
				}

			} else {
				croak
					"Unknown node \"$fromNodeId\"\n",
					"Bad ROUTE specification\n";
			}
		}
	}
	return;
}

sub URLList {
	#print CONSOLE "VRML2::Parser::URLList\n";
	my $this = shift;
	return $this->mfstringValue;
}

# Nodes
sub node {
	#print CONSOLE "VRML2::Parser::node\n";
	my $this = shift;
	my $nodeNameId = shift;


	if ($this->{vrmlSyntax} =~ m/$_NodeTypeId/gc) {
		my $type = $1;
		if ($this->{vrmlSyntax} =~ m/$_open_brace/gc) {
			my $proto = $this->getProto($type);
			if (ref $proto) {
				#print CONSOLE "VRML2::Parser::node $type\n";
				my $node = new SFNode();
	
				if ($type eq 'Script') {
					my $baseNode = new VRML2::Node::Script($this->{parent}, $nodeNameId, $proto);
					$node->setValue($baseNode);
	
					$this->{parent}->addNode($node);
	
					my $body = $this->scriptBody($proto);
					$baseNode->setBody($body);
	
				} else {
					my $baseNode = new VRML2::Node::Node($this->{parent}, $nodeNameId, $proto);
	
					$node->setValue($baseNode);
					$this->{parent}->addNode($node);
	
					my $body = $this->nodeBody($proto);
					$baseNode->setBody($body);
				}
	
				if ($this->{vrmlSyntax} =~ m/$_close_brace/gc) {
					return $node;
				} else {
					croak "Expected '}'\n";
				}
	
			} else {
				croak "Unknown class \"$type\"\n";
			}
		} else {
			croak "Expected '{'\n";
		}
	}

	#print CONSOLE "VRML2::Parser::node undef\n";
	return;
}

sub nodeBody {
	#print CONSOLE "VRML2::Parser::nodeBody\n";
	my $this = shift;
	my $proto = shift;
	my $nodeBodyElement = $this->nodeBodyElement($proto);
	my $nodeBody = [];
	while (ref $nodeBodyElement) {
		push @{$nodeBody}, $nodeBodyElement if ref $nodeBodyElement;
		$nodeBodyElement = $this->nodeBodyElement($proto);
	}
	return $nodeBody;
}

sub scriptBody {
	#print CONSOLE "VRML2::Parser::scriptBody\n";
	my $this = shift;
	my $proto = shift;
	my $scriptBodyElement = $this->scriptBodyElement($proto);
	my $scriptBody = [];
	while (ref $scriptBodyElement) {
		push @{$scriptBody}, $scriptBodyElement if ref $scriptBodyElement;
		$scriptBodyElement = $this->scriptBodyElement($proto);
	}
	return $scriptBody;
}

sub scriptBodyElement {
	#print CONSOLE "VRML2::Parser::scriptBodyElement\n";
	my $this = shift;
	my $proto = shift;

	if ($this->{vrmlSyntax} =~ m/$_ScriptNodeInterface_IS/gc) {
		my $fieldClass = $1;
		my $fieldType  = $2;
		my $fieldId    = $3;

		my $field = {type => $fieldType, name => $fieldId};
		bless $field, $fieldClass;
		#print CONSOLE "VRML2::Parser::scriptBodyElement", ref $field,"\n";

		if (ref $this->{parent} ne 'VRML2::Browser') {
			my $is = $this->Id;
			my $isField = $this->{parent}->getField($is);

			if (ref $isField) {
				if ($field ge $isField) {
					if ($field->getType eq $isField->getType) {
						return $field->new(
							$fieldType,
							$fieldId,
							$isField->getValue,
							$isField
						);
					} else {
						croak
							"Field ", $field->getName, " and ", $isField->getName,
							" in PROTO ", $this->{parent}->getName,
							" have different types\n"
							;
					}
				} else {
					croak
						"Field ", $field->getName, " and ", $isField->getName,
						" in PROTO ", $this->{parent}->getName,
						" are incompatible as an IS mapping\n"
						;
				}
			} else {
				croak "No such event or field \"$is\" inside PROTO ", $this->{parent}->getName, "\n";
			}	
		} else {
			croak "IS statement outside PROTO definition\n";
		}
		
	}	

	my $restrictedInterfaceDeclaration = $this->restrictedInterfaceDeclaration;
	return $restrictedInterfaceDeclaration if ref $restrictedInterfaceDeclaration;

	my $nodeBodyElement = $this->nodeBodyElement($proto);
	return $nodeBodyElement if ref $nodeBodyElement;
	

	return;
}

sub nodeBodyElement {
	my $this = shift;
	my $proto = shift;
	#print CONSOLE "VRML2::Parser::nodeBodyElement\n";

	my $protoStatement = $this->protoStatement;
	return $protoStatement if ref $protoStatement;

	my $routeStatement = $this->routeStatement;
	return $routeStatement if ref $routeStatement;

	my $fieldId = $this->fieldId;
	if ($fieldId) {
		#print CONSOLE "VRML2::Parser::nodeBodyElement $fieldId\n";
	
		my $field = $proto->getField($fieldId);
		if (ref $field) {

			if ($this->{vrmlSyntax} =~ m/$_IS/gc) {
				if (ref $this->{parent} ne 'VRML2::Browser') {
					my $is = $this->Id;
					#print CONSOLE "VRML2::Parser::nodeBodyElement IS mapping", $is, "\n";
					my $isField = $this->{parent}->getField($is);
					if (ref $isField) {
						if ($field ge $isField) {
							if ($field->getType eq $isField->getType) {
								return $field->new(
									$field->getType,
									$fieldId,
									$isField->getValue,
									$isField
								);
							} else {
								croak
									"Field ", $field->getName, " and ", $isField->getName,
									" in PROTO ", $this->{parent}->getName,
									" have different types\n"
									;
							}
						} else {
							croak
								"Field ", $field->getName, " and ", $isField->getName,
								" in PROTO ", $this->{parent}->getName,
								" are incompatible as an IS mapping\n"
								;
						}
					} else {
						croak "No such event or field \"$is\" inside PROTO ", $this->{parent}->getName, "\n";
					}
				} else {
					croak "IS statement outside PROTO definition\n";
				}
			}
		
			my $fieldValue = $this->fieldValue($field->getType);
			if (ref $fieldValue) {
				return $field->new(
					$field->getType,
					$fieldId,
					$fieldValue
				);
			} else {
				croak "Couldn't read value for field \"", $fieldId,"\"\n";
			}

		} else {
			croak "Unknown field \"$fieldId\" in class \"", $proto->getName, "\"\n";
		}
	}
	#print CONSOLE "VRML2::Parser::nodeBodyElement undef\n";
	return;
}

sub nodeNameId {
	#print CONSOLE "VRML2::Parser::nodeNameId\n";
	my $this = shift;
	return $this->Id;
}

sub nodeTypeId {
	#print CONSOLE "VRML2::Parser::nodeTypeId\n";
	my $this = shift;
	return $this->Id;
}

sub fieldId {
	#print CONSOLE "VRML2::Parser::fieldId\n";
	my $this = shift;
	return $this->Id;
}

sub eventInId {
	#print CONSOLE "VRML2::Parser::EventInId\n";
	my $this = shift;
	return $this->Id;
}

sub eventOutId {
	#print CONSOLE "VRML2::Parser::EventOutId\n";
	my $this = shift;
	return $this->Id;
}

sub Id {
	#print CONSOLE "VRML2::Parser::Id\n";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ m/$_Id/gc;
	return;
}

# Fields
sub fieldType {
	#print CONSOLE "VRML2::Parser::fieldType\n";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ m/$_fieldType/gc;
	return;
}



sub fieldValue {
	#print CONSOLE "VRML2::Parser::fieldValue\n";
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

	if ($this->{comment} =~ /$_CosmoWorlds/) {
		my $version = $1;
		return $this->sfenumValue if $fieldType eq 'SFEnum';
		return $this->mfenumValue if $fieldType eq 'MFEnum';
	}

	return;
}

sub sfboolValue {
	#print CONSOLE "VRML2::Parser::sfboolValue\n";
	my $this = shift;
	return new SFBool(1) if $this->{vrmlSyntax} =~ m/$_TRUE/gc;
	return new SFBool    if $this->{vrmlSyntax} =~ m/$_FALSE/gc;
	return;
}

sub sfcolorValue {
	#print CONSOLE "VRML2::Parser::sfcolorValue\n";
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
	#print CONSOLE "VRML2::Parser::sffloatValue\n";
	my $this = shift;
	my $float = $this->float;
	return new SFFloat($float) if defined $float;
	return;
}

sub float {
	#print CONSOLE "VRML2::Parser::float\n";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ m/$_float/gc;
	return 0  if $this->{vrmlSyntax} =~ m/$_nan/gc;
	#return ...  if $this->{vrmlSyntax} =~ m/$_inf/gc;
	#print CONSOLE "VRML2::Parser::float undef\n";
	return;
}

sub sfimageValue {
	#print CONSOLE "VRML2::Parser::sfimageValue\n";
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
	#print CONSOLE "VRML2::Parser::sfint32Value\n";
	my $this = shift;
	my $int32 = $this->int32;
	return new SFInt32($int32) if defined $int32;
	return;
}

sub int32 {
	#print CONSOLE "VRML2::Parser::int32\n";
	my $this = shift;
	return defined $3 ? hex($1) : $1 if $this->{vrmlSyntax} =~ m/$_int32/gc;
	return;
}

sub sfnodeValue {
	#print CONSOLE "VRML2::Parser::sfnodeValue\n";
	my $this = shift;
	my $nodeStatement = $this->nodeStatement;
	return $nodeStatement if ref $nodeStatement;
	return new SFNode if $this->{vrmlSyntax} =~ m/$_NULL/gc;
	return;
}

sub sfrotationValue {
	#print CONSOLE "VRML2::Parser::sfrotationValue\n";
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
	#print CONSOLE "VRML2::Parser::sfstringValue\n";
	my $this = shift;
	my $string = $this->string;
	return new SFString($string) if defined $string;
	return;
}

sub string {
	#print CONSOLE "VRML2::Parser::string\n";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ m/$_string/gc;
	return;
}

sub sftimeValue {
	#print CONSOLE "VRML2::Parser::sftimeValue\n";
	my $this = shift;
	my $time = $this->double;
	return new SFTime($time) if defined $time;
	return;
}

sub double {
	#print CONSOLE "VRML2::Parser::double\n";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ m/$_double/gc;
	return;
}

sub mftimeValue {
	#print CONSOLE "VRML2::Parser::mftimeValue\n";
	my $this = shift;

	my $sftimeValue = $this->sftimeValue;
	return new MFTime($sftimeValue) if ref $sftimeValue;

	return new MFTime if $this->{vrmlSyntax} =~ m/$_brackets/gc;

	if ($this->{vrmlSyntax} =~ m/$_open_bracket/gc) {
		my $sftimeValues = $this->sftimeValues;
		return new MFTime($sftimeValues) if @{$sftimeValues} && $this->{vrmlSyntax} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sftimeValues {
	#print CONSOLE "VRML2::Parser::sftimeValues\n";
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
	#print CONSOLE "VRML2::Parser::sfvec2fValue\n";
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
	#print CONSOLE "VRML2::Parser::sfvec3fValue\n";
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
	#print CONSOLE "VRML2::Parser::mfcolorValue\n";
	my $this = shift;

	my $sfcolorValue = $this->sfcolorValue;
	return new MFColor($sfcolorValue) if ref $sfcolorValue;

	return new MFColor if $this->{vrmlSyntax} =~ m/$_brackets/gc;

	if ($this->{vrmlSyntax} =~ m/$_open_bracket/gc) {
		my $sfcolorValues = $this->sfcolorValues;
		return new MFColor($sfcolorValues) if @{$sfcolorValues} && $this->{vrmlSyntax} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfcolorValues {
	#print CONSOLE "VRML2::Parser::sfcolorValues\n";
	my $this = shift;
	my $sfcolorValue = $this->sfcolorValue;
	my $sfcolorValues = [];
	while (ref $sfcolorValue) {
		push @{$sfcolorValues}, $sfcolorValue;
		$sfcolorValue = $this->sfcolorValue
	}
	return $sfcolorValues;
}


sub mffloatValue {
	#print CONSOLE "VRML2::Parser::mffloatValue\n";
	my $this = shift;

	my $sffloatValue = $this->sffloatValue;
	return new MFFloat($sffloatValue) if ref $sffloatValue;

	return new MFFloat if $this->{vrmlSyntax} =~ m/$_brackets/gc;

	if ($this->{vrmlSyntax} =~ m/$_open_bracket/gc) {
		my $sffloatValues = $this->sffloatValues;
		return new MFFloat($sffloatValues) if @{$sffloatValues} && $this->{vrmlSyntax} =~ m/$_close_bracket/gc;
	}

	return;
}


sub sffloatValues {
	#print CONSOLE "VRML2::Parser::sffloatValues\n";
	my $this = shift;
	my $sffloatValue = $this->sffloatValue;
	my $sffloatValues = [];
	while (ref $sffloatValue) {
		push @{$sffloatValues}, $sffloatValue;
		$sffloatValue = $this->sffloatValue
	}
	return $sffloatValues;
}

sub mfint32Value {
	#print CONSOLE "VRML2::Parser::mfin32Value\n";
	my $this = shift;

	my $sfint32Value = $this->sfint32Value;
	return new MFInt32($sfint32Value) if ref $sfint32Value;

	return new MFInt32 if $this->{vrmlSyntax} =~ m/$_brackets/gc;

	if ($this->{vrmlSyntax} =~ m/$_open_bracket/gc) {
		my $sfint32Values = $this->sfint32Values;
		return new MFInt32($sfint32Values) if @{$sfint32Values} && $this->{vrmlSyntax} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfint32Values {
	#print CONSOLE "VRML2::Parser::sfint32Values\n";
	my $this = shift;
	my $sfint32Value = $this->sfint32Value;
	my $sfint32Values = [];
	while (ref $sfint32Value) {
		push @{$sfint32Values}, $sfint32Value;
		$sfint32Value = $this->sfint32Value
	}
	return  $sfint32Values;
}

sub mfnodeValue {
	#print CONSOLE "VRML2::Parser::mfnodeValue\n";
	my $this = shift;

	my $node = $this->nodeStatement;
	return new MFNode($node) if ref $node;

	return new MFNode if $this->{vrmlSyntax} =~ m/$_brackets/gc;

	if ($this->{vrmlSyntax} =~ m/$_open_bracket/gc) {
		my $nodes = $this->nodeStatements;
		return new MFNode($nodes)
			if @{$nodes} && $this->{vrmlSyntax} =~ m/$_close_bracket/gc;
	}

	return;
}

sub nodeStatements {
	#print CONSOLE "VRML2::Parser::nodeStatements\n";
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
	#print CONSOLE "VRML2::Parser::mfrotationValue\n";
	my $this = shift;

	my $sfrotationValue = $this->sfrotationValue;
	return new MFRotation($sfrotationValue) if ref $sfrotationValue;

	return new MFRotation if $this->{vrmlSyntax} =~ m/$_brackets/gc;

	if ($this->{vrmlSyntax} =~ m/$_open_bracket/gc) {
		my $sfrotationValues = $this->sfrotationValues;
		return new MFRotation($sfrotationValues) if @{$sfrotationValues} && $this->{vrmlSyntax} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfrotationValues {
	#print CONSOLE "VRML2::Parser::sfrotationValues\n";
	my $this = shift;
	my $sfrotationValue = $this->sfrotationValue;
	my $sfrotationValues = [];
	while (ref $sfrotationValue) {
		push @{$sfrotationValues}, $sfrotationValue;
		$sfrotationValue = $this->sfrotationValue;
	}
	return $sfrotationValues;
}


sub mfstringValue {
	#print CONSOLE "VRML2::Parser::mfstringValues\n";
	my $this = shift;

	my $sfstringValue = $this->sfstringValue;
	return new MFString($sfstringValue) if ref $sfstringValue;

	return new MFString if $this->{vrmlSyntax} =~ m/$_brackets/gc;

	if ($this->{vrmlSyntax} =~ m/$_open_bracket/gc) {
		my $sfstringValues = $this->sfstringValues;
		return new MFString($sfstringValues) if @{$sfstringValues} && $this->{vrmlSyntax} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfstringValues {
	#print CONSOLE "VRML2::Parser::sfstringValues\n";
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
	#print CONSOLE "VRML2::Parser::mfvec2fValue\n";
	my $this = shift;

	my $sfvec2fValue = $this->sfvec2fValue;
	return new MFVec2f($sfvec2fValue) if ref $sfvec2fValue;

	return new MFVec2f if $this->{vrmlSyntax} =~ m/$_brackets/gc;

	if ($this->{vrmlSyntax} =~ m/$_open_bracket/gc) {
		my $sfvec2fValues = $this->sfvec2fValues;
		return new MFVec2f($sfvec2fValues) if @{$sfvec2fValues} && $this->{vrmlSyntax} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfvec2fValues {
	#print CONSOLE "VRML2::Parser::sfvec2fValues\n";
	my $this = shift;
	my $sfvec2fValue = $this->sfvec2fValue;
	my $sfvec2fValues = [];
	while (ref $sfvec2fValue) {
		push @{$sfvec2fValues}, $sfvec2fValue;
		$sfvec2fValue = $this->sfvec2fValue;
	}
	return $sfvec2fValues;
}

sub mfvec3fValue {
	#print CONSOLE "VRML2::Parser::mfvec3fValue\n";
	my $this = shift;

	my $sfvec3fValue = $this->sfvec3fValue;
	return new MFVec3f($sfvec3fValue) if ref $sfvec3fValue;

	return new MFVec3f if $this->{vrmlSyntax} =~ m/$_brackets/gc;

	if ($this->{vrmlSyntax} =~ m/$_open_bracket/gc) {
		my $sfvec3fValues = $this->sfvec3fValues;
		return new MFVec3f($sfvec3fValues) if @{$sfvec3fValues} && $this->{vrmlSyntax} =~ m/$_close_bracket/gc;
	}

	return;
}

sub sfvec3fValues {
	#print CONSOLE "VRML2::Parser::sfvec3fValues\n";
	my $this = shift;
	my $sfvec3fValue = $this->sfvec3fValue;
	my $sfvec3fValues = [];
	while (ref $sfvec3fValue) {
		push @{$sfvec3fValues}, $sfvec3fValue;
		$sfvec3fValue = $this->sfvec3fValue;
	}
	return $sfvec3fValues;
}

# Fields CosmoWorlds
sub sfenumValue {
	#print CONSOLE "VRML2::Parser::sfenumValue\n";
	my $this = shift;
	my $enum = $this->enum;
	return new SFEnum($enum) if defined $enum;
}

sub enum {
	#print CONSOLE "VRML2::Parser::enum\n";
	my $this = shift;
	return $1 if $this->{vrmlSyntax} =~ m/$_enum/gc;
	return;
}

sub mfenumValue {
	#print CONSOLE "VRML2::Parser::mfenumValue\n";
	my $this = shift;

	my $sfenumValue = $this->sfenumValue;
	return new MFEnum($sfenumValue) if ref $sfenumValue;

	return new MFEnum if $this->{vrmlSyntax} =~ m/$_brackets/gc;

	if ($this->{vrmlSyntax} =~ m/$_open_bracket/gc) {
		my $sfenumValues = $this->sfenumValues;
		return new MFEnum($sfenumValues) if @{$sfenumValues} && $this->{vrmlSyntax} =~ m/$_close_bracket/gc;
	}
	return;
}

sub sfenumValues {
	#print CONSOLE "VRML2::Parser::sfenumValues\n";
	my $this = shift;
	my $sfenumValue = $this->sfenumValue;
	my $sfenumValues = [];
	while (ref $sfenumValue) {
		push @{$sfenumValues}, $sfenumValue;
		$sfenumValue = $this->sfenumValue;
	}
	return $sfenumValues;
}

# proto ########################################################################
sub addProto {
	my $this  = shift;
	my $proto = shift;
	#print CONSOLE "VRML2::Browser::addProto ".$proto->getName."\n";
	
	if (ref $this->{parent} eq 'VRML2::Browser') {
		push @{$this->{protos}}, $proto;
		$this->{protosByName}->{$proto->getName} = $proto;
	} else {
		$this->{parent}->addProto($proto);
	}
}

sub getProto {
	my $this = shift;
	my $name = shift;
	#print CONSOLE "VRML2::Browser::getProto $name\n";

	my $proto = $this->{parent}->getProto($name);
	if (ref $proto) {
		#print CONSOLE "VRML2::Browser::getProto standard\n";
		return $proto;
	}

	if (exists $this->{protosByName}->{$name}) {
		#print CONSOLE "VRML2::Browser::getProto standard\n";
		return $this->{protosByName}->{$name};
	}
	
	return;
}

sub getProtos {
	my $this = shift;
	return $this->{protos};
}

sub getProtosByName {
	my $this = shift;
	return $this->{protosByName};
}

# comment ######################################################################
sub getComment {
	my $this = shift;
	return $this->{comment};
}

sub setComment {
	my $this = shift;
	$this->{comment} = shift;
}

# error ########################################################################
sub getError {
	my $this = shift;
	return $this->{error};
}

sub setError {
	my $this = shift;
	my $error = shift;
	if ($error) {
#		$error =~ s/[^\n]*\n$//sg;

		$this->{vrmlSyntax} =~ m/\G(.*)/sgc;
		my $end = $1;
		my $begin = substr $this->{vrmlSyntax}, 0, (length $this->{vrmlSyntax}) - (length $end);

		my $errorLines = 4;
		my $pattern = ".*?\n" x $errorLines;
		
		$end =~ m/^($pattern)/sg;
		my $code = $1;

		my $line = $begin =~ s/(?=\n)//sg + 1;

		$this->{error} = "Parser Error at line $line:\n" .
			$error .
			"code: " .
			$code
		;

	} else {
		$this->{error} = '';
	}
}

1;
__END__
