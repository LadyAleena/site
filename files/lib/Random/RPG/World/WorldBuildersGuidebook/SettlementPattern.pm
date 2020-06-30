package Random::RPG::World::WorldBuildersGuidebook::SettlementPattern;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_settlement_pattern);

use Random::SpecialDice qw(percentile);

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

1;