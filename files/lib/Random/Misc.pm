package Random::Misc;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(
  random_misc
  random_emotion
  random_game
  random_generation
  random_group
  random_mental_condition
  random_non
  random_parent
  random_relationship
  random_sexual_orientation
  random_shadow
  random_sign
  random_zstuff
);

my %misc = (
  'emotions'            => [qw(joy sorrow trust fear love hate indifference)],
  'games'               => [map("$_ game", ('board', 'card', 'role-playing', 'video'))],
  'groups'              => [qw(group band cabal tribe caravan army)],
  'mental conditions'   => [
                             map("${_}active", qw(hypo hyper)),
                             map("$_ psychosis", qw(hallucinatory delusional)),
                             'addiction', 'amnesia', 'anxiety', 'catatonia', 'dementia', 'fugue', 'manic', 'melancholy',
                             'obsessive-compulsive', 'panic', 'paranoia', 'schizophrenia', 'split personality'
                           ],
  'non'                 => ['', 'non-'],
  'relationships'       => [qw(single dating attached engaged married divorced widowed)],
  'sexual orientations' => [qw(heterosexual heteroflexible bisexual homoflexible homosexual pansexual polysexual asexual)],
  'shadows'             => [qw(umbra penumbra antumbra)],
  'signs'               => [qw(+ -)],
  'zstuffs'             => [qw(thing doodad doohickey gizmo widget thingamabob stuff)],
);

sub random_misc {
  my ($user_misc, $user_additions) = @_;
  my $misc = fancy_rand(\%misc, $user_misc, { caller => 'random_misc', additions => $user_additions ? $user_additions : undef });
  return $misc;
}

sub random_emotion            { my $user_addition = shift; random_misc('emotions'           , $user_addition) }
sub random_game               { my $user_addition = shift; random_misc('games'              , $user_addition) }
sub random_group              { my $user_addition = shift; random_misc('groups'             , $user_addition) }
sub random_mental_condition   { my $user_addition = shift; random_misc('mental conditions'  , $user_addition) }
sub random_non                { my $user_addition = shift; random_misc('non'                , $user_addition) }
sub random_relationship       { my $user_addition = shift; random_misc('relationships'      , $user_addition) }
sub random_sexual_orientation { my $user_addition = shift; random_misc('sexual orientations', $user_addition) }
sub random_shadow             { my $user_addition = shift; random_misc('shadows'            , $user_addition) }
sub random_sign               { my $user_addition = shift; random_misc('signs'              , $user_addition) }
sub random_zstuff             { my $user_addition = shift; random_misc('zstuffs'            , $user_addition) }

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
