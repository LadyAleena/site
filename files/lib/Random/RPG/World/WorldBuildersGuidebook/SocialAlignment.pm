package Random::RPG::World::WorldBuildersGuidebook::SocialAlignment;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_social_alignment);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Social Alignment (Table 25)

my %social_alignment;
$social_alignment{$_} = 'Lawful Good'     for 1..16;
$social_alignment{$_} = 'Lawful Neutral'  for 17..28;
$social_alignment{$_} = 'Lawful Evil'     for 29..44;
$social_alignment{$_} = 'Neutral Evil'    for 45..56;
$social_alignment{$_} = 'True Neutral'    for 57..60;
$social_alignment{$_} = 'Neutral Good'    for 61..70;
$social_alignment{$_} = 'Chaotic Good'    for 71..82;
$social_alignment{$_} = 'Chaotic Neutral' for 83..88;
$social_alignment{$_} = 'Chaotic Evil'    for 89..100;

sub random_social_alignment {
  my $percent = percentile;
  return $social_alignment{$percent};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::SocialAlignment> randomly selects the social alignment of the new region.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::SocialAlignment version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::SocialAlignment qw(random_social_alignment);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::SocialAlignment depends on L<Random::SpecialDice> and L<Exporter>.

Random::SpecialDice depends on L<Games::Dice>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;