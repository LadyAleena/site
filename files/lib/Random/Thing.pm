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

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
