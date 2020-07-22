package Random::Thing;
use v5.10.0;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);

use Lingua::EN::Inflect qw(PL_N);

use Fancy::Rand qw(fancy_rand);
use Random::RPG::MagicItem qw(random_magic_items);
use Random::RPG::Monster   qw(random_monster);
use Random::RPG::Weapon    qw(random_weapons);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_things random_animals random_armor random_musical_instruments random_plants random_utensils
                    random_magic_items random_monster random_weapons);

my %things = (
  'animals'             => [qw(animals amphibians arthropods birds fish mammals reptiles insects spiders)],
  'plants'              => [qw(plants ferns flowers mosses trees weeds)],
  'armor'               => [qw(armor helmets shields)],
  'musical instruments' => ['musical instruments', map("$_ instruments", qw(brass percussion string woodwind))],
  'utensils'            => ['utensils', map("$_ utensils", qw(cooking eating writing))],
  'magic items'         => ['magical '.random_magic_items('all', ['items'])],
  'monsters'            => ['monsters', PL_N(random_monster, 2)],
  'weapons'             => [random_weapons('all', ['weapons'])],
  'other'               => ['inanimate objects', 'religious symbols', qw(bedding boats books clothing dishes furniture jewelry rocks rugs tools wagons)],
);

sub random_things {
  my ($user_thing, $user_additions) = @_;
  my $thing = fancy_rand(\%things, $user_thing, { caller => 'random_thing', additions => $user_additions ? $user_additions : undef });
  return $thing;
}

sub random_animals             { my $user_addition = shift; random_things('animals' , $user_addition) }
sub random_armor               { my $user_addition = shift; random_things('armor'   , $user_addition) }
sub random_plants              { my $user_addition = shift; random_things('plants'  , $user_addition) }
sub random_utensils            { my $user_addition = shift; random_things('utensils', $user_addition) }
sub random_musical_instruments { my $user_addition = shift; random_things('musical instruments', $user_addition) }

=pod

=encoding utf8

=head1 NAME

B<Random::Thing> selects random things.

=head1 VERSION

This document describes Random::Thing version 1.000.

=head1 SYNOPSIS

  use Random::Thing;

  my $things              = random_things;

  my $animals             = random_things('animals');
  # or
  my $animals             = random_animals;
    # selects from animals, amphibians, arthropods, birds, fish, mammals, reptiles,
    # insects, and spiders

  my $armor               = random_things('armor');
  # or
  my $armor               = random_armor;
    # selects from armor, helmets, and shields

  my $magic_items         = random_things('magic items');
  # or
  my $magic_items         = random_magic_items;
    # see Random::RPG::Magic_item for details

  my $monsters            = random_things('monsters');
  # or
  my $monsters            = PL_N(random_monster, 2);
    # see Random::RPG::Monster for details

  my $musical_instruments = random_things('musical instruments');
  # or
  my $musical_instruments = random_musical_instruments;
    # selects from musical instruments, brass instruments, percussion instruments,
    # string instruments, and woodwind instruments

  my $plants              = random_things('plants');
  # or
  my $plants              = random_plants;
    # selects from plants, ferns, flowers, mosses, trees, and weeds

  my $utensils            = random_things('utensils');
  # or
  my $utensils            = random_utensils;
    # selects from utensils, cooking utensils, eating utensils, and writing utensils

  my $weapons             = random_things('weapons');
  # or
  my $weapons             = random_weapons;
    # see Random::RPG::Weapons for details

  my $other_things        = random_things('other');
    # selects from bedding, boats, books, clothing, dishes, furniture, inanimate objects,
    # jewelry, religious symbols, rocks, rugs, tools, and wagons

  print random_thing('help'); # get random_thing options

=head1 DESCRIPTION

Random::Thing selects random animals, plants, armor, musicial intruments, utensils, magic items, monsters, weapons, and a general other category.

=head1 DEPENDENCIES

Random::Thing depends on L<Fancy::Rand>, I<Random::RPG::MagicItem>, I<Random::RPG::Monster>, L<Random::RPG::Weapon>, and L<Exporter>.

=head1 SEE ALSO

L<Random::Misc>

=head1 AUTHOR

Lady Aleena

=cut

1;