package Random::RPG::World::WorldBuildersGuidebook::RegionalClimate;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_regional_climate);

use Games::Dice qw(roll);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Regional Climate (Table 16)

my %regional_climate;
$regional_climate{polyhedral}{$_} = 'artic/sub-artic/temperate (northern)' for 1..2;
$regional_climate{polyhedral}{$_} = 'subtropical/tropical/subtropical'     for 3..6;
$regional_climate{polyhedral}{$_} = 'temperate/sub-artic/artic (southern)' for 7..8;

$regional_climate{polar_display}{1}  = 'artic (north)';
$regional_climate{polar_display}{$_} = 'sub-artic/temperate (north)'   for 2..5;
$regional_climate{polar_display}{$_} = 'sub-tropical/tropical (north)' for 6..10;
$regional_climate{polar_display}{$_} = 'tropical/sub-tropical (south)' for 11..15;
$regional_climate{polar_display}{$_} = 'temperate/sub-artic (south)'   for 16..19;
$regional_climate{polar_display}{20} = 'artic (south)';

sub random_regional_climate {
  my $map_type = shift;
  my $roll;
     $roll = roll('1d8')  if $map_type eq 'polyhedral';
     $roll = roll('1d20') if $map_type eq 'polar_display';
  return $regional_climate{$map_type}{$roll};
}

1;