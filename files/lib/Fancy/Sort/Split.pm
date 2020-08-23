package Fancy::Sort::Split;
use v5.16.0;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(split_sort);

sub split_sort {
  my ($in_a, $in_b, $sort_type, $split) = @_;

  if ($sort_type =~ /^(alpha|letter)/) {
    $in_a cmp $in_b
  }
  else {
    $split = qr($split);
    my ($numa1, $numa2) = split(/$split/, $in_a, 2);
    my ($numb1, $numb2) = split(/$split/, $in_b, 2);

    if ($sort_type =~ /^num/) {
      $numa1 <=> $numb1 || $numa2 <=> $numb2
    }
    elsif (fc($sort_type) eq 'left' ) {
      $numa1 <=> $numb1 || $numa2 cmp $numb2
    }
    elsif (fc($sort_type) eq 'right' ) {
      $numa1 cmp $numb1 || $numa2 <=> $numb2
    }
    else {
      $in_a <=> $in_b
    }
  }
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
