package Random::RPG::Weapon;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);
use String::Util qw(collapse);
use Text::CSV qw(csv);

use Fancy::Rand  qw(fancy_rand tiny_rand);
use RPG::WeaponName qw(display_weapon);
use Page::File qw(file_directory);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_weapon random_magic_weapon random_weapon_damage);

my $weapons_dir     = file_directory('Role_playing/Reference_tables', 'data');
my $weapons_fn      = "$weapons_dir/Weapons.txt";
my $weapons_headers = ['Weapon','#AT','Dmg(S/M)','Dmg(L)','Range','Weight','Size','Type','Speed','KO','broad group','tight group'];
my $weapons_list = csv(
  in      => $weapons_fn,
  headers => $weapons_headers,
  key     => $weapons_headers->[0],
  sep_char         => '|',
  quote_char       => undef,
  blank_is_undef   => 1,
  empty_is_undef   => 1,
  allow_whitespace => 1,
);

my %weapon_groups = (
  'broad group' => ['axes, hammers, and picks', 'bows', 'clubs, flails, and maces', 'firearms', 'javelins and spears', 'polearms', 'swords', 'unique weapons'],
  'tight group' => [qw(axe hammer pick bow crossbow club flail mace javelin lance spear glaive poleaxe staff),
                    map("$_ firearm",(qw(flintlock matchlock snaplock wheellock), 'hand match')),
                    map("$_ polarm",  qw(beaked billed spear-like)),
                    map("$_ sword",   qw(short medium large)),
                    map("$_ weapon", (qw(combined farm chain rope), 'aided missile', 'martial arts')),
                    'weapon of opportunity'
                   ],
  'material'    => [map("$_ weapon", qw(bone metal stone wooden))],
  'damage type' => [map("$_ weapon", qw(bludgeoning piercing slashing missile))],
  'weapon'      => [map(display_weapon('text' => $_, 'plural' => 'singular', 'full' => 'yes'), keys %$weapons_list)],
);

sub random_weapon {
  my ($user_weapons, $user_additions) = @_;
  my $weapon = fancy_rand(\%weapon_groups, $user_weapons, { caller => 'random_weapon', additions => $user_additions ? $user_additions : undef });
  return $weapon;
}

sub random_magic_weapon {
  my @magics = ('', tiny_rand('', 'non-').'magical');
  my $magic  = tiny_rand(@magics);
  my $weapons = "$magic ".random_weapon('all', ['weapons']);
     $weapons = $weapons =~ /magic/ ? $weapons : "all $weapons";
  return collapse($weapons);
}

sub random_weapon_damage {
  my @damage = (
    'immune to damage',
    map("takes $_ damage", (
      '1 hp per die',
      '½',
      '-1 hp per die',
      'maximum',
      '×'.roll('1d4+1'),
      'only '.tiny_rand('', 'non-').'magical'
      )
    )
  );
  return tiny_rand(@damage);
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::Weapon> selects random weapons from I<Advanced Dungeons & Dragons>, Second Edition.

=head1 VERSION

This document describes Random::RPG::Weapon version 1.000.

=head1 SYNOPSIS

  use Random::RPG::Weapon qw(random_weapon random_magic_weapon random_weapon_damage);

=head1 DEPENDENCIES

Random::RPG::Weapon depends on Page::File, L<Fancy::Rand>, L<RPG::WeaponName>, L<Games::Dice>, L<String::Util>, L<Text::CSV>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;