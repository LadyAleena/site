package Random::RPG::World::WorldBuildersGuidebook::SeasonalVariations;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_seasonal_variations);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# SeasonalVariations (Table 14)

my %seasonal_variations;
$seasonal_variations{$_} = 'none'     for 1..10;
$seasonal_variations{$_} = 'mild'     for 11.30;
$seasonal_variations{$_} = 'moderate' for 31..75;
$seasonal_variations{$_} = 'severe'   for 76..90;
$seasonal_variations{$_} = 'extreme'  for 91..100;

sub random_seasonal_variations {
  my $percent = percentile;
  return $seasonal_variations{$percent};
}

1;