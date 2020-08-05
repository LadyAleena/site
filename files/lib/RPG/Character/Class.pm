package RPG::Character::Class;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(convert_class class_level player_classes);

use Lingua::EN::Inflect qw(ORD);

use Util::Data qw(make_hash);

my @specialists = qw(enchanter illusionist invoker necromancer);
my @elementalists = qw(pyromancer hydromancer geomancer aeromancer);
my @other_wizards = ('arcanist',"sha'ira",'wild mage');
my $wizards = join('|', (@specialists, @elementalists, @other_wizards));

sub convert_class {
  my ($class, $module) = @_;

  $class = 'warrior' if (
    ($class eq 'fighter' && $module !~ /(?:Level|WeaponSlots)/) ||
    ($class eq 'paladin' && $module ne 'TurningUndead') ||
    ($class =~ /(?:paladin|ranger)/i && $module ne 'SpellProgression') ||
    ($class eq 'askara')
  );
  $class = 'rogue'   if (
    ($class eq 'thief' && $module ne 'RogueSkills') ||
    ($class eq 'bard' && $module !~ /(?:SpellProgression|RogueSkills)/)
  );
  $class = 'priest'  if (
    ($class =~ /(?:cleric|witch doctor)/i) ||
    ($class eq 'druid' && $module !~ /(?:Level|TurningUndead)/) ||
    ($class eq 'specialty priest' && $module ne 'Level')
  );
  $class = 'wizard'  if ($class =~ /(?:mage|$wizards)/i);

  return $class;
}

my $xpchart = make_hash(
  'file' => ['Role_playing/Classes','Levels.txt'],
  'headings' => [qw(level fighter warrior rogue priest druid),'specialty priest','wizard','psionisist','chaos warden','theopsyelementalist']
);

sub class_level {
  my ($class, $user_xp, $user_level) = @_;
  $class = convert_class($class, 'Level');
  my $xp = $user_xp ? $user_xp : 0;
  my $level = $user_level ? $user_level : 1;
  my $next_level = $level + 1;

  my $current_level;
  if ($level >= 100) {
    $current_level = $level;
    warn "The XP charts do not go above level 100.";
  }
  elsif ($xp >= $xpchart->{$level}{$class} && $xp < $xpchart->{$next_level}{$class}) {
    $current_level = $level;
  }
  else {
    $current_level = class_level($class, $xp, $next_level);
  }
  return $current_level;
}

sub player_classes {
  my ($class, $experience) = @_;

  my @classes;
  for (@{$class}) {
    my $level = ORD(class_level($_, $experience));
    push @classes, "$level level $_";
  }

  return \@classes;
}

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;