package Random::RPG::World::WorldBuildersGuidebook::WorldHooks;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);

use Random::SpecialDice qw(percentile d16);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(world_hook);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# World Hooks (Table 1)

my %world_hooks;
$world_hooks{$_} = 'climate or landform' for 1..24;
$world_hooks{$_} = 'sites of interest'   for 25..34;
$world_hooks{$_} = 'cultures'            for 35..60;
$world_hooks{$_} = 'situation'           for 31..85;
$world_hooks{$_} = 'historical'          for 86..100;

my %climate_or_landform = (
   1 => 'aerial',
   2 => 'archipelago',
   3 => 'artic',
   4 => 'desert',
   5 => 'forest',
   6 => 'inland seas / lake',
   7 => 'jungle',
   8 => 'mountain',
   9 => 'oceanic',
  10 => 'plains / steppes',
  11 => 'subterranean',
  12 => 'swamp',
  13 => 'uninhabitable',
  14 => 'unstable / formless',
  15 => 'volcanic',
  16 => 'weather',
);

my %sites_of_interest = (
   1 => 'caverns',
   2 => 'cities',
   3 => 'dungeons',
   4 => 'extraplanar',
   5 => 'fortresses / strongholds',
   6 => 'ruins',
   7 => 'shrines',
   8 => 'wilderness',
);

my %cultures = (
   1 => 'African',
   2 => 'ancient',
   3 => 'Arabian',
   4 => 'barbarian',
   5 => 'feudal',
   6 => 'mercantiles',
   7 => 'Native American',
   8 => 'Oriental',
   9 => 'Renaissance',
  10 => 'post-Renaissance',
  11 => 'savage / tribal',
  12 => 'seafaring',
);

my %situation = (
   1 => 'class dominance',
   2 => 'court',
   3 => 'chivalry',
   4 => 'deity',
   5 => 'dying world',
   6 => 'enemies',
   7 => 'exploration',
   8 => 'frontier',
   9 => 'magical',
  10 => 'new world',
  11 => 'psionics',
  12 => 'race dominance',
  13 => 'religious',
  14 => 'slavery',
  15 => 'technology',
  16 => 'warfare',
);

my %historical = (
   1 => 'ancient warfare',
   2 => 'artifact',
   3 => 'Balkanization',
   4 => 'civil war',
   5 => 'crusade',
   6 => 'insurrection',
   7 => 'migration',
   8 => 'post-apocalyptic',
);

sub hook {
  my $percent = percentile;
  return $world_hooks{$percent};
}

sub world_hook {
  my $hook = hook;

  my $roll;
  my $world_hook;

  if ($hook eq 'climate or landform') {
    $roll = d16;
    $world_hook = $climate_or_landform{$roll};
  }
  if ($hook eq 'sites of interest') {
    $roll = roll('d8');
    $world_hook = $sites_of_interest{$roll};
  }
  if ($hook eq 'cultures') {
    $roll = roll('d12');
    $world_hook = $cultures{$roll};
  }
  if ($hook eq 'situation') {
    $roll = d16;
    $world_hook = $situation{$roll};
  }
  if ($hook eq 'historical') {
    $roll = roll('d8');
    $world_hook = $historical{$roll};
  }

  return $world_hook;
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::WorldHooks> randomly selects the hook of the new setting.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::WorldHooks version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::WorldHooks qw(world_hook);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::WorldHooks depends on L<Random::SpecialDice>, L<Games::Dice>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;