package Random::RPG::World::WorldBuildersGuidebook::PlateMovement;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_plate_movement);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Plate Movement (Table 7)

my %plate_movement;
$plate_movement{$_} = 'away from bordering plate, no mountains'     for 1..5;
$plate_movement{$_} = 'away from bordering plate, low mountains'    for 6..21;
$plate_movement{$_} = 'away from bordering plate, rift system'      for 22..33;
$plate_movement{$_} = 'alongside bordering plate, no mountains'     for 34..39;
$plate_movement{$_} = 'alongside bordering plate, low mountains'    for 40..56;
$plate_movement{$_} = 'alongside bordering plate, medium mountains' for 57..66;
$plate_movement{$_} = 'towards bordering plate, trench system'      for 67..79;
$plate_movement{$_} = 'towards bordering plate, medium mountains'   for 80..94;
$plate_movement{$_} = 'towards bordering plate, high mountains'     for 95..100;

sub random_plate_movement {
  my $percent = percentile;
  return $plate_movement{$percent};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::PlateMovement> randomly selects the plate movement of the new world.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::PlateMovement version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::PlateMovement qw(random_plate_movement);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::PlateMovement depends on L<Random::SpecialDice> and L<Exporter>.

Random::SpecialDice depends on L<Games::Dice>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;