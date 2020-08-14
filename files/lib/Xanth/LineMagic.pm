package Xanth::LineMagic;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Open   qw(fancy_open);
use Util::Convert qw(textify idify searchify);
use Util::Data    qw(data_file make_hash);

use Xanth::Novel     qw(novel_link);
use Xanth::PageLinks qw(character_link timeline_link);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(Xanth_line_magic);

my $headings = [qw(Name species origin location gender talent description book chapter)];
my $characters = make_hash(
  'file' => ['Fandom/Xanth','characters.txt'],
  'headings' => $headings,
);

my $see_char = make_hash(
  'file' => ['Fandom/Xanth', 'see_character.txt'],
);

my @book_list = fancy_open(data_file('Fandom/Xanth', 'books.txt'));

sub Xanth_line_magic {
  my $type = shift;

  my $Xanth_line_magic;

  for my $book (@book_list) {
    my $search = searchify($book);
    if ($type eq 'page') {
      $Xanth_line_magic->{$book} = qq(A<I<$book>|href="Characters.pl?novel=$search">);
    }
    elsif ($type eq 'character') {
      $Xanth_line_magic->{$book} = novel_link($book);
    }
  }

  for my $key ( keys %$characters ) {
    my $name   = textify($key);
    if ($type eq 'page') {
      my $search = $see_char->{$key} ? searchify($see_char->{$key}) : searchify($key);
      $Xanth_line_magic->{$key}      = qq(A<$name|href="Characters.pl?character=$search">);
      $Xanth_line_magic->{"$key\'s"} = qq(A<$name\'s|href="Characters.pl?character=$search">);
    }
    elsif ($type eq 'character') {
      $Xanth_line_magic->{$key}      = character_link($key);
      $Xanth_line_magic->{"$key\'s"} = character_link($name, "$name\'s");
    }
  }

  for my $num (0..1200) {
    my $id = idify($num);

    if ($type eq 'page') {
      $Xanth_line_magic->{$num}     = qq(A<$num|href="?select=Timeline#$id">);
      $Xanth_line_magic->{"id$num"} = qq(SPAN<$num|id="$id">);
    }
    elsif ($type eq 'character') {
      $Xanth_line_magic->{$num}     = timeline_link($num);
    }
  }

  return $Xanth_line_magic;

}

=pod

=encoding utf8

=head1 VERSION

This document describes Xanth::LineMagic version 1.0.

=head1 DEPENDENCIES

Xanth::LineMagic depends on L<Fancy::Open>, Util::Convert, Util::Data, Xanth::Util, Xanth::Novel, Xanth::PageLinks, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;