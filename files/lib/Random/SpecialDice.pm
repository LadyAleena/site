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

=pod

=encoding utf8

=head1 NAME

B<Random::SpecialDice> rolls a random die, d16, percentile, permille, or permyriad.

=head1 VERSION

This document describes Random::SpecialDice version 1.0.

=head1 SYNOPSIS

  use Random::SpecialDice qw(random_die percentile permille permyriad d16);

  my $die        = random_die;    # returns a die (1d4, 1d6, 1d8, 1d10, 1d12, 1d20)
  my $rolled_die = random_die(1); # rolls the random die and returns the result
  my $percent    = percentile;    # rolls a percentile using d10s
  my $permille   = permille;      # rolls a permille using d10s
  my $permyriad  = permyriad;     # rolls a permyriad using d10s

=head1 DESCRIPTION

Random::SpecialDice rolls a random die, d16, percentile, permille, or permyriad. The functions C<random_die>, C<d16>, C<percentile>, C<permille>, and C<permyriad> need to be imported into your script.

=head1 Functions

=head2 random_die

  random_die();

If used without a parameter, C<random_die> returns a random dice by the number of sides (1d4, 1d6, 1d8, 1d10, 1d12, or 1d20).

  random_die(1);

If used with a paramter, C<random_die> returns the result of the roll for the random dice. It will not tell you which die was rolled.

=head2 d16

  d16;

C<d16> was written to reproduce the die rolls required for a chart. It rolls a d6 first. If the result of the d6 is less than 4, it will roll a d8. If the result of the d6 is 4 or greater, it will roll a d8 and add 8.

=head2 percentile

  percentile;

C<percentile> is the result for rolling 2 d10s and combining the results to generate a number between 1 and 100. The value of the first d10 is the first digit, and the value of the second d10 is the second digit. Should the results of both rolls be 10, the result will be 100.

=head2 permille

  permille;

C<permille> is the result for rolling 3 d10s and combining the results to generate a number between 1 and 1000. The value of the first d10 is the first digit, the value of the second d10 is the second digit, and the value of the third d10 is the third digit. Should the results of the three rolls be 10, the result will be 1000.

=head2 permyriad

  permyriad;

C<permyriad> is the result for rolling 4 d10s and combining the results to generate a number between 1 and 10000. The value of the first d10 is the first digit, the value of the second d10 is the second digit, the value of the third d10 is the third digit, and the value of the fourth d10 is the fourth digit. Should the results of the four rolls be 10, the result will be 10000.

=head1 DEPENDENCIES

Random::SpecialDice depends on L<Games::Dice> and L<Exporter>.

=head1 AUTHOR

Lady Aleena with help from GrandFather on PerlMonks.

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;