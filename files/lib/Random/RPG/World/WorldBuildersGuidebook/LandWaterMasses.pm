package Random::RPG::World::WorldBuildersGuidebook::LandWaterMasses;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(masses);

use Games::Dice qw(roll);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Land and Water Masses (Table 6)

# Table incomplete, missing 12, 15, 16, 18, 20, 23, and 26 regions.

my %regions = (
   2 => { number => '1d2', size => '1d2' },
   3 => { number => '1d3', size => '1d3' },
   9 => { number => '1d6', size => '1d8' },
  11 => { number => '2d4', size => '1d10' },
  13 => { number => '2d6', size => '1d12' }
);

sub masses {
  my ($regional_distribution) = @_;
  my %masses;

  for (keys %$regional_distribution) {
    $masses{land}{regions}  += $$regional_distribution{$_} if $_ =~ /land/;
    $masses{water}{regions} += $$regional_distribution{$_} if $_ =~ /water/;
  }

  return \%masses;
}

1;