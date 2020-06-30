package Random::RPG::World::WorldBuildersGuidebook::PlanetaryTemperature;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_planetary_temperature);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Planetary Temperature (Table 13)

my %planetary_temperature;
$planetary_temperature{$_} = 'inferno' for 1..15;
$planetary_temperature{$_} = 'hot'     for 16..30;
$planetary_temperature{$_} = 'normal'  for 31..70;
$planetary_temperature{$_} = 'cold'    for 71..85;
$planetary_temperature{$_} = 'frozen'  for 86..100;

sub random_planetary_temperature {
  my $percent = percentile;
  return $planetary_temperature{$percent};
}

1;