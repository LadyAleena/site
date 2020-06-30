package Random::RPG::World::HighLevelCampaigns::TechnologicalRating;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_technological_rating);

use Games::Dice qw(roll);

# Table from the Dungeon Master Option: High-Level Campaigns  by Skip Williams (c) TSR.
# Technological Ratings (Table 4)

my %technological_rating = (
	2 => "Tools are unknown; fire has not been harnessed.",
	3 => "Simple stone tools and weapons; campfires.",
	4 => "Complex stone tools, some soft metal tools and weapons (copper); domesticated animals; simple agriculture; ovens; pottery.",
	5 => "Soft metal tools and weapons (copper and bronze); arithmetic; complex agriculture and irrigation; hieroglyphic writing; boats; cities; sundials and water clocks; coins.",
	6 => "Hard metal tools and weapons (iron); small ships; alphabetic writing; small land vehicles; simple locks; siege machines.",
	7 => "Water mills; furnaces; cast iron; large oared ships; advanced mathematics and philosophy.",
	8 => "Civil engineering; roads; blown glass; wagons; medicine.",
	9 => "Compass; windmills; universities; surgery.",
	13 => "Cannons; ocean-going sailing ships; mechanical clocks; national governments.",
	14 => "Firearms; printing; intercontinental trade.",
	15 => "Steam engines; blast furnaces; mechanical calculating machines.",
	16 => "Internal combustion engines; light aircraft; steamships; railroads; labor unions.",
	17 => "Nuclear power; civil and military aircraft; electronic computers.",
	18 => "Fusion power; commercial spacecraft; laser weapons; genetic engineering; intercontinental governments.",
	19 => "Sentient robots and computers; solar power; portable nuclear power.",
	20 => "Faster-than-light space travel; matter transmission; matter replication; interplanetary governments.",
);
$technological_rating{$_} = "Steel tools and weapons; coal mining; trade and craft guilds; small, slow sailing ships, feudal governments; extensive trade." for 10..12;

sub random_technological_rating {
  my $roll = roll('2d10');
  return $technological_rating{$roll};
}

1;