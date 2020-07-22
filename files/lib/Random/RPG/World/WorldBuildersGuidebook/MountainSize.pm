package Random::RPG::World::WorldBuildersGuidebook::MountainSize;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(mountain_size_adjustment);

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

=pod

=encoding utf8

=head1 Random::RPG::World::WorldBuildersGuidebook::MountainSize

B<Random::RPG::World::WorldBuildersGuidebook::MountainSize> adjusts the size of mountainds by world size.

=head2 Version

This document describes Random::RPG::World::WorldBuildersGuidebook::MountainSize version 1.0.

=head2 Synopsis

  use Random::RPG::World::WorldBuildersGuidebook::MountainSize qw(mountain_size_adjustment);

=head2 Dependencies

Random::RPG::World::WorldBuildersGuidebook::MountainSize depends on L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;