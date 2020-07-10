package Random::RPG::World::WorldBuildersGuidebook::RacePosition;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(random_race_position);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Race Position (Table 22)

my %race_position;
$race_position{$_} = 'completely intermixed' for 1..15;
$race_position{$_} = 'common communities, separate districts; one race is dominant over the others' for 16..25;
$race_position{$_} = 'common communities, separate districts; one race is dominant but secondary races considered equal' for 26..40;
$race_position{$_} = 'separate communities; one race is dominant' for 41..65;
$race_position{$_} = 'separate communities; one race is dominant but secondary races considered equal' for 66..85;
$race_position{$_} = 'one race enslaves the other' for 89..100;

sub random_race_position {
  my $percent = percentile;
  return $race_position{$percent};
}

1;