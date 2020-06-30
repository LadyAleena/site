package Random::RPG::World::WorldBuildersGuidebook::WorldShape;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_world_shape);

use Games::Dice qw(roll);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR.
# World Shape and Form (Table 2)

my %world_shape;
$world_shape{$_} = 'sphere'                   for 1..60;
$world_shape{$_} = 'inner surface'            for 61..70;
$world_shape{$_} = 'plane'                    for 71..80;
$world_shape{$_} = 'cylinder'                 for 81..85;
$world_shape{$_} = 'self-contained dimension' for 86..90;
$world_shape{$_} = 'polyhedron'               for 91..97;
$world_shape{$_} = 'irregular'                for 98..100;

my %polyhedrons;
$polyhedrons{1} = 'pyramid';
$polyhedrons{2} = 'cube';
$polyhedrons{3} = 'eight-sided';
$polyhedrons{4} = 'ten-sided';
$polyhedrons{5} = 'twelve-sided';
$polyhedrons{6} = 'twenty-sided';

sub random_world_shape {
  my $percent = percentile;
  my $shape = $world_shape{$percent};
  if ($shape eq 'polyhedron') {
    $shape = $polyhedrons{roll('1d6')};
  }
  return $shape;
}

1;