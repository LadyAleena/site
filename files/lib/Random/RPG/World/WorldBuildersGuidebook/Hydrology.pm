package Random::RPG::World::WorldBuildersGuidebook::Hydrology;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(random_hydrology);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# World Hydrology (Table 4)

my %hydrology;
$hydrology{$_} = '20' for 1..10;
$hydrology{$_} = '40' for 11..35;
$hydrology{$_} = '60' for 36..75;
$hydrology{$_} = '80' for 66..90;
$hydrology{$_} = '100' for 91..100;

sub random_hydrology {
  my $percent = percentile;
  return $hydrology{$percent};
}

1;