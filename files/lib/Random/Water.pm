package Random::Water;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);
our @EXPORT_OK = qw(random_water);

use Fancy::Rand qw(fancy_rand);

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

=pod

=encoding utf8

=head1 NAME

B<Random::Water> selects random running or standing waters and precipitation.

=head1 SYNOPSIS

  use Random::Water qw(random_water);

  my $random_water = random_water();
    # selects any body of water or precipitation.

  my $random_running_water  = random_water('running');
    # selects a body of running water like a stream or river.

  my $random_standing_water = random_water('standing');
    # selects a body of standing water like a pond or lake.

  my $random_precipitation  = random_water('precipitation')
    # selects a type of precipitation like rain or snow.

  print random_water('help'); # get random_water options


=head1 DEPENDENCY

Random::Water depends on L<Fancy::Rand>.

=head1 AUTHOR

Lady Aleena

=cut

1;