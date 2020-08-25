package Random::Food;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);
use Fancy::Map  qw(fancy_map);
use Fancy::Open qw(fancy_open);
use Page::File qw(file_directory);

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

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
