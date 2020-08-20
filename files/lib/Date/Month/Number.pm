package Date::Month::Number;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(month_number);

my %month_names = (
  'English'      => [qw(January February March April May June July August September October November December)],
  'English abbr' => [qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Now Dec)],
  'Danish'       => [qw(januar februar marts april maj juni juli august september oktober november december)],
  'Dutch'        => [qw(januari februari maart april mei juni juli augustus september oktober november december)],
  'Finnish'      => [qw(tammikuu helmikuu maaliskuu huhtikuu toukokuu kesäkuu heinäkuu elokuu syyskuu lokakuu marraskuu joulukuu)],
  'French'       => [qw(janvier février mars avril mai juin juillet août septembre octobre novembre décembre)],
  'German'       => [qw(Januar Februar März April Mai Juni Juli August September Oktober November Dezember)],
  'Greek'        => [qw(Ianuários Fevruários Mártios Aprílios Máios Iúnios Iúlios Avghustos Septémvrios Októvrios Noémvrios Thekémvrios)],
  'Hungarian'    => [qw(Január Február Március Április Május Június Július Augusztus Szeptember Október November December)],
  'Italian'      => [qw(gennaio febbraio marzo aprile maggio giugno luglio agosto settembre ottobre novembre dicembre)],
  'Norwegian'    => [qw(januar februar mars april mai juni juli august september oktober november desember)],
  'Polish'       => [qw(Styczen Luty Marzec Kwiecien Maj Czerwiec Lipiec Sierpien Wrzesien Pazdziernik Listopad Grudzien)],
  'Portuguese'   => [qw(janeiro fevereiro março abril maio junho julho agosto setembro outubro novembro dezembro)],
  'Romanian'     => [qw(Ianuarie Februarie Martie Aprilie Mai Iunie Iulie August Septembrie Octombrie Noiembrie Decembrie)],
  'Russian'      => [qw(Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь)],
  'Spanish'      => [qw(enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre)],
  'Swedish'      => [qw(januari februari mars april maj juni juli augusti september oktober november december)],
);

my %months;
for my $language (keys %month_names) {
  my $number = 0;
  $months{lc $_} = ++$number for @{$month_names{$language}};
}

sub month_number {
  my $month = lc shift;
  return $months{$month};
}

=pod

=encoding utf8

=head1 NAME

B<Date::Month::Number> returns the number for a month.

=head1 VERSION

This document describes Date::Month::Number version 1.0.

=head1 SYNOPSIS

  use Date::Month::Number qw(month_number);

  my $month_number = month_number('July');
  # 7

=head1 DESCRIPTION

Date::Month::Number returns the number of the month entered. The languages supported are English and the English abbreviations, Danish, Dutch, Finnish, French, German, Greek, Hungarian, Italian, Norwegian, Polish, Portuguese, Romanian, Russian, Spanish, and Swedish.

=head1 DEPENDENCY

Date::Month::Number depends on L<Exporter>.

=head1 NOTE

L<Date::Calc> can also return the month number using C<Decode_Month> except Greek and Russian.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;
