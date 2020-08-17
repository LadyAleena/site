package Random::GemMetalJewelry;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Lingua::EN::Inflect qw(A);

use Fancy::Rand qw(fancy_rand);
use Fancy::Join::Grammatical qw(grammatical_join);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_gem random_gem_variety random_gem_color random_gem_cut random_metal random_jewelry random_gem_expanded);

my %gem_varieties = (
  'unsorted'   => [qw(diamond garnet spinel topaz tourmaline zircon crystal)],
  'beryl'      => [qw(emerald aquamarine)],
  'chalcedony' => [qw(agate bloodstone carnelian jasper onyx sard sardonyx)],
  'corundum'   => [qw(ruby sapphire)],
  'quartz'     => [qw(amethyst citrine), map("$_ quartz",('milky','rose','smokey'))],
  'organic'    => [qw(amber coral ivory jet pearl seashell)],
  'metal'      => [qw(aluminum brass bronze cobalt copper electrum gold iron lead nickel pewter platinum silver steel tin titanium)],
);

my %gem_colors = (
  'diamond'    => [qw(black blue brown colorless gray green pink red yellow)],
  'garnet'     => [qw(black brown colorless green orange pink purple red violet yellow)],
  'sapphire'   => [qw(blue colorless green pink yellow)],
  'spinel'     => [qw(blue orange pink red)],
  'topaz'      => [qw(blue green pink yellow brown orange)],
  'gold'       => [qw(blue black green gray pink purple red rose white yellow)],
);

my %gem_cuts = (
  'brilliant'  => [qw(oval round)],
  'fancy'      => [qw(marquise pendeloque scissors)],
  'mixed'      => [qw(cushion mixed)],
  'step'       => [qw(baguette octagon oval square table)],
  'other'      => [qw(bead carving cabochon polished)],
);

my @jewelry = (
  qw(anklet bracelet brooch chatelaine crown earrings necklace ring tiara),
  'belt buckle', 'cuff link', 'tie bar', 'wrist watch', 'pocket watch'
);

my @gems;
for my $gems_key (grep(!/metal/,keys %gem_varieties)) {
  push @gems, @{$gem_varieties{$gems_key}};
}

sub random_gem_variety {
  my ($user_variety, $user_additions) = @_;
  my $gem_variety = fancy_rand(\%gem_varieties, $user_variety, { caller => 'random_gem_variety', additions => $user_additions ? $user_additions : undef });
  return $gem_variety;
}

sub random_gem_color {
  my ($user_color, $user_additions) = @_;
  my $gem_color = fancy_rand(\%gem_colors, $user_color, { caller => 'random_gem_color', additions => $user_additions ? $user_additions : undef });
  return $gem_color;
}

sub random_gem_cut {
  my ($user_cut, $user_additions) = @_;
  my $gem_cut = fancy_rand(\%gem_cuts, $user_cut, { caller => 'random_gem_cut', additions => $user_additions ? $user_additions : undef });
  return $gem_cut;
}

sub random_gem_expanded {
  my ($user_gem) = @_;

  my $base_gem = $user_gem ? random_gem_variety($user_gem) : random_gem_variety;

  my $gem;
  if ($gem_colors{$base_gem}) {
    my $gem_color = random_gem_color($base_gem);
    $gem = "$gem_color $base_gem";
  }
  else {
    $gem = $base_gem;
  }

  return $gem;
}

sub random_gem {
  my $user_gem = shift;

  $gem_varieties{'no metal'} = [map { @$_ } @gem_varieties{ grep $_ ne 'metal', keys %gem_varieties }];

  my $gem = $user_gem ? random_gem_variety($user_gem) : random_gem_variety('no metal');

  delete $gem_varieties{'no metal'};

  return $gem;
}

sub random_metal {
  random_gem_variety('metal');
}

sub random_jewelry {
  my $user_gems = shift;
  my $gem_varieties = $user_gems ? $user_gems : 0;

  my $piece = $jewelry[rand @jewelry];
  my $metal = random_metal;
  my $item = A("$metal $piece");

  if ($gem_varieties and $gem_varieties > 0) {
    my @jewlery_gems = map(random_gem_expanded, 1..$gem_varieties);
    my $jewlery_gems_text = grammatical_join('and', @jewlery_gems);
    return "$jewlery_gems_text on $item";
  }
  elsif ($gem_varieties != 0) {
    return "$item";
  }
  else {
    my $roll = int(rand(100));
    if ($roll <= 30) {
      return "$item";
    }
    elsif ($roll <= 50) {
      return random_jewelry(1);
    }
    elsif ($roll <= 75) {
      return random_jewelry(2);
    }
    elsif ($roll <= 90) {
      return random_jewelry(3);
    }
    else {
      return random_jewelry(4);
    }
  }
}

