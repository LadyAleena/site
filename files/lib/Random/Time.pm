package Random::Time;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Lingua::EN::Inflect qw(PL_N A);

use Fancy::Rand qw(fancy_rand tiny_rand);
use Random::SpecialDice qw(random_die);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_time_unit random_day_part random_time random_frequency);

my %time_units = (
  'general' => [qw(second minute hour day week month year decade century millennium)],
  'game'    => [qw(segment round turn)],
);

my %times;
$times{'second'}     = 1;
$times{'minute'}     = $times{'second'}  * 60;
$times{'hour'}       = $times{'minute'}  * 60;
$times{'day'}        = $times{'hour'}    * 24;
$times{'week'}       = $times{'day'}     *  7;
$times{'month'}      = $times{'week'}    *  4;
$times{'year'}       = $times{'week'}    * 52;
$times{'decade'}     = $times{'year'}    * 10;
$times{'century'}    = $times{'decade'}  * 10;
$times{'millennium'} = $times{'century'} * 10;
$times{'round'}      = $times{'minute'};
$times{'segment'}    = $times{'round'}   / 10;
$times{'turn'}       = $times{'round'}   * 10;

sub random_time_unit {
  my ($user_time, $user_additions) = @_;
  my $time = fancy_rand(\%time_units, $user_time, { caller => 'random_time_unit', additions => $user_additions ? $user_additions : undef });
  return $time;
}

sub random_day_part {
  my @day_part = qw(dawn morning midmorning noon midday afternoon evening dusk night midnight);
  my $day_part = tiny_rand(@day_part);
  if ($day_part =~ /^(morning|afternoon|evening)$/) {
    return "in the $day_part";
  }
  else {
    return "at $day_part";
  }
}

sub random_time {
  my ($type) = @_;
  my $time_unit = $type ? random_time_unit($type) : random_time_unit('all');
  my $day_part = random_day_part;
  if ($times{$time_unit} <= $times{'day'}) {
    return $time_unit
  }
  else {
    return "$time_unit $day_part";
  }
}

sub random_frequency {
  my $time_unit = A(random_time_unit('all'));
  my $frequency = $time_unit =~ /(?:second|segment)/ ? 1 : random_die(1);
  my $plural = PL_N('time', $frequency);
  return "$frequency $plural $time_unit";
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
