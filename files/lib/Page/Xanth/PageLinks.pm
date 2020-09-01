package Page::Xanth::PageLinks;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Lingua::EN::Inflexion qw(noun);

use Page::Data qw(make_hash);
use Page::HTML qw(anchor);
use Page::Xanth::Util qw(get_article);
use Fancy::Join::Defined     qw(join_defined);
use Fancy::Join::Grammatical qw(grammatical_join);
use Util::Convert qw(textify idify searchify);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(character_link group_character_link locations_page_link species_page_link timeline_link);

# Begin creating links for characters

my $see_char = make_hash( 'file' => ['Fandom/Xanth', 'see_character.txt'] );

sub character_link {
  my ($in, $alt) = @_;
  my $num_text;
  if ($in =~ /^\d/) {
    my ($num, $new_text) = split(/ /, $in, 2);
    $num_text = noun($num)->cardinal." $new_text";
  }
  my $text   = $alt ? textify($alt) : textify($in);
  my $search = $see_char->{$in} ? searchify($see_char->{$in}) : searchify($in);
  my $link   = $in =~ /^[A-Z]/  ? anchor($text, { href => "Characters.pl?character=$search" }) :
               $in =~ /^\d/     ? $num_text : noun($text)->indefinite;
  return $link;
}

sub group_character_link {
  my $in = shift;
#  my @characters = split(/; /, $in);
  my $out = grammatical_join('and', map { character_link($_) } @$in);
  return $out;
}

# End creating links for characters
# Begin getting link to index Locations

sub locations_page_link {
  my ($main, $section) = @_;

  my $location = $section ? $section : $main;
  my $text     = textify(join(', ', reverse split(/, /,$location)));
  my $id       = $location =~ /^Xanth Reality/ ? idify("Xanth reality") : idify($location);
  my $link     = anchor($text, { href => "index.pl?page=Locations#$id"});
  my $article  = $main ne 'Mundania' ? get_article($location) : undef;
  my $out      = join_defined(' ', ($article, $link));

  return $out;
}

# End getting link to index Locations
# Begin getting link to index Species

sub species_page_link {
  my $species = shift;

  my $text = textify($species);
  my $id   = idify($species);
  my $link = anchor($text, { href => "index.pl?page=Species#$id"});

  return $link;
}

# End getting link to index Species
# Being getting link to index Timeline

sub timeline_link {
  my $in = shift;
     $in =~ s/\.\d+//;
  my $id = idify($in);
  my $link = defined($in) ? anchor($in, { href => "index.pl?page=Timeline#$id" }) : undef;
  return $link;
}

# End getting link to index Timeline

# Version 1.0
# Depends on Page::Data, Page::HTML, Page::Xanth::Util, Fancy::Join::Defined, Fancy::Join::Grammatical, Util::Convert, Lingua::EN::Inflect, and Exporter.
# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;