=pod

=encoding utf8

=head1 NAME

B<Random::GemMetalJewelry> returns a random gem, metal, or piece of jewelry.

=head1 VERSION

This document describes Random::GemsMetalJewelry version 1.000.

=head1 SYNOPSIS

  use Random::GemMetalJewelry qw(
    random_gem_variety
    random_gem_color
    random_gem_cut
    random_gem
    random_metal
    random_gem_expanded
    random_jewelry
  );

  # random_gem_variety usage

  my $gem_variety = random_gem_variety('all'); # returns a random gem or metal

  my $unsorted_gem   = random_gem_variety('unsorted');
  my $beryl_gem      = random_gem_variety('beryl');
  my $chalcedony_gem = random_gem_variety('chalcedony');
  my $corundum_gem   = random_gem_variety('corundum');
  my $quartz_gem     = random_gem_variety('quartz');
  my $organic_gem    = random_gem_variety('organic');
  my $metal          = random_gem_variety('metal');

  print random_gem_variety('help'); # get random_gem_variety options

  # random_gem_color usage

  my $gem_color = random_gem_color('all'); # returns a random gem color

  my $diamond_color  = random_gem_color('diamond');
  my $garnet_color   = random_gem_color('garnet');
  my $sapphire_color = random_gem_color('sapphire');
  my $spinel_color   = random_gem_color('spinel');
  my $topaz_color    = random_gem_color('topaz');
  my $gold_color     = random_gem_color('gold');

  print random_gem_color('help'); # get random_gem_color options

  # random_gem_cut usage

  my $gem_cut = random_gem_cut('all'); # returns a random gem cut

  my $brilliant_cut = random_gem_cut('brilliant');
  my $fancy_cut     = random_gem_cut('fancy');
  my $mixed_cut     = random_gem_cut('mixed');
  my $step_cut      = random_gem_cut('step');
  my $other_cut     = random_gem_cut('other');

  print random_gem_cut('help'); # get random_gem_cut options

  # random_gem_expanded usage

  my $gem_expanded        = random_gem_expanded('all');
  my $unsorted_expanded   = random_gem_expanded('unsorted');
  my $beryl_expanded      = random_gem_expanded('beryl');      # or use random_gem_variety or random_gem
  my $chalcedony_expanded = random_gem_expanded('chalcedony'); # or use random_gem_variety or random_gem
  my $corundum_expanded   = random_gem_expanded('corundum');
  my $quartz_expanded     = random_gem_expanded('quartz');     # or use random_gem_variety or random_gem
  my $organic_expanded    = random_gem_expanded('organic');    # or use random_gem_variety or random_gem
  my $metal_expanded      = random_gem_expanded('metal');

  # random_gem usage

  my $gem        = random_gem('all');
  my $unsorted   = random_gem('unsorted');
  my $beryl      = random_gem('beryl');
  my $chalcedony = random_gem('chalcedony');
  my $corundum   = random_gem('corundum');
  my $quartz     = random_gem('quartz');
  my $organic    = random_gem('organic');
  my $metal_2    = random_gem('metal');
  my $no_metal   = random_gem('no metal');

  # random_metal usage

  my $metal_3 = random_metal;

  # random_jewelry usage

  my $jewelry = random_jewelry(1); # or any number

=head1 DESCRIPTION

Random::GemMetalJewelry returns a random gem, metal, or jewelry.

=head2 Options

=head3 nothing, all, or undef

These options are applicable to C<random_gem_variety>, C<random_gem_color>, and C<random_gem_cut>.

  random_gem_variety;
  random_gem_variety();
  random_gem_variety('all');
  random_gem_variety(undef);

  random_gem_color;
  random_gem_color();
  random_gem_color('all');
  random_gem_color(undef);

  random_gem_cut;
  random_gem_cut();
  random_gem_cut('all');
  random_gem_cut(undef);

These options will select any value in any list related to the function. You can read the options below to see all of the potential values.

=head3 random_gem_variety options

=head4 unsorted

  random_gem_variety('unsorted');

The C<unsorted> option returns diamond, garnet, spinel, topaz, tourmaline, zircon, or crystal.

=head4 beryl

  random_gem_variety('beryl');

The C<beryl> option returns emerald or aquamarine.

=head4 chalcedony

  random_gem_variety('chalcedony');

The C<chalcedony> option returns agate, bloodstone, carnelian, jasper, onyx, sard, or sardonyx.

=head4 corumdum

  random_gem_variety('corondum');

The C<corundum> option returns ruby or sapphire.

=head4 quartz

  random_gem_variety('quartz');

The C<quartz> option returns milky quartz, rose quartz, smokey quartz, amethyst, or citrine.

=head4 organic

  random_gem_variety('organic');

