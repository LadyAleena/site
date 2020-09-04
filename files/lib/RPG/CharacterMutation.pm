package RPG::CharacterMutation;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(random_mutations parent_knows);

use Games::Dice qw(roll);
use Lingua::EN::Inflect qw(PL_N A ORD);
use Lingua::EN::Inflexion qw(noun);
use List::Util qw(sum max);

use Fancy::Rand qw(tiny_rand);
use Fancy::Join::Defined qw(join_defined);
use Page::Convert qw(textify);

use Random::Body::Modification qw(random_body_modification random_body_color_change random_aura);
use Random::Body::Function qw(random_body_functions);
use Random::FamilyMember   qw(random_family_member);
use Random::Range          qw(random_range random_radius);
use Random::SpecialDice    qw(random_die);
use Random::Time           qw(random_time_unit random_frequency);
use Random::Thing          qw(random_thing random_animal);
use Random::Misc           qw(random_mental_condition random_sign);

use Random::RPG::AbilityScores  qw(random_ability random_game_effect_expanded);
use Random::RPG::Class          qw(random_class random_class_special);
use Random::RPG::Event          qw(random_event);
use Random::RPG::MagicItem      qw(random_magic_item random_magic_item_action);
use Random::RPG::Misc           qw(random_divinity random_language_common random_proficiency_type);
use Random::RPG::Monster        qw(random_monster);
use Random::RPG::SavingThrow    qw(random_saving_throw);
use Random::RPG::SpecialAttack  qw(random_attack random_special_attack);
use Random::RPG::Spell          qw(random_spell_casting random_spell_group random_spell_resistance);
use Random::RPG::Weapon         qw(random_weapon random_magic_weapon random_weapon_damage);
use Random::RPG::WildPsionics   qw(random_wild_psionic_talent);

# Note to anyone looking at this code.
# This is not pretty. The code to make this random generator sometimes is extremely messy.
# So, if you come up with a way to make a part of this code prettier,
# let me know in an issue on GitHub.
# Much of this is awful to look at, you have been warned.

# I already have random_thing and random_misc, so this got named random_stuff.
# This was done to make Random::Thing generic and not use any Random::RPG modules.
sub random_stuff {
  my @stuffs = (
    random_thing,
    random_monster('all', ['monsters']),
    'magical ' . random_magic_item('all', ['item']),
    random_weapon('all', ['weapon'])
  );
  my $stuff = noun( $stuffs[rand @stuffs] )->classical->plural;
}

sub random_check {
  my @base_checks = (
    random_ability('by keys').' check',
    tiny_rand('', random_ability('by keys').' based ').tiny_rand('', random_class.' ').'non-weapon proficiency check',
    'saving throw'.tiny_rand('',' vs. '.random_saving_throw(tiny_rand('by keys', 'all'))),
    'backstab',
    'undead turning',
    'spell memorization'
  );

  my @checks;
  for my $check (@base_checks) {
    push @checks, map("$_ $check", qw(successful failed));
  }
  push @checks, map("critical $_", qw(hit miss));

  return $checks[rand @checks];
}

sub game_rolls {
  my @game_rolls = (
    random_ability('by keys').' checks',
    'on non-weapon proficiency checks',
    'to saving throws'.tiny_rand('',' vs. '.random_saving_throw(tiny_rand('by keys', 'all'))),
    'Armor Class',
    'THAC0 modifier',
    'to Surprise'
  );
  return tiny_rand(@game_rolls);
}

sub parent_knows {
  my $base_parent = random_family_member('generational parents');
  my $parent = $base_parent =~ /mother|father/ ? $base_parent : A($base_parent);
  return " $parent knows";
}

sub learning {
  my @learning = (
    PL_N(random_proficiency_type).parent_knows,
    random_language_common().' or related languages',
    tiny_rand(random_ability('by keys').' based',random_class('by keys')).' non-weapon proficiencies',
    noun( random_weapon('damage type') )->classical->plural,
    'the '.random_spell_group('psionisist')
  );
  return tiny_rand(@learning);
}

sub miscellaneous_magic {
  my @miscellaneous = (
    'magic dead',
    'a magic attracter',
    'addicted to magic energies',
    tiny_rand(qw(blessed cursed)),
    'a '.random_range('imperial').' radius '.tiny_rand('wild magic', 'magic dead').' zone',
    A(random_monster('lycanthrope')),
  );
  return tiny_rand(@miscellaneous);
}

sub events {
  my ($game_time) = @_;

  my @events = (
    'magic is used '.random_radius('imperial', 'touch'),
    'every '.random_check,
    'seeing '.A(random_monster)
  );

  my $event = tiny_rand(undef, map("after $_", @events));
  return $event;
}

sub effects {
  my $event     = events();
  my $frequency = sub { tiny_rand(undef, 'at will', random_frequency()) };
  my $duration  = sub { defined($event) ? tiny_rand(undef, 'for '.A(random_time_unit('general'))) : undef; };

  my @effects = (
    sub { join_defined(' ', ('wild magic surge',         $event, &$frequency, &$duration))},
    sub { join_defined(' ', (random_body_color_change(), $event, &$frequency, &$duration))},
    sub { join_defined(' ', (random_body_functions   (), $event, &$duration))},
    sub { join_defined(' ', (random_magic_item_action(), $event, &$frequency, &$duration))},
    sub { join_defined(' ', (random_mental_condition (), $event, &$duration))},
    sub { join_defined(' ', (miscellaneous_magic     (), $event, &$duration))}
  );

  my $raw_effect = tiny_rand(@effects);
  my $effect = &$raw_effect;

  return $effect;
}

