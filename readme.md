# Lady_Aleena

*The files behind [my website](http://fantasy.xecu.net).*

## page-scripts

[Collections](Collections): My collections of books, music, movies, and more.

[Fandom](Fandom): Pages about things I am a fan of such as crossovers, fictional family trees, Xanth, and more.

[Miscellany](Miscellany): My random thoughts and other stuff.

[Movies](Movies): Lists of movies by series and genre along with some opinions.

[Role_playing](Role_playing): Role playing information I made up or collated over the years. It is all based on AD&D 2nd Ed.

[Writing](Writing): Stories and poems I have written. Please don't take any of them and claim they are yours. I am trusting you.

[admin](admin): Scripts I wrote to display various bits of data that I wanted a better visualization for that can not be achieved on the command line.

### Code

The code in most of the index.pl page-scripts in the above directories looks like the following (without the comments after line 3):

```perl
#!/usr/bin/perl
# This is the index for <directory>.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);

# path to lib
use lib '../files/lib';
use Page::Base qw(page);
use Page::File qw(file_directory file_list print_file_menu);
use Page::Story qw(story);

my $cgi       = CGI::Simple->new;
my $page      = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir = file_directory('Writing', 'text');
my @pages     = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article', 'text' => 1 });
my $heading   = q(Some heading for when there is no "page");
my $page_file = "$pages_dir/index.txt";
if ( $page && grep { $_ eq $page } @pages ) {
# There are times when the headings of various pages might not follow this format.
# Tenaries are used in those where the $heading is diffent.
  $heading    = $page;
  $page_file  = "$pages_dir/$page.txt";
  $page_file  =~ s/ /_/g;
}
open(my $page_fh, '<', $page_file) || die "Can't open $page_file. $!";

my $magic;
$magic->{'pages'} = sub { print_file_menu('page', \@pages, $page, 2) };

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story($page_fh, { 'doc magic' => $magic, 'line magic' => $magic });
  }
);

```

Some of the index scripts use various [magic modules](files/lib/Page/Story/Magic) to include more data into their stories.

These the index.pl page-scripts do not follow the above format:

- [Movies/index.pl](Movies/index.pl)
- [Role_playing/Monsters/index.pl](Role_playing/Monsters/index.pl)
- [Role_playing/Player_characters/index.pl](Role_playing/Player_characters/index.pl)

Also, these scripts that are not indexes do not follow the above format either.

- [Fandom/Crossovers/timeline.pl](Fandom/Crossovers/timeline.pl) - this may eventually become magic.
- [Fandom/Xanth/Character.pl](Fandom/Xanth/Character.pl)
- [Role_playing/Magic_items/spell_scrolls.pl](Role_playing/Magic_items/spell_scrolls.pl) - this may eventually become magic.
- [Role_playing/Miscellany/Character_mutations_generator.pl](Role_playing/Miscellany/Character_mutations_generator.pl)
- [Role_playing/Miscellany/Word_finds.pl](Role_playing/Miscellany/Word_finds.pl)
- [Role_playing/Player_characters/Spellbooks.pl](Role_playing/Player_characters/Spellbooks.pl)
- [Role_playing/Reference_tables/Proficiencies.pl](Role_playing/Reference_tables/Proficiencies.pl)
- [Role_playing/Reference_tables/Weapons.pl](Role_playing/Reference_tables/Weapons.pl)

And everything in [admin](admin).

## [files](files)

These are the files used to create pages on my site.

[css](files/css): All of the style sheets used on my site.

[data](files/data): All of the tabular or list data that is used in my modules and sent to my scripts.

[images](files/images): All of the images that are used on my site. The SVG files for [crossovers](files/images/Fandom/Crossovers) and [fictional family trees](files/images/Fandom/Fictional_family_trees) have external style sheets, so they will not render properly on GitHub or a Google search.

[lib](files/lib): The modules I have written for my site and for fun. I am considering moving those that are not used for my site to another repository. Please see the [readme](files/lib/readme.md) for more information on the modules.

[text](files/text): All of the text that is used on my site to generate pages. These files are written in my [custom markup](files/lib/Page/Story.pod).
