package Random::RPG::MagicItem::Ring::SpellDoubling;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(tiny_rand);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(make_ring random_ring);

my %stats = (
  'wizard' => {
    'levels' => [1..9],
    'xp' => { 'base' => 4000,  'inc' => 400 },
    'gp' => { 'base' => 50000, 'inc' => 4000 }
  },
  'priest' => {
    'levels' => [1..7],
    'xp' => { 'base' => 6000,  'inc' => 600 },
    'gp' => { 'base' => 75000, 'inc' => 6000 }
  }
);

sub ring_value {
  my($class, $stat, @array) = @_;
  return $stats{$class}{$stat}{'base'} + ( (scalar(@array) - 1) * $stats{$class}{$stat}{'inc'} );
}

sub make_ring {
  my ($class, $levels) = @_;
  my @ring = sort @{$levels};

  my $ring_xp = ring_value($class, 'xp', @ring);
  my $ring_gp = ring_value($class, 'gp', @ring);

  $class = ucfirst $class;

  return {
    name   => "Ring of $class Spell Doubling",
    spells => \@ring,
    xp => $ring_xp,
    gp => $ring_gp,
  }
}

sub random_ring {
  my ($class) = @_;

  my $ring_class = $class ? $class : tiny_rand(qw(wizard priest));
  my @levels;
  for my $level (@{$stats{$ring_class}{levels}}) {
    my $roll = int(rand(2));
    if ($roll) {
      push @levels, $level;
    }
  }

  return make_ring($ring_class,\@levels);
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::MagicItem::Ring::SpellDoubling> makes or randomly generates a Ring of Spell Doubling.

=head1 VERSION

This document describes Random::RPG::MagicItem::SpellDoubling version 1.000.

=head1 SYNOPSIS

  use Random::RPG::MagicItem::Ring::SpellDoubling qw(make_ring random_ring);

=head1 DEPENDENCIES

Random::RPG::MagicItem::Ring::SpellDoubling depends on L<Fancy::Rand> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;