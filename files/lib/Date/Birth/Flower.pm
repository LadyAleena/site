package Date::Birth::Flower;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);
our @EXPORT = qw(birth_flower);

use String::Util qw(trim);

my $flowers;
while (<DATA>) {
  chomp($_);
  my ($month, $us_flower, $bi_flower) = split(/\|/, $_);
  $month = trim($month);

  $flowers->{$month}{US} = trim($us_flower);
  $flowers->{$month}{UK} = trim($bi_flower);
}

sub birth_flower {
  my ($month, $country) = @_;
  return $flowers->{$month}{$country};
}

=head1 NAME

B<Date::Birth::Flower> returns the birth flower associated with months.

=head1 SYNOPSIS

  my $birth_flower = birth_flower('July', 'US');
  # water lily or delphinium

=head1 DESCRIPTION

C<birth_flower> is exported by default and returns the birth flower associated with the month and country entered. There are currently only two countries with birth flowers, the US and the UK, as far as I know.

=head1 AUTHOR

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