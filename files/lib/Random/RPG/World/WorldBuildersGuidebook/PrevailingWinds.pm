package Random::RPG::World::WorldBuildersGuidebook::PrevailingWinds;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_prevailing_winds);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Prevailing Winds (Table 17)

my @prevailing_winds = qw(
  north
  northeast
  east
  southeast
  south
  southwest
  west
  northwest
);

sub random_prevailing_winds {
  my $roll = roll('1d8');
  return $prevailing_winds[$roll];
}

=pod

=encoding utf8

=head1 Random::RPG::World::WorldBuildersGuidebook::PrevailingWinds

B<Random::RPG::World::WorldBuildersGuidebook::PrevailingWinds> randomly selects the prevailing winds of the new world.

=head2 Version

This document describes Random::RPG::World::WorldBuildersGuidebook::PrevailingWinds version 1.0.

=head2 Synopsis

  use Random::RPG::World::WorldBuildersGuidebook::PrevailingWinds qw(random_prevailing_winds);

=head2 Dependencies

Random::RPG::World::WorldBuildersGuidebook::PrevailingWinds depends on L<Games::Dice> and L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;