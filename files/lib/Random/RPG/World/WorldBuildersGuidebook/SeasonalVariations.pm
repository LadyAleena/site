package Random::RPG::World::WorldBuildersGuidebook::SeasonalVariations;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_seasonal_variations);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# SeasonalVariations (Table 14)

my %seasonal_variations;
$seasonal_variations{$_} = 'none'     for 1..10;
$seasonal_variations{$_} = 'mild'     for 11.30;
$seasonal_variations{$_} = 'moderate' for 31..75;
$seasonal_variations{$_} = 'severe'   for 76..90;
$seasonal_variations{$_} = 'extreme'  for 91..100;

sub random_seasonal_variations {
  my $percent = percentile;
  return $seasonal_variations{$percent};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::SeasonalVariations> randomly selects the seasonal variations of the new world.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::SeasonalVariations version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::SeasonalVariations qw(random_seasonal_variations);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::SeasonalVariations depends on L<Random::SpecialDice> and L<Exporter>.

Random::SpecialDice depends on L<Games::Dice>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;