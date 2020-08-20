package Random::Month;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Date::Calc qw(Month_to_Text);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_month);

my %months = (
  'English'      => [map(Month_to_Text($_,  1),(1..12))],
  'en'           => [map(Month_to_Text($_,  1),(1..12))],

  'French'       => [map(Month_to_Text($_,  2),(1..12))],
  'français'     => [map(Month_to_Text($_,  2),(1..12))],
  'fr'           => [map(Month_to_Text($_,  2),(1..12))],

  'German'       => [map(Month_to_Text($_,  3),(1..12))],
  'Deutsch'      => [map(Month_to_Text($_,  3),(1..12))],
  'de'           => [map(Month_to_Text($_,  3),(1..12))],

  'Spanish'      => [map(Month_to_Text($_,  4),(1..12))],
  'Español'      => [map(Month_to_Text($_,  4),(1..12))],
  'es'           => [map(Month_to_Text($_,  4),(1..12))],

  'Portuguese'   => [map(Month_to_Text($_,  5),(1..12))],
  'Português'    => [map(Month_to_Text($_,  5),(1..12))],
  'pt'           => [map(Month_to_Text($_,  5),(1..12))],

  'Dutch'        => [map(Month_to_Text($_,  6),(1..12))],
  'Nederlands'   => [map(Month_to_Text($_,  6),(1..12))],
  'nl'           => [map(Month_to_Text($_,  6),(1..12))],

  'Italian'      => [map(Month_to_Text($_,  7),(1..12))],
  'Italiano'     => [map(Month_to_Text($_,  7),(1..12))],
  'it'           => [map(Month_to_Text($_,  7),(1..12))],

  'Norwegian'    => [map(Month_to_Text($_,  8),(1..12))],
  'Norsk bokmål' => [map(Month_to_Text($_,  8),(1..12))],
  'nb'           => [map(Month_to_Text($_,  8),(1..12))],

  'Swedish'      => [map(Month_to_Text($_,  9),(1..12))],
  'svenska'      => [map(Month_to_Text($_,  9),(1..12))],
  'sv'           => [map(Month_to_Text($_,  9),(1..12))],

  'Danish'       => [map(Month_to_Text($_, 10),(1..12))],
  'dansk'        => [map(Month_to_Text($_, 10),(1..12))],
  'da'           => [map(Month_to_Text($_, 10),(1..12))],

  'Finnish'      => [map(Month_to_Text($_, 11),(1..12))],
  'suomi'        => [map(Month_to_Text($_, 11),(1..12))],
  'fi'           => [map(Month_to_Text($_, 11),(1..12))],

  'Hungarian'    => [map(Month_to_Text($_, 12),(1..12))],
  'magyar'       => [map(Month_to_Text($_, 12),(1..12))],
  'hu'           => [map(Month_to_Text($_, 12),(1..12))],

  'Polish'       => [map(Month_to_Text($_, 13),(1..12))],
  'język polski' => [map(Month_to_Text($_, 13),(1..12))],
  'pl'           => [map(Month_to_Text($_, 13),(1..12))],

  'Romanian'     => [map(Month_to_Text($_, 14),(1..12))],
  'Română'       => [map(Month_to_Text($_, 14),(1..12))],
  'ro'           => [map(Month_to_Text($_, 14),(1..12))],

  'Greek'        => [qw(Ianuários Fevruários Mártios Aprílios Máios Iúnios Iúlios Avghustos Septémvrios Októvrios Noémvrios Thekémvrios)],
  'el'           => [qw(Ianuários Fevruários Mártios Aprílios Máios Iúnios Iúlios Avghustos Septémvrios Októvrios Noémvrios Thekémvrios)],

  'Russian'      => [qw(Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь)],
  'ru'           => [qw(Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь)],
);
# I wrote this hash for another reason, but Date::Calc killed the need for the original purpose.

sub random_month {
  my ($user_language, $user_additions) = @_;
  my $random_month = fancy_rand(\%months, $user_language, { caller => 'random_month', additions => $user_additions ? $user_additions : undef });
  return $random_month;
}

=pod

=encoding utf8

=head1 NAME

B<Random::Month> returns a random month by language.

=head1 VERSION

This document describes Random::Month version 1.000.

=head1 SYNOPSIS

  use Random::Month qw(random_month);

  my $random_month            = random_month();
  my $random_English_month    = random_month('English');
  my $random_Danish_month     = random_month('Danish');
  my $random_Dutch_month      = random_month('Dutch');
  my $random_Finnish_month    = random_month('Finnish');
  my $random_French_month     = random_month('French');
  my $random_German_month     = random_month('German');
  my $random_Greek_month      = random_month('Greek');
  my $random_Hungarian_month  = random_month('Hungarian');
  my $random_Italian_month    = random_month('Italian');
  my $random_Norwegian_month  = random_month('Norwegian');
  my $random_Polish_month     = random_month('Polish');
  my $random_Portuguese_month = random_month('Portuguese');
  my $random_Romanian_month   = random_month('Romanian');
  my $random_Spanish_month    = rnadom_month('Spanish');
  my $random_Swedish_month    = random_month('Swedish');

  print random_month('help') # get random_month options

=head1 DESCRIPTION

Random::Month returns a random month by language with C<random_month>. All of the lanauge options are generated by C<Month_to_Text> from L<Date::Calc> except Greek.

=head2 Options

