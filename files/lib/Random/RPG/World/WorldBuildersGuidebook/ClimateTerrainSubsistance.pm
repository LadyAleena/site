package Random::RPG::World::WorldBuildersGuidebook::ClimateTerrainSubsistance;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(random_climate random_terrain random_subsistance climate_chart);

use Games::Dice qw(roll);
use List::Util qw(max);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Merged Tables 18, 28, 29.

# Subsistence Systems (Table 29)

my %barren1;
$barren1{$_} = 'fishing'         for 1..2;
$barren1{3}  = 'hunting/gathering';
$barren1{4}  = 'raiding';
$barren1{$_} = 'whaling/sealing' for 5..6;
$barren1{$_} = 'non-sufficient'  for 7..8;

my %barren2;
$barren2{1}  = 'hunting/gathering';
$barren2{$_} = 'mining'         for 2..3;
$barren2{$_} = 'raiding'        for 4..5;
$barren2{$_} = 'non-sufficient' for 6..8;

my %rocky_desert;
$rocky_desert{$_} = 'grazing/hearding' for 1..3;
$rocky_desert{4}  = 'hunting/gathering';
$rocky_desert{5}  = 'mining';
$rocky_desert{6}  = 'raiding';
$rocky_desert{$_} = 'non-sufficient'   for 7..8;

my %desert;
$desert{$_} = 'agriculture, light' for 1..2;
$desert{$_} = 'grazing/hearding'   for 3..4;
$desert{5}  = 'hunting/gathering';
$desert{6}  = 'industry';
$desert{7}  = 'mining';
$desert{8}  = 'raiding';
$desert{9}  = 'trade';
$desert{$_} = 'non-sufficient'     for 10..12;

my %light_forest;
$light_forest{$_} = 'fishing'  for 1..2;
$light_forest{$_} = 'forestry' for 3..5;
$light_forest{6}  = 'hunting/gathering';
$light_forest{7}  = 'mining';
$light_forest{8}  = 'raiding';
$light_forest{9}  = 'trade';
$light_forest{10} = 'non-sufficient';

my %medium_forest;
$medium_forest{$_} = 'agriculture, light' for 1..3;
$medium_forest{4}  = 'banditry/brigandage';
$medium_forest{5}  = 'fishing';
$medium_forest{$_} = 'forestry'           for 6..7;
$medium_forest{8}  = 'hunting/gathering';
$medium_forest{9}  = 'industry';
$medium_forest{10} = 'trade';

my %heavy_forest;
$heavy_forest{1}  = 'banditry/brigandage';
$heavy_forest{$_} = 'forestry'          for 2..5;
$heavy_forest{$_} = 'hunting/gathering' for 6..7;
$heavy_forest{8}  = 'raiding';

my %glacier;
$glacier{1}  = 'fishing';
$glacier{2}  = 'hunting/gathering';
$glacier{3}  = 'raiding';
$glacier{4}  = 'whaling/sealing';
$glacier{$_} = 'non-sufficient' for 5..6;

my %grassland1;
$grassland1{$_} = 'agriculture, heavy' for 1..2;
$grassland1{$_} = 'agriculture, light' for 3..5;
$grassland1{6}  = 'banditry/brigandage';
$grassland1{$_} = 'grazing/hearding'   for 7..8;
$grassland1{9}  = 'hunting/gathering';
$grassland1{10} = 'industry';
$grassland1{11} = 'mining';
$grassland1{12} = 'trade';

my %grassland2;
$grassland2{$_} = 'agriculture, light' for 1..4;
$grassland2{5}  = 'banditry/brigandage';
$grassland2{$_} = 'grazing/hearding'   for 6..8;
$grassland2{$_} = 'hunting/gathering'  for 9..10;
$grassland2{11} = 'mining';
$grassland2{12} = 'trade';

my %medium_jungle;
$medium_jungle{$_} = 'agriculture, light' for 1..3;
$medium_jungle{4}  = 'fishing';
$medium_jungle{5}  = 'forestry';
$medium_jungle{$_} = 'hunting/gathering'  for 6..7;
$medium_jungle{8}  = 'mining';
$medium_jungle{9}  = 'raiding';
$medium_jungle{10} = 'trade';

