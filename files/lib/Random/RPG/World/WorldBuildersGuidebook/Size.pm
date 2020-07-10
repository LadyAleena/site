package Random::RPG::World::WorldBuildersGuidebook::Size;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(random_size);

use Games::Dice qw(roll);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR

my %size;

=cut
$size{general}{$_} = 'city-state' for 1..20;
$size{general}{$_} = 'kingdom'    for 21..85;
$size{general}{$_} = 'empire'     for 86..100;
=cut

# World Size (Table 3)
# all numbers are miles

$size{world}{$_}{diameter} = '800'   for 1..2;
$size{world}{$_}{diameter} = '1600'  for 3..8;
$size{world}{$_}{diameter} = '2400'  for 9..15;
$size{world}{$_}{diameter} = '4000'  for 16..28;
$size{world}{$_}{diameter} = '4800'  for 29..52;
$size{world}{$_}{diameter} = '8000'  for 53..80;
$size{world}{$_}{diameter} = '10000' for 81..91;
$size{world}{$_}{diameter} = '12000' for 92..97;
$size{world}{$_}{diameter} = '16000' for 98..100;

$size{world}{$_}{hex_size}{world_map} = '50'   for 1..2;
$size{world}{$_}{hex_size}{world_map} = '100'  for 3..8;
$size{world}{$_}{hex_size}{world_map} = '150'  for 9..15;
$size{world}{$_}{hex_size}{world_map} = '250'  for 16..28;
$size{world}{$_}{hex_size}{world_map} = '300'  for 29..52;
$size{world}{$_}{hex_size}{world_map} = '500'  for 53..80;
$size{world}{$_}{hex_size}{world_map} = '625'  for 81..91;
$size{world}{$_}{hex_size}{world_map} = '750'  for 92..97;
$size{world}{$_}{hex_size}{world_map} = '1000' for 98..100;

$size{world}{$_}{hex_size}{region_map} = '10'  for 1..2;
$size{world}{$_}{hex_size}{region_map} = '20'  for 3..8;
$size{world}{$_}{hex_size}{region_map} = '30'  for 9..15;
$size{world}{$_}{hex_size}{region_map} = '50'  for 16..28;
$size{world}{$_}{hex_size}{region_map} = '60'  for 29..52;
$size{world}{$_}{hex_size}{region_map} = '100' for 53..80;
$size{world}{$_}{hex_size}{region_map} = '125' for 81..91;
$size{world}{$_}{hex_size}{region_map} = '150' for 92..97;
$size{world}{$_}{hex_size}{region_map} = '200' for 98..100;


# Random Kingdom Size (Table 26)

$size{kingdom}{$_}{type} = 'city-state'     for 1..20;
$size{kingdom}{$_}{type} = 'small kingdom'  for 21..35;
$size{kingdom}{$_}{type} = 'medium kingdom' for 36..65;
$size{kingdom}{$_}{type} = 'large kingdom'  for 66..85;
$size{kingdom}{$_}{type} = 'empire'         for 86..100;

$size{kingdom}{$_}{hexes} = roll('1d8') for 1..20;
$size{kingdom}{$_}{hexes} = roll('3d6') for 21..35;
$size{kingdom}{$_}{hexes} = roll('4d6') for 36..65;
$size{kingdom}{$_}{hexes} = roll('6d6') for 66..85;
$size{kingdom}{$_}{hexes} = roll('8d8') for 86..100;

$size{kingdom}{$_}{miles} = roll('10d10') * '1'  for 1..20;
$size{kingdom}{$_}{miles} = roll('10d10') * '5'  for 21..35;
$size{kingdom}{$_}{miles} = roll('10d10') * '8'  for 36..65;
$size{kingdom}{$_}{miles} = roll('10d10') * '10' for 66..85;
$size{kingdom}{$_}{miles} = roll('10d10') * '20' for 86..100;

sub random_size {
  my ($area) = @_;
  my $percent = percentile;

  return $size{$area}{$percent};
}

1;