# Random generators

All of these modules depend on [Exporter](). Most depend on [Fancy::Rand](../Fancy/Rand.pm), those that do not will be in *italics*.

## General randomness

* [Random::Alpha](Alpha.pm) selects random letters of the English alphabet. It also depends on [Fancy::Open](../Fancy/Open.pm) and [Util::Data](../Util/Data.pm). It needs the [alpha data files](../../data/Random/Alpha) to run.
* [Random::Descriptor](Descriptor.pm) selects a random descriptor.
* [Random::Dragon](Dragon.pm) selects random dragons from the DreamWorks Dragons, *Harry Potter*, *Pern*, and *Xanth* series and dragons from *Advanced Dungeons & Dragons*, 2nd Edition. It also depends on Fancy::Open, Random::Color, Random::Xanth::Dragon, Random::RPG::Monster, and Util::Data. It needs the [dragon data files](../../data/Random/Dragons) to run.
* [Random::Food](Food.pm) selects either a random food or drink. It also depends on Fancy::Open, [Fancy::Map](../Fancy/Map.pm), and Util::Data. It needs the [food data files](../../data/Random/Food) to run.
* [Random::GemMetalJewelry](GemMetalJewelry.pm) selects random gems, metals, and jewelry. It also depends on [Fancy::Join::Grammatical](../Fancy/Join/Grammatical.pm) and [Lingua::EN::Inflect](https://metacpan.org/pod/Lingua::EN::Inflect).
* [*Random::Government*](Government.pm) selects a random government type.
* [*Random::Insanity*](Insanity.pm) selects a random mental disorder. It is used in the [character mutation generator](../RPG/CharacterMutation.pm).
* [*Random::Military*](Military.pm) generates a random fictional and fantasy military unit. It depends on [Games::Dice](https://metacpan.org/pod/Games::Dice).
* [Random::Misc](Misc.pm) selects random miscellaneous things. It is used in the [character mutation generator](../RPG/CharacterMutation.pm).
* [Random::Month](Month.pm) selects a random month by language. It also depends on [Date::Calc](https://metacpan.org/pod/Date::Calc).
* [Random::Range](Range.pm) selects random ranges or radiuses. It is used in the [character mutation generator](../RPG/CharacterMutation.pm).
* [Random::SciFi](SciFi.pm) returns a random *Hitchhikers' Guide to the Galaxy* sector or a random *Men in Black* agent id. It also depends on Random::Alpha.
* [Random::Size](Size.pm) selects random relative sizes.
* [Random::SpecialDice](SpecialDice.pm) rolls for a random die, d16, percentile, permille, and permyriad. It also depends on Games::Dice. It is used in the [character mutation generator](../RPG/CharacterMutation.pm).
* [Random::Thing](Thing.pm) selects random things. It is used in the [character mutation generator](../RPG/CharacterMutation.pm).
* [Random::Time](Time.pm) selects a random time unit, random day part, random time, or random frequency. It also depends on Random::SpecialDice and Lingua::EN::Inflect. It is used in the [character mutation generator](../RPG/CharacterMutation.pm).
* [Random::Title](Title.pm) selects random titles given to people.
* [Random::Water](Water.pm) selects random running or standing waters and precipitation.

## Random::Body
* [Random::Body::Function](Body/Function.pm) selects random body functions. It also depends on [Fancy::Join::Grammatical](../Fancy/Join/Grammatical.pm). It is used in the [character mutation generator](../RPG/CharacterMutation.pm).
* [Random::Body::Modification](Body/Modification.pm) selects random body modifications. It also depends on Random::Color, Random::GemMetalJewelry, Random::Size, Random::Misc, Random::RPG::Alignment, [Games::Dice](https://metacpan.org/pod/Games::Dice), and [Lingua::EN::Inflect](https://metacpan.org/pod/Lingua::EN::Inflect). It is used in the [character mutation generator](../RPG/CharacterMutation.pm).

## Random::Color
* [Random::Color](Color.pm) selects random colors. It also depends on [Fancy::Open](../Fancy/Open.pm) and [Util::Data](../Util/Data.pm). It needs the [color data files](../../data/Random/Colors) to run.
* [*Random::Color::Hex*](Color/Hex.pm) returns random colors. It depends on [Fancy::Split](../Fancy/Split.pm).
* [Random::Color::VisiBone](Color/VisiBone.pm) selects random colors based on the Web Designer's Color Reference Poster by [VisiBone](http://www.visibone.com/color/poster4x.html).

## Random::Name
* [*Random::Name::Pattern*](Name/Pattern.pm) generates random names by a specified pattern, based on Random Name by Jason Seeley.
* [*Random::Name::Triador*](Name/Triador.pm) is a name generator for the world of Triador that I am slowly building. It depends on Random::Name::Pattern and [Games::Dice](https://metacpan.org/pod/Games::Dice).

## Random::Xanth
* [Random::Xanth::Dragon](Xanth/Dragon.pm) generates random dragons from the *Xanth* series by Piers Anthony.

## Random::RPG
All of Random::RPG modules are based on and are for *Advanced Dungeons & Dragons*, Second Edition. All of the modules listed below are used in the [character mutation generator](../RPG/CharacterMutation.pm) except the specific magic item generators. Please see the [Random::RPG::World readme](RPG/World/readme.md) for more on those modules.

* [Random::RPG::AbilityScores](RPG/AbilityScores.pm) selects random ability scores and their game effects.
* [Random::RPG::Alignment](RPG/Alignment.pm) selects random alignments.
* [Random::RPG::Class](RPG/Class.pm) selects random adventurer classes.
* [Random::RPG::Event](RPG/Event.pm) selects random game events. It also depends on Random::RPG::AbilityScores and Random::RPG::SavingThrow.
* [Random::RPG::Monster](RPG/Monster.pm) selects random monsters from the I<Monstrous Manual> and its compendiums. It also depends on Fancy::Map and [List::Util](https://metacpan.org/pod/List::Util).
* [Random::RPG::SavingThrow](RPG/SavingThrow.pm) selects random saving throws.
* [Random::RPG::SpecialAttack](RPG/SpecialAttack.pm) selects random special attacks. It also depends on [Fancy::Join::Defined](../Fancy/Join/Defined.pm), Random::SpecialDice, and Random::Time.
* [Random::RPG::Spell](RPG/Spell.pm) selects random spells and spell actions. It also depends on Random::SpecialDice and [Lingua::EN::Inflect](https://metacpan.org/pod/Lingua::EN::Inflect).
* [Random::RPG::Weapon](RPG/Weapon.pm) selects random weapons. It also depends on Random::Misc, [RPG::WeaponName](../RPG/WeaponName.pm), [Games::Dice](https://metacpan.org/pod/Games::Dice), [String::Util](https://metacpan.org/pod/String::Util), and Util::Data.
* [Random::RPG::WildPsionics](RPG/WildPsionics.pm) selects random wild psionic talents. It also depends on Games::Dice, Lingua::EN::Inflect, [List::MoreUtils](https://metacpan.org/pod/List::MoreUtils), and Util::Data.

### Random::RPG::MagicItem
* [Random::RPG::MagicItem](RPG/MagicItem.pm) selects random magic items. It also depends on Random::Range, Random::SpecialDice, and [Lingua::EN::Inflect](https://metacpan.org/pod/Lingua::EN::Inflect).
* [Random::RPG::MagicItem::Giant](RPG/MagicItem/Giant.pm) selects random magic items based on giants. It also depends on Random::RPG::MagicItem.
* [Random::RPG::MagicItem::Ring::SpellDoubling](RPG/MagicItem/Ring/SpellDoubling.pm) makes or randomly generates a Ring of Spell Doubling.
