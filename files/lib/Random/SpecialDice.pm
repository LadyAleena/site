package Random::SpecialDice;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll roll_array);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_die percentile permille permyriad d16);

sub random_die {
  my $roll = shift;
  my @dice = qw(1d4 1d6 1d8 1d10 1d12 1d20);
  my $die = $dice[rand @dice];
  return $roll ? roll($die) : $die;
}

sub d16 {
  my $d6 = roll('1d6');
  my $d8 = roll('1d8');

  my $d16 = $d6 < 4 ? $d8 : $d8 + 8;

  return $d16;
}

sub percentile {
  my @rolls = roll_array('2d10');
  $_ = 0 for grep {$_ == 10} @rolls; # Thank you GrandFather.

  my $roll = join('',@rolls);
     $roll =~ s/^0//;

  my $percentile = $roll == '00' ? 100 : $roll;

  return $percentile;
}

sub permille {
  my @rolls = roll_array('3d10');
  $_ = 0 for grep {$_ == 10} @rolls; # Thank you GrandFather.

  my $roll = join('', @rolls);
     $roll =~ s/^0//;

  my $permille = $roll == '000' ? 1000 : $roll;

  return $permille;

}

sub permyriad {
  my @rolls = roll_array('4d10');
  $_ = 0 for grep {$_ == 10} @rolls; # Thank you GrandFather.

  my $roll = join('',@rolls);
     $roll =~ s/^0//;

  my $permyriad = $roll == '0000' ? 10000 : $roll;

  return $permyriad;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
