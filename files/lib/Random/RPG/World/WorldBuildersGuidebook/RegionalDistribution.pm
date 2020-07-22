package Random::RPG::World::WorldBuildersGuidebook::RegionalDistribution;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(regional_distribution);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Regional Land and Water Distribution Chart (Table 5)

my %distribution;

$distribution{polyhedral}{20} = {
  'water'                   => 0,
  'water and minor islands' => 0,
  'water and major islands' => 0,
  'water and land'          => 2,
  'land and major seas'     => 6,
  'land and minor lakes'    => 4,
  'land'                    => 8,
};
$distribution{polyhedral}{40} = {
  'water'                   => 0,
  'water and minor islands' => 1,
  'water and major islands' => 4,
  'water and land'          => 4,
  'land and major seas'     => 3,
  'land and minor lakes'    => 3,
  'land'                    => 5,
};
$distribution{polyhedral}{60} = {
  'water'                   => 2,
  'water and minor islands' => 4,
  'water and major islands' => 5,
  'water and land'          => 4,
  'land and major seas'     => 3,
  'land and minor lakes'    => 2,
  'land'                    => 0,
};
$distribution{polyhedral}{80} = {
  'water'                   => 8,
  'water and minor islands' => 6,
  'water and major islands' => 4,
  'water and land'          => 2,
  'land and major seas'     => 0,
  'land and minor lakes'    => 0,
  'land'                    => 0,
};
$distribution{polyhedral}{100} = {
  'water'                   => 18,
  'water and minor islands' => 2,
  'water and major islands' => 0,
  'water and land'          => 0,
  'land and major seas'     => 0,
  'land and minor lakes'    => 0,
  'land'                    => 0,
};

$distribution{polar}{20} = {
  'water'                   => 0,
  'water and minor islands' => 0,
  'water and major islands' => 0,
  'water and land'          => 3,
  'land and major seas'     => 8,
  'land and minor lakes'    => 5,
  'land'                    => 10,
};
$distribution{polar}{40} = {
  'water'                   => 0,
  'water and minor islands' => 1,
  'water and major islands' => 6,
  'water and land'          => 6,
  'land and major seas'     => 5,
  'land and minor lakes'    => 5,
  'land'                    => 3,
};
$distribution{polar}{60} = {
  'water'                   => 3,
  'water and minor islands' => 5,
  'water and major islands' => 7,
  'water and land'          => 5,
  'land and major seas'     => 3,
  'land and minor lakes'    => 3,
  'land'                    => 0,
};
$distribution{polar}{80} = {
  'water'                   => 10,
  'water and minor islands' => 8,
  'water and major islands' => 5,
  'water and land'          => 3,
  'land and major seas'     => 0,
  'land and minor lakes'    => 0,
  'land'                    => 0,
};
$distribution{polar}{100} = {
  'water'                   => 23,
  'water and minor islands' => 3,
  'water and major islands' => 0,
  'water and land'          => 0,
  'land and major seas'     => 0,
  'land and minor lakes'    => 0,
  'land'                    => 0,
};


sub regional_distribution {
  my ($display, $hydrology) = @_;
  return $distribution{$display}{$hydrology};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::RegionalDistribution> randomly selects the regional distribution of the new world.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::RegionalDistribution version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::RegionalDistribution qw(regional_distribution);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::RegionalDistribution depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;