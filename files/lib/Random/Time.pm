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

=pod

=encoding utf8

=head1 NAME

B<Random::Time> returns a random time unit, random day part, random time, or random frequency.

=head1 VERSION

This document describes Random::Time version 1.000.

=head1 SYNOPSIS

  use Random::Time qw(random_time_unit random_day_part random_time random_frequency);

  my $time_unit          = random_time_unit;
  my $standard_time_unit = random_time_unit('general');
  my $game_time_unit     = random_time_init('game');

  print random_time_unit('help')

  my $day_part = random_day_part;

  my $time          = random_time;
  my $standard_time = random_time('general');
  my $game_time     = random_time('game');

  my $frequency = random_frequency;

=head1 DESCRIPTION

Random::Time returns a random time unit, random day part, random time, or random frequency. You need to import the functions into your script.

=head2 random_time_unit

C<random_time_unit> returns a random unit of time from a second to a millennium. It has two optional parameters: the list option and any units of time you want to add to the list.

=head3 Options

=head4 nothing, all, or undef

  random_time_unit;
  random_time_unit();
  random_time_unit('all');
  random_time_unit(undef);

These options return any value in any list. You can read the options below to see all of the potential values.

=head4 general

  random_time_unit('general');

The C<general> option returns second, minute, hour, day, week, month, year, decade, century, or millennium.

=head4 game

  random_time_unit('game');

The C<game> option returns segment, round, or turn.

=head4 by keys

  random_time_unit('by keys');

The C<by keys> option will select a random key listed above.

=head4 keys

  random_time_unit('keys');

The C<keys> option will list all of the available keys in an array reference.

=head4 data

  random_time_unit('data');

The C<data> option will return the data used in a hash reference.

=head4 help or options

  random_time_unit('help');
  random_time_unit('options');

The C<help> or C<options> options will return a list of all of your options.

=head3 Adding items to a list

  my @additions = ('time unit 1', 'time unit 2');
  random_time_unit('<your option>', \@additions);

You can add items to the list by adding an array reference with the additional items as the second parameter.

=head2 random_day_part

C<random_day_part> returns a random part of the day and has no parameters. If the part of the day is morning, afternoon, or evening; the returned string will read "in the morning", "in the afternoon", or "in the evening". The the part of the day is dawn, midmorning, noon, midday, dusk, night, or midnight; the returned string will read "at dawn", "at midmorning", "at noon", "at midday", "at dusk", "at night", or "at midnight".

=head2 random_time

C<random_time> returns a random time and has one parameter. It combines C<random_time_unit> with C<random_day_part>. Time units that are a day or shorter will return just the time unit, every other time unit will be suffixed with a day part phrase. There are sixty-eight possible combinations, so I will not list them all here, but I will give a few examples of the output.

  hour
  century in the afternoon
  decade at night
  week in the morning
  segment

=head3 Options

=head4 nothing, all, or undef

See the description for nothing, C<all>, or C<undef> in C<random_time_unit>.

=head4 general

See the description for C<general> in C<random_time_unit>.

=head4 game

See the description for C<game> in C<random_time_unit>.

=head2 random_frequency

C<random_frequency> returns a random frequency for when something could happen from one time to twenty times a time unit. It has no parameters.

  5 times a year
  3 times a month
  7 times an hour
  2 times a century
  13 times a round

=head1 DEPENDENCIES

Random::Time depends on L<Fancy::Rand>, L<Random::SpecialDice>, L<Lingua::EN::Inflect>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;