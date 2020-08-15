package Random::RPG::World::WorldBuildersGuidebook::Hydrology;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_hydrology);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# World Hydrology (Table 4)

my %hydrology;
$hydrology{$_} = '20' for 1..10;
$hydrology{$_} = '40' for 11..35;
$hydrology{$_} = '60' for 36..75;
$hydrology{$_} = '80' for 66..90;
$hydrology{$_} = '100' for 91..100;

sub random_hydrology {
  my $percent = percentile;
  return $hydrology{$percent};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::Hydrology> randomly selects the hydrology of the new world.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::Hydrology version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::Hydrology qw(random_hydrology);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::Hydrology depends on L<Random::SpecialDice> and L<Exporter>.

Random::SpecialDice depends on L<Games::Dice>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;