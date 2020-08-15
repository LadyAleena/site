package Random::RPG::Weapon;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);
use String::Util qw(collapse);
use Text::CSV qw(csv);

use Fancy::Rand  qw(fancy_rand tiny_rand);
use Random::Misc qw(random_non);
use RPG::WeaponName qw(display_weapon);
use Util::Data   qw(file_directory);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_weapon random_weapons random_magic_weapon random_weapon_damage);

my $weapons_dir     = file_directory('Role_playing/Reference_tables', 'data');
my $weapons_fn      = "$weapons_dir/Weapons.txt";
my $weapons_headers = ['Weapon','#AT','Dmg(S/M)','Dmg(L)','Range','Weight','Size','Type','Speed','KO','broad group','tight group'];
my $weapons = csv(
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
  'tight group' => [qw(axes hammers picks bows crossbows clubs flails maces javelins lances spears glaives poleaxes staves),
                    map("$_ firearms",(qw(flintlock matchlock snaplock wheellock), 'hand match')),
                    map("$_ polarms",  qw(beaked billed spear-like)),
                    map("$_ swords",   qw(short medium large)),
                    map("$_ weapons", (qw(combined farm chain rope), 'aided missile', 'martial arts')),
                    'weapons of opportunity'
                   ],
  'material'    => [map("$_ weapons", qw(bone metal stone wooden))],
  'damage type' => [map("$_ weapons", qw(bludgeoning piercing slashing missile))],
  'weapon'      => [map(display_weapon('text' => $_, 'plural' => 'plural', 'full' => 'yes'), keys %$weapons)],
);

sub random_weapon {
  my @weapon_list = (map(display_weapon('text' => $_, 'plural' => 'singular', 'full' => 'yes'), keys %$weapons));
  my $weapon = tiny_rand(@weapon_list);
  return $weapon;
}

sub random_weapons {
  my ($user_weapons, $user_additions) = @_;
  my $weapon = fancy_rand(\%weapon_groups, $user_weapons, { caller => 'random_weapons', additions => $user_additions ? $user_additions : undef });
  return $weapon;
}

sub random_magic {
  my @magics = ('', random_non.'magical');
  my $magic  = tiny_rand(@magics);
  return $magic;
}

sub random_magic_weapon {
  my $magic   = random_magic();
  my $weapons = "$magic ".random_weapons('all', ['weapons']);
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
      'only '.random_non.'magical'
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

  use Random::RPG::Weapon qw(random_weapon random_weapons random_magic_weapon random_weapon_damage);

=head1 DEPENDENCIES

Random::RPG::Weapon depends on <Fancy::Rand>, L<Random::Misc>, L<RPG::WeaponName>, L<Util::Data>, L<Games::Dice>, L<String::Util>, L<Text::CSV>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;