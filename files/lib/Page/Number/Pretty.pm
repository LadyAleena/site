package Page::Number::Pretty;
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

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
