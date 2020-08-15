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

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::MountainSize> adjusts the size of mountainds by world size.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::MountainSize version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::MountainSize qw(mountain_size_adjustment);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::MountainSize depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;