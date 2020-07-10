package Random::RPG::World::WorldBuildersGuidebook::PrevailingWinds;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(random_prevailing_winds);

use Games::Dice qw(roll);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Prevailing Winds (Table 17)

my @prevailing_winds = qw(
  north
  northeast
  east
  southeast
  south
  southwest
  west
  northwest
);

sub random_prevailing_winds {
  my $roll = roll('1d8');
  return $prevailing_winds[$roll];
}

1;