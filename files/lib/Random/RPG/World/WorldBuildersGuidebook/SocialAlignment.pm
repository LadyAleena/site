package Random::RPG::World::WorldBuildersGuidebook::SocialAlignment;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(random_social_alignment);

use Random::SpecialDice qw(percentile);

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

1;