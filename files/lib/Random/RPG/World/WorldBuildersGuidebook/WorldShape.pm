package Random::RPG::World::WorldBuildersGuidebook::WorldShape;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_world_shape);

# From the World Builder's Guidebook by Richard Baker (c) TSR.
# World Shape and Form (Table 2)

my %world_shape;
$world_shape{$_} = 'sphere'                   for 1..60;
$world_shape{$_} = 'inner surface'            for 61..70;
$world_shape{$_} = 'plane'                    for 71..80;
$world_shape{$_} = 'cylinder'                 for 81..85;
$world_shape{$_} = 'self-contained dimension' for 86..90;
$world_shape{$_} = 'polyhedron'               for 91..97;
$world_shape{$_} = 'irregular'                for 98..100;

my %polyhedrons;
$polyhedrons{1} = 'pyramid';
$polyhedrons{2} = 'cube';
$polyhedrons{3} = 'eight-sided';
$polyhedrons{4} = 'ten-sided';
$polyhedrons{5} = 'twelve-sided';
$polyhedrons{6} = 'twenty-sided';

sub random_world_shape {
  my $percent = percentile;
  my $shape = $world_shape{$percent};
  if ($shape eq 'polyhedron') {
    $shape = $polyhedrons{roll('1d6')};
  }
  return $shape;
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::WorldShape> randomly selects the shape of the new world.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::WorldShape version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::WorldShape qw(random_world_shape);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::WorldShape depends on L<Random::SpecialDice>, L<Games::Dice>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;