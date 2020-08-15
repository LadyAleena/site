package Random::RPG::World::WorldBuildersGuidebook::LocalTopography;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(local_topography);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Local Mountains, Hills, and Tablelands (Table 34)

my %topography;
$topography{$_} = 'very moutainous' for 1..8;
$topography{$_} = 'mountainous'     for 9..22;
$topography{$_} = 'rugged hills'    for 23..37;
$topography{$_} = 'gentle hills'    for 38..69;
$topography{$_} = 'tablelands'      for 70..76;
$topography{$_} = 'plains'          for 77..100;

sub local_topography {
  my $percent = percentile;
  return $topography{$percent};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::LocalTopography> randomly selects the local mountains, hills, and tablelands.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::LocalTopography version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::LocalTopography qw(local_topography);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::LocalTopography depends on L<Random::SpecialDice> and L<Exporter>.

Random::SpecialDice depends on L<Games::Dice>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;