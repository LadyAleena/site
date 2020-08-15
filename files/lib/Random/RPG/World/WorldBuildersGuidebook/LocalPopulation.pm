package Random::RPG::World::WorldBuildersGuidebook::LocalPopulation;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(local_population);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Village, Town, and City Population (Table 35)

my %densities;

$densities{sparse}{village} = '1d4 - 3';
$densities{sparse}{town}    = '1s3';
$densities{sparse}{city}    = '6d4';

$densities{low}{village} = '1d4 - 3';
$densities{low}{town}    = '1d4';
$densities{low}{city}    = '8d4';

$densities{average}{village} = '1d3 - 2';
$densities{average}{town}    = '1d6';
$densities{average}{city}    = '10d6';

$densities{high}{village} = '1d2 - 1';
$densities{high}{town}    = '1d10';
$densities{high}{city}    = '10d8';

$densities{'very high'}{village} = '1d2 - 1';
$densities{'very high'}{town}    = '1d8 + 2';
$densities{'very high'}{city}    = '10d10';

sub local_population {
  my ($population_level) = @_;

  for (qw(village town city)) {
    my $dice = $densities{$population_level}{$_};
    my $roll = roll($dice);
    my $population = $roll > 0 ? $roll * 500 : roll('20d20');
    $densities{$population_level}{$_} = "$population people";
  }

  return $densities{$population_level};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::LocalPopulation> randomly selects the population of the new village, town, or city.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::LocalPopulation version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::LocalPopulation qw(local_population);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::LocalPopulation depends on L<Games::Dice> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;