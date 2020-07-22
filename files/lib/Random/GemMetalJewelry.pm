package Random::GemMetalJewelry;
use v5.10.0;
use strict;
use warnings FATAL => qw(all);
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
    my @gems = map(random_gem,1..$gem_varieties);
    my $gems = grammatical_join('and',@gems);
    return "$gems on $item";
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

=head1 Random::GemMetalJewelry

B<Random::GemMetalJewelry> selects random gems, metals, and jewelry.

=head2 Version

This document describes Random::GemsMetalJewelry version 1.000.

=head2 Synopsis

  use Random::GemMetalJewelry qw(
    random_gem_variety
    random_gem_color
    random_gem_cut
    random_gem
    random_metal
    random_gem_expanded
    random_jewelry
  );

=head3 random_gem_variety usage

  my $gem_variety = random_gem_variety('all');
    # selects a random gem or metal

  my $unsorted_gem = random_gem_variety('unsorted');
    # selects from diamond, garnet, spinel, topaz, tourmaline, zircon, and crystal

  my $beryl_gem = random_gem_variety('beryl');
    # selects from emerald and aquamarine

  my $chalcedony_gem = random_gem_variety('chalcedony');
    # selects from agate, bloodstone, carnelian, jasper, onyx, sard, and sardonyx

  my $corundum_gem = random_gem_variety('corundum');
    # selects from ruby and sapphire

  my $quartz_gem = random_gem_variety('quartz');
    # selects from amethyst, citrine, milky quartz, rose quartz, and smokey quartz

  my $organic_gem = random_gem_variety('organic');
    # selects from amber, coral, ivory, jet, pearl, and seashell

  my $metal = random_gem_variety('metal');
    # selects from aluminum, brass, bronze, cobalt, copper, electrum, gold,
    # iron, lead, nickel, pewter, platinum, silver, steel, tin, and titanium

  print random_gem_variety('help'); # get random_gem_variety options

=head3 random_gem_color usage

  my $gem_color = random_gem_color('all');
    # selects a random gem color

  my $diamond_color = random_gem_color('diamond');
    # selects from black, blue, brown, colorless, gray, green, pink, red, and yellow

  my $garnet_color = random_gem_color('garnet');
    # selects from black, brown, colorless, green, orange, pink, purple, red, violet, and yellow

  my $sapphire_color = random_gem_color('sapphire');
    # selects from blue, colorless, green, pink, and yellow

  my $spinel_color = random_gem_color('spinel');
    # selects from blue, orange, pink, and red

  my $topaz_color = random_gem_color('topaz');
    # selects from blue, green, pink, yellow, brown, and orange

  my $gold_color = random_gem_color('gold');
    # selects from blue, black, green, gray, pink, purple, red, rose, white, and yellow

  print random_gem_color('help'); # get random_gem_color options

=head3 random_gem_cut usage

  my $gem_cut = random_gem_cut('all');
    # selects a random gem cut

  my $brilliant_cut = random_gem_cut('brilliant');
    # selects from oval and round

  my $fancy_cut = random_gem_cut('fancy');
    # selects from marquise, pendeloque, and scissors

  my $mixed_cut = random_gem_cut('mixed');
    # selects from cushion and mixed

  my $step_cut = random_gem_cut('step');
    # selects from baguette, octagon, oval, square, and table

  my $other_cut = random_gem_cut('other');
    # selects from bead, carving, cabochon, and polished

  print random_gem_cut('help'); # get random_gem_cut options

=head3 random_gem usage

  my $gem        = random_gem('all');
  my $unsorted   = random_gem('unsorted');
  my $beryl      = random_gem('beryl');
  my $chalcedony = random_gem('chalcedony');
  my $corundum   = random_gem('corundum');
  my $quartz     = random_gem('quartz');
  my $organic    = random_gem('organic');
  my $metal_2    = random_gem('metal');
  my $no_metal   = random_gem('no metal');

  # is random_gem_variety with more weight to gems
  # 'no metal' is 'all' without metals

=head3 random_metal usage

  my $metal_3 = random_metal;
    # is random_gem_variety('metal')

=head3 random_gem_expanded usage

  my $gem_expanded        = random_gem_expanded('all');
  my $unsorted_expanded   = random_gem_expanded('unsorted');
  my $beryl_expanded      = random_gem_expanded('beryl');      # or use random_gem_variety or random_gem
  my $chalcedony_expanded = random_gem_expanded('chalcedony'); # or use random_gem_variety or random_gem
  my $corundum_expanded   = random_gem_expanded('corundum');
  my $quartz_expanded     = random_gem_expanded('quartz');     # or use random_gem_variety or random_gem
  my $organic_expanded    = random_gem_expanded('organic');    # or use random_gem_variety or random_gem
  my $metal_expanded      = random_gem_expanded('metal');

  # selects a random gem with color if it has a list of colors
  # see random_gem_variety for the gems
  # see random_gem_color for the colors

=head3 random_jewelry usage

  my $jewelry = random_jewelry(1); # or any number

  # selects a piece of jewelry from anklet, belt buckle, bracelet, brooch,
  # chatelaine, crown, cuff link, earrings, necklace, ring, tiara, tie bar,
  # pocket watch, and wrist watch
  # selects random gems to go on the jewelry by amount entered

=head2 Dependencies

Random::GemMetalJewelry depends on L<Fancy::Rand>, L<Fancy::Join::Grammatical>, L<Lingua::EN::Inflect>, and L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;