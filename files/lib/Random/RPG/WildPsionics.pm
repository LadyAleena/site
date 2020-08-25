package Random::RPG::WildPsionics;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);
use Lingua::EN::Inflect qw(PL_N);
use List::Util qw(uniq);
use Text::CSV qw(csv);

use Page::File qw(file_directory);
use Fancy::Rand qw(tiny_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_wild_psionic_talent);

# When adding PSPS, it is the initial cost + (maintenance * 4) for each talent.
my $psps_dir     = file_directory('Role_playing/Classes/Psionics', 'data');
my $psps_fn      = "$psps_dir/powers.txt";
my $psps_headers = ['power', 'initial cost', 'maintenance cost'];
my $psps = csv(
  in      => $psps_fn,
  headers => $psps_headers,
  key     => $psps_headers->[0],
  sep_char         => '|',
  quote_char       => undef,
  blank_is_undef   => 1,
  empty_is_undef   => 1,
  allow_whitespace => 1,
);

my %devotions = (
   '1' => 'all-round vision',
   '2' => 'combat mind',
   '3' => 'danger sense',
   '4' => 'feel light',
   '5' => 'feel sound',
   '6' => 'hear light',
   '7' => 'know direction',
   '8' => 'know location',
   '9' => 'poison sense',
  '10' => 'radial navigation',
  '11' => 'see sound',
  '12' => 'spirit sense',
  '15' => 'animate object',
  '16' => 'animate shadow',
  '17' => 'ballistic attack',
  '18' => 'control body',
  '19' => 'control flames',
  '20' => 'control light',
  '21' => 'control sound',
  '22' => 'reroll',
  '23' => 'absorb disease',
  '24' => 'adrenaline control',
  '25' => 'aging',
  '26' => 'biofeedback',
  '27' => 'body control',
  '28' => 'body equilibrium',
  '29' => 'body weaponry',
  '30' => 'catfall',
  '31' => 'cause decay',
  '32' => 'cell adjustment',
  '33' => 'chameleon power',
  '34' => 'chemical simulation',
  '35' => 'displacement',
  '36' => 'double path',
  '37' => 'enhanced strength',
  '38' => 'ectoplasmic form',
  '39' => 'expansion',
  '40' => 'flesh armor',
  '41' => 'graft weapon',
  '42' => 'heightened senses',
  '43' => 'immovability',
  '44' => 'lend health',
  '45' => 'mind over body',
  '46' => 'reduction',
  '47' => 'share strength',
  '48' => 'suspend animation',
  '50' => 'attraction',
  '51' => 'aversion',
  '52' => 'awe',
  '53' => 'conceal thoughts',
  '54' => 'daydream',
  '55' => 'empathy',
  '56' => 'esp',
  '57' => 'false sensory input',
  '58' => 'identity penetration',
  '59' => 'incarnation awareness',
  '60' => 'inflict pain',
  '61' => 'invisible foes',
  '62' => 'invisibility',
  '63' => 'life detection',
  '64' => 'mind bar',
  '65' => 'phobia amplification',
  '66' => 'post-hypnotic suggestion',
  '67' => 'psychic impersonations',
  '68' => 'psychic messenger',
  '69' => 'repugnance',
  '70' => 'send thought',
  '71' => 'sight link',
  '72' => 'sound link',
  '73' => 'synaptic static',
  '74' => 'taste link',
  '75' => 'telempathic projections',
  '76' => 'truthear',
  '79' => 'astral projection',
  '80' => 'dimensional door',
  '81' => 'dimension walk',
  '82' => 'dream travel',
  '83' => 'time shift',
  '84' => 'time/space anchor',
);
$devotions{$_} = sub { my @array = (1..12);  my $num = $array[rand @array]; return $devotions{$num} } for 13..14;
$devotions{$_} = sub { my @array = (15..21); my $num = $array[rand @array]; return $devotions{$num} } for 22;
$devotions{$_} = sub { my @array = (23..48); my $num = $array[rand @array]; return $devotions{$num} } for 49;
$devotions{$_} = sub { my @array = (50..76); my $num = $array[rand @array]; return $devotions{$num} } for 77..78;
$devotions{$_} = sub { my @array = (79..84); my $num = $array[rand @array]; return $devotions{$num} } for 85;
$devotions{$_} = sub { random_psionic_devotion(2) } for 86..87;
$devotions{$_} = sub { random_psionic_devotion(3) } for 88..89;
$devotions{$_} = sub { random_psionic_devotion(4) } for 90;
$devotions{$_} = sub { random_psionic_science(1)  } for 91..99;
$devotions{$_} = sub { join(', ',(random_psionic_science(1), random_psionic_devotion(1))) } for 100;

