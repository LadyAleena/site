package Random::RPG::World::WorldBuildersGuidebook::LandWaterMasses;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(masses);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Land and Water Masses (Table 6)

# Table incomplete, missing 12, 15, 16, 18, 20, 23, and 26 regions.

my %regions = (
   2 => { number => '1d2', size => '1d2' },
   3 => { number => '1d3', size => '1d3' },
   9 => { number => '1d6', size => '1d8' },
  11 => { number => '2d4', size => '1d10' },
  13 => { number => '2d6', size => '1d12' }
);

sub masses {
  my ($regional_distribution) = @_;
  my %masses;

  for (keys %$regional_distribution) {
    $masses{land}{regions}  += $$regional_distribution{$_} if $_ =~ /land/;
    $masses{water}{regions} += $$regional_distribution{$_} if $_ =~ /water/;
  }

  return \%masses;
}

=pod

=encoding utf8

=head1 Random::RPG::World::WorldBuildersGuidebook::LandWaterMasses

B<Random::RPG::World::WorldBuildersGuidebook::LandWaterMasses> randomly selects the land and water masses of the new world.

=head2 Version

This document describes Random::RPG::World::WorldBuildersGuidebook::LandWaterMasses version 1.0.

=head2 Synopsis

  use Random::RPG::World::WorldBuildersGuidebook::LandWaterMasses qw(masses);

=head2 Dependencies

Random::RPG::World::WorldBuildersGuidebook::LandWaterMasses depends on L<Games::Dice> and L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;