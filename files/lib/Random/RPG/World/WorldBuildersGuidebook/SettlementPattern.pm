package Random::RPG::World::WorldBuildersGuidebook::SettlementPattern;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_settlement_pattern);

# From the World Builder's Guidebook by Richard Baker (c) TSR

my %settlement_pattern;

# Race/Culture Settlement Pattern (Table 20)

$settlement_pattern{race}{$_} = 'coastal/seafaring'  for 1..5;
$settlement_pattern{race}{$_} = 'inland/nomadic'     for 6..9;
$settlement_pattern{race}{$_} = 'riverine'           for 10..13;
$settlement_pattern{race}{$_} = 'grasslands'         for 14..18;
$settlement_pattern{race}{$_} = 'forests'            for 19..23;
$settlement_pattern{race}{$_} = 'jungles'            for 24..27;
$settlement_pattern{race}{$_} = 'marshes/swamps'     for 28..29;
$settlement_pattern{race}{$_} = 'scrublands/deserts' for 30..31;
$settlement_pattern{race}{$_} = 'hill/highlands'     for 32..36;
$settlement_pattern{race}{$_} = 'mountains'          for 37..38;
$settlement_pattern{race}{$_} = 'tropical'           for 39..43;
$settlement_pattern{race}{$_} = 'sub-tropical'       for 44..47;
$settlement_pattern{race}{$_} = 'temperate'          for 48..53;
$settlement_pattern{race}{$_} = 'sub-artic'          for 54..58;
$settlement_pattern{race}{$_} = 'arctic'             for 59..60;
$settlement_pattern{race}{$_} = 'northeast quadrant' for 61..70;
$settlement_pattern{race}{$_} = 'southeast quadrant' for 71..80;
$settlement_pattern{race}{$_} = 'southwest quadrant' for 81..90;
$settlement_pattern{race}{$_} = 'northwest quadrant' for 91..100;

# Kingdom Settlement Pattern (Table 31)

$settlement_pattern{kingdom}{$_} = 'coastal'            for 1..25;
$settlement_pattern{kingdom}{$_} = 'riverline'          for 26..40;
$settlement_pattern{kingdom}{$_} = 'wells/oases'        for 41..45;
$settlement_pattern{kingdom}{$_} = 'grasslands/arable land' for 46..60;
$settlement_pattern{kingdom}{$_} = 'best climate'       for 61..75;
$settlement_pattern{kingdom}{$_} = 'best topography'    for 76..92;
$settlement_pattern{kingdom}{$_} = 'northeast quadrant' for 93..94;
$settlement_pattern{kingdom}{$_} = 'southeast quadrant' for 95..93;
$settlement_pattern{kingdom}{$_} = 'southwest quadrant' for 97..98;
$settlement_pattern{kingdom}{$_} = 'northwest quadrant' for 99..100;

sub random_settlement_pattern {
  my $pattern = shift;
  warn "You need to choose either 'race', 'culture', or 'kingdom' patterns." if !$pattern;

  my $pattern_type = $pattern eq 'culture' ? 'race' : $pattern;
  my $percent = percentile;
  return $settlement_pattern{$pattern_type}{$percent};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::SettlementPattern> randomly selects the settlement pattern by race, culture, or kingdom.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::SettlementPattern version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::SettlementPattern qw(random_settlement_pattern);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::SettlementPattern depends on L<Random::SpecialDice> and L<Exporter>.

Random::SpecialDice depends on L<Games::Dice>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;