my %sciences;
$sciences{$_} = 'aura sight'     for 1..2;
$sciences{$_} = 'clairaudience'  for 3..4;
$sciences{$_} = 'clairvoyance'   for 5..6;
$sciences{$_} = 'object reading' for 7..8;
$sciences{$_} = 'precognition'   for 9..10;
$sciences{$_} = 'sensitivity to psychic impressions' for 11..12;
$sciences{$_} = sub { my @array = (1..12);  my $num = $array[rand @array]; return $sciences{$num} } for 13..16;
$sciences{$_} = 'detonate'               for 17..18;
$sciences{$_} = 'disintegrate'            for 19..20;
$sciences{$_} = 'molecular rearrangement' for 21..22;
$sciences{$_} = 'project force'           for 23..24;
$sciences{$_} = 'telekinesis'             for 25..26;
$sciences{$_} = sub { my @array = (17..26);  my $num = $array[rand @array]; return $sciences{$num} } for 27..30;
$sciences{$_} = 'animal affinity'         for 31..32;
$sciences{$_} = 'complete healing'        for 33..34;
$sciences{$_} = 'death field'             for 35..36;
$sciences{$_} = 'energy containment'      for 37..38;
$sciences{$_} = 'life draining'           for 39..40;
$sciences{$_} = 'metamorphosis'           for 41..42;
$sciences{$_} = 'shadow form'             for 43..44;
$sciences{$_} = sub { my @array = (31..44);  my $num = $array[rand @array]; return $sciences{$num} } for 45..48;
$sciences{$_} = 'domination'              for 49..50;
$sciences{$_} = 'fate link'               for 51..52;
$sciences{$_} = 'mass domination'         for 53..54;
$sciences{$_} = 'mindwipe'                for 55..56;
$sciences{$_} = 'probe'                   for 57..58;
$sciences{$_} = 'superior invisibility'   for 59..60;
$sciences{$_} = 'switch personality'      for 61..62;
$sciences{$_} = 'mindlink'                for 63..64;
$sciences{$_} = sub { my @array = (49..50);  my $num = $array[rand @array]; return $sciences{$num} } for 65..68;
$sciences{$_} = 'banishment'              for 69..70;
$sciences{$_} = 'probability travel'      for 71..72;
$sciences{$_} = 'summon planar creature'  for 73..74;
$sciences{$_} = 'teleport'                for 75..76;
$sciences{$_} = 'teleport other'          for 77..78;
$sciences{$_} = sub { my @array = (69..78);  my $num = $array[rand @array]; return $sciences{$num} } for 79..82;
$sciences{$_} = sub { random_psionic_science(2) } for 83..85;
$sciences{$_} = sub { random_psionic_science(3) } for 86..88;
$sciences{$_} = sub { tiny_rand(random_psionic_devotion(1), random_psionic_science(1)) }    for 89..92;
$sciences{$_} = sub { join(', ', (random_psionic_science(1), random_psionic_devotion(2))) } for 93..96;
$sciences{$_} = sub { join(', ', (random_psionic_science(1), random_psionic_devotion(3))) } for 97..99;
$sciences{$_} = sub { join(', ', (random_psionic_science(1), random_psionic_devotion(4))) } for 100;

