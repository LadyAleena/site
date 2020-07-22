package Date::Birth::ZodiacStone;
use v5.10.0;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);

use String::Util qw(trim);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(sign zodiac_stone);

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

sub sign {
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

=head1 Date::Birth::ZodiacStone

B<Date::Birth::ZodiacStone> returns the stone associated with zodiac signs.

=head2 Version

This document describes Date::Birth::ZodiacStone version 1.0.

=head2 Synopsis

  use Date::Birth::ZodiacStone qw(zodiac_stone);

  my $zodiac_stone = zodiac_stone('Cancer');
  # emerald

=head2 Description

C<zodiac_stone> is exported by default and returns the stone associated with the sign entered.

If you do not know your zodiac sign, you can use C<sign> to determine your sign using your birth month and day.

=head2 Dependencies

Date::Birth::ZodiacStone depends on L<Exporter> and L<String::Util>.

=head2 Author

Lady Aleena

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