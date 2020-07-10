package Random::RPG::World::HighLevelCampaigns::ChronologicalRating;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(random_chronological_rating);

use Games::Dice qw(roll);

# Table from the Dungeon Master Option: High-Level Campaigns  by Skip Williams (c) TSR.
# Chronological Ratings (Table 2)

my %chronological_rating = (
  2 => "1 second",
  3 => "15 seconds",
  4 => "1 minute",
  5 => "10 minutes",
  6 => "30 minutes",
  7 => "1 hour",
  8 => "6 hours",
  9 => "1 day",
  13 => "1 month",
  14 => "3 months",
  15 => "6 months",
  16 => "1 year",
  17 => "5 years",
  18 => "10 years",
  19 => "30 years",
  20 => "100 years",
);
$chronological_rating{$_} = "1 week" for 10..12;

sub random_chronological_rating {
  my $roll = roll('2d10');
  my $chrondiff = $chronological_rating{$roll};
  my $time;
  if ($chrondiff eq "1 week") {
    $time = "Thre is no temporal difference.";
  }
  else {
    $time = "1 week there equals $chrondiff in your home world.";
  }
  return $time;
}

1;