my %heavy_jungle;
$heavy_jungle{1}  = 'fishing';
$heavy_jungle{2}  = 'forestry';
$heavy_jungle{$_} = 'hunting/gathering' for 3..4;
$heavy_jungle{5}  = 'raiding';
$heavy_jungle{6}  = 'non-sufficient';

my %marsh_swamp1;
$marsh_swamp1{1}  = 'fishing';
$marsh_swamp1{$_} = 'forestry' for 2..3;
$marsh_swamp1{4}  = 'hunting/gathering';
$marsh_swamp1{$_} = 'industry' for 5..6;
$marsh_swamp1{7}  = 'mining';
$marsh_swamp1{8}  = 'raiding';

my %marsh_swamp2;
$marsh_swamp2{$_} = 'agriculture, light' for 1..2;
$marsh_swamp2{3}  = 'banditry/brigandage';
$marsh_swamp2{$_} = 'fishing'            for 4..5;
$marsh_swamp2{6}  = 'forestry';
$marsh_swamp2{7}  = 'hunting/gathering';
$marsh_swamp2{8}  = 'raiding';

my %moor;
$moor{1}  = 'banditry/brigandage';
$moor{2}  = 'grazing/hearding';
$moor{$_} = 'industry' for 3..4;
$moor{$_} = 'mining'   for 5..7;
$moor{8}  = 'non-sufficient';

my %scrub_brush1;
$scrub_brush1{$_} = 'agriculture, light' for 1..2;
$scrub_brush1{3}  = 'banditry/brigandage';
$scrub_brush1{$_} = 'grazing/hearding'   for 4..5;
$scrub_brush1{3}  = 'hunting/gathering';
$scrub_brush1{7}  = 'industry';
$scrub_brush1{8}  = 'mining';
$scrub_brush1{9}  = 'raiding';
$scrub_brush1{10} = 'trade';

my %scrub_brush2;
$scrub_brush2{$_} = 'agriculture, light' for 1..3;
$scrub_brush2{4}  = 'banditry/brigandage';
$scrub_brush2{$_} = 'grazing/hearding'  for 5..6;
$scrub_brush2{7}  = 'hunting/gathering';
$scrub_brush2{8}  = 'mining';
$scrub_brush2{9}  = 'raiding';
$scrub_brush2{10} = 'trade';

my %tundra;
$tundra{$_} = 'fishing'         for 1..2;
$tundra{3}  = 'grazing/hearding';
$tundra{4}  = 'hunting/gathering';
$tundra{$_} = 'whaling/sealing' for 5..6;
$tundra{$_} = 'non-sufficient'  for 7..8;

# Predominant Terrain (Table 18)

my %super_artic;
$super_artic{humid}{1}{terrain} = 'tundra';
$super_artic{humid}{1}{subsistance} = \%tundra;
$super_artic{humid}{$_}{terrain} = 'barren' for 2..3;
$super_artic{humid}{$_}{subsistance} = \%barren1 for 2..3;
$super_artic{humid}{$_}{terrain} = 'glacier' for 4..6;
$super_artic{humid}{$_}{subsistance} = \%glacier for 4..6;
$super_artic{arid}{$_}{terrain} = 'barren' for 1..2;
$super_artic{arid}{$_}{subsistance} = \%barren1 for 1..2;
$super_artic{arid}{$_}{terrain} = 'glacier' for 3..4;
$super_artic{arid}{$_}{subsistance} = \%glacier for 3..4;

my %artic;
$artic{humid}{$_}{terrain} = 'tundra' for 1..2;
$artic{humid}{$_}{subsistance} = \%tundra for 1..2;
$artic{humid}{$_}{terrain} = 'glacier' for 3..4;
$artic{humid}{$_}{subsistance} = \%glacier for 3..4;
$artic{arid}{$_}{terrain} = 'barren' for 1..2;
$artic{arid}{$_}{subsistance} = \%barren1 for 1..2;
$artic{arid}{$_}{terrain} = 'glacier' for 3..4;
$artic{arid}{$_}{subsistance} = \%glacier for 3..4;

