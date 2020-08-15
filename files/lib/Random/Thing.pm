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

B<Random::Thing> returns random things.

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

  my $armor              = random_thing('armor');
  # or
  my $armor              = random_armor;

  my $clothing           = random_thing('clothing');
  # or
  my $clothing           = random_clothing;

  my $musical_instrument = random_thing('musical instruments');
  # or
  my $musical_instrument = random_musical_instrument;

  my $plant              = random_thing('plants');
  # or
  my $plant              = random_plant;

  my $utensil            = random_thing('utensils');
  # or
  my $utensil            = random_utensil;

  my $other_thing        = random_thing('other');

  print random_thing('help'); # get random_thing options

=head1 DESCRIPTION

Random::Thing returns a random animal, plant, armor, clothing, musicial intrument, utensil, or a general other category. All of the functions must be imported into your script.

=head2 random_thing

  random_thing();

=head3 Options

=head4 nothing, all, or undef

  random_thing();
  random_thing('all');
  random_thing(undef);

=head4 animals

  random_thing('animals');

The C<animals> option returns animal, amphibian, arthropod, bird, fish, mammal, reptile, insect, or spider.

=head4 armor

  random_thing('armor');

The C<armor> option returns armor, helmet, or shield.

=head4 clothing

  random_thing('clothing');

The C<clothing> option returns clothing, cape, coat, dress, jacket, pants, robe, shirt, shorts, skirt, sock, sweater, or vest.

=head4 musical instruments

  random_thing('musical instruments');

The C<muscial instruments> option returns musical instrument, brass instrument, percussion instrument, string instrument, or woodwind instrument.

=head4 plants

  random_thing('plants');

The C<plants> option returns plant, fern, flower, moss, tree, or weed.

=head4 utensils

  random_thing('utensils');

The C<utensils> option returns utensil, cooking utensil, eating utensil, or writing utensil.

=head4 other

  random_thing('other');

The C<other> option returns bedding, boat, book, clothing, dish, furniture, inanimate object, jewelry, religious symbol, rock, rug, tool, or wagon.

=head4 by keys

  random_thing('by keys');

The C<by keys> option will select a random key listed above.

=head4 keys

  random_thing('keys');

The C<keys> option will list all of the available keys in an array reference.

=head4 data

  random_thing('data');

The C<data> option will return the data used in a hash reference.

=head4 help or options

  random_thing('help');
  random_thing('options');

The C<help> or C<options> options will return a list of all of your options.

=head3 Adding items to a list

  my @additions = ('thing 1', 'thing 2');
  random_thing('<your option>', \@additions);

You can add items to the list by adding an array reference with the additional items as the second parameter.

=head2 Other functions

The following functions are shortcuts to the some of the options above. You can add items to the list by adding an array reference with the additional items as the first parameter in the following functions. If you want to add additional animals in C<random_animal>, you would do the following:

  my @animal_additions = ('lion', 'tiger', 'bear'); # Oh my!
  random_animal(\@animal_additions);

=head3 random_animal

 random_animal();

C<random_animal> is the same using L</animals> in C<random_thing>.

=head3 random_armor

 random_armor();

C<random_armor> is the same using L</armor> in C<random_thing>.

=head3 random_clothing

 random_clothing();

C<random_clothing> is the same using L</clothing> in C<random_thing>.

=head3 random_musical_instrument

 random_musical_instrument();

C<random_musical_instrument> is the same using L</musical instruments> in C<random_thing>.

=head3 random_plant

 random_plant();

C<random_plant> is the same using L</plants> in C<random_thing>.

=head3 random_utensil

 random_utensil();

C<random_utensil> is the same using L</utensils> in C<random_thing>.

=head1 DEPENDENCIES

Random::Thing depends on L<Fancy::Rand> and L<Exporter>.

=head1 SEE ALSO

L<Random::Misc>

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;