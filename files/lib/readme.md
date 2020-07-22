# Lady Aleena's modules

I wrote these modules for my site, but some were written just for fun. Those that I would like to share on CPAN one day are in **bold** and have POD (Plain Old Documetation).

## The directories and files

[Base](Base): The module that begins the display of my pages. I am currently considering splitting it into two modules. Check your sanity before looking at it.

**[Date](Date)**: These modules were written for fun and are not used on my site.

**[Fancy](Fancy)**: These modules were written to allow for more fancy usage of some functions.

**[Fun](Fun)**: These modules were written for fun and are not used on my site.

[HTML](HTML): These modules are to print the html for my site.

**[Name](Name)**: The Transfrom module parses names into an arrayref.

[RPG](RPG): These modules were written to help me display my AD&D player characters, however, that project is on indefinite hold. They are not worth sharing as they are for *Advanced Dungeons & Dragons* 2nd Ed., and the current edition is 5.

**[Random](Random)**: These modules started out as helpers to my [character mutations generator](RPG/CharacterMutation.pm), but it has since grown to include generators for many many more things. It includes a [readme](Random/readme.md) for more information.

[SVG](SVG): These modules were all written to help me write the [SVGs](../images) for my site and are specific to my needs.

**[Time](Time)**: The Duration module was written so I could find out durations.

[Util](Util): These modules are almost all helpers for my site and are very specific to my needs. There are not many in here that I would want to share. Those I may want to share would need new names.

[Xanth](Xanth): These modules were written to help me display my [Xanth Character Database](../../../Fandom/Xanth/Characters.pl).

[Zodiac](Zodiac): The Chinese zodiac module here has already been shared on CPAN by Rene Schickbauer with my permission.

I am considering spinning the modules that I would like to share on CPAN off into their own repository.

The one javascript file is for my collapsable site menu mainly.

## The POD in my modules

You will be able to see rather quickly that I do not use the standard headings in the postions you are used to them being in my POD.

The first heading `head1` is the name of the module not just `NAME`. As more people are reading module descriptions on the web, the first heading should always be the title, in this case the module name.

The remaining standard headings are all `head2` and in `Sentence case` even if the title of the section is not a full sentence.

It may take some time to get used to reading my POD, but this is an experiment to see how people like it generally. This does give me only two additional levels down, but I can work with that. My personal opinion is that even in HTML documents, one should never go that far down. However, I have not writen any technical documents or research papers where that depth would be needed.