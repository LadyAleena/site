package Page::Story::Magic::MagicItem;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use Lingua::EN::Inflect qw(NO);

use Page::File qw(file_directory file_list);
use Page::HTML qw(list anchor);
use Util::Convert qw(searchify);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(magic_item_magic);

sub magic_item_magic {
  my $magic;

  for my $count (0..9) {
    my $charges = ucfirst NO('charge', $count, { words_below => 101 });
    $magic->{$charges} = qq(STRONG<$charges:>);
  }

  $magic->{'XP'} = 'ABBR<XP|title="experience point value">';
  $magic->{'GP'} = 'ABBR<GP|title="gold piece value">';
  $magic->{'MR'} = 'ABBR<MR|title="magic resistance">';

  $magic->{'magic items of the specialist'} = 'A<magic items of the specialist|href="?select=magic+items+of+the+specialist">';

  $magic->{'spellbooks'} = sub {
    my $spellbook_dir  = file_directory('Role_playing/Player_characters/Spellbooks');
    my @spellbook_list = file_list($spellbook_dir, { 'sort' => 'name', 'text' => 1 });
    my @spellbooks;
    for my $spellbook (@spellbook_list) {
      my $search = searchify($spellbook);
      push @spellbooks, anchor($spellbook, { href => qq(../Player_characters/Spellbooks.pl?spellbook=$search) });
    }
    list(4, 'u', \@spellbooks, { 'class' => 'three' })
  };

  return $magic;
}

# Version 1.0
# Depends on Page::File, Page::HTML, Util::Convert, Lingua::EN::Inflect, and Exporter
# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;