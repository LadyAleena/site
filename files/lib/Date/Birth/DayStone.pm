package Date::Birth::DayStone;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Date::Calc qw(:all);
use String::Util qw(trim);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(day_stone);

my $day_stones;
while (my $line = <DATA>) {
  chomp($line);
  my ($day, $stone) = split(/\|/, $line);
  $day_stones->{trim($day)} = $stone;
}

sub day_stone {
  my ($year, $month, $day, $lang) = @_;

  $lang  = Decode_Language($lang)           if $lang  !~ /\d+/;
  $month = Decode_Month($month, $lang // 1) if $month !~ /\d+/;

  my $dow      = Day_of_Week($year, $month, $day);
  my $day_word = Day_of_Week_to_Text($dow);

  return $day_stones->{$day_word};
}

=pod

=encoding utf8

=head1 NAME

B<Date::Birth::DayStone> returns the birthday stone for the day of the week you were born.

=head1 VERSION

This document describes Date::Birth::DayStone version 1.0.

=head1 SYNOPSIS

  use Date::Birth::DayStone qw(day_stone);

  my $day_stone = day_stone(1970, 'July', 3);
  # emerald or cat's eye

=head1 DESCRIPTION

Date::Birth::DayStone returns the birthday stones for the day of the week you were born when you use C<day_stone>. C<day_stone> needs to be imported into your script. It returns the birthday stone associated with the day of the week you were born. All you need to do is enter the 4-digit year, the month name or digits, and day you were born.

Date::Birth::DayStone requires Perl version 5.10.0 or better to run.

=head2 The day stones

  Day of the week | Stones
  ----------------|----------------------
  Sunday          | topaz or diamond
  Monday          | pearl or crystal
  Tuesday         | ruby or emerald
  Wednesday       | amethyst or lodestone
  Thursday        | sapphire or carnelian
  Friday          | emerald or cat's eye
  Saturday        | turquoise or diamond

=head1 USAGE

C<day_stone> has four parameters: the year, month, and day parameters are required; the language parameter is optional if English is being used.

  day_stone($year, $month, $day, $lang);


=head2 year

The year can be any year, starting with year 1.

=head2 month

The month can be the digits 1 through 12 or a month name. If you are using a month name, and the name is not in English, you will need to enter the language. Language support comes from L<Date::Calc>.

=head2 day

This is the one-digit or two-digit day of the month.

=head2 language

Currently, fourteen languages are supported by L<Date::Calc>.

=head1 DEPENDENCIES

Date::Birth::DayStone depends on L<Date::Calc>, L<String::Util>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena (C<aleena@cpan.org>). All rights reserved.

=cut

1;

__DATA__
Sunday   |topaz or diamond
Monday   |pearl or crystal
Tuesday  |ruby or emerald
Wednesday|amethyst or lodestone
Thursday |sapphire or carnelian
Friday   |emerald or cat's eye
Saturday |turquoise or diamond