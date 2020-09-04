package Page::Story::Magic::Xanth;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Page::Data qw(make_hash);
use Page::File qw(file_directory);
use Page::Convert qw(textify idify searchify);
use Page::Story::Magic::FamilyTree qw(family_tree_magic);
use Page::Xanth::Novel qw(novel_link);
use Page::Xanth::PageLinks qw(character_link timeline_link);
use Fancy::Open    qw(fancy_open);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(Xanth_magic);

sub Xanth_magic {
  my ($type, $opt) = @_;

  my $trees_dir = '../../files/images/Fandom/Fictional_family_trees/Xanth';
  my $magic = family_tree_magic($trees_dir, $opt);

  my $X_dir = file_directory('Fandom/Xanth');

  my @book_list  = fancy_open("$X_dir/books.txt");
  for my $book (@book_list) {
    my $search = searchify($book);
    if ($type eq 'page') {
      $magic->{$book} = qq(A<I<$book>|href="Characters.pl?novel=$search">);
    }
    elsif ($type eq 'character') {
      $magic->{$book} = novel_link($book);
    }
  }

  my $headings   = [qw(Name species origin location gender talent description book chapter)];
  my $characters = make_hash('file' => "$X_dir/characters.txt", 'headings' => $headings);
  my $see_char   = make_hash('file' => "$X_dir/see_character.txt");
  for my $key ( keys %$characters ) {
    my $name   = textify($key);
    if ($type eq 'page') {
      my $search = $see_char->{$key} ? searchify($see_char->{$key}) : searchify($key);
      $magic->{$key}      = qq(A<$name|href="Characters.pl?character=$search">);
      $magic->{"$key\'s"} = qq(A<$name\'s|href="Characters.pl?character=$search">);
    }
    elsif ($type eq 'character') {
      $magic->{$key}      = character_link($key);
      $magic->{"$key\'s"} = character_link($name, "$name\'s");
    }
  }

  for my $num (0..1200) {
    my $id = idify($num);

    if ($type eq 'page') {
      $magic->{$num}     = qq(A<$num|href="?page=Timeline#$id">);
      $magic->{"id$num"} = qq(SPAN<$num|id="$id">);
    }
    elsif ($type eq 'character') {
      $magic->{$num}     = timeline_link($num);
    }
  }

  return $magic;
}

# Version 1.0
# Depends on Page::Convert, Page::Data, Page::File, Page::Xanth::Novel, Page::Xanth::PageLinks, Page::Xanth::Util, Fancy::Open, and Exporter
# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;