package Random::Misc;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);
our @EXPORT_OK = qw(random_divinity random_emotion random_generation random_group random_henchmen random_language_common random_non random_parent
                    random_proficiency_type random_relationship random_sexual_orientation random_shadow random_sign random_zstuff);

use Fancy::Rand qw(fancy_rand);

my %misc = (
  'emotion'            => [qw(joy sorrow trust fear love hate indifference)],
  'game'               => [map("$_ game", ('board', 'card', 'role-playing', 'video'))],
  'generation'         => ['', 'grand', 'great-grand', 'ancestral '],
  'group'              => [qw(group band cabal tribe caravan army)],
  'non'                => ['', 'non-'],
  'parent'             => ['mother', 'father'],
  'relationship'       => [qw(single dating attached engaged married divorced widowed)],
  'sexual orientation' => [qw(heterosexual heteroflexible bisexual homoflexible homosexual pansexual polysexual asexual)],
  'shadow'             => [qw(umbra penumbra antumbra)],
  'sign'               => [qw(+ -)],
  'zstuff'             => ['things', 'doohickeys', 'widgets', 'thingamabobs', 'stuff'],

  'divinity'           => [map("${_}power",('demi-', 'lesser ', 'intermediate ', 'greater '))],
  'henchmen'           => [qw(friends servants minions slaves mercenaries)],
  'language common'    => [map("$_ common", qw(beholder dragon dwarven elven faerie giant gnome goblinoid halfling human planar))],
  'proficiency type'   => ['weapon', 'non-weapon proficiency', 'language'],
);

sub random_divinity           { fancy_rand(\%misc, 'divinity'          , { 'caller' => (caller(0))[3] }) }
sub random_emotion            { fancy_rand(\%misc, 'emotion'           , { 'caller' => (caller(0))[3] }) }
sub random_game               { fancy_rand(\%misc, 'game'              , { 'caller' => (caller(0))[3] }) }
sub random_generation         { fancy_rand(\%misc, 'generation'        , { 'caller' => (caller(0))[3] }) }
sub random_group              { fancy_rand(\%misc, 'group'             , { 'caller' => (caller(0))[3] }) }
sub random_henchmen           { fancy_rand(\%misc, 'henchmen'          , { 'caller' => (caller(0))[3] }) }
sub random_language_common    { fancy_rand(\%misc, 'language common'   , { 'caller' => (caller(0))[3] }) }
sub random_non                { fancy_rand(\%misc, 'non'               , { 'caller' => (caller(0))[3] }) }
sub random_parent             { fancy_rand(\%misc, 'parent'            , { 'caller' => (caller(0))[3] }) }
sub random_proficiency_type   { fancy_rand(\%misc, 'proficiency type'  , { 'caller' => (caller(0))[3] }) }
sub random_relationship       { fancy_rand(\%misc, 'relationship'      , { 'caller' => (caller(0))[3] }) }
sub random_sexual_orientation { fancy_rand(\%misc, 'sexual orientation', { 'caller' => (caller(0))[3] }) }
sub random_shadow             { fancy_rand(\%misc, 'shadow'            , { 'caller' => (caller(0))[3] }) }
sub random_sign               { fancy_rand(\%misc, 'sign'              , { 'caller' => (caller(0))[3] }) }
sub random_zstuff             { fancy_rand(\%misc, 'zstuff'            , { 'caller' => (caller(0))[3] }) }

=head1 NAME

B<Random::Misc> selects random miscellaneous things.

=head1 SYNOPSIS

  use Random::Misc qw(
    random_divinity
    random_emotion
    random_game
    random_generation
    random_group
    random_henchmen
    random_language_common
    random_non
    random_parent
    random_proficiency_type
    random_relationship
    random_sexual_orientation
    random_shadow
    random_sign
    random_zstuff
  );

  my $divinity           = random_divinity;           # selects a random A&D divinity
  my $emotion            = random_emotion;            # selects a random emotion
  my $game               = random_game;               # selects a random type of game
  my $generation         = random_generation;         # selects a random generation
  my $group              = random_group;              # selects a random group type
  my $henchmen           = random_henchmen;           # selects random AD&D henchmen
  my $language_common    = random_language_common;    # selects a random AD&D common language
  my $non                = random_non;                # selects either an empty string or non
  my $parent             = random_parent;             # selects a random parent, mother or father
  my $proficiency_type   = random_proficiency_type;   # selects a random AD&D proficiency type
  my $relationship       = random_relationship;       # selects a random relationship status
  my $sexual_orientation = random_sexual_orientation; # selects a random sexual orientation
  my $shadow             = random_shadow;             # selects a random shadow
  my $sign               = random_sign;               # selects either a + or a -
  my $zstuff             = random_zstuff;             # selects random stuff

=head1 DESCRIPTION

Random::Misc is a catch all for lists that can not be classified as anything else.

=head1 DEPENDENCY

Random::Misc depends on L<Fancy::Rand>.

=head1 SEE ALSO

L<Random::Things>

=head1 AUTHOR

Lady Aleena

=cut

1;