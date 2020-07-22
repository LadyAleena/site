package Random::RPG::World::WorldBuildersGuidebook::PlanetaryTemperature;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_planetary_temperature);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Planetary Temperature (Table 13)

my %planetary_temperature;
$planetary_temperature{$_} = 'inferno' for 1..15;
$planetary_temperature{$_} = 'hot'     for 16..30;
$planetary_temperature{$_} = 'normal'  for 31..70;
$planetary_temperature{$_} = 'cold'    for 71..85;
$planetary_temperature{$_} = 'frozen'  for 86..100;

sub random_planetary_temperature {
  my $percent = percentile;
  return $planetary_temperature{$percent};
}

=pod

=encoding utf8

=head1 Random::RPG::World::WorldBuildersGuidebook::PlanetaryTemperature

B<Random::RPG::World::WorldBuildersGuidebook::PlanetaryTemperature> randomly selects the planetary temperatute of the new world.

=head2 Version

This document describes Random::RPG::World::WorldBuildersGuidebook::PlanetaryTemperature version 1.0.

=head2 Synopsis

  use Random::RPG::World::WorldBuildersGuidebook::PlanetaryTemperature qw(random_planetary_temperature);

=head2 Dependencies

Random::RPG::World::WorldBuildersGuidebook::PlanetaryTemperature depends on L<Random::SpecialDice> and L<Exporter>.

Random::SpecialDice depends on L<Games::Dice>.

=head2 Author

Lady Aleena

=cut

1;