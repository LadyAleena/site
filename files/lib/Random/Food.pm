package Random::Food;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);
use Fancy::Map qw(fancy_map);
use Fancy::Open qw(fancy_open);
use Util::Data qw(file_directory);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_food random_drink);

my $directory = file_directory('Random/Food', 'data');
my @Klondike_flavors = fancy_open("$directory/Klondike_flavors.txt", { 'after' => " Klondike bar" });
my @Kool_Aid_flavors = fancy_open("$directory/Kool-Aid_flavors.txt", { 'after' => " Kool-Aid" });
my @MandMs_flavors   = fancy_open("$directory/MandMs_flavors.txt",   { 'after' => " M&M" });

my %foods = (
  'fruits' => [qw(apple apricot banana blueberry cherry cranberry grape grapefruit lemon lime orange peach pear plum raspberry strawberry tomato)],
  'tubers' => ['potato','sweet potato','yam'],
  'meats'  => [qw(beef lamb chicken pork turkey fish)],
  'junk foods'   => [ map( "$_ chips", qw(corn potato) ), 'pretzels', 'crackers'],
  'Lucky Charms' => [ fancy_map({ 'after'=> 'lucky charm' }, [
    'heart','star','horseshoe','green clover','blue moon','hourglass','rainbow','red balloon',
    map( "swirled $_ moon", qw(pink orange yellow green blue purple) ),
    map( "$_->[0] hat with a $_->[1] clover", (['green', 'dark green'], ['blue', 'pink'], ['purple', 'green'], ['dark green', 'orange'], ['yellow', 'blue'], ['orange', 'green']) ),
    map( "$_->[0] and $_->[1] swirled diamond", (['dark green', 'yellow'], ['purple', 'pink'], ['blue', 'green'], ['pink', 'white'], ['green', 'orange']) )
  ])],
  'Klondike bars' => [@Klondike_flavors],
  'M&Ms'          => [@MandMs_flavors],
);

my %drinks = (
  'beers'      => ['pale ale', map( "$_ beer", qw(stout mild wheat lager lambic) )],
  'hot drinks' => [qw(coffee tea cider)],
  'juices'     => ['lemonade', map("$_ juice", qw(apple grape orange cranberry grapefruit tomato))],
  'Kool-Aid'  => [@Kool_Aid_flavors],
);

sub random_food {
  my ($user_food, $user_additions) = @_;
  my $food = fancy_rand(\%foods, $user_food, { caller => 'random_food', additions => $user_additions ? $user_additions : undef });
  return $food;
}

sub random_drink {
  my ($user_drink, $user_additions) = @_;
  my $drink = fancy_rand(\%drinks, $user_drink, { caller => 'random_drink', additions => $user_additions ? $user_additions : undef });
  return $drink;
}

=pod

=encoding utf8

=head1 NAME

B<Random::Food> returns either a random food or drink.

=head1 VERSION

This document describes Random::Food version 1.000.

=head1 SYNOPSIS

  use Random::Food qw(random_food random_drink);

  my $food  = random_food('all');        # returns a food from any list
  my $fruit = random_food('fruits');     # returns a fruit
  my $tuber = random_food('tubers');     # returns a tuber
  my $meat  = random_food('meats');      # returns a meat
  my $junk  = random_food('junk foods'); # returns a junk food

  my $Lucky_Charm  = random_food('Lucky Charms');  # returns a magically delicious Lucky Charm
  my $Klondike_bar = random_food('Klondike bars'); # returns a Klondike bar flavor
  my $MandM        = random_food('M&Ms');          # returns an M&M flavor

  print random_food('help'); # get random_food options

  my $drink = random_drink('all');        # returns a drink from any list
  my $beer  = random_drink('beers');      # returns a beer or ale
  my $hot   = random_drink('hot drinks'); # returns a hot drink
  my $juice = random_drink('juices');     # returns a juice

  my $KoolAid = random_drink('Kool-Aid'); # returns a Kool-Aid flavor

  print random_drink('help'); # get random_drink options

=head1 DESCRIPTION

Random::Food returns either a random food with C<random_food> or drink with C<random_drink>.

=head2 Options

=head3 nothing, all, or undef

  random_food;
  random_food();
  random_food('all');
  random_food(undef);


  random_drink;
  random_drink();
  random_drink('all');
  random_drink(undef);

These options will return any value in any list related to the function. You can read the options below to see all of the potential values.

=head3 random_food options

=head4 fruits

  random_food('fruits');

The C<fruits> option returns apple, apricot, banana, blueberry, cherry, cranberry, grape, grapefruit, lemon, lime, orange, peach, pear, plum, raspberry, strawberry, or tomato.

=head4 tubers

  random_food('tubers');

The C<tubers> option returns potato, sweet potato, or yam.

=head4 meats

  random_food('meats');

The C<meats> option returns beef, lamb, chicken, pork, turkey, or fish.

=head4 junk foods

  random_food('junk foods');

The C<junk foods> option returns corn chips, potato chips, pretzels, or crackers.

=head4 Lucky Charms

  random_food('Lucky Charms');

The C<Lucky Charms> option returns one of the following: heart, star, horseshoe, green clover, blue moon, hourglass, rainbow, red balloon, one of the swirled moons, one of the hats with clovers, or one of the swirled diamonds. For the complete list of Lucky Charms, you can do the following:

  my $charms = random_food('data')->{'Lucky Charms'};

=head4 Klondike bars

  random_food('Klondike bars');

The C<Klondike bars> option returns a flavor of Klondike Bars. For the complete list of Klondike bar flavors, you can do the following:

  my $Klondike = random_food('data')->{'Klondike bars'};

=head4 M&Ms

  random_food('M&Ms');

The C<M&Ms> option returns a flavor of M&Ms. For the complete list of M&M flavors, you can do the following:

  my $MandMs = random_food('data')->{'M&Ms'};

=head3 random_drink options

=head4 beers

  random_drink('beers');

The C<beers> option returns stout beer, mild beer, wheat beer, lager beer, lambic beer, or pale ale.

=head4 hot drinks

  random_drink('hot drinks');

The C<hot drinks> option returns coffee, tea, or cider.

=head4 juices

  random_drink('juices');

The C<juices> option returns apple juice, grape juice, orange juice, cranberry juice, grapefruit juice, tomato juice, or lemonade.

=head4 Kool-Aid

  random_drink('Kool-Aid');

The C<Kool-Aid> option returns a flavor of Kool-Aid. For the complete list of Kool-Aid flavors, you can do the following:

  my $KoolAid = random_drink('data')->{'Kool-Aid'};

=head3 by keys

  random_food('by keys');
  random_drink('by keys');

The C<by keys> option returns a random key listed above.

=head3 keys

  random_food('keys');
  random_drink('keys');

The C<keys> option will list all of the available keys in an array reference.

=head3 data

  random_food('data');
  random_drink('data');

The C<data> option will return the data used in a hash reference.

=head3 help or options

  random_food('help');
  random_drink('help');

  random_food('options');
  random_drink('options');

The C<help> or C<options> options will return a list of all of your options.

=head2 Adding items to a list

You can add items to the list by adding an array reference with the additional items as the second parameter.

  my @additions = ('food 1', 'food 2');
  random_food('<your option>', \@additions);

  my @additions = ('drink 1', 'drink 2');
  random_drink('<your option>', \@additions);

=head1 DEPENDENCIES

Random::Food depends on L<Fancy::Rand>, L<Fancy::Map>, L<Fancy::Open>, L<Util::Data>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;