my %prereqs = (
  'detonate' => ['telekinesis','molecular agitation'],
  'disintegrate' => ['telekinesis','soften'],
  'molecular rearrangement' => ['telekinesis','molecular manipulation'],
  'create sound' => ['telekinesis','control sound'],
  'summon planar energies' => ['summon planar creature'],
  'mass domination' => ['mindlink','contact','domination'],
  'probe' => ['esp','contact'],
  'psychic impersonation' => ['mindlink','probe'],
  'psychic clone' => ['clairaudience','psychic messenger'],
  'psionic sense' => ['telepathy'],
  'receptacle' => ['empower'],
  'retrospection' => ['convergence']
);
$prereqs{$_} = ['telekinesis'] for (
  'animate object', 'animate shadow', 'control body', 'control flames', 'control light', 'control sound',
  'control wind', 'create object', 'inertial barrier', 'levitation', 'molecular agitation', 'molecular manipulation',
  'project force', 'soften', 'psionic blast'
);
$prereqs{$_} = ['teleport'] for (
  'banishment', 'summon planar creature', 'teleport other', 'teleport trigger', 'time shift'
);
$prereqs{$_} = ['mindlink'] for (
  'psychic crush', 'tower of iron will', 'ego whip', 'intellect fortress', 'mental barrier', 'mind blank',
  'mind thrust', 'synaptic static', 'thought shield', 'truthear'
);
$prereqs{$_} = ['mindlink', 'contact'] for (
  'attraction', 'aversion', 'awe', 'daydream', 'domination', 'empathy', 'fate link', 'mindwipe', 'switch personality',
  'esp', 'false sensory input', 'id insinuation', 'identity penetration', 'incarnation awareness', 'inflict pain',
  'invincible foes', 'invisibility', 'phobia amplification', 'post-hypnotic suggestion', 'repugnance', 'send thoughts',
  'sight link', 'sound link', 'taste link', 'telempathic projection'
);
$prereqs{$_} = ['contact'] for ('mindlink', 'convergence');
$prereqs{$_} = ['telepathy', 'contact'] for ('psychic surgery', 'psychic drain');
$prereqs{$_} = ['psychic surgery'] for ('aura alteration', 'split personality');

sub random_psionic_devotion {
  my ($rolls) = @_;

  my @talents;
  for (1..$rolls) {
    my $roll = roll('1d100');
    my $rolled_talent = $devotions{$roll};
    my $talent = ref($rolled_talent) eq 'CODE' ? &$rolled_talent : $rolled_talent;
    push @talents, $talent;
    if ($prereqs{$talent}) {
      push @talents, @{$prereqs{$talent}};
    }
  }

  return join(', ',@talents);
}

sub random_psionic_science {
  my ($rolls) = @_;

  my @talents;
  for (1..$rolls) {
    my $roll = roll('1d100');
    my $rolled_talent = $sciences{$roll};
    my $talent = ref($rolled_talent) eq 'CODE' ? &$rolled_talent : $rolled_talent;
    push @talents, $talent;
    if ($prereqs{$talent}) {
      push @talents, @{$prereqs{$talent}};
    }
  }

  return join(', ',@talents);
}

sub random_wild_psionic_talent {
  my ($user_rolls) = @_;
  my $rolls = $user_rolls ? $user_rolls : 1;
  my @r_talents = split(/, /,random_psionic_devotion($rolls));

  my $lead = PL_N('wild psionic talent',scalar @r_talents);
  my $psp_total;
  for my $talent (@r_talents) {
    $psp_total += $psps->{$talent}{'initial cost'} ? $psps->{$talent}{'initial cost'} : 0;
    $psp_total += $psps->{$talent}{'maintenance cost'} ? $psps->{$talent}{'maintenance cost'} * 4 : 0;
  }

  my @talents = @r_talents ? uniq(@r_talents) : undef;
  return @talents ? "$lead: (PSPs: $psp_total) ".join(', ',sort @talents) : undef;
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::WildPsionics> selects random a wild psionic talent from I<Advanced Dungeons & Dragons>, Second Edition.

=head1 VERSION

This document describes Random::RPG::WildPsionics version 1.000.

=head1 SYNOPSIS

  use Random::RPG::WildPsionics qw(random_wild_psionic_talent);

  my $psionic_talent = random_wild_psionic_talent;

=head1 DESCRIPTION

Random::RPG::WildPsionics selects a wild psionic talent with all of its prerequisites and total amount of PSPs.

You can roll for more than one wild psionic talent:

  my $wild_talent = random_wild_psionic_talent(2);

That could return something like: C<wild psionic talents: (PSPs: 47) animate shadow, combat mind, telekinesis>

=head1 DEPENDENCIES

Random::RPG::WildPsionics depends on <Fancy::Rand>, Page::File, L<Games::Dice>, L<Lingua::EN::Inflect>, L<List::MoreUtils>, L<Text::CSV>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;