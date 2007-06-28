package Weed::FieldTypes::BaseFieldTypes::SFNumber;

use overload
  'int' => sub { int $_[0]->getValue },
  '0+'  => sub { 0 + $_[0]->getValue },

  '!' => sub { !$_[0]->getValue },
  '~' => sub { ~( 0 + $_[0]->getValue ) },

  '&' => sub { $_[0]->getValue & $_[1] },
  '|' => sub { $_[0]->getValue | $_[1] },
  '^' => sub { $_[0]->getValue ^ $_[1] },

  '=='  => sub { $_[0]->getValue == $_[1] },
  '!='  => sub { $_[0]->getValue != $_[1] },
  '<=>' => sub { $_[2] ? $_[1] <=> $_[0]->getValue : $_[0]->getValue <=> $_[1] },

  '<<' => sub { $_[2] ? $_[1] << $_[0]->getValue : $_[0]->getValue << $_[1] },
  '>>' => sub { $_[2] ? $_[1] >> $_[0]->getValue : $_[0]->getValue >> $_[1] },

  'neg' => sub { -( 0 + $_[0]->getValue ) },

  '+' => sub { $_[0]->getValue + $_[1] },
  '-' => sub { $_[2] ? $_[1] - $_[0]->getValue : $_[0]->getValue - $_[1] },

  '*' => sub { $_[0]->getValue * $_[1] },
  '/' => sub { $_[2] ? $_[1] / $_[0]->getValue : $_[0]->getValue / $_[1] },
  '%' => sub { $_[2] ? $_[1] % $_[0]->getValue : $_[0]->getValue % $_[1] },

  '**' => sub { $_[2] ? $_[1]**$_[0]->getValue : $_[0]->getValue**$_[1] },

  'cos'  => sub { cos $_[0]->getValue },
  'sin'  => sub { sin $_[0]->getValue },
  'exp'  => sub { exp $_[0]->getValue },
  'abs'  => sub { abs $_[0]->getValue },
  'log'  => sub { log $_[0]->getValue },
  'sqrt' => sub { sqrt $_[0]->getValue },
  ;

1;
__END__
