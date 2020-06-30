package Random::RPG::World::WorldBuildersGuidebook::PlateMovement;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_plate_movement);

use Random::SpecialDice qw(percentile);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Plate Movement (Table 7)

my %plate_movement;
$plate_movement{$_} = 'away from bordering plate, no mountains'     for 1..5;
$plate_movement{$_} = 'away from bordering plate, low mountains'    for 6..21;
$plate_movement{$_} = 'away from bordering plate, rift system'      for 22..33;
$plate_movement{$_} = 'alongside bordering plate, no mountains'     for 34..39;
$plate_movement{$_} = 'alongside bordering plate, low mountains'    for 40..56;
$plate_movement{$_} = 'alongside bordering plate, medium mountains' for 57..66;
$plate_movement{$_} = 'towards bordering plate, trench system'      for 67..79;
$plate_movement{$_} = 'towards bordering plate, medium mountains'   for 80..94;
$plate_movement{$_} = 'towards bordering plate, high mountains'     for 95..100;

sub random_plate_movement {
  my $percent = percentile;
  return $plate_movement{$percent};
}

1;