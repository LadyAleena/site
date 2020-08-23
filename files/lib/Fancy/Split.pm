package Fancy::Split;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(fancy_split);

# written with help, but I'm embarrassed I didn't note them.
sub fancy_split {
  my ($character, $string, $number) = @_;

  my @split_array = split(/$character/, $string);

  my $rejoined;
  for (my $i = 0; $i < @split_array; $i += $number) {
    my $max = $i + $number - 1 > $#split_array ? $#split_array : $i + $number - 1;
    push @{$rejoined}, join($character, @split_array[$i..$max])
  }

  return $rejoined;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
