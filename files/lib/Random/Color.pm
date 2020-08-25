package Random::Color;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);
use Fancy::Open qw(fancy_open);
use Page::File qw(file_directory);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_color);

my $directory = file_directory('Random/Colors', 'data');
my @Crayola_crayons = fancy_open("$directory/Crayola_crayon_colors.txt");;
my @MandMs          = fancy_open("$directory/MandMs_colors.txt");

my %colors = (
  'additive primary'      => [qw(red green blue)],
  'additive secondary'    => [qw(yellow cyan magenta)],
  'subtractive primary'   => [qw(red yellow blue)],
  'subtractive secondary' => [qw(orange green violet)],
  'pure' => [qw(white black red yellow green blue)],
  'gray' => [qw(white gray black)],
  'eye'  => [qw(amber black blue brown gray green hazel red violet)],
  'hair' => [qw(auburn brown black blond gray red white)],
  'star' => [qw(blue red orange yellow white)],
  'rainbow'  => [qw(red orange yellow green blue indigo violet)],
  'spectral' => [qw(infrared red orange yellow green blue violet ultraviolet)],
  'flower'   => [qw(amaranth cornflower fern heliotrope lavender lilac orchid rose violet)],
  'fruit'    => [qw(apricot lemon lime olive peach pear plum pumpkin raspberry tangerine tomato)],
  'metallic' => [qw(brass bronze cobalt copper gold platinum silver steel tin)],
  'organic mineral' => [qw(amber coral ivory seashell)],
  'karate belts'    => [qw(white orange yellow gold green blue red purple brown black)],
  'Crayola crayons' => [@Crayola_crayons],
  'M&Ms'            => [@MandMs],
  'Olympic rings'   => [qw(blue yellow black green red)],
  'Pern dragon'     => [qw(blue green brown bronze gold)],
);
$colors{'additive'}         = [map( @{$colors{$_}}, ('additive primary','additive secondary') )];
$colors{'additive plus'}    = [map( @{$colors{$_}}, ('additive','gray') )];
$colors{'subtractive'}      = [map( @{$colors{$_}}, ('subtractive primary','subtractive secondary') )];
$colors{'subtractive plus'} = [map( @{$colors{$_}}, ('subtractive','gray') )];

sub random_color {
  my ($user_color, $user_additions) = @_;
  my $color = fancy_rand(\%colors, $user_color, { caller => 'random_color', additions => $user_additions ? $user_additions : undef });
  return $color;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
