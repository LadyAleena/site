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
sub random_non                { my $user_addition = shift; random_misc('non'                , $user_addition) }
sub random_relationship       { my $user_addition = shift; random_misc('relationships'      , $user_addition) }
sub random_sexual_orientation { my $user_addition = shift; random_misc('sexual orientations', $user_addition) }
sub random_shadow             { my $user_addition = shift; random_misc('shadows'            , $user_addition) }
sub random_sign               { my $user_addition = shift; random_misc('signs'              , $user_addition) }
sub random_zstuff             { my $user_addition = shift; random_misc('zstuffs'            , $user_addition) }

=pod

=encoding utf8

=head1 NAME

B<Random::Misc> selects random miscellaneous things.

=head1 VERSION

This document describes Random::Misc version 1.000.

=head1 SYNOPSIS

  use Random::Misc qw(
    random_emotion
    random_game
    random_group
    random_non
    random_relationship
    random_sexual_orientation
    random_shadow
    random_sign
    random_zstuff
  );

  my $emotion            = random_emotion;            # selects a random emotion
  my $game               = random_game;               # selects a random type of game
  my $group              = random_group;              # selects a random group type
  my $non                = random_non;                # selects either an empty string or non
  my $relationship       = random_relationship;       # selects a random relationship status
  my $sexual_orientation = random_sexual_orientation; # selects a random sexual orientation
  my $shadow             = random_shadow;             # selects a random shadow
  my $sign               = random_sign;               # selects either a + or a -
  my $zstuff             = random_zstuff;             # selects random stuff

=head1 DESCRIPTION

Random::Misc is a catch all for lists that can not be classified as anything else. All of the functions must be imported into your script.

It requires Perl version 5.10.0 or better.

=head2 random_misc

=head3 Options

=head4 nothing, all, or undef

  random_misc();
  random_misc('all');
  random_misc(undef);

These options will select any value in any list. You can read the options below to see all of the potential values.

=head4 emotions

  random_misc('emotions');

The C<emotions> option will select from fear, hate, indifference, joy, love, sorrow, and trust.

=head4 games

  random_misc('games');

The C<games> option will select from board game, card game, role-playing game, and video game.

=head4 groups

  random_misc('groups');

The C<groups> option will select from group, band, cabal, tribe, caravan, and army.

=head4 non

  random_misc('non');

The C<non> option will select from non- and a zero-width string. This was written to make something a non- or not.

=head4 relationships

  random_misc('relationships');

The C<relationships> option will select from single, attached, dating, engaged, married, divorced, and widowed.

=head4 sexual orientations

  random_misc('sexual orientations');

The C<sexual orientations> option will select from heterosexual, heteroflexible, bisexual, homoflexible, homosexual, pansexual, polysexual, and asexual.

=head4 shadows

  random_misc('shadows');

The C<shadows> option will select from umbra, penumbra, and antumbra.

=head4 signs

  random_misc('signs');

The C<signs> option will select from + and -.

=head4 zstuffs

  random_misc('zstuffs');

The C<zstuffs> option will select from thing, doodad, doohickey, gizmo, widget, thingamabob, and stuff.

=head4 by keys

  random_misc('by keys');

The C<by keys> option will select a random key listed above.

=head4 keys

  random_misc('keys');

The C<keys> option will list all of the available keys in an array reference.

=head4 data

  random_misc('data');

The C<data> option will return the data used in a hash reference.

=head4 help or options

  random_misc('help');
  random_misc('options');

The C<help> and C<options> options will return a list of all of your options.

=head3 Adding items to a list

  my @additions = ('misc 1', 'misc 2');
  random_misc('<your option>', \@additions);

You can add items to the list by adding an array reference with the additional items as the second parameter.

=head2 Specific functions

The following functions are shortcuts to the some of the options above. You can add items to the list by adding an array reference with the additional items as the first parameter in the following functions. If you want to add additional emotions in C<random_emotions>, you would do the following:

  my @emotion_additions = ('agony', 'bliss');
  random_emotion(\@emotion_additions);

=head3 random_emotion

 random_emotion();

C<random_emotion> is the same using L</emotions> in C<random_misc>.

=head3 random_game

 random_game();

C<random_game> is the same using L</games> in C<random_misc>.

=head3 random_generation

 random_generation();

C<random_generation> is the same using L</generations> in C<random_misc>.

=head3 random_group

 random_group();

C<random_group> is the same using L</groups> in C<random_misc>.

=head3 random_non

 random_non();

C<random_non> is the same using L</non> in C<random_misc>.

=head3 random_parent

 random_parent();

C<random_parent> is the same using L</parents> in C<random_misc>.

=head3 random_relationship

 random_relationship();

C<random_relationship> is the same using L</relationships> in C<random_misc>.

=head3 random_sexual_orientation

 random_sexual_orientation();

C<random_sexual_orientation> is the same using L</sexual orientations> in C<random_misc>.

=head3 random_shadow

 random_shadow();

C<random_shadow> is the same using L</shadows> in C<random_misc>.

=head3 random_sign

 random_sign();

C<random_sign> is the same using L</signs> in C<random_misc>.

=head3 random_zstuff

 random_zstuff();

C<random_zstuff> is the same using L</zstuffs> in C<random_misc>.

=head1 DEPENDENCIES

Random::Misc depends on L<Fancy::Rand> and L<Exporter>.

=head1 NOTE

Random::Misc will be very fluid between versions. Items will be added to the lists. New lists will be added. Current lists can be moved into their own modules for better grouping should other similar lists be found.

=head1 SEE ALSO

L<Random::Thing>

=head1 AUTHOR

Lady Aleena

=cut

1;