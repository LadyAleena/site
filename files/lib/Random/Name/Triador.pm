package Random::Name::Triador;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);

use Random::Name::Pattern qw(random_name);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(Yrethi_place_name Zilarban_place_name additions);

my %addition;
$addition{'Vecile'}{'grand duchy'} = 'Vi';
$addition{'Vecile'}{'duchy'}       = 'Xi';
$addition{'Vecile'}{'county'}      = 'Li';
$addition{'Vecile'}{'barony'}      = 'Ci';
$addition{'Vecile'}{'town'}        = 'Mi';
$addition{'Vecile'}{'village'}     = 'Di';

for ('Telanna','Abru') {
  $addition{$_}{'grand duchy'} = 'dil';
  $addition{$_}{'duchy'}       = 'sar';
  $addition{$_}{'county'}      = 'til';
  $addition{$_}{'barony'}      = 'car';
  $addition{$_}{'town'}        = '';
  $addition{$_}{'village'}     = '';
}

$addition{'Teglan'}{'grand duchy'} = 'trun';
$addition{'Teglan'}{'duchy'}       = 'nar';
$addition{'Teglan'}{'county'}      = 'bur';
$addition{'Teglan'}{'barony'}      = 'lan';
$addition{'Teglan'}{'town'}        = '';
$addition{'Teglan'}{'village'}     = '';

$addition{'Krigt'}{'grand duchy'} = 'lain';
$addition{'Krigt'}{'duchy'}       = 'dal';
$addition{'Krigt'}{'county'}      = 'hik';
$addition{'Krigt'}{'barony'}      = 'lode';
$addition{'Krigt'}{'town'}        = '';
$addition{'Krigt'}{'village'}     = '';

$addition{'Alveigtrudil'}{'grand duchy'} = 'trudil'; # This shouldn't be used, Alveigtrudil is the grand duchy.
$addition{'Alveigtrudil'}{'duchy'}       = 'nasar';
$addition{'Alveigtrudil'}{'county'}      = 'butil';
$addition{'Alveigtrudil'}{'barony'}      = 'lacar';
$addition{'Alveigtrudil'}{'town'}        = '';
$addition{'Alveigtrudil'}{'village'}     = '';

sub additions {
  my ($bare_name,$location,$place) = @_;

  my $name;
  $name = $addition{'Vecile'}{$place}.' '.$bare_name.$addition{'Telanna'}{$place} if $location eq 'Vi Gwenalladil';
  $name = $bare_name.$addition{$location}{$place} if $location =~ /(?:Telanna|Abru|Teglan|Krigt|Alveigtrudil)/;
  $name = $addition{$location}{$place}.' '.$bare_name if $location eq 'Vecile';

  return $name;
}

sub Yrethi_place_name {
  my $syllables = shift;

  my $first_syllable = random_name('^Lv');

  my @syllable_parts = ($first_syllable);
  my $end = $syllables - 1;
  for (1..$end) {
    my $part = random_name('cv');
       $part =~ s/c/k/g;
       $part =~ s/f/v/g;
       $part =~ s/g/j/g;
       $part =~ s/(q)/$1u/gi;
    push @syllable_parts, $part if ($part ne lc $syllable_parts[-1]);
  }

  my $name = join('',@syllable_parts);

  if ($name =~ /quu/i) {
    my @quu_vowels = qw(a e i o);
    my $new_vowel = $quu_vowels[rand @quu_vowels];
    $name =~ s/(q|Q)uu/$1u$new_vowel/;
  }

     $name =~ s/^Aa/Aya/;
     $name =~ s/^Ee/Eye/;
     $name =~ s/^Ii/Iy/;
     $name =~ s/^Oo/Owo/;
     $name =~ s/^Uu/Ew/;


  if ($name =~ /e$/) {
    my @new_vowels;
    for (qw(a i o u y)) {
      push @new_vowels, $_ if $name !~ /$_/;
    }
    $name .= $new_vowels[rand @new_vowels];
  }

  return $name;
}

sub Zilarban_place_name {
  my $syllables = roll('1d2') + 1;
  my @syllable_parts;
  push @syllable_parts, random_name('^c');

  my @choices = qw(c ch k l s sh ss th v x z zz);
  for my $iter (1..$syllables) {
    my $consonent = $choices[rand @choices];
    my $syllable = random_name('v').$consonent;
    push @syllable_parts, $syllable;
  }

  my $name = join('',@syllable_parts);
  return $name;
}

=pod

=encoding utf8

=head1 Random::Name::Triador

B<Random::Name::Triador> is a name generator for the world of Triador that I am slowly building.

=head2 Version

This document describes Random::Name::Triador version 1.000.

=head2 Synopsis

  use Random::Name::Triador qw(Yrethi_place_name Zilarban_place_name additions);

=head2 Dependencies

Random::Name::Triador depends on <Random::Name::Pattern>, L<Games::Dice>, and L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;