package RPG::WeaponName;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(display_weapon display_weapon_group);

use Lingua::EN::Inflect qw(PL_N);

sub display_weapon {
  my %opt = @_;
  my $plural = $opt{'plural'} ? $opt{'plural'} : undef;
  my $full   = $opt{'full'}   ? $opt{'full'}   : undef;
  my $text   = $opt{'text'} || die "No weapon name. Died$!";
     $text   =~ s/(.+) \((.+)\)/$2 $1/;

  my ($r_weapon, $accessory) = split(/ w\//,$text);

  my $weapon = join(' ', reverse(split(/, /, $r_weapon)));
     $weapon =~ s/\// or /;
     $weapon =~ s/ hammer// if $weapon =~ /(?:maul|warhammer) hammer/;
     $weapon =~ s/ sword//  if $weapon !~ /(?:bastard|broad|long|short|two-handed) sword/;
     $weapon = $plural && $plural =~ /^[pyt1]/ ? PL_N($weapon) : $weapon;

  my $full_weapon = $full && $accessory ? "$weapon with $accessory" :
                    $accessory ? "$weapon ($accessory)" :
                    $weapon;

  return lc $full_weapon;
}

sub display_weapon_group {
  my $text = shift;
  if ($text =~ /:/) {
    my ($main_weapon, $sub_weapons_text) = split(/: ?/, $text);
    my @sub_weapons = split(/, ?/, $sub_weapons_text);
    my @weapons_list = map { display_weapon( 'text' => "$main_weapon, $_" ) } @sub_weapons;
    return @weapons_list;
  }
  else {
    return display_weapon( 'text' => $text );
  }
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