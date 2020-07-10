package Random::RPG::World::WorldBuildersGuidebook::LocalPopulation;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(local_population);

use Games::Dice qw(roll);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Village, Town, and City Population (Table 35)

my %densities;

$densities{sparse}{village} = '1d4 - 3';
$densities{sparse}{town}    = '1s3';
$densities{sparse}{city}    = '6d4';

$densities{low}{village} = '1d4 - 3';
$densities{low}{town}    = '1d4';
$densities{low}{city}    = '8d4';

$densities{average}{village} = '1d3 - 2';
$densities{average}{town}    = '1d6';
$densities{average}{city}    = '10d6';

$densities{high}{village} = '1d2 - 1';
$densities{high}{town}    = '1d10';
$densities{high}{city}    = '10d8';

$densities{'very high'}{village} = '1d2 - 1';
$densities{'very high'}{town}    = '1d8 + 2';
$densities{'very high'}{city}    = '10d10';

sub local_population {
  my ($population_level) = @_;

  for (qw(village town city)) {
    my $dice = $densities{$population_level}{$_};
    my $roll = roll($dice);
    my $population = $roll > 0 ? $roll * 500 : roll('20d20');
    $densities{$population_level}{$_} = "$population people";
  }

  return $densities{$population_level};
}

1;