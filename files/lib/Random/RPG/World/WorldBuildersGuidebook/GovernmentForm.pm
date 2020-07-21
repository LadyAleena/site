package Random::RPG::World::WorldBuildersGuidebook::GovernmentForm;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_government_form);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Government Form (Table 24)

my %government_form;
$government_form{$_} = 'Autocracy'    for 1..8;
$government_form{$_} = 'Bureaucracy'  for 9..13;
$government_form{$_} = 'Confederacy'  for 14..19;
$government_form{$_} = 'Democracy'    for 20..22;
$government_form{$_} = 'Dictatorship' for 23..27;
$government_form{$_} = 'Feudalism'    for 28..42;
$government_form{$_} = 'Geriatocracy' for 43..44;
$government_form{$_} = 'Gynarchy'     for 45..47;
$government_form{$_} = 'Hierarchy'    for 48..56;
$government_form{$_} = 'Magocracy'    for 57..59;
$government_form{$_} = 'Matriarchy'   for 60..63;
$government_form{$_} = 'Militocracy'  for 64..69;
$government_form{$_} = 'Monarchy'     for 70..79;
$government_form{$_} = 'Oligarchy'    for 80..83;
$government_form{$_} = 'Pedocracy'    for 84;
$government_form{$_} = 'Plutocracy'   for 85;
$government_form{$_} = 'Republic'     for 86..92;
$government_form{$_} = 'Satrapy'      for 93..94;
$government_form{$_} = 'Syndicracy'   for 95;
$government_form{$_} = 'Theocracy'    for 96..100;

sub random_government_form {
  my $percent = percentile;
  return $government_form{$percent};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::GovernmentForm> randomly selects the government form of the new society.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::GovernmentForm version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::GovernmentForm qw(random_government_form);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::GovernmentForm depends on L<Random::SpecialDice> and L<Exporter>.

Random::SpecialDice depends on L<Games::Dice>.

=head1 AUTHOR

Lady Aleena

=cut

1;