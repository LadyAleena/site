package Random::RPG::World::WorldBuildersGuidebook::EarthquakeActivity;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_earthquake_activity);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Earthquake Activity (Table 10)

my %earthquake_activity;

$earthquake_activity{$_}{strength}  = 'mild'     for 1..49;
$earthquake_activity{$_}{strength}  = 'moderate' for 50..84;
$earthquake_activity{$_}{strength}  = 'strong'   for 85..100;

$earthquake_activity{$_}{frequency} = 'rare'     for (1..29, 50..65, 85..94);
$earthquake_activity{$_}{frequency} = 'uncommon' for (30..39, 66..74, 95..98);
$earthquake_activity{$_}{frequency} = 'common'   for (40..49, 75..84, 99..100);

sub random_earthquake_activity {
  my $percent = percentile;
  return $earthquake_activity{$percent};
}

1;