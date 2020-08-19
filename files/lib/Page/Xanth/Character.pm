package Page::Xanth::Character;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Lingua::EN::Inflect qw(A NUMWORDS ORD);

use Page::Story    qw(convert_string);
use Page::Story::Magic::Xanth qw(Xanth_magic);
use Fancy::Join    qw(join_defined);
use Util::Convert  qw(textify idify searchify);
use Page::Xanth::Dates     qw(get_dates_family);
use Page::Xanth::Location  qw(get_locations);
use Page::Xanth::Novel     qw(char_intro_novel get_novels);
use Page::Xanth::PageLinks qw(character_link);
use Page::Xanth::Species   qw(get_species);
use Page::Xanth::Util      qw(get_article gendering);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(get_open get_character);

# Begin getting group character belongs to used in get_open

sub get_group {
  my $in = shift;
  my $text = "of ".get_article($in, { full => 1});
  return $text;
}

# End getting group character belongs to
# Begin getting link to character main entry used in get_open

sub get_see {
  my $in_char = shift;
  my $in_char_link = character_link($in_char);
  return "See $in_char_link for more.";
}

# End getting link to character main entry
# Start opening paragraph

sub get_open {
  my ($character, $opt) = @_;

  my $name  = $character->{Name};
  my $text  = textify($name);
  my @books = @{$character->{book}};
  my $link  = $character->{dates} || $character->{family} || $character->{other} || $character->{challenge} || @books > 1 ? character_link($name) : $text;

  my $species  = $character->{species};
  my $gender   = $character->{gender};
  my $location = $character->{places};
  my $intro    = $character->{intro};

  my $gendering  = gendering($gender, $species->[-1]);

  my $open_name  = $opt->{link} && $opt->{link} =~ /^[yt1]/ ? $link : $text;
  my $salutation = $character->{title} ? join(' ', ($character->{title}, $open_name)) : $open_name;
  my $address    = $character->{group} ? join(' ', ("<b>$salutation</b>", get_group($character->{group}))) : "<b>$salutation</b>";

  my $species_text  = get_species($species, $gender);
  my $location_text = get_locations($location);

  my $talent_text = $character->{talent} ? "$gendering->{possesive} talent is $character->{talent}." : undef;
  my $intro_text  = "$gendering->{pronoun} was ".char_intro_novel($intro->{book}, $intro->{type}, scalar(@books));
  my $see_text    = $character->{see} ? get_see($character->{see}) : undef;

  my $open_text   = "$address is $species_text from $location_text. ".join_defined(' ', map { ucfirst $_ if $_ } ($talent_text, $intro_text, $see_text));

  return $open_text;
}

# End opening paragraph
# Begin getting challenge

sub get_challenge {
  my $in = shift;
  my $num     = NUMWORDS(ORD($in->{number}));
  my $querant = character_link($in->{querant});
  my $text    = "was part of the $num challenge for $querant";
  return $text;
}

# End getting challenge
# Begin getting description paragraph

sub get_description {
  my ($character, $pronoun) = @_;

  my $name = $character->{Name};
  my $text = textify($name);
  my $line_magic = Xanth_magic('character');

  my $challenge_text = $character->{challenge} ? get_challenge($character->{challenge}) : undef;
  my $other_text     = $character->{other}     ? convert_string($character->{other}, $line_magic) : undef;

  my $description = undef;
  if ( $challenge_text || $other_text ) {
    if ( $challenge_text && $other_text ) {
      if ( $other_text =~ /^[a-z]/ ) {
        $description = "$text $challenge_text. ".ucfirst $pronoun." $other_text";
      }
      else {
        $description = "$text $challenge_text. $other_text";
      }
    }
    elsif ( $other_text ) {
      if ( $other_text =~ /^[a-z]/ ) {
        $description = "$text $other_text";
      }
      else {
        $description = "$other_text";
      }
    }
    elsif ( $challenge_text ) {
      $description = "$text $challenge_text.";
    }
  }

  return $description;
}

# End getting description paragraph
# Being putting the character together

sub get_character {
  my $character = shift;

  my $name      = $character->{Name};
  my $text      = textify($name);
  my $species   = $character->{species};
  my $gender    = $character->{gender};
  my $gendering = gendering($gender, $species->[-1]);
  my $pronoun   = $gendering->{pronoun};

  my @paragraphs;
  my $open_text    = get_open($character);
  push @paragraphs, [$open_text];
  my $dates_family = get_dates_family($character, $gendering);
  push @paragraphs, [$dates_family] if $dates_family;
  my $description  = get_description($character, $pronoun);
  push @paragraphs, [$description, { separator => '::' }] if $description;
  if ( scalar @{$character->{book}} > 1 ) {
    my $novel_text = get_novels($character->{book});
    push @paragraphs, [$novel_text];
    push @paragraphs, ["A <b><i>Bold Title</i></b> means $pronoun was a major character. A <small><i>Small Title</i></small> means $pronoun was only mentioned.", { class => 'noprint', style => 'font-size: smaller;' }];
  }

  return \@paragraphs;
}

# End putting the character together

=pod

=encoding utf8

=head1 VERSION

This document describes Page::Xanth::Character version 1.0.

=head1 DEPENDENCIES

Page::Xanth::Character depends on L<Fancy::Join>, Page::Story, Util::Convert, Page::Xanth::Dates, Page::Xanth::LineMagic, Page::Xanth::Location, Page::Xanth::Novel, Page::Xanth::Species, Page::Xanth::Util, L<Lingua::EN::Inflect>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;