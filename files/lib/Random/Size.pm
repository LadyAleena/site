package Random::Size;
use v5.10.0;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_size);

my %relative_sizes = (
  'amount'  => ['more',    'less'],
  'density' => ['thicker', 'thinner'],
  'depth'   => ['deeper',  'shallower'],
  'height'  => ['taller',  'shorter'],
  'length'  => ['longer',  'shorter'],
  'speed'   => ['faster',  'slower'],
  'weight'  => ['heavier', 'lighter'],
  'width'   => ['wider',   'narrower'],
  'general' => ['bigger',  'smaller']
);
$relative_sizes{'consistency'} = $relative_sizes{'density'};

sub random_size {
  my ($user_size, $user_additions) = @_;
  my $size = fancy_rand(\%relative_sizes, $user_size, { caller => 'random_size', additions => $user_additions ? $user_additions : undef });
  return $size;
}

=pod

=encoding utf8

=head1 NAME

B<Random::Size> selects random relative sizes.

=head1 VERSION

This document describes Random::Size version 1.000.

=head1 SYNOPSIS

  use RolePlaying::Random::Size qw(random_size);

  my $random_amount      = random_size('amount')  # selects more or less
  my $random_consistency = random_size('consistency') # selects thicker or thinner
  my $random_density     = random_size('density') # selects thicker or thinner
  my $random_depth       = random_size('depth')   # selects deeper or shallower
  my $random_height      = random_size('height')  # selects taller or shorter
  my $random_length      = random_size('length')  # selects longer or shorter
  my $random_speed       = random_size('speed')   # selects faster or slower
  my $random_weight      = random_size('weight')  # selects heavier or lighter
  my $random_width       = random_size('width')   # selects wider or narrower
  my $random_general     = random_size('general') # selects bigger or smaller
  my $random_key         = random_size('by keys') # selects a random key
  my $random_size        = random_size('all')     # selects a random selection from all of the above except keys
  my $keys = random_size('keys')    # the keys
  my $hash = random_size('list')    # the hash

  print random_size('help'); # get random_size options

=head1 DESCRIPTION

The options for B<random_size> are: amount, consistency, density, depth, height, length, speed, weight, width, or general.

If you can not remember what you want, you can always use C<random_size('help')> to retrieve the list of options.

=head1 DEPENDENCIES

Random::Size depends on L<Fancy::Rand> and  L<Exporter>.

=head1 NOTE

L<Random::RPG::World::WorldBuildersGuidebook::Size> also has a function called C<random_size>. Do not use these two modules together.

=head1 AUTHOR

Lady Aleena

=cut

1;