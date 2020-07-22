package Random::RPG::Class;
use v5.10.0;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);

use Lingua::EN::Inflect qw(PL_N);

use Fancy::Rand qw(fancy_rand tiny_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_class random_class_special);

my %classes = (
  'warrior'    => ['fighter', 'paladin', 'ranger'],
  'rogue'      => ['thief', 'bard'],
  'priest'     => ['cleric', 'priest', 'druid', 'shaman'],
  'wizard'     => ['mage', 'wizard'],
  'psionisist' => ['psionisist'],
);

my %class_specials_info = (
  'warrior' => 'attacks',
  'thief'   => 'backstabs',
  'priest'  => 'turns undead',
  'wizard'  => 'creates magic items'
);

my @class_specials = (map(
  "$class_specials_info{$_} as a $_ of the same level. If already a $_, $class_specials_info{$_} at 1 level higher.",
  keys %class_specials_info
));

sub random_class {
  my ($user_class, $user_additions) = @_;
  my $class = fancy_rand(\%classes, $user_class, { caller => 'random_class', additions => $user_additions ? $user_additions : undef });
  return $class;
}

sub random_class_special {
  return tiny_rand(@class_specials);
}

=pod

=encoding utf8

=head1 Random::RPG::Classes

B<Random::RPG::Classes> selects random adventurer classes from I<Advanced Dungeons & Dragons>, Second Edition.

=head2 Version

This document describes Random::RPG::Class version 1.000.

=head2 Synopsis

  use Random::RPG::Class qw(random_class random_class_special);

=head2 Dependencies

Random::RPG::Class depends on L<Fancy::Rand>, L<Lingua::EN::Inflect>, and L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;