package Random::RPG::World::HighLevelCampaigns::EcologicalRating;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(random_ecological_rating);

use Games::Dice qw(roll);

# Table from the Dungeon Master Option: High-Level Campaigns  by Skip Williams (c) TSR.
# Ecological Ratings (Table 5)

my %ecological_rating = (
  2 => "Ecology is wildly different from the base campaign in almost every way; the environment is deadly (poisonous, airless, acidic, etc.). Living creatures, if they exist at all, are barely recognizable as such.",
  3 => "Ecology is different from the base campaign in most ways; the environment is hostile (very cold, waterless, flooded with x-rays, etc.). Living creatures have completely alien forms.",
  4 => "Ecology is similar to the base campaign. The environment is fairly livable, but some vital element is absent or incompatible. The PCs cannot survive over the long term without a large stock of supplies from their home world or magical aid (can't eat the food, water makes PCs drunk, etc.). Overall conditions may be hostile, such as boiling daytime temperatures, subzero nighttime temperatures, acid rain, etc. One or more intelligent races resemble some nonhumanoid or monstrous species (insects, serpents, fungi, etc.).",
  5 => "Ecology is similar to the base campaign. The environment is livable, but some vital element is absent or incompatible. The PCs cannot survive over the  long term without a large stock of supplies from their home world or magical aid (can't eat the food, water makes PCs drunk, etc.). Overall conditions may be severe, such as a global desert, ice age, endless rain, etc. One or more intelligent  races resemble some nonhumanoid or monstrous species (insects, felines, fungi,  etc.).",
  6 => "Ecology is similar to the base campaign. The environment is livable, but some important element is absent or incompatible. The PCs may find the conditions inconvenient, but their long term survival is not in jeopardy (little or no metal, thin atmosphere, sunless sky, etc.). Overall conditions may be severe, such as a global desert, ice age, endless rain, etc. One or more intelligent races resembles some nonhumanoid or monstrous species (insects, felines, dragons, etc.).",
  7 => "Ecology is similar to the base campaign. Some familiar races and species are present, though they have slightly different appearances and abilities. Races and species entirely unknown in the base campaign are present. At least one intelligent race resembles some nonhumanoid species (lizards, felines, avians, etc.).",
  8 => "Ecology is very similar to the base campaign, and the environment is generally benign. Many familiar races and species are present, though they have slightly different appearances and abilities. Races and species entirely unknown in the base campaign are present.",
  9 => "Ecology is very similar to the base campaign. Most familiar races and species are present, though some may have slightly different appearances or abilities.",
  13 => "Ecology and environment is almost identical to the base campaign. All major races and species are present, but the world is ruled by elves, gnomes, dragons, or other race that is not dominant in the base campaign.",
  14 => "Ecology and environment is almost identical to the base campaign. All major races and species are present, but not all races have the same level of Intelligence and culture as they do in the base campaign (humans with only animal intelligence, talking horses, ogre artists, etc.).",
  15 => "Ecology and environment are almost identical to the base campaign. All major races and species from the base campaign are present, but some general characteristic is vastly different worldwide (everything is giant sized, colors are reversed, world is flat, etc.).",
  16 => "Ecology is very similar to the base campaign, and the environment is generally favorable (completely tropical, rains according to a predictable schedule, most plants edible, etc.). Most races and species from the base campaign are present, but local species tend to be exotic, such as flightless giant parrots, feathered snakes with iridescent plumage, or birds who sing highly musical songs.",
  17 => "Ecology is similar to the base campaign, and the environment is favorable (tropical with temperate nights, never rains, all plants edible, etc.). At least one intelligent race resembles some nonhumanoid species, such as elves that look like felines.",
  18 => "Ecology is slightly similar to the base campaign, and the environment is favorable (drinking the local water provides nourishment, sleeping is not necessary, equipment grows on trees, etc.). One or more intelligent races resemble some nonhumanoid or monstrous species (insects, serpents, fungi, etc.).",
  19 => "Ecology is different from the base campaign in most ways, and the environment is very favorable (constant temperature, breathing supplies nourishment, sunlight heals wounds, etc.). Living creatures have completely alien forms.",
  20 => "Ecology is wildly different from the base campaign in almost every way, and the environment is completely favorable (eating, sleeping, and drinking unnecessary). Living creatures exist, but are barely recognizable (pure energy, rocklike, microscopic).",
);
$ecological_rating{$_} = "Ecology, environment, and inhabitants are almost identical to the base campaign." for 10..12;

sub random_ecological_rating {
  my $roll = roll('2d10');
  return $ecological_rating{$roll};
}

1;