package Random::RPG::World::WorldBuildersGuidebook::LocalTopography;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(local_topography);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Local Mountains, Hills, and Tablelands (Table 34)

my %topography;
$topography{$_} = 'very moutainous' for 1..8;
$topography{$_} = 'mountainous'     for 9..22;
$topography{$_} = 'rugged hills'    for 23..37;
$topography{$_} = 'gentle hills'    for 38..69;
$topography{$_} = 'tablelands'      for 70..76;
$topography{$_} = 'plains'          for 77..100;

sub local_topography {
  my $percent = percentile;
  return $topography{$percent};
}

1;