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
						my $eventOut   = $fromNode->getValue->getField($eventOutId);

						if ( ref $eventOut ) {
							if ( $this->{string} =~ m/$_TO/gc ) {
								if ( $this->{string} =~ m/$_Id/gc ) {
									my $toNodeId = $1;
									my $toNode   = $this->getScene->getNamedNode($toNodeId);

									if ( ref $toNode ) {
										if ( $this->{string} =~ m/$_period/gc ) {
											if ( $this->{string} =~ m/$_Id/gc ) {
												my $eventInId = $1;
												my $eventIn   = $toNode->getValue->getField($eventInId);

												if ( ref $eventIn ) {
													if ( $eventOut->getType eq $eventIn->getType ) {
														#return $this->getScene->addRoute($fromNode, $eventOutId, $toNode, $eventInId);
														return new X3DRoute( $fromNode, $eventOut, $toNode, $eventIn );
													}
													else {
														croak "ROUTE types do not match\n";
													}

												}
												else {
													croak "Unknown eventIn \"$eventInId\" in node \"$toNodeId\"\n", "Bad ROUTE specification\n";
												}

											}
											else {
												croak "Bad ROUTE specification\n";
											}

										}
										else {
											croak "Bad ROUTE specification\n";
										}

									}
									else {
										croak "Unknown node \"$toNodeId\"\n", "Bad ROUTE specification\n";
									}

								}
								else {
									croak "Bad ROUTE specification\n";
								}

							}
							else {
								croak "Bad ROUTE specification\n";
							}

						}
						else {
							croak "Unknown eventOut \"$eventOutId\" in node \"$fromNodeId\"\n", "Bad ROUTE specification\n";
						}

					}
					else {
						croak "Bad ROUTE specification\n";
					}

				}
				else {
					croak "Bad ROUTE specification\n";
				}

			}
			else {
				croak "Unknown node \"$fromNodeId\"\n", "Bad ROUTE specification\n";
			}
		}
	}
	return;
}
