package Date::Birth::ZodiacStone;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use String::Util qw(trim);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(zodiac_sign zodiac_stone);

my $zodiac;
while (my $line = <DATA>) {
  chomp($line);
  my ($sign, $start_month, $start_day, $end_month, $end_day, $stone) = split(/\|/, $line);
  $sign = trim($sign);

  $zodiac->{$sign}{name}        = $sign;
  $zodiac->{$sign}{start_month} = trim($start_month);
  $zodiac->{$sign}{start_day}   = $start_day;
  $zodiac->{$sign}{end_month}   = trim($end_month);
  $zodiac->{$sign}{end_day}     = $end_day;
  $zodiac->{$sign}{stone}       = $stone;
}

sub zodiac_sign {
  my ($month, $day) = @_;

  my $sign_name;
  for my $base_sign (keys %$zodiac) {
    my $sign = $zodiac->{$base_sign};
    if (($month eq $sign->{start_month} && $day >= $sign->{start_day}) || ($month eq $sign->{end_month} && $day <= $sign->{end_day})) {
      $sign_name = $sign->{name};
    }
  }
  return $sign_name;
}

sub zodiac_stone {
  my ($sign) = @_;
  return $zodiac->{$sign}{stone};
}

=pod

=encoding utf8

=head1 NAME

B<Zodiac::Stone> returns the stone associated with zodiac signs.

=head1 VERSION

This document describes Date::Birth::ZodiacStone version 1.0.

=head1 SYNOPSIS

  use Date::Birth::ZodiacStone qw(zodiac_stone zodiac_sign);

  my $zodiac_sign = zodiac_sign('July', 3);
  # Cancer

  my $zodiac_stone = zodiac_stone('Cancer');
  # emerald

=head1 DESCRIPTION

B<Date::Birth::ZodiacStone> returns the stone associated with zodiac signs when you use C<zodiac_stone>. C<zodiac_stone> needs to be imported into your script. It returns the stone associated with the sign entered.

If you do not know your zodiac sign, you can use C<zodiac_sign> to determine your sign using your birth month and day. C<sign> also needs to be imported into your script.

Date::Birth::ZodiacStone requires Perl version 5.10.0 or better to run.

=head2 The stones

  Zodiac sign | Stone
  ------------|-----------
  Capricorn   | ruby
  Aquarius    | garnet
  Pisces      | amethyst
  Aries       | bloodstone
  Taurus      | sapphire
  Gemini      | agate
  Cancer      | emerald
  Leo         | onyx
  Virgo       | carnelian
  Libra       | chrysolite
  Scorpio     | beryl
  Sagittarius | topaz

=head1 FUNCTIONS

Date::Birth::ZodiacStone has two functions that need to be imported into your script: C<zodiac_stone> and C<zodiac_sign>.

=head2 zodiac_stone

C<zodiac_stone> has one required parameter, the zodiac sign in English. You can see the list above for the names of the zodiac signs.

  zodiac_stone($zodiac_sign);

=head2 zodiac_sign

C<zodiac_sign> has two required parameters, the month and day.

  zodiac_sign($month, $day);

=head3 month

The month is the full month name in English.

=head3 day

The day is the day of the month.

=head1 DEPENDENCIES

Date::Birth::ZodiacStone depends on L<String::Util> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena (C<aleena@cpan.org>). All rights reserved.

=cut

1;

__DATA__
Capricorn  |December |22|January  |20|ruby
Aquarius   |January  |21|February |19|garnet
Pisces     |February |20|March    |20|amethyst
Aries      |March    |21|April    |20|bloodstone
Taurus     |April    |21|May      |21|sapphire
Gemini     |May      |22|June     |21|agate
Cancer     |June     |22|July     |22|emerald
Leo        |July     |23|August   |22|onyx
Virgo      |August   |23|September|23|carnelian
Libra      |September|24|October  |23|chrysolite
Scorpio    |October  |24|November |22|beryl
Sagittarius|November |23|December |21|topaz