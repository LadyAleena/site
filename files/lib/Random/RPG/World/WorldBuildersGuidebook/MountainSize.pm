package Random::RPG::World::WorldBuildersGuidebook::MountainSize;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(mountain_size_adjustment);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Mountain Size Adjustment for Gravity World (Table 8)

my %mountain_sizes = (
    800 => '+3 grades (foothills to high)',
   1600 => '+2 grades (foothills to medium)',
   2400 => '+2 grades (foothills to medium)',
   4000 => '+1 grade (foothills to low)',
   4800 => '+1 grade (foothills to low, low to medium)',
   8000 => 'none',
  10000 => '-1 grade (low to foothills)',
  12000 => '-2 grades (medium to foothills)',
  16000 => '-3 grades (high to foothills)'
);

sub mountain_size_adjustment {
  my ($world_size) = @_;
  return $mountain_sizes{$world_size};
}

1;