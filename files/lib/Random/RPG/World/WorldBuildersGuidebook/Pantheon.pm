package Random::RPG::World::WorldBuildersGuidebook::Pantheon;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_pantheon_size random_pantheon_type random_pantheon_organization random_pantheon_involvement);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Campaign World Pantheon (Table 38)

my %pantheon_type;
$pantheon_type{$_} = 'one universal pantheon'                              for 1..40;
$pantheon_type{$_} = 'one pantheon per major culture, overlapping deities' for 41..70;
$pantheon_type{$_} = 'one pantheon per major culture, in contact'          for 71..90;
$pantheon_type{$_} = 'one pantheon per major culture, no contact'          for 91..100;

# Pantheon Size (Table 39)

my %number_of_powers;
for (1..25) {
  $number_of_powers{$_}{size}         = 'small';
  $number_of_powers{$_}{greater}      = '1d2';
  $number_of_powers{$_}{intermediate} = '1d3';
  $number_of_powers{$_}{lesser}       = '1d4 + 1';
  $number_of_powers{$_}{'demi-'}      = '1d4';
}
for (26..60) {
  $number_of_powers{$_}{size}         = 'medium';
  $number_of_powers{$_}{greater}      = '1d3';
  $number_of_powers{$_}{intermediate} = '1d4';
  $number_of_powers{$_}{lesser}       = '1d6 + 1';
  $number_of_powers{$_}{'demi-'}      = '1d6';
}
for (61..85) {
  $number_of_powers{$_}{size}         = 'large';
  $number_of_powers{$_}{greater}      = '1d4';
  $number_of_powers{$_}{intermediate} = '1d6';
  $number_of_powers{$_}{lesser}       = '2d4 + 1';
  $number_of_powers{$_}{'demi-'}      = '1d8';
}
for (86..100) {
  $number_of_powers{$_}{size}         = 'huge';
  $number_of_powers{$_}{greater}      = '2d3';
  $number_of_powers{$_}{intermediate} = '2d4';
  $number_of_powers{$_}{lesser}       = '2d6 + 1';
  $number_of_powers{$_}{'demi-'}      = '1d10';
}

# Pantheon Organization (Table 40)

my %pantheon_organization;
$pantheon_organization{$_} = 'family'      for 1..15;
$pantheon_organization{$_} = 'racial'      for 16..25;
$pantheon_organization{$_} = 'elemental'   for 26..35;
$pantheon_organization{$_} = 'celestial'   for 36..50;
$pantheon_organization{$_} = 'heroes'      for 51..60;
$pantheon_organization{$_} = 'natural'     for 61..65;
$pantheon_organization{$_} = 'stewards'    for 66..75;
$pantheon_organization{$_} = 'bureaucracy' for 76..80;
$pantheon_organization{$_} = 'mixed'       for 81..100;

# Pantheon Involvement (Table 41)

my %pantheon_involvement;
$pantheon_involvement{$_} = 'oblivious'  for 1..15;
$pantheon_involvement{$_} = 'aloof'      for 16..40;
$pantheon_involvement{$_} = 'moderate'   for 41..70;
$pantheon_involvement{$_} = 'meddlesome' for 71..95;
$pantheon_involvement{$_} = 'direct'     for 96..100;

sub random_pantheon_type {
  my $percent = percentile;
  return $pantheon_type{$percent};
}

sub random_pantheon_organization {
  my ($size) = @_;
  my $percent = percentile;

  $percent += 10 if $size eq 'large';
  $percent += 25 if $size eq 'huge';

  $percent = $percent > 100 ? 100 : $percent;

  return $pantheon_organization{$percent};
}

sub random_pantheon_involvement {
  my $percent = percentile;
  return $pantheon_involvement{$percent};
}

sub random_pantheon_size {
  my ($rolled_type) = @_;
  my $percent = percentile;

  my $type = $rolled_type ? $rolled_type : random_pantheon_type;
  $percent += 25 if $type =~ /universal/;
  $percent = $percent > 100 ? 100 : $percent;

  my %pantheon;
  for my $power (keys %{$number_of_powers{$percent}}) {
    next if $power eq 'size';
    $pantheon{$power} = roll($number_of_powers{$percent}{$power});
  }
  $pantheon{'size'} = $number_of_powers{$percent}{'size'};
  $pantheon{'orgnization'} = random_pantheon_organization($pantheon{'size'});
  $pantheon{'involvement'} = random_pantheon_involvement;

  return \%pantheon;
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::Pantheon> randomly selects the pantheon of the new world.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::Pantheon version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::Pantheon qw(
    random_pantheon_size
    random_pantheon_type
    random_pantheon_organization
    random_pantheon_involvement
  );

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::Pantheon depends on L<Random::SpecialDice>, L<Games::Dice>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;