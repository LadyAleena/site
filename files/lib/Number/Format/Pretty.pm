package Number::Format::Pretty;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(commify round pretty_number);

# commify, round, and pretty_number all make my numbers more readable.
# commify was found in the perlfaq5 to put commas in numbers.
sub commify {
  local $_  = shift;
  1 while s/^([-+]?\d+)(\d{3})/$1,$2/;
  return $_;
}

# sprintf written by james2vegas on PerlMonks.
sub round {
  my ($number, $precision) = @_;
  my $rounded = $number =~ /\./ ? sprintf("%.${precision}f", $number) : $number;
  return $rounded;
}

sub pretty_number {
  my ($number, $precision) = @_;
  my $pretty_number = commify(round($number, $precision));
  return $pretty_number;
}

=pod

=encoding utf8

=head1 NAME

B<Number::Format::Pretty> adds commas, rounds, and returns pretty numbers.

=head1 VERSION

This document describes Number::Format::Pretty version 1.0.

=head1 SYNOPSIS

  use Number::Format::Pretty qw(commify round pretty_number);

  my $comma_number = commify(2468);
  # returns 2,468

  my $rounded_number = round(0.2468, 3);
  # returns .247

  my $pretty_number = pretty_number(2468.13579, 3);
  # returns 2,468.136

=head1 DESCRIPTION

Number::Format::Pretty contains three subroutines that make numbers prettier: C<commify>, C<round>, and C<pretty_number>.

=head2 commify

B<C<commify>> returns a number with commas between every three digits in the number.

The code was found in L<perlfaq5|http://perldoc.perl.org/perlfaq5.html#How-can-I-output-my-numbers-with-commas-added?>.

=head2 round

B<C<round>> rounds a decimal number by a set precision. If you want the number returned with three digits after the decimal, the precision would be set to 3.

  round($number, $precision);

=head2 pretty_number

B<C<pretty_number>> puts commify and round together so you can get rounded numbers with commas.

  pretty_number($number, $precision);

=head1 DEPENDENCY

Number::Format::Pretty depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;