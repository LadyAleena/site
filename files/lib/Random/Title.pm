package Random::Title;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);
our @EXPORT_OK = qw(random_title);

use Fancy::Rand qw(fancy_rand);

my %titles = (
  'noble male'   => [qw(emperor king prince archduke duke count viscount baron squire master lord)],
  'noble female' => [qw(empress queen princess archduchess duchess countess viscountess baroness dame mistress lady)],
  'military'     => [qw(marshal general colonel major captain lieutenant sergeant corporal private)],
  'naval'        => [qw(admiral captain commander lieutenant ensign seaman)],
  'government'   => [qw(president secretary senator governor director commissioner mayor administrator manager)],
);

sub random_title {
  my ($user_title, $user_additions) = @_;
  my $title = fancy_rand(\%titles, $user_title, { caller => 'random_title', additions => $user_additions ? $user_additions : undef });
  return $title;
}

=pod

=encoding utf8

=head1 NAME

B<Random::Title> selects random titles given to people.

=head1 SYNOPSIS

  use Random::Title qw(random_title);

  my $title            = random_title;
  # or
  my $title            = random_title('all');

  my $noble_male       = random_title('noble male');
    # selects from emperor, king, prince, archduke, duke, count,
    # viscount, baron, squire, master, and lord

  my $noble_female     = random_title('noble female');
    # selects from empress, queen, princess, archduchess, duchess,
    # countess, viscountess, baroness, dame, mistress, and lady

  my $military_rank    = random_title('military');
    # selects from marshal, general, colonel, major, captain,
    # lieutenant, sergeant, corporal, and private

  my $naval_rank       = random_title('naval');
    # selects from admiral, captain, commander, lieutenant,
    # ensign, and seaman

  my $government_title = random_title('government');
    # selects from president, secretary, senator, governor, director,
    # commissioner, mayor, administrator, and manager

  print random_title('help'); # get random_title options

=head1 DEPENDENCY

Random::Title depends on L<Fancy::Rand>.

=head1 AUTHOR

Lady Aleena

=cut

1;

# unused titles: grand duke/duchess; landgrave/landgravine; marquess, marquis/marchioness; burgrave/burgravine; earl; baronet; knight; knight bachelor