sub fate {
  my @fates = (
    'fated to become '.A(random_monster('undead','by keys')).' upon death',
    'is a '.tiny_rand(qw(major minor)).' '.tiny_rand(qw(hero villain)).' in a prophesy',
    'will become '.A(random_divinity)
  );
  my $fate = tiny_rand(@fates);

  return $fate;
}

sub random_mutation {
  my @mutations = (
    'no unusual effect',
    'ability modifier',
    'game effect modifier',
    sub { return '<strong>Body modification:</strong> '.random_body_modification },
    sub { return '<strong>Special Attack:</strong> '.random_special_attack },
    sub { return random_class_special },
    sub { return random_spell_casting(random_frequency) },
    'wild psionic talent',
    sub { return random_sign.roll('1d10').' '.game_rolls },
    sub { return random_spell_resistance },
    sub { return random_weapon_damage.' from '. noun(random_magic_weapon)->classical->plural },
    'birth level',
    'max level',
    sub { return 'can '. tiny_rand('only','not') . tiny_rand(
      ' learn '.learning,
      ' use '.noun( tiny_rand(random_weapon('material'), random_weapon('damage type')) )->classical->plural
    )},
    sub { return 'can '.tiny_rand('only','not').' make '.PL_N(random_event) },
    sub { return 'knows one '.random_proficiency_type.parent_knows },
    sub { return 'knows all '.PL_N(random_proficiency_type).parent_knows },
    sub { return 'attracts '.random_class.' followers' },
    sub { return tiny_rand(qw(attracts repels)).' all '.PL_N(random_animal).' '.random_radius('simple','imperial') },
    sub { return tiny_rand('communicates with','knows history of').' '.random_stuff.' '.random_radius('touch','imperial') },
    sub { return 'has '.A(random_aura) },
    sub { return 'touch '.random_attack('touch special') },
    sub { return effects() },
    sub { return fate() },
    sub { return 'is '.miscellaneous_magic }
  );

  my $mutation = $mutations[rand @mutations];
  return ref($mutation) eq 'CODE' ? &$mutation : $mutation;
}

sub random_mutations {
  my ($user_rolls) = @_;
  my $main_rolls = $user_rolls ? $user_rolls : random_die(1);

  my @effects;
  for (1..$main_rolls) {
    push @effects, random_mutation;
  };

  my %effects_count;
  ++$effects_count{$_} for @effects;
  delete $effects_count{'no unusual effect'};

  my @mutations;
  for my $effect (keys %effects_count) {
    my $value = $effects_count{$effect};
    if ($effect eq 'ability modifier') {
      my %abilities;
      $abilities{random_ability('by keys')}++ for (1..$value);
      for my $ability (keys %abilities) {
        my $rolls = $abilities{$ability};
        my $modifier = sum(map(random_sign.random_die(1),(1..$rolls)));
        $abilities{$ability} = $modifier > 0 ? "+$modifier" : $modifier;
      }

      for my $ability (qw(strength dexterity constitution intelligence wisdom charisma)) {
        if ($abilities{$ability} && $abilities{$ability} != 0) {
          push @mutations, "<strong>Ability score modifier:</strong> $ability ".$abilities{$ability};
        }
      }
    }
    elsif ($effect eq 'game effect modifier') {
      my %game_effects;
      $game_effects{random_game_effect_expanded()}++ for (1..$value);
      for my $game_effect (keys %game_effects) {
        my $rolls = $game_effects{$game_effect};
        my $modifier = sum(map(random_sign.random_die(1),(1..$rolls)));
        $game_effects{$game_effect} = $modifier > 0 ? "+$modifier" : $modifier;
      }

      for my $game_effect (sort keys %game_effects) {
        push @mutations, "<strong>Game effect modifier:</strong> $game_effect ".$game_effects{$game_effect};
      }
    }
    elsif ($effect eq 'birth level') {
      my @levels = map(random_die(1),(1..$value));
      my $birth_level = ORD(max(@levels));
      push @mutations, "born already at $birth_level level";
    }
    elsif ($effect eq 'max level') {
      my @levels = map(roll('5d4'),(1..$value));
      my $max_level = ORD(int(sum(@levels) / (scalar @levels / 2)));
      push @mutations, "can not advance past $max_level level";
    }
    elsif ($effect eq 'wild psionic talent') {
      my $psionics = random_wild_psionic_talent($value);
      push @mutations, $psionics if $psionics;
    }
    else {
      push @mutations, $value > 1 ? "$effect <em>($value)</em>" : $effect;
    }
  }

  @mutations = sort { textify($a) cmp textify($b) } @mutations;
  return \@mutations;
}

=pod

=encoding utf8

=head1 NAME

B<RPG::CharacterMutation> allows a DM to mutate characters by generating enhancements, diminishments, and mutations.

=head1 ACKNOWLEDGEMENTS

Perl Monks: Anno, bradenshep, Corion, ikegami, Limbic~Region, Petruchio, shmem, Sidhekin, wfsp, ysth and the rest of the community that has been so kind to me.

This generator is why I began to learn perl seriously. All my other work in perl stems from this randomness.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;