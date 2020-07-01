# Random generators

Most of these modules depend on [Fancy::Rand](../Fancy/Rand.pm), those that do not will be in *italics*.

## General randomness

* [Random::Alpha](Random/Alpha.pm) selects random letters of the English alphabet.
* [Random::Descriptor](Random/Descriptor.pm) selects a random descriptor.
* [Random::Dragon](Random/Dragon.pm) generates random dragons from the DreamWorks Dragons, *Harry Potter*, *Pern*, and *Xanth* series and dragons from *Advanced Dungeons & Dragons*, 2nd Edition. It also depends on Util::Data, Random::Color, Random::Xanth::Dragon, and Random::RPG::Monster.
* [Random::Food](Random/Food.pm) selects either a random food or drink. It also depends on [Fancy::Map](../Fancy/Map.pm).
* [Random::GemMetalJewelry](Random/GemMetalJewelry.pm) selects random gems, metals, and jewelry. It also depends on [Fancy::Join::Grammatical](../Fancy/Join/Grammatical.pm) and [Lingua::EN::Inflect](https://metacpan.org/pod/Lingua::EN::Inflect).
* [*Random::Government*](Random/Government.pm) returns a random government type.
* [*Random::Insanity*](Random/Insanity.pm) returns a random mental disorder.
* [*Random::Military*](Random/Military.pm) returns a random fictional and fantasy military unit. It depends on [Games::Dice](https://metacpan.org/pod/Games::Dice).
* [Random::Misc](Random/Misc.pm) selects random miscellaneous things.
* [Random::Month](Random/Month.pm) selects a random month by language. It also depends on [Date::Calc](https://metacpan.org/pod/Date::Calc).
* [Random::Range](Random/Range.pm) selects random ranges or radiuses.
* [Random::SciFi](Random/SciFi.pm) returns a random *Hitchhikers' Guide to the Galaxy* sector or a random *Men in Black* agent id. It also depends on Random::Alpha.
* [Random::Size](Random/Size.pm) selects random relative sizes.
* [Random::SpecialDice](Random/SpecialDice.pm) rolls for a random die, d16, percentile, permille, and permyriad. It also depends on Games::Dice.
* [Random::Thing](Random/Thing.pm) selects random things. It also depends on Random::RPG::MagicItem, Random::RPG::Monster, and Random::RPG::Weapon.
* [Random::Time](Random/Time.pm) selects a random time unit, random day part, random time, or random frequency. It also depends on Random::SpecialDice and Lingua::EN::Inflect.
* [Random::Title](Random/Title.pm) selects random titles given to people.
* [Random::Water](Random/Water.pm) selects random running or standing waters and precipitation.

* [Random::Body::Function](Random/Body/Function.pm) selects random body functions. It also depends on [Fancy::Join::Grammatical](../Fancy/Join/Grammatical.pm).
* [Random::Body::Modification](Random/Body/Modification.pm) selects random body modifications. It also depends on Games::Dice, Lingua::EN::Inflect, Random::Color, Random::GemMetalJewelry, Random::Size, Random::Misc, and Random::RPG::Alignment.

* [Random::Color](Random/Color.pm) selects random colors. It also depends on [Util::Data](../Util/Data.pm).
* [*Random::Color::Hex*](Random/Color/Hex.pm) returns random colors. It depends on [Fancy::Split](../Fancy/Split.pm).
* [Random::Color::VisiBone](Random/Color/VisiBone.pm) selects random colors based on the Web Designer's Color Reference Poster by [VisiBone](http://www.visibone.com/color/poster4x.html).

* [*Random::Name::Pattern*](Random/Name/Pattern.pm) generates random names by a specified pattern, based on Random Name by Jason Seeley.
* [*Random::Name::Triador*](Random/Name/Triador.pm) is a name generator for the world of Triador that I am slowly building. It depends on Games::Dice and Random::Name::Pattern.

* [Random::Xanth::Dragon](Random/Xanth/Dragon.pm) generates random dragons from the *Xanth* series by Piers Anthony.

All of Random::RPG modules are based on and are for *Advanced Dungeons & Dragons*, Second Edition.
* [Random::RPG::AbilityScores](Random/RPG/AbilityScores.pm) selects random ability scores and their game effects.
* [Random::RPG::Alignment](Random/RPG/Alignment.pm) selects random alignments.
* [Random::RPG::Class](Random/RPG/Class.pm) selects random adventurer classes.
* [Random::RPG::Event](Random/RPG/Event.pm) selects random game events. It also depends on Random::RPG::AbilityScores and Random::RPG::SavingThrow.
* [Random::RPG::Monster](Random/RPG/Monster.pm) selects random monsters from the I<Monstrous Manual> and its compendiums. It also depends on Lingua::EN::Inflect, [List::Util](https://metacpan.org/pod/List::Util), and Fancy::Map.
* [Random::RPG::SavingThrow](Random/RPG/SavingThrow.pm) selects random saving throws.
* [Random::RPG::SpecialAttack](Random/RPG/SpecialAttack.pm) selects random special attacks. It also depends on [Fancy::Join::Defined](../Fancy/Join/Defined.pm), Random::SpecialDice, and Random::Time.
* [Random::RPG::Spell](Random/RPG/Spell.pm) selects random spells and spell actions. It also depends on Lingua::EN::Inflect and Random::SpecialDice.
* [Random::RPG::Weapon](Random/RPG/Weapon.pm) selects random weapons. It also depends on Games::Dice, Lingua::EN::Inflect, [String::Util](https://metacpan.org/pod/String::Util), Util::Data, Random::Misc, and [RPG::WeaponName](../RPG/WeaponName.pm).
* [Random::RPG::WildPsionics](Random/RPG/WildPsionics.pm) selects random wild psionic talents. It also depends on Games::Dice, Lingua::EN::Inflect, [List::MoreUtils](https://metacpan.org/pod/List::MoreUtils), and Util::Data.

* [Random::RPG::MagicItem](Random/RPG/MagicItem.pm) selects random magic items. It also depends on Lingua::EN::Inflect, Random::Range, and Random::SpecialDice.
* [Random::RPG::MagicItem::Giant](Random/RPG/MagicItem/Giant.pm) selects random magic items based on giants. It also depends on Random::RPG::MagicItem.
* [Random::RPG::MagicItem::Ring::SpellDoubling](Random/RPG/MagicItem/Ring/SpellDoubling.pm) makes or randomly generates a Ring of Spell Doubling. It also depends on Lingua::EN::Inflect, List::Util, Fancy::Join::Grammatical, and [Util::Number](../Util/Number.pm).

Please see the [Random RPG World readme](Random/RPG/World/readme.md) for more on those modules.