my %sub_arctic;
$sub_arctic{humid}{$_}{terrain} = 'marsh/swamp' for 1..3;
$sub_arctic{humid}{$_}{subsistance} = \%marsh_swamp1 for 1..3;
$sub_arctic{humid}{$_}{terrain} = 'light forest' for 4..5;
$sub_arctic{humid}{$_}{subsistance} = \%light_forest for 4..5;
$sub_arctic{humid}{6}{terrain}  = 'medium forest';
$sub_arctic{humid}{6}{subsistance}  = \%medium_forest;
$sub_arctic{humid}{7}{terrain}  = 'moor';
$sub_arctic{humid}{7}{subsistance}  = \%moor;
$sub_arctic{humid}{8}{terrain}  = 'glacier';
$sub_arctic{humid}{8}{subsistance}  = \%glacier;
$sub_arctic{arid}{1}{terrain} = 'barren';
$sub_arctic{arid}{1}{subsistance} = \%barren1;
$sub_arctic{arid}{$_}{terrain} = 'rocky desert' for 2..3;
$sub_arctic{arid}{$_}{subsistance} = \%rocky_desert for 2..3;
$sub_arctic{arid}{$_}{terrain} = 'steppe' for 4..5;
$sub_arctic{arid}{$_}{subsistance} = \%grassland1 for 4..5;
$sub_arctic{arid}{$_}{terrain} = 'prairie' for 6..7;
$sub_arctic{arid}{$_}{subsistance} = \%grassland1 for 6..7;
$sub_arctic{arid}{8}{terrain}  = 'light forest';
$sub_arctic{arid}{8}{subsistance}  = \%light_forest;

my %temperate;
$temperate{humid}{1}{terrain} = 'marsh/swamp';
$temperate{humid}{1}{subsistance} = \%marsh_swamp1;
$temperate{humid}{$_}{terrain} = 'heavy forest' for 2..3;
$temperate{humid}{$_}{subsistance} = \%heavy_forest for 2..3;
$temperate{humid}{$_}{terrain} = 'medium forest' for 4..5;
$temperate{humid}{$_}{subsistance} = \%medium_forest for 4..5;
$temperate{humid}{6}{terrain} = 'moor';
$temperate{humid}{6}{subsistance} = \%moor;
$temperate{arid}{1}{terrain} = 'barren';
$temperate{arid}{1}{subsistance} = \%barren2;
$temperate{arid}{$_}{terrain} = 'desert' for 2..4;
$temperate{arid}{$_}{subsistance} = \%desert for 2..4;
$temperate{arid}{$_}{terrain} = 'prairie' for 5..6;
$temperate{arid}{$_}{subsistance} = \%grassland1 for 5..6;
$temperate{arid}{7}{terrain} = 'steppe';
$temperate{arid}{7}{subsistance} = \%grassland1;
$temperate{arid}{8}{terrain} = 'scrub/brush';
$temperate{arid}{8}{subsistance} = \%scrub_brush1;

my %sub_tropical;
$sub_tropical{humid}{1}{terrain} = 'marsh/swamp';
$sub_tropical{humid}{1}{subsistance} = \%marsh_swamp2;
$sub_tropical{humid}{$_}{terrain} = 'medium forest' for 2..3;
$sub_tropical{humid}{$_}{subsistance} = \%medium_forest for 2..3;
$sub_tropical{humid}{$_}{terrain} = 'light forest' for 4..5;
$sub_tropical{humid}{$_}{subsistance} = \%light_forest for 4..5;
$sub_tropical{humid}{6}{terrain} = 'medium jungle';
$sub_tropical{humid}{6}{subsistance} = \%medium_jungle;
$sub_tropical{arid}{1}{terrain} = 'barren';
$sub_tropical{arid}{1}{subsistance} = \%barren2;
$sub_tropical{arid}{$_}{terrain} = 'desert' for 2..3;
$sub_tropical{arid}{$_}{subsistance} = \%desert for 2..3;
$sub_tropical{arid}{$_}{terrain} = 'scrub/brush' for 4..5;
$sub_tropical{arid}{$_}{subsistance} = \%scrub_brush2 for 4..5;
$sub_tropical{arid}{6}{terrain} = 'grassland';
$sub_tropical{arid}{6}{subsistance} = \%grassland2;

