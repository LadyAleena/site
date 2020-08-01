package Random::RPG::Misc;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(
  random_RPG_misc
  random_divinity
  random_henchmen
  random_language_common
  random_proficiency_type
);

my %misc = (
  'divinity'         => [map("${_}power",('demi-', 'lesser ', 'intermediate ', 'greater '))],
  'henchmen'         => [qw(friends servants minions slaves mercenaries)],
  'language common'  => [map("$_ common", qw(beholder dragon dwarven elven faerie giant gnome goblinoid halfling human planar))],
  'proficiency type' => ['weapon', 'non-weapon proficiency', 'language'],
);

sub random_RPG_misc {
  my ($user_misc, $user_additions) = @_;
  my $misc = fancy_rand(\%misc, $user_thing, { caller => 'random_misc', additions => $user_additions ? $user_additions : undef });
  return $misc;
}

sub random_divinity         { my $user_addition = shift; random_RPG_misc('divinity'        , $user_addition) }
sub random_henchmen         { my $user_addition = shift; random_RPG_misc('henchmen'        , $user_addition) }
sub random_language_common  { my $user_addition = shift; random_RPG_misc('language common' , $user_addition) }
sub random_proficiency_type { my $user_addition = shift; random_RPG_misc('proficiency type', $user_addition) }

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::Misc> selects random miscellaneous things related to AD&D role-playing games.

=head1 VERSION

This document describes Random::RPG::Misc version 1.000.

=head1 SYNOPSIS

  use Random::RPG::Misc qw(
    random_RPG_misc
    random_divinity
    random_henchmen
    random_language_common
    random_proficiency_type
  );

  my $rpg_misc         = random_RPG_misc;         # selects a random AD&D misc
  my $divinity         = random_divinity;         # selects a random A&D divinity
  my $henchmen         = random_henchmen;         # selects random AD&D henchmen
  my $language_common  = random_language_common;  # selects a random AD&D common language
  my $proficiency_type = random_proficiency_type; # selects a random AD&D proficiency type

=head1 DESCRIPTION

Random::RPG::Misc is a catch all for AD&D role-playing game lists that can not be classified as anything else. All of the functions must be imported into your script.

It requires Perl version 5.10.0 or better.

=head2 random_RPG_misc

 random_RPG_misc();

=head3 Options

=head4 nothing, all, or undef

  random_RPG_misc();
  random_RPG_misc('all');
  random_RPG_misc(undef);

These options will select any value in any list. You can read the options below to see all of the potential values.

=head4 divinity

  random_RPG_misc('divinity');

The C<divinity> option will select from demi-power, lesser power, intermediate power, and greater power.

=head4 henchmen

  random_RPG_misc('henchmen');

The C<henchmen> option will select from friends, servants, minions, slaves, and mercenaries.

=head4 language common

  random_RPG_misc('language common');

The C<language common> option will select from beholder common, dragon common, dwarven common, elven common, faerie common, giant common, gnome common, goblinoid common, halfling common, human common, and planar common.

=head4 proficiency type

  random_RPG_misc('proficiency type');

The C<profiency type> option will select from weapon, non-weapon proficiency, and language.

=head4 by keys

  random_RPG_misc('by keys');

The C<by keys> option will select a random key listed above.

=head4 keys

  random_RPG_misc('keys');

The C<keys> option will list all of the available keys in an array reference.

=head4 data

  random_RPG_misc('data');

The C<data> option will return the data used in a hash reference.

=head4 help or options

  random_RPG_misc('help');
  random_RPG_misc('options');

The C<help> and C<options> options will return a list of all of your options.

=head3 Adding items to a list

  my @additions = ('misc 1', 'misc 2');
  random_RPG_misc('<your option>', \@additions);

You can add items to the list by adding an array reference with the additional items as the second parameter.

=head2 Specific functions

The following functions are shortcuts to the some of the options above. You can add items to the list by adding an array reference with the additional items as the first parameter in the following functions. If you want to add additional divinities in C<random_divinity>, you would do the following:

  my @divinity_additions = ('under power', 'superpower');
  random_divinity(\@divinity_additions);

=head3 random_divinity

 random_divinity();

C<random_divinity> is the same using L</divinity> in C<random_RPG_misc>.

=head3 random_henchmen

 random_henchmen();

C<random_henchmen> is the same using L</henchmen> in C<random_RPG_misc>.

=head3 random_language_common

 random_language_common();

C<random_language_common> is the same using L</language common> in C<random_RPG_misc>.

=head3 random_proficiency_type

 random_proficiency_type();

C<random_proficiency_type> is the same using L</proficiency type> in C<random_RPG_misc>.

=head1 DEPENDENCIES

Random::RPG::Misc depends on L<Fancy::Rand> and L<Exporter>.

=head1 NOTE

Random::RPG::Misc will be very fluid between versions. Items will be added to the lists. New lists will be added. Current lists can be moved into their own modules for better grouping should other similar lists be found.

=head1 SEE ALSO

L<Random::Misc> and L<Random::Thing>

=head1 AUTHOR

Lady Aleena

=cut

1;