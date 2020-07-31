package Random::Thing;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(
  random_thing
  random_animal
  random_armor
  random_clothing
  random_musical_instrument
  random_plant
  random_utensil
);

my %things = (
  'animals'             => [qw(animal amphibian arthropod bird fish mammal reptile insect spider)],
  'plants'              => [qw(plant fern flower moss tree weed)],
  'armor'               => [qw(armor helmet shield)],
  'clothing'            => [qw(clothing shirt sweater vest jacket coat pants skirt dress shorts sock cape robe)],
  'musical instruments' => ['musical instrument', map("$_ instrument", qw(brass percussion string woodwind))],
  'utensils'            => ['utensil', map("$_ utensil", qw(cooking eating writing))],
  'other'               => ['inanimate object', 'religious symbol', qw(bedding boat book dish furniture jewelry rock rug tool wagon)],
);

sub random_thing {
  my ($user_thing, $user_additions) = @_;
  my $thing = fancy_rand(\%things, $user_thing, { caller => 'random_thing', additions => $user_additions ? $user_additions : undef });
  return $thing;
}

sub random_animal             { my $user_addition = shift; random_thing('animals' , $user_addition) }
sub random_armor              { my $user_addition = shift; random_thing('armor'   , $user_addition) }
sub random_clothing           { my $user_addition = shift; random_thing('clothing', $user_addition) }
sub random_plant              { my $user_addition = shift; random_thing('plants'  , $user_addition) }
sub random_utensil            { my $user_addition = shift; random_thing('utensils', $user_addition) }
sub random_musical_instrument { my $user_addition = shift; random_thing('musical instruments', $user_addition) }

=pod

=encoding utf8

=head1 NAME

B<Random::Thing> selects random things.

=head1 VERSION

This document describes Random::Thing version 1.000.

=head1 SYNOPSIS

  use Random::Thing qw(
    random_thing
    random_animal
    random_armor
    random_musical_instrument
    random_plant
    random_utensil
  );

  my $thing              = random_thing;

  my $animal             = random_thing('animals');
  # or
  my $animal             = random_animal;
    # selects from animal, amphibian, arthropod, bird, fish, mammal, reptile,
    # insect, and spider

  my $armor               = random_thing('armor');
  # or
  my $armor               = random_armor;
    # selects from armor, helmet, and shield

  my $cloting             = random_thing('cloting');
  # or
  my $cloting             = random_cloting;
    # selects from clothing, shirt, sweater, vest, jacket, coat, pants, skirt,
    # dress, shorts, sock, cape, and robe

  my $musical_instrument = random_thing('musical instruments');
  # or
  my $musical_instrument = random_musical_instrument;
    # selects from musical instrument, brass instrument, percussion instrument,
    # string instrument, and woodwind instrument

  my $plant              = random_thing('plants');
  # or
  my $plant              = random_plant;
    # selects from plant, fern, flower, moss, tree, and weed

  my $utensil            = random_thing('utensils');
  # or
  my $utensil            = random_utensil;
    # selects from utensil, cooking utensil, eating utensil, and writing utensil

  my $other_thing        = random_thing('other');
    # selects from bedding, boat, book, clothing, dish, furniture, inanimate object,
    # jewelry, religious symbol, rock, rug, tool, and wagon

  print random_thing('help'); # get random_thing options

=head1 DESCRIPTION

Random::Thing selects random animals, plants, armor, clothing, musicial intruments, utensils, and a general other category.

=head1 DEPENDENCIES

Random::Thing depends on L<Fancy::Rand> and L<Exporter>.

=head1 SEE ALSO

L<Random::Misc>

=head1 AUTHOR

Lady Aleena

=cut

1;