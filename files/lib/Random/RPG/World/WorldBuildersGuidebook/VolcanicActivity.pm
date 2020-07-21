package Random::RPG::World::WorldBuildersGuidebook::VolcanicActivity;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_volcanic_activity);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Volcanic Activity (Table 9)

my %volcanic_activity;
$volcanic_activity{$_} = 'none'                        for 1..25;
$volcanic_activity{$_} = 'geysers / hot springs'       for 26..33;
$volcanic_activity{$_} = 'extinct volcanoes, sparse'   for 34..49;
$volcanic_activity{$_} = 'extinct volcanoes, numerous' for 50..59;
$volcanic_activity{$_} = 'dormant volcanoes, sparse'   for 60..74;
$volcanic_activity{$_} = 'dormant volcanoes, numerous' for 75..84;
$volcanic_activity{$_} = 'active volcanoes, sparse'    for 86..95;
$volcanic_activity{$_} = 'active volcanoes, numerous'  for 96..100;

sub random_volcanic_activity {
  my $percent = percentile;
  return $volcanic_activity{$percent};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::VolcanicActivity> randomly selects the volcanic avtivity of the new world.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::VolcanicActivity version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::VolcanicActivity qw(random_volcanic_activity);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::VolcanicActivity depends on L<Random::SpecialDice> and L<Exporter>.

Random::SpecialDice depends on L<Games::Dice>.

=head1 AUTHOR

Lady Aleena

=cut

1;