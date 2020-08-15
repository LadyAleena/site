package Date::Birth::Flower;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use String::Util qw(trim);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(birth_flower);

my $flowers;
my $month_number;
while (my $line = <DATA>) {
  chomp($line);
  my ($month, $us_flower, $bi_flower) = split(/\|/, $line);
  $month = trim($month);

  ++$month_number;
  $flowers->{$month_number}{US} = trim($us_flower);
  $flowers->{$month_number}{UK} = trim($bi_flower);

  $flowers->{$month}{US} = trim($us_flower);
  $flowers->{$month}{UK} = trim($bi_flower);
}

sub birth_flower {
  my ($month, $country) = @_;
  return $flowers->{$month}{$country};
}

=pod

=encoding utf8

=head1 NAME

B<Date::Birth::Flower> returns the birth flower associated with months.

=head1 VERSION

This document describes Date::Birth::Flower version 1.0.

=head1 SYNOPSIS

  use Date::Birth::Flower qw(birth_flower);

  my $birth_flower = birth_flower('July', 'US');
  # water lily or delphinium

=head1 DESCRIPTION

Date::Birth::Flower returns the birth flower associated with months when you use C<birth_flower>. C<birth_flower> needs to be imported into your script. It returns the birth flower associated with the month and country entered. There are currently only two countries with birth flowers, the US and the UK, as far as I know.

Date::Birth::Flower requires Perl version 5.10.0 or better to run.

=head2 The flowers

  Month     | US flower(s)                    | UK flower(s)
  ----------|---------------------------------|------------------------
  January   | carnation or snowdrop           | carnation
  February  | primrose                        | violet or iris
  March     | daffodil                        | daffodil
  April     | sweat pea                       | sweat pea or daisy
  May       | hawthorne or lily of the valley | lily of the valley
  June      | rose or honeysuckle             | rose
  July      | water lily or delphinium        | larkspur
  August    | poppy or gladiolus              | gladiolus
  September | morning glory or aster          | aster or forget-me-not
  October   | calendula or marigold           | marigold
  November  | chrysanthemum or peony          | chrysanthemum
  December  | holly or Narcissus              | poinsettia

=head1 USAGE

C<birth_flower> has two required parameters, the month and the country.

  birth_flower($month, $country);

=head2 month

The month can be the digits 1 through 12 or the full month name in English.

=head2 country

The country can either be C<US> for United States or C<UK> for the United Kingdom.

=head1 DEPENDENCIES

Date::Birth::Flower depends on L<String::Util> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena (C<aleena@cpan.org>). All rights reserved.

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
December |holly or Narcissus             |poinsettia