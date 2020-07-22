package Random::RPG::World::WorldBuildersGuidebook::LocalDistribution;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(local_distribution);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Town and City Distribution (Table 32)

my %distributions;

$distributions{sparse}{villages} = '4d12';
$distributions{sparse}{towns}    = '10d20';
$distributions{sparse}{cities}   = '0';
$distributions{sparse}{other}    = '25%';

$distributions{low}{villages} = '4d6';
$distributions{low}{towns}    = '10d8';
$distributions{low}{cities}   = '10d20';
$distributions{low}{other}    = '40%';

$distributions{average}{villages} = '3d6';
$distributions{average}{towns}    = '4d12';
$distributions{average}{cities}   = '10d10';
$distributions{average}{other}    = '60%';

$distributions{high}{villages} = '4d3';
$distributions{high}{towns}    = '4d8';
$distributions{high}{cities}   = '8d8';
$distributions{high}{other}    = '80%';

$distributions{'very high'}{villages} = '2d4';
$distributions{'very high'}{towns}    = '4d6';
$distributions{'very high'}{cities}   = '5d12';
$distributions{'very high'}{other}    = '95%';

sub local_distribution {
  my ($population_level) = @_;

  for (qw(villages towns cities)) {
    my $dice = $distributions{$population_level}{$_};
    $distributions{$population_level}{$_} = roll($dice)." miles apart";
  }

  return $distributions{$population_level};
}

=pod

=encoding utf8

=head1 Random::RPG::World::WorldBuildersGuidebook::LocalDistribution

B<Random::RPG::World::WorldBuildersGuidebook::LocalDistribution> randomly selects the town or city distribution of the new world.

=head2 Version

This document describes Random::RPG::World::WorldBuildersGuidebook::LocalDistribution version 1.0.

=head2 Synopsis

  use Random::RPG::World::WorldBuildersGuidebook::LocalDistribution qw(local_distribution);

=head2 Dependencies

Random::RPG::World::WorldBuildersGuidebook::LocalDistribution depends on L<Games::Dice> and L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;