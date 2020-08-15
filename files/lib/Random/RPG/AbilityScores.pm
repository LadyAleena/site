package Random::RPG::AbilityScores;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_ability random_game_effect_expanded);

my %abilities = (
  'strength'     => ['Hit Probability','Damage Adjustment','Weight Allow','Maximum Press','Open Doors','Bend Bars/Lift Gates'],
  'dexterity'    => ['Surprise Reaction Adjustment','Missile Attack Adjustment','Defensive Adjustment'],
  'constitution' => ['Hit Point Adjustment','System Shock','Resurrection Survival','Poison Save','Regeneration'],
  'intelligence' => ['# of Languages','Spell Level','Chance to Learn Spell','Maximum # of Spells/Lvl','Illusion Immunity'],
  'wisdom'       => ['Magical Defense Adjustment','Bonus Spells','Chance of Spell Failure','Spell Immunity'],
  'charisma'     => ['Maximum # of Henchmen','Loyalty Base','NPC Reaction Adjustment'],
);

sub random_ability {
  my ($user_ability, $user_additions) = @_;
  my $random_ability = fancy_rand(\%abilities, $user_ability, { caller => 'random_ability', additions => $user_additions ? $user_additions : undef });
  return $random_ability;
}

sub random_game_effect_expanded {
  my $ability = random_ability('by keys');
  my $game_effect = lc random_ability($ability);
  return qq{$game_effect <small>($ability)</small>};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::AbilityScores> selects random ability scores and their game effects from I<Advanced Dungeons & Dragons>, Second Edition.

=head1 VERSION

This document describes Random::RPG::AbilityScores version 1.000.

=head1 SYNOPSIS

  use Random::RPG::AbilityScores qw(random_ability);

=head1 DEPENDENCIES

Random::RPG::AbilityScroes depends on L<Fancy::Rand> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;