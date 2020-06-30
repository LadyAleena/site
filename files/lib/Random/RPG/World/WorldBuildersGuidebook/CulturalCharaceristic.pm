package Random::RPG::World::WorldBuildersGuidebook::CulturalCharaceristic;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_cultural_characteristic);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR.
# Cultural Characteristics (Table 21)

my %cultural_characteristics;
$cultural_characteristics{$_} = 'Aborigial'             for 1..3;
$cultural_characteristics{$_} = 'African'               for 4..9;
$cultural_characteristics{$_} = 'Arabic'                for 10..18;
$cultural_characteristics{$_} = 'Aztec/Incan'           for 19..20;
$cultural_characteristics{$_} = 'Barbarian'             for 21..24;
$cultural_characteristics{$_} = 'Central Asian'         for 25..29;
$cultural_characteristics{$_} = 'Egyptian'              for 30..33;
$cultural_characteristics{$_} = 'European, Renaissance' for 34..44;
$cultural_characteristics{$_} = 'European, Middle Ages' for 45..59;
$cultural_characteristics{$_} = 'European, Dark Ages'   for 60..74;
$cultural_characteristics{$_} = 'Indian'                for 75..78;
$cultural_characteristics{$_} = 'Oriental'              for 79..87;
$cultural_characteristics{$_} = 'Persian'               for 88..89;
$cultural_characteristics{$_} = 'Roman'                 for 90..93;
$cultural_characteristics{$_} = 'Savage'                for 94..96;
$cultural_characteristics{$_} = 'Viking'                for 97..100;

sub random_cultural_characteristic {
  my $percent = percentile;
  return $cultural_characteristics{$percent};
}

1;