my %tropical;
$tropical{humid}{1}{terrain} = 'marsh/swamp';
$tropical{humid}{1}{subsistance} = \%marsh_swamp2;
$tropical{humid}{$_}{terrain} = 'medium jungle' for 2..3;
$tropical{humid}{$_}{subsistance} = \%medium_jungle for 2..3;
$tropical{humid}{4}{terrain} = 'heavy jungle';
$tropical{humid}{4}{subsistance} = \%heavy_jungle;
$tropical{humid}{$_}{terrain} = 'grassland' for 5..6;
$tropical{humid}{$_}{subsistance} = \%grassland2 for 5..6;
$tropical{arid}{1}{terrain} = 'barren';
$tropical{arid}{1}{subsistance} = \%barren2;
$tropical{arid}{$_}{terrain} = 'desert' for 2..3;
$tropical{arid}{$_}{subsistance} = \%desert for 2..3;
$tropical{arid}{$_}{terrain} = 'scrub/brush' for 4..5;
$tropical{arid}{$_}{subsistance} = \%scrub_brush2 for 4..5;
$tropical{arid}{6}{terrain} = 'grassland';
$tropical{arid}{6}{subsistance} = \%grassland2;

my %super_tropical;
$super_tropical{humid}{1}{terrain} = 'marsh/swamp';
$super_tropical{humid}{1}{subsistance} = \%marsh_swamp2;
$super_tropical{humid}{$_}{terrain} = 'medium jungle' for 2..3;
$super_tropical{humid}{$_}{subsistance} = \%medium_jungle for 2..3;
$super_tropical{humid}{4}{terrain} = 'heavy jungle';
$super_tropical{humid}{4}{subsistance} = \%heavy_jungle;
$super_tropical{humid}{$_}{terrain} = 'grassland' for 5..6;
$super_tropical{humid}{$_}{subsistance} = \%grassland2 for 5..6;
$super_tropical{arid}{$_}{terrain} = 'barren' for 1..3;
$super_tropical{arid}{$_}{subsistance} = \%barren2 for 1..3;
$super_tropical{arid}{$_}{terrain} = 'desert' for 4..5;
$super_tropical{arid}{$_}{subsistance} = \%desert for 4..5;
$super_tropical{arid}{6}{terrain} = 'scrub/brush';
$super_tropical{arid}{6}{subsistance} = \%scrub_brush2;

# Kingdom Climate (Table 28)

my %climates;
$climates{1}{name}  = "super-artic";
$climates{1}{data}  = \%super_artic;
$climates{1}{dice}  = '1d4';
$climates{$_}{name} = "artic" for 2..6;
$climates{$_}{data} = \%artic for 2..6;
$climates{$_}{dice} = '1d4'    for 2..6;
$climates{$_}{name} = "sub-arctic" for 7..25;
$climates{$_}{data} = \%sub_arctic for 7..25;
$climates{$_}{dice} = '1d8'         for 7..25;
$climates{$_}{name} = "temperate" for 26..60;
$climates{$_}{data} = \%temperate for 26..60;
$climates{$_}{dice} = '1d8'        for 26..60;
$climates{$_}{name} = "sub-tropical" for 61..80;
$climates{$_}{data} = \%sub_tropical for 61..80;
$climates{$_}{dice} = '1d6'           for 61..80;
$climates{$_}{name} = "tropical" for 81..97;
$climates{$_}{data} = \%tropical for 81..97;
$climates{$_}{dice} = '1d6'       for 81..97;
$climates{$_}{name} = "super-tropical" for 98..100;
$climates{$_}{data} = \%super_tropical for 98..100;
$climates{$_}{dice} = '1d6'             for 98..100;

sub random_air_quality {
  my @air = qw(humid arid);
  return $air[rand @air];
}

sub random_climate {
  my $climate = percentile;
  return $climates{$climate}{name};
}

sub random_terrain {
  my $roll = percentile;
  my $climate = $climates{$roll};
  my $air_quality = random_air_quality;
  my $dice = $climate->{'dice'};
  my $terrain = $climate->{data}{$air_quality}{roll($dice)};
  return $terrain->{terrain};
}

sub random_subsistance {
  my $roll = percentile;
  my $climate = $climates{$roll};
  my $air_quality = random_air_quality;
  my $dice = $climate->{'dice'};
  my $terrain = $climate->{data}{$air_quality}{roll($dice)}{subsistance};
  my $subsistance = (keys %{$terrain})[rand keys %{$terrain}];
  return $terrain->{$subsistance};
}

sub climate_chart {
  return \%climates;
}

1;