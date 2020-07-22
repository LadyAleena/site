package Random::RPG::SpecialAttack;
use v5.10.0;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand tiny_rand);
use Fancy::Join::Defined qw(join_defined);
use Random::SpecialDice qw(random_die);
use Random::Time qw(random_frequency);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_attack random_special_attack);

my %special_attacks = (
  'gaze' => [qw(paralysis stone stun death)],
  'part' => [qw(acid cold electricity fire)],
  'range part' => [qw(gas sonic)],
  'touch part' => ['poison','energy drain'],
  'touch special' => [qw(befouls purifies), glob q({creates,destroys}\ {,un}holy\ water)],
  'vocal' => [qw(deafen fear terror flight)],
);
$special_attacks{$_} = [@{$special_attacks{'part'}}, @{$special_attacks{"$_ part"}}] for ('range','touch');

sub random_attack {
  my ($user_attack, $user_additions) = @_;
  my $special_attack = fancy_rand(\%special_attacks, $user_attack, { caller => 'random_attack', additions => $user_additions ? $user_additions : undef });
  return $special_attack;
}

sub random_special_attack {
  my @attacks = qw(range gaze touch vocal);
  my $rand_attack = tiny_rand(@attacks);
  my $attack = $rand_attack ne 'range' ? "$rand_attack attack" : 'breath weapon';

  my $effect = random_attack($rand_attack);
  my $damage = $rand_attack =~ /(range|touch)/ ? 'for '.random_die.' damage' : undef;
  my $freqency = random_frequency;

  return "$attack - ".join_defined(' ', ($effect, $damage, $freqency));
}

=pod

=encoding utf8

=head1 Random::RPG::SpecialAttack

B<Random::RPG::SpecialAttack> selects random special attacks based on I<Advanced Dungeons & Dragons>, Second Edition.

=head2 Version

This document describes Random::RPG::SpecialAttack version 1.000.

=head2 Synopsis

  use Random::RPG::SpecialAttack qw(random_special_attack);

=head2 Dependencies

Random::RPG::SpecialAttack depends on <Fancy::Rand>, L<Fancy::Join::Defined>, L<Random::SpecialDice>, L<Random::Time>, and L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;