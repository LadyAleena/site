package Random::Water;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_water);

my %waters = (
  'running'  => [qw(spring streamlet rivulet run brook creek stream estuary fjord river)],
  'standing' => [qw(drop puddle pool pond lake lagoon bay sea bight sound ocean)],
  'precipitation' => [qw(rain snow sleet hail)]
);

sub random_water {
  my ($user_water, $user_additions) = @_;
  my $water = fancy_rand(\%waters, $user_water, { caller => 'random_water', additions => $user_additions ? $user_additions : undef });
  return $water;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
