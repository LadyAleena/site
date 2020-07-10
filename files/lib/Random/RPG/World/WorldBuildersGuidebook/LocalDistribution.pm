package Random::RPG::World::WorldBuildersGuidebook::LocalDistribution;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(local_distribution);

use Games::Dice qw(roll);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Town and City Distribution (Table 32)

my %distributions;

$distributions{sparse}{villages} = '4d12';
$distributions{sparse}{towns}    = '10d20';
$distributions{sparse}{cities}   = '0';
$distributions{sparse}{other}    = '25%';

$distributions{low}{villages} = '4d6';
$distributions{low}{towns}    = '10d8';
$distributions{low}{cities}   = '10d20';
$distributions{low}{other}    = '40%';

$distributions{average}{villages} = '3d6';
$distributions{average}{towns}    = '4d12';
$distributions{average}{cities}   = '10d10';
$distributions{average}{other}    = '60%';

$distributions{high}{villages} = '4d3';
$distributions{high}{towns}    = '4d8';
$distributions{high}{cities}   = '8d8';
$distributions{high}{other}    = '80%';

$distributions{'very high'}{villages} = '2d4';
$distributions{'very high'}{towns}    = '4d6';
$distributions{'very high'}{cities}   = '5d12';
$distributions{'very high'}{other}    = '95%';

sub local_distribution {
  my ($population_level) = @_;

  for (qw(villages towns cities)) {
    my $dice = $distributions{$population_level}{$_};
    $distributions{$population_level}{$_} = roll($dice)." miles apart";
  }

  return $distributions{$population_level};
}

1;