The C<organic> option returns amber, coral, ivory, jet, pearl, or seashell.

=head4 metal

  random_gem_variety('metal');

The C<metal> option returns aluminum, brass, bronze, cobalt, copper, electrum, gold, iron, lead, nickel, pewter, platinum, silver, steel, tin, or titanium.

=head3 random_gem_color options

=head4 diamond

  random_gem_color('diamond');

The C<diamond> option returns black, blue, brown, colorless, gray, green, pink, red, or yellow.

=head4 garnet

  random_gem_color('garnet');

The C<garnet> option returns black, brown, colorless, green, orange, pink, purple, red, violet, or yellow.

=head4 sapphire

  random_gem_color('sapphire');

The C<sapphire> option returns blue, colorless, green, pink, or yellow.

=head4 spinel

  random_gem_color('spinel');

The C<spinel> option returns blue, orange, pink, or red.

=head4 topaz

  random_gem_color('topaz');

The C<topaz> option returns blue, green, pink, yellow, brown, or orange.

=head4 gold

  random_gem_color('gold');

The C<gold> option returns blue, black, green, gray, pink, purple, red, rose, white, or yellow.

=head3 random_gem_cut options

=head4 brilliant

  random_gem_cut('brilliant');

The C<brilliant> option returns oval or round.

=head4 fancy

  random_gem_cut('fancy');

The C<fancy> option returns marquise, pendeloque, or scissors.

=head4 mixed

  random_gem_cut('mixed');

The C<mixed> option returns cushion or mixed.

=head4 step

  random_gem_cut('step');

The C<step> option returns baguette, octagon, oval, square, or table.

=head4 other

  random_gem_cut('other');

The C<other> option returns bead, carving, cabochon, or polished.

=head4 random_gem_expanded options

C<random_gem_expanded> is a combination of C<random_gem_variety> and C<random_gem_color> and has the same options as C<random_gem_variety>. If the gem variety returned has a corresponding color option, a random color will be returned for the gem variety. The combination will be returned. If "diamond" is returned as the variey, a "blue diamond" could be returned.

=head4 random_metal

C<random_metal> is an alias for C<random_gem_variety('metal')> and has no options.

=head4 random_gem options

C<random_gem> has the same options as C<random_gem_variety> with the addition of C<no metal>.

=head4 random_jewelry option

  random_jewelry();

C<random_jewelry> returns a random piece of jewelry. The jewelry returned can be anklet, belt buckle, bracelet, brooch, chatelaine, crown, cuff link, earrings, necklace, ring, tiara, tie bar, pocket watch, or wrist watch with gems.

  random_jewelry('0');

If you do not want any gems on the piece of jewelry, use C<0>.

  random_jewelry('2'); # or any number

The number you enter will be the amount of gems attached to the jewelry.

=head3 by keys

C<by keys> is applicable to C<random_gem_variety>, C<random_gem_color>, and C<random_gem_cut>.

  random_gem_variety('by keys');
  random_gem_color('by keys');
  random_gem_cut('by keys');

The C<by keys> option returns a random key listed above related to the function.

=head3 keys

C<keys> is applicable to C<random_gem_variety>, C<random_gem_color>, and C<random_gem_cut>.

  random_gem_variety('keys');
  random_gem_color('keys');
  random_gem_cut('keys');

The C<keys> option will list all of the available keys related to the function in an array reference.

=head3 data

C<data> is applicable to C<random_gem_variety>, C<random_gem_color>, and C<random_gem_cut>.

  random_gem_variety('data');
  random_gem_color('data');
  random_gem_cut('data');

The C<data> option will return the data used for the function in a hash reference.

=head3 help or options

These options are applicable to C<random_gem_variety>, C<random_gem_color>, and C<random_gem_cut>.

  random_gem_variety('help');
  random_gem_color('help');
  random_gem_cut('help');

  random_gem_variety('options');
  random_gem_color('options');
  random_gem_cut('options');

The C<help> or C<options> options will return a list of all of your options for the function.

=head2 Adding items to a list

You can add items to the list by adding an array reference with the additional items as the second parameter. This is only applicable to C<random_gem_variety>, C<random_gem_color>, and C<random_gem_cut>.

  my @variety_additions = ('gem 1', 'gem 2');
  random_gem_variety('<your option>', \@variety_additions);

  my @color_additions = ('color 1', 'color 2');
  random_gem_color('<your option>', \@color_additions);

  my @cut_additions = ('cut 1', 'cut 2');
  random_gem_cut('<your option>', \@cut_additions);

=head1 DEPENDENCIES

Random::GemMetalJewelry depends on L<Fancy::Rand>, L<Fancy::Join::Grammatical>, L<Lingua::EN::Inflect>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;