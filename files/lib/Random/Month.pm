package Random::Month;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);
our @EXPORT_OK = qw(random_month);

use Date::Calc qw(Month_to_Text);

use Fancy::Rand qw(fancy_rand);

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
);
# I wrote this hash for another reason, but Date::Calc killed the need for the original purpose.

sub random_month {
  my ($user_language, $user_additions) = @_;
  my $random_month = fancy_rand(\%months, $user_language, { caller => 'random_month', additions => $user_additions ? $user_additions : undef });
  return $random_month;
}

=head1 NAME

B<Random::Month> selects a random month by language.

=head1 SYNOPSIS

  use Random::Month qw(random_month);

  my $random_month = random_month();
  my $random_English_month = random_month('English');
  my $random_Dutch_month   = random_month('Dutch');
  my $random_French_month  = random_month('French');
  my $random_German_month  = random_month('German');
  my $random_Greek_month   = random_month('Greek');
  my $random_Italian_month = random_month('Italian');
  my $random_Spanish_month = rnadom_month('Spanish');

  print random_month('help') # get random_month options

=head1 DEPENDENCIES

Random::Month depends on L<Fancy::Rand> and L<Date::Calc>.

=head1 AUTHOR

Lady Aleena

=cut

1;