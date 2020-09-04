# Lady Aleena's modules

I wrote these modules for my site, but some were written just for fun. Those that I would like to share on CPAN one day are in **bold** and have POD (Plain Old Documetation).

I am considering spinning the modules that I would like to share on CPAN off into their own repository.

The one JavaScript file is for my collapsible site menu mainly.

## The directories and files

[Page](Page): These modules display my site's pages, generate data for specific sections or pages on my site, or are miscellaneous helpers for my site.

### Modules in use on my site that I want to also share

[**Fancy**](Fancy): These modules were written to allow for more fancy usage of some functions. You can read [readme](Fancy/readme.md) for more information.

[**Random**](Random): These modules started out as helpers to my [character mutations generator](RPG/CharacterMutation.pm), but they have since grown to include generators for many many more things. The data for these modules are in [auto/Random](auto/Random). It includes a [readme](Random/readme.md) for more information.

### Modules not in use on my site

[**Date**](Date): These modules were written for fun and are not used on my site. You can read [readme](Date/readme.md) for more information.

[**Fun**](Fun): These modules were written for fun and are not used on my site. You can read [readme](Fun/readme.md) for more information.

[**List/Value**](List/Value): The Length module was written for some reason, which I can not remember. It is not being used on my site.

[**Name**](Name): The Transform module parses names into an arrayref.

[**String**](String): The Abbreviate module was written for fun and is not used on my site.

[**Time**](Time): The Duration module was written so I could find out durations.

## Modules I may want to add to CPAN

When I wrote these modules long ago, I was not planning on putting them on CPAN, but with some judicious rewrites to make some more generic, I think the generic ones might be worth sharing. In the directory list above, I have the directories with modules I may want to share with CPAN in **bold**. These are the modules that I will give a little more attention to, like writing plain old documentation (POD) for them. I still need to figure out tests, and thankfully some sample tests were written for me to study. I will probably need more help in the future with those modules.

I am considering copying the ones I want to share to CPAN into a new directory and starting a new repository for them to keep this repository just for my website. [Date](Date), [Fun](Fun), [Name](Name), [String](String), [Time](Time), and [Zodiac](Zodiac) may be removed from this repository completely since I don't use them anywhere on my site. The only reason they are kept in this directory, for now, is that I do not fully understand the structure of module packaging. So, if I move these and copy [Fancy](Fancy) and [Random](Random) (and a few [Util](Util)) modules to a new directory and repository, I will hopefully be able to put that directory in the path, but maybe not.

I am quite unsure of myself when it comes to more formal writing in Perl, so I may have lots and lots of questions.
