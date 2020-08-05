package Date::Birth::DayStone;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Date::Calc qw(:all);
use String::Util qw(trim);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(day_stone);

use Date::Verify qw(month_number);

my $day_stones;
while (my $line = <DATA>) {
  chomp($line);
  my ($day, $stone) = split(/\|/, $line);
  $day_stones->{trim($day)} = $stone;
}

sub day_stone {
  my ($year, $month, $day) = @_;
  $month = month_number($month);

  my $dow       = Day_of_Week($year, $month, $day);
  my $day_word  = Day_of_Week_to_Text($dow);

  return $day_stones->{$day_word};
}

=pod

=encoding utf8

=head1 NAME

B<Date::Birth::DayStone> returns the birthday stone for the day of the week you were born.

=head1 VERSION

This document describes Date::Birth::DayStone version 1.0.

=head1 SYNOPSIS

  my $day_stone = day_stone(1970, 'July', 3);
  # emerald or cat's eye

=head1 DESCRIPTION

C<day_stone> is exported by default and returns the birthday stone associated with the day of the week you were born. Enter the 4-digit year, the month, and day you were born.

=head1 DEPENDENCIES

Date::Birth::DayStone depends on L<Exporter>, L<Date::Calc>, L<String::Util>, and L<Date::Verify>.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;

__DATA__
Sunday   |topaz or diamond
Monday   |pearl or crystal
Tuesday  |ruby or emerald
Wednesday|amethyst or lodestone
Thursday |sapphire or carnelian
Friday   |emerald or cat's eye
Saturday |turquiose or diamond