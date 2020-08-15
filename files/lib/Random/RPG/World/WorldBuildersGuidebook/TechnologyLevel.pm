package Random::RPG::World::WorldBuildersGuidebook::TechnologyLevel;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_technology_level);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Kingdom Technology Level (Table 23)

my %technology_level;
# DMG level; DMG is the Dungeon Master's Guide.
$technology_level{DMG}{$_} = 'Ancient'     for 1..15;
$technology_level{DMG}{$_} = 'Dark Ages'   for 16..45;
$technology_level{DMG}{$_} = 'Middle Ages' for 46..80;
$technology_level{DMG}{$_} = 'Renaissance' for 81..100;

# Player's Option level
$technology_level{PlayOpt}{$_} = 'Stone Age'     for 1..5;
$technology_level{PlayOpt}{$_} = 'Savage'        for 6..15;
$technology_level{PlayOpt}{$_} = 'Bronze Age'    for 16..25;
$technology_level{PlayOpt}{$_} = 'Roman'         for 26..32;
$technology_level{PlayOpt}{$_} = 'Dark Ages'     for 33..51;
$technology_level{PlayOpt}{$_} = 'Crusades'      for 52..69;
$technology_level{PlayOpt}{$_} = '100 Years War' for 70..89;
$technology_level{PlayOpt}{$_} = 'Renaissance'   for 90..100;

sub random_technology_level {
  my $book = shift;
  warn "You need to choose either 'DMG' or more 'PlayOpt' technology levels." if !$book;

  my $percent = percentile;
  return $technology_level{$book}{$percent};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::TechnologyLevel> randomly selects the technology level of the new world.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::TechnologyLevel version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::TechnologyLevel qw(random_technology_level);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::TechnologyLevel depends on L<Random::SpecialDice> and L<Exporter>.

Random::SpecialDice depends on L<Games::Dice>.

=head1 NOTE

You can use this module with L<Random::RPG::World::HighLevelCampaigns::TechnologicalRating> to create truly unique technological levels.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;