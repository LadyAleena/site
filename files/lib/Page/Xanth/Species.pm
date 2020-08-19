package Page::Xanth::Species;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Lingua::EN::Inflect qw(A);

use Page::Data     qw(data_file);
use Page::Xanth::Util qw(gendering);
use Fancy::Open    qw(fancy_open);
use Fancy::Join    qw(join_defined);
use HTML::Elements qw(anchor);
use Util::Convert  qw(textify idify searchify);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(species_link get_species);

my @gendered_species_list = fancy_open(data_file('Fandom/Xanth', 'gendered_species.txt'));;
my $gendered_species = join('|', @gendered_species_list);

sub species_link {
  my ($in, $alt) = @_;
  my $text   = $alt ? textify($alt) : textify($in);
  my $search = searchify($in);
  my $link   = anchor($text, { href => "Characters.pl?species=$search" });
  return $link;
}

sub get_merfolk {
  my ($in, $gender) = @_;
  my $text;
  if ($gender eq 'female') {
    my ($merspecies, $mertype) = split(/, /, $in);
    if ($mertype eq 'fresh') {
      $text = 'mermaid';
    }
    elsif ($mertype eq 'salt') {
      $text = 'merwoman';
    }
  }
  else {
    $text = 'merman';
  }
  return $text;
}

sub get_gendered_species {
  my ($species, $gendering) = @_;

  my $gender_text = $gendering->{text};
  my $gender_noun = $gendering->{noun};

  my $text = undef;
  if ($gender_text) {
    if ( $species eq 'human' ) {
      $text = $gender_noun;
    }
    elsif ( $species eq 'elf' ) {
      $text = "elven $gender_noun";
    }
    elsif ( $species =~ /(night|day) horse/ ) {
      my $alt_text = $species;
         $alt_text =~ s/(night|day) horse/$1/;
      $text = "$alt_text $gender_noun";
    }
    elsif ( $species =~ /curse fiend|goblin|horse|centaur|hippo|pooka|icorn/ ) {
      $text = "$species $gender_noun";
    }
    elsif ( $species =~ /merfolk/ ) {
      $text = get_merfolk($species, $gender_text);
    }
    elsif ( $species eq 'brassy' ) {
      $text = $gender_text eq 'female' ? 'brassie'  : $species;
    }
    elsif ( $species =~ /demon/ ) {
      # There are demons, dwarf demons, and major demons.
      (my $female = $species) =~ s/demon/demoness/;
      $text = $gender_text eq 'female' ? $female : $species;
    }
    elsif ( $species eq 'god' ) {
      $text = $gender_text eq 'female' ? 'goddess'  : $species;
    }
    elsif ( $species =~ /$gendered_species|tree|ghost|zombie/ ||
            $species =~ /harpy|nymph/ && $gender_text eq 'female' ||
            $species =~ /faun/ && $gender_text eq 'male' ) {
      $text = $species;
    }
    else {
      $text = join_defined(' ', ($gender_text, $species));
    }
  }

  return $text;
}

sub get_species {
  my ($in_species, $gender) = @_;
  my $species_text;
  for ( my $species_no = 0; $species_no < @$in_species; $species_no++ ) {
    my $curr_species = $in_species->[$species_no];
    my $prev_species = $species_no - 1 >= 0 ? $in_species->[$species_no - 1] : undef;
    my $link_species = $curr_species =~ /merfolk/ ? 'merfolk' : $curr_species;

    my $gendering = gendering($gender, $curr_species);
    my $gendered_text = get_gendered_species($curr_species, $gendering);

    my $base_text = $gendered_text ? A($gendered_text) : A($curr_species);
    my ($article, $alt_text) = split(/ /, $base_text, 2);
    my $link = species_link($link_species, $alt_text);

    if ($prev_species) {
      $species_text .= " who became $article $link";
    }
    else {
      $species_text .= "$article $link";
    }
  }
  return $species_text;
}

=pod

=encoding utf8

=head1 VERSION

This document describes Page::Xanth::Species version 1.0.

=head1 DEPENDENCIES

Page::Xanth::Species depends on L<Fancy::Open>, L<Fancy::Join>, HTML::Elements, Util::Convet, Util::Data, Page::Xanth::Util, L<Lingua::EN::Inflect>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;