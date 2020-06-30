package Random::RPG::World::HighLevelCampaigns::MagicalRating;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_magical_rating);

use Games::Dice qw(roll);

# Table from the Dungeon Master Option: High-Level Campaigns  by Skip Williams (c) TSR.
# Magical Ratings (Table 3)

my %magical_rating = (
  2 => "No spell, spell-like ability, magical item, artifact, or psionic power functions, and travel into or out of the area is possible only through a pre-existing gate. Land creatures are not more than 10 feet tall, and there are no flying creatures. Demihumans and fantastic creatures do not exist.",
  3 => "Potions, wands, rings, and miscellaneous magic is ineffective, and from 6-9 schools of magic are modified in some way.  Spell casting times and PSP requirements are quintupled, and 4th-10th level spells can't be cast.  Land creatures are not more than 10 feet tall, and flight is limited to creatures less than six inches tall.  There are no demihumans or fantastic creatures.",
  4 => "Potions, wands, and rings are ineffective and from 4-9 schools of magic are modified in some fashion. Spell casting times and PSP requirements quintupled; 5th-10th level spells impossible; land creatures are not more than 10 feet tall; flight is limited to creatures less than 1 foot tall. There are no demihumans or fantastic creatures.",
  5 => "Potions and wands ineffective; 3-9 schools of magic modified. Spell casting times and PSP requirements are quintupled, and 6th-10th level spells can't be cast — native spellcasters are almost unknown. Land creatures are not more than 10 feet tall, and flight is limited to size T creatures (two feet tall or less). There are no demihumans or fantastic creatures.",
  6 => "Potions are ineffective and from 3-9 schools of magic are modified. Spell casting times and PSP requirements quadrupled, and 7th-10th level spells can't be cast. Native spellcasters are very rare and have supra genius Intelligence. There are no land creatures more than 15 feet tall, no bipedal creatures more than 10 feet tall, and flight is limited to size S or smaller creatures.",
  7 => "Most spells, magical items, and psionics function normally, but 2-7 schools of magic are modified. Spell casting times and PSP requirements are tripled, and 8th-10th level spells cannont be cast. With long and diffucult training, a few creatures of at least genius intelligence can learn to cast spells. There are no land creatures more than 20 feet tall, no bipedal creatures more than 15 feet tall, and flight is limited to size M or smaller creaures.",
  8 => "Most spells, magical items, and psionics function normally, but 2-5 schools of magic are modified. Spell casting times and PSP requirements are doubled, and 9th-10th level spells can't be cast. With training, a few creatures of at least exceptional Intelligence can learn to cast spells. There are no land creatures more than 25 feet tall, no bipedal creatures more than 20 feet tall, and flight is limited to size L or smaller creatures.",
  9 => "Most spells, magical items, and psionics function normally, and only 1-4 schools of magic are modified. True Dweomers (10th level spells) are not available, but creatures with at least average intelligence can learn to cast spells if properly trained. There are no land creatures more than 30 feet tall, no bipedal creatures more than 25 feet tall, and flight is limited to size H or smaller creatures.",
  13 => "Spells, magical items, and psionics function normally, and major races have minor spell like abilities or psionic wild talents. Some individual spells are modified.",
  14 => "Most spells, magical items, and psionics function normally, and major races have minor and major spell like abilities or multiple psionic powers. Some elemental spells and from 1-4 schools of magic are modified.",
  15 => "Most spells, magical items, and psionics function normally, and major races have minor, major, and extraordinary spell like abilities or full psionic powers. Some elemental spells are modified. From 2-5 schools of magic are also modified with possibly catastrophic effects.",
  16 => "Most spells, magical items, and psionics function normally, and major races have minor, major, and extraordinary spell like abilities or full psionic powers. Some elemental spells are modified. From 2-7 schools of magic are also modified with possibly catastrophic effects.",
  17 => "Most spells, magical items, and psionics function normally, and major races have minor, major, and extraordinary spell like abilities or full psionic powers. Some elemental spells are modified. From 3-9 schools of magic are also modified with possibly catastrophic effects.",
  18 => "Most spells, magical items, and psionics function normally, and major races have minor, major, and extraordinary spell like abilities or full psionic powers. Some elemental spells are modified. From 3-9 schools of magic are also modified with possibly catastrophic effects. Beings of at least average Intelligence have minor spellcasting abilities.",
  19 => "Most spells, magical items, and psionics function normally, and major races have minor, major, and extraordinary spell like abilities or full psionic powers. Some elemental spells are modified. From 3-9 schools of magic are also modified with possibly catastrophic effects. Beings of average intelligence have minor spellcasting abilities, and those with at least high intelligence have major spellcasting abilities. Wizard characters do not need to study spellbooks.",
  20 => "Most spells, magical items, and psionics function normally, and major races have minor, major, and extraordinary spell like abilities or full psionic powers. Some elemental spells are modified. From 3-9 schools of magic are also modified with possibly catastrophic effects. Beings of average intelligence have major spellcasting abilities, and those with at least high Intelligence have extraordinary spellcasting abilities. Wizard characters do not need to study spellbooks, and no spellcaster needs to memorize spells.",
);
$magical_rating{$_} = "Spells, magical items, and psionics function normally, and most creatures of at least average Intelligence can learn to cast spells with adequate training. There are no practical limits on the size of land or of flying creatures, and demihumans and fantastic creatures are fairly common." for 10..12;

sub random_magical_rating {
  my $roll = roll('2d10');
  return $magical_rating{$roll};
}

1;