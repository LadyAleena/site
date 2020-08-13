# Lady Aleena's modules

I wrote these modules for my site, but some were written just for fun. Those that I would like to share on CPAN one day are in **bold** and have POD (Plain Old Documetation).

## The directories and files

[Base](Base): The module that begins the display of my pages. I am currently considering splitting it into two modules. Check your sanity before looking at it.

[**Date**](Date): These modules were written for fun and are not used on my site. It includes a [readme](Date/readme.md) for more information.

[**Fancy**](Fancy): These modules were written to allow for more fancy usage of some functions. It includes a [readme](Fancy/readme.md) for more information.

[**Fun**](Fun): These modules were written for fun and are not used on my site. It includes a [readme](Fun/readme.md) for more information.

[HTML](HTML): These modules are to print the html for my site.

[**Name**](Name): The Transform module parses names into an arrayref.

[**RPG**](RPG): These modules were written to help me display my AD&D player characters, however, that project is on indefinite hold. They are not worth sharing as they are for *Advanced Dungeons & Dragons* 2nd Ed., and the current edition is 5.

[**Random**](Random): These modules started out as helpers to my [character mutations generator](RPG/CharacterMutation.pm), but it has since grown to include generators for many many more things. It includes a [readme](Random/readme.md) for more information.

[SVG](SVG): These modules were all written to help me write the [SVGs](../images) for my site and are specific to my needs.

[**String**](String): The Abbreviation module was written for fun and is not used on my site.

[**Time**](Time): The Duration module was written so I could find out durations.

[Util](Util): These modules are almost all helpers for my site and are very specific to my needs. There are not many in here that I would want to share. Those I may want to share would need new names.

[Xanth](Xanth): These modules were written to help me display my [Xanth Character Database](../../../Fandom/Xanth/Characters.pl).

[Zodiac](Zodiac): The Chinese zodiac module here has already been shared on CPAN by Rene Schickbauer with my permission.

I am considering spinning the modules that I would like to share on CPAN off into their own repository.

The one javascript file is for my collapsable site menu mainly.

## Modules I may want to add to CPAN

When I wrote these modules long ago, I was not planning on putting them on CPAN, but with some judicious rewrites to make some more generic, I think the generic ones might be worth sharing. In the directory list above, I have the directories with modules I may want to share with CPAN in **bold**. These are the modules that I will give a little more attention to, like writing plain old documentation (POD) for them. I still need to figure out tests, and thankfully some sample tests were written for me to study. I will probably need more help in the future with those modules.

I am considering copying the ones I want to share to CPAN into a new directory and starting a new repository for them to keep this repository just for my website. [Date](Date), [Fun](Fun), [Name](Name), [String](String), [Time](Time), and [Zodiac](Zodiac) may be removed from this repository completely since I don't use them anywhere on my site. The only reason they are kept in this directory for now is that I do not fully understand the structure of module packaging. So, if I move these and copy [Fancy](Fancy) and [Random](Random) (and a few [Util](Util)) modules to a new directory and repository, I will hopefully be able to put that directory in the path, but maybe not.

I am quite unsure of myself when it comes to more formal writing in Perl, so I may have lots and lots of questions.
