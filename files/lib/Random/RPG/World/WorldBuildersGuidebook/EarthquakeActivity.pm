package Random::RPG::World::WorldBuildersGuidebook::EarthquakeActivity;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_earthquake_activity);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Earthquake Activity (Table 10)

my %earthquake_activity;

$earthquake_activity{$_}{strength}  = 'mild'     for 1..49;
$earthquake_activity{$_}{strength}  = 'moderate' for 50..84;
$earthquake_activity{$_}{strength}  = 'strong'   for 85..100;

$earthquake_activity{$_}{frequency} = 'rare'     for (1..29, 50..65, 85..94);
$earthquake_activity{$_}{frequency} = 'uncommon' for (30..39, 66..74, 95..98);
$earthquake_activity{$_}{frequency} = 'common'   for (40..49, 75..84, 99..100);

sub random_earthquake_activity {
  my $percent = percentile;
  return $earthquake_activity{$percent};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::EarthquakeActivity> randomly selects the earthquake activity of the new world.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::EarthquakeActivity version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::EarthquakeActivity qw(random_earthquake_activity);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::EarthquakeActivity depends on L<Random::SpecialDice> and L<Exporter>.

Random::SpecialDice depends on L<Games::Dice>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;