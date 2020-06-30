package Random::RPG::World::WorldBuildersGuidebook::TechnologyLevel;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_technology_level);

use Random::SpecialDice qw(percentile);

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

1;