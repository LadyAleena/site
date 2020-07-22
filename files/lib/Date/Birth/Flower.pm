package Date::Birth::Flower;
use v5.10.0;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);

use String::Util qw(trim);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(birth_flower);

my $flowers;
while (my $line = <DATA>) {
  chomp($line);
  my ($month, $us_flower, $bi_flower) = split(/\|/, $line);
  $month = trim($month);

  $flowers->{$month}{US} = trim($us_flower);
  $flowers->{$month}{UK} = trim($bi_flower);
}

sub birth_flower {
  my ($month, $country) = @_;
  return $flowers->{$month}{$country};
}

=pod

=encoding utf8

=head1 Date::Birth::Flower

B<Date::Birth::Flower> returns the birth flower associated with months.

=head2 Version

This document describes Date::Birth::Flower version 1.0.

=head2 Synopsis

  use Date::Birth::Flower qw(birth_flower);

  my $birth_flower = birth_flower('July', 'US');
  # water lily or delphinium

=head2 Description

C<birth_flower> is exported by default and returns the birth flower associated with the month and country entered. There are currently only two countries with birth flowers, the US and the UK, as far as I know.

=head2 Dependencies

Date::Birth::Flower depends on L<Exporter> and L<String::Util>.

=head2 Author

Lady Aleena

=cut

1;

__DATA__
January  |carnation or snowdrop          |carnation
February |primrose                       |violet or iris
March    |daffodil                       |daffodil
April    |sweat pea                      |sweat pea or daisy
May      |hawthorne or lily of the valley|lily of the valley
June     |rose or honeysuckle            |rose
July     |water lily or delphinium       |larkspur
August   |poppy or gladiolus             |gladiolus
September|morning glory or aster         |aster or forget-me-not
October  |calendula or marigold          |marigold
November |chrysanthemum or peony         |chrysanthemum
December |holly or Narcissus             |pionsetta