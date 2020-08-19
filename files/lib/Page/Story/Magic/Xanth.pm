package Page::Story::Magic::Xanth;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Page::Data qw(make_hash);
use Page::Line qw(line);
use Page::List::File qw(file_directory file_list);
use Page::List::File qw(file_directory);
use Page::Xanth::Novel     qw(novel_link);
use Page::Xanth::PageLinks qw(character_link timeline_link);
use Fancy::Open    qw(fancy_open);
use HTML::Elements qw(figure object anchor);
use Util::Convert  qw(textify idify searchify);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(Xanth_magic);

sub Xanth_magic {
  my $type = shift;

  my $magic;

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
      $magic->{$num}     = qq(A<$num|href="?select=Timeline#$id">);
      $magic->{"id$num"} = qq(SPAN<$num|id="$id">);
    }
    elsif ($type eq 'character') {
      $magic->{$num}     = timeline_link($num);
    }
  }

  my $trees_dir = '../../files/images/Fandom/Fictional_family_trees/Xanth';
  my @trees_list = file_list($trees_dir);
  for my $tree (@trees_list) {
    my $link = "$trees_dir/$tree";
    my $class = 'svg_group';
    if ( $tree !~ /(?:Kings|Adora|Gorbage|Incarnations|key)/ ) {
      $class .= ' right';
    }

    $magic->{textify($tree)} = sub {
      figure(6, sub {
        line(7, anchor( '', { 'href' => $link, 'target' => 'new' }));
        line(7, object( '', { 'data' => $link, 'type' => 'image/svg+xml'})); # object used instead of img, b/c img won't render svg properly
      }, { 'class' => $class });
    };
  }

  return $magic;
}

=pod

=encoding utf8

=head1 VERSION

This document describes Page::Xanth::LineMagic version 1.0.

=head1 DEPENDENCIES

Page::Xanth::LineMagic depends on L<Fancy::Open>, Page::List::File, Util::Convert, Util::Data, Page::Xanth::Util, Page::Xanth::Novel, Page::Xanth::PageLinks, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;