package Random::Descriptor;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_descriptor);

my %descriptors = (
  'good'     => [qw(good great wonderful glorious)],
  'bad'      => [qw(bad horrible awful atrocious)],
  'quality'  => [qw(excellent good average poor terrible)],
  'rarity'   => ['common', 'uncommon', 'rare', 'very rare', 'unique'],
  'reaction' => [qw(hostile unfriendly indifferent friendly)],
);

sub random_descriptor {
  my ($user_descriptor, $user_additions) = @_;
  my $descriptor = fancy_rand(\%descriptors, $user_descriptor, { caller => 'random_descriptor', additions => $user_additions ? $user_additions : undef });
  return $descriptor;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
