package Random::Size;
use v5.10.0;
use strict;
use warnings;
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

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
