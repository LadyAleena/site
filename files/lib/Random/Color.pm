package Random::Color;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);
use Fancy::Open qw(fancy_open);
use Util::Data qw(file_directory);

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

=pod

=encoding utf8

=head1 NAME

B<Random::Color> returns a random color.

=head1 VERSION

This document describes Random::Color version 1.000.

=head1 SYNOPSIS

  my $additive              = random_color('additive');
  my $additive_primary      = random_color('additive primary');
  my $additive_secondary    = random_color('additive secondary');
  my $additive_plus         = random_color('additive plus');

  my $subtractive           = random_color('subtractive');
  my $subtractive_primary   = random_color('subtractive primary');
  my $subtractive_secondary = random_color('subtractive secondary');
  my $subtractive_plus      = random_color('subtractive plus');

  my $pure_color            = random_color('pure');
  my $gray                  = random_color('gray');
  my $eye_color             = random_color('eye');
  my $hair_color            = random_color('hair');
  my $star_color            = random_color('star');
  my $rainbow_color         = random_color('rainbow');
  my $spectral_color        = random_color('spectral');
  my $flower_color          = random_color('flower');
  my $fruit_color           = random_color('fruit');
  my $metallic_color        = random_color('metallic');
  my $organic_mineral_color = random_color('organic mineral');
  my $karate_belt_color     = random_color('karate belts');
  my $Crayola_crayon_color  = random_color('Crayola crayons');
  my $MandM_color           = random_color('M&Ms');
  my $Olympic_ring_color    = random_color('Olympic rings');
  my $Pern_dragon_color     = random_color('Pern dragon');

  print random_color('help'); # get random_color options

=head1 DESCRIPTION

Random::Color returns a random color from a list of colors.

=head2 random_color

=head3 Options

=head4 nothing, all, or undef

  random_color;
  random_color();
  random_color('all');
  random_color(undef);

These options will return any value in any list. You can read the options below to see all of the potential values.

=head4 additive

  random_color('additive');

The C<additive> option returns red, yellow, green, cyan, blue, or magenta.

=head4 additive primary

  random_color('additive primary');

The C<additive primary> option returns red, green, or blue.

=head4 additive secondary

  random_color('additive secondary');

The C<additive secondary> option returns yellow, cyan, or magenta.

=head4 additive plus

  random_color('additive plus');

The C<additive plus> option returns red, yellow, green, cyan, blue, magenta, or gray.

=head4 subtractive

  random_color('subtractive');

The C<subtractive> option returns red, orange, yellow, green, blue, or violet.

=head4 subtractive primary

  random_color('subtractive primary');

The C<subtractive primary> option returns red, yellow, or blue.

=head4 subtractive secondary

  random_color('subtractive secondary');

The C<subtractive secondary> option returns orange, green, or violet.

=head4 subtractive plus

  random_color('subtractive plus');

The C<subtractive plus> option returns red, orange, yellow, green, blue, violet, or gray.

=head4 pure

  random_color('pure');

The C<pure> option returns white, black, red, yellow, green, or blue.

=head4 gray

  random_color('gray');

The C<gray> option returns white, gray, and black.

=head4 eye

  random_color('eye');

The C<eye> option returns amber, black, blue, brown, gray, green, hazel, red, or violet.

=head4 hair

  random_color('hair');

The C<hair> option returns auburn, brown, black, blonde, red, gray, or white.

=head4 star

  random_color('star');

The C<star> option returns blue, red, orange, yellow, or white.

=head4 rainbow

  random_color('rainbow');

The C<rainbow> option returns red, orange, yellow, green, blue, indigo, or violet.

=head4 spectral

  random_color('spectral');

The C<spectral> option returns infrared, red, orange, yellow, green, blue, violet, or ultraviolet.

=head4 flower

  random_color('flower');

The C<flower> option returns amaranth, cornflower, fern, heliotrope, laventer, lilac, orchid, rose, or violet.

=head4 fruit

  random_color('fruit');

The C<fruit> option returns apricot, lemon, lime, olive, peach, pear, plum, pumpkin, raspberry, tangerine, or tomato.

=head4 metallic

  random_color('metallic');

The C<metallic> option returns brass, bronze, cobalt, copper, gold, platinum, silver, steel, or tin.

=head4 organic material

  random_color('organic material');

The C<organic material> option returns amber, coral, ivory, or seashell.

=head4 karate belts

  random_color('karate belts');

The C<karate belts> option returns white, orange, yellow, gold, green, blue, red, purple, brown, or black.

=head4 Crayola crayons

  random_color('Crayola crayons');

The C<Crayola crayons> option returns a random Crayola crayon color. The list of colors is too long to include here.

=head4 M&Ms

  random_color('M&Ms');

The C<M&Ms> option returns a random M&M color. The list of colors is too long to list here.

=head4 Olympic rings

  random_color('Olympic rings');

The C<Olympic rings> option returns blue, yellow, black, green, or red.

=head4 Pern dragon

  random_color('Pern dragon');

The C<Pern dragon> option returns blue, green, brown, bronze, or gold.

=head4 by keys

  random_color('by keys');

The C<by keys> option returns a random key listed above.

=head4 keys

  random_color('keys');

The C<keys> option will list all of the available keys in an array reference.

=head4 data

  random_color('data');

The C<data> option will return the data used in a hash reference.

=head4 help or options

  random_color('help');
  random_color('options');

The C<help> or C<options> options will return a list of all of your options.

=head3 Adding items to a list

You can add items to the list by adding an array reference with the additional items as the second parameter.

  my @additions = ('color 1', 'color 2');
  random_color('<your option>', \@additions);

=head1 DEPENDENCIES

Random::Color depends on L<Fancy::Rand>, L<Fancy::Open>, L<Util::Data>, and L<Exporter>.

=head1 SEE ALSO

More random colors can be found in L<Random::GemMetalJewelry>.

=head1 NOTE

I am always looking for more lists of colors to add, so please send your lists of colors.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;