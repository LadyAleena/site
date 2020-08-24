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

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