=head4 nothing, all, or undef

  random_month;
  random_month();
  random_month('all');
  random_month(undef);

These options will return any value in any list. You can read the options below to see all of the potential values.

=head4 English or en

  random_month('English');
  random_month('en');

The C<English> or C<en> options return January, February, March, April, May, June, July, August, September, October, November, or December.

=head4 Danish, dansk, or da

  random_month('Danish');
  random_month('dansk');
  random_month('da');

The C<Danish>, C<dansk>, or C<da> options return januar, februar, marts, april, maj, juni, juli, august, september, oktober, november, or december.

=head4 Dutch, Nederlands, or nl

  random_month('Dutch');
  random_month('Nederlands');
  random_month('nl');

The C<Dutch>, C<Nederlands>, or C<nl> options return januari, februari, maart, april, mei, juni, juli, augustus, september, oktober, november, or december.

=head4 Finnish, suomi, or fi

  random_month('Finnish');
  random_month('suomi');
  random_month('fi');

The C<Finnish>, C<suomi>, or C<fi> options return tammikuu, helmikuu, maaliskuu, huhtikuu, toukokuu, kesäkuu, heinäkuu, elokuu, syyskuu, lokakuu, marraskuu, or joulukuu.

=head4 French, français, or fr

  random_month('French');
  random_month('français');
  random_month('fr');

The C<French>, C<français>, or C<fr> options return janvier, février, mars, avril, mai, juin, juillet, août, septembre, octobre, novembre, or décembre.

=head4 German, Deutsch, or de

  random_month('German');
  random_month('Deutsch');
  random_month('de');

The C<German>, C<Deutsch>, or C<de> options return Januar, Februar, März, April, Mai, Juni, Juli, August, September, Oktober, November, or Dezember.

=head4 Greek or el

  random_month('Greek');
  random_month('el');

The C<Greek> or C<el> options return Ianuários, Fevruários, Mártios, Aprílios, Máios, Iúnios, Iúlios, Avghustos, Septémvrios, Októvrios, Noémvrios, or Thekémvrios.

=head4 Hungarian, magyar, or hu

  random_month('Hungarian');
  random_month('magyar');
  random_month('hu');

The C<Hungarian>, C<magyar>, or C<hu> options return Január, Február, Március, Április, Május, Június, Július, Augusztus, Szeptember, Október, November, or December.

Date::Calc incorrectly capitalizes the month names.

=head4 Italian, Italiano, or it

  random_month('Italian');
  random_month('Italiano');
  random_month('it');

The C<Italian>, C<Italiano>, or C<it> options return Gennaio, Febbraio, Marzo, Aprile, Maggio, Giugno, Luglio, Agosto, Settembre, Ottobre, Novembre, or Dicembre.

=head4 Norwegian, Norsk bokmål, or nb

  random_month('Norwegian');
  random_month('Norsk bokmål');
  random_month('nb');

The C<Norwegian>, C<Norsk bokmål>, or C<nb> options return januar, februar, mars, april, mai, juni, juli, august, september, oktober, november, or desember.

=head4 Polish, język polski, or pl

  random_month('Polish');
  random_month('język polski');
  random_month('pl');

The C<Polish>, C<język polski>, or C<pl> options return Styczen, Luty, Marzec, Kwiecien, Maj, Czerwiec, Lipiec, Sierpien, Wrzesien, Pazdziernik, Listopad, or Grudzien.

=head4 Portuguese, Português, or pt

  random_month('Portuguese');
  random_month('Português');
  random_month('pt');

The C<Portuguese>, C<Português>, or C<pt> options return janeiro, fevereiro, março, abril, maio, junho, julho, agosto, setembro, outubro, novembro, or dezembro.

=head4 Romanian, Română, or ro

  random_month('Romanian');
  random_month('Română');
  random_month('ro');

The C<Romanian>, C<Română>, or C<ro> options return Ianuarie, Februarie, Martie, Aprilie, Mai, Iunie, Iulie, August, Septembrie, Octombrie, Noiembrie, or Decembrie.

=head4 Russian or ru

  random_month('Russian');
  random_month('ru');

The C<Russian> or C<ru> options return Январь, Февраль, Март, Апрель, Май, Июнь, Июль, Август, Сентябрь, Октябрь, Ноябрь, or Декабрь.
=head4 Spanish, Español, or es

  random_month('Spanish');
  random_month('Español');
  random_month('es');

The C<Spanish>, C<Español>, or C<es> options return enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, or diciembre.

=head4 Swedish, svenska, or sv

  random_month('Swedish');
  random_month('svenska');
  random_month('sv');

The C<Swedish>, C<svenska>, or C<sv> options return januari, februari, mars, april, maj, juni, juli, augusti, september, oktober, november, or december.

=head4 by keys

  random_month('by keys');

The C<by keys> option returns a random key listed above.

=head4 keys

  random_month('keys');

The C<keys> option will list all of the available keys in an array reference.

=head4 data

  random_month('data');

The C<data> option will return the data used in a hash reference.

=head4 help or options

  random_month('help');
  random_month('options');

The C<help> or C<options> options will return a list of all of your options.

=head3 Adding items to a list

You can add items to the list by adding an array reference with the additional items as the second parameter.

  my @additions = ('month 1', 'month 2');
  random_month('<your option>', \@additions);

=head1 DEPENDENCIES

Random::Month depends on L<Fancy::Rand>, L<Date::Calc>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;