package Random::RPG::World::WorldBuildersGuidebook::VolcanicActivity;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_volcanic_activity);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Volcanic Activity (Table 9)

my %volcanic_activity;
$volcanic_activity{$_} = 'none'                        for 1..25;
$volcanic_activity{$_} = 'geysers / hot springs'       for 26..33;
$volcanic_activity{$_} = 'extinct volcanoes, sparse'   for 34..49;
$volcanic_activity{$_} = 'extinct volcanoes, numerous' for 50..59;
$volcanic_activity{$_} = 'dormant volcanoes, sparse'   for 60..74;
$volcanic_activity{$_} = 'dormant volcanoes, numerous' for 75..84;
$volcanic_activity{$_} = 'active volcanoes, sparse'    for 86..95;
$volcanic_activity{$_} = 'active volcanoes, numerous'  for 96..100;

sub random_volcanic_activity {
  my $percent = percentile;
  return $volcanic_activity{$percent};
}

1;