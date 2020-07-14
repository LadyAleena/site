package Date::Birth::ZodiacStone;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);
our @EXPORT_OK = qw(sign zodiac_stone);

use String::Util qw(trim);

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

=head1 NAME

B<Zodiac::Stone> returns the stone associated with zodiac signs.

=head1 SYNOPSIS

  my $zodiac_stone = zodiac_stone('Cancer');
  # emerald

=head1 DESCRIPTION

C<zodiac_stone> is exported by default and returns the stone associated with the sign entered.

If you do not know your zodiac sign, you can use C<sign> to determine your sign using your birth month and day.

=head1 AUTHOR

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