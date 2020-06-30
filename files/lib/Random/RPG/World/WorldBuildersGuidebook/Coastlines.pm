package Random::RPG::World::WorldBuildersGuidebook::Coastlines;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_coastlines);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR

my %coastlines;

# Regional Hydrology (Table 15)

$coastlines{region}{$_} = 'archipelago'                     for 1..5;
$coastlines{region}{$_} = 'major islands'                   for 6..15;
$coastlines{region}{$_} = 'island-continent'                for 16..30;
$coastlines{region}{$_} = 'coastline with offshore islands' for 31..45;
$coastlines{region}{$_} = 'coastline, no islands'           for 46..55;
$coastlines{region}{$_} = 'multiple coastlines'             for 56..75;
$coastlines{region}{$_} = 'land with inland sea'            for 76..85;
$coastlines{region}{$_} = 'land with minor bodies of water' for 86..95;
$coastlines{region}{$_} = 'land, no significant water'      for 96..100;

# Kingdom Coastlines, Lakes, and Seas (Table 27)

$coastlines{kingdom}{$_} = 'archipelago'                      for 1..14;
$coastlines{kingdom}{$_} = 'large island'                     for 15..29;
$coastlines{kingdom}{$_} = 'coastal with offshore islands'    for 30..42;
$coastlines{kingdom}{$_} = 'coastal, no islands'              for 43..57;
$coastlines{kingdom}{$_} = 'multiple coastlines'              for 58..68;
$coastlines{kingdom}{$_} = 'landlocked with inland seas'      for 69..79;
$coastlines{kingdom}{$_} = 'landlocked with major lakes'      for 80..91;
$coastlines{kingdom}{$_} = 'landlocked, no significant water' for 92..100;

# Seas and Rivers in the Local Area (Table 33)

$coastlines{city}{$_} = 'island'                 for 1..10;
$coastlines{city}{$_} = 'coastal or peninsula'   for 11..19;
$coastlines{city}{$_} = 'major lake'             for 20..29;
$coastlines{city}{$_} = 'major river'            for 30..45;
$coastlines{city}{$_} = 'minor lakes and rivers' for 46..70;
$coastlines{city}{$_} = 'no significant water'   for 71..100;

sub random_coastlines {
  my $land = shift;
  my $percent = percentile;
  return $coastlines{$land}{$percent};
}

1;