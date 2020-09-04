package Page::Columns;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use Lingua::EN::Inflect qw(NUMWORDS);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(number_of_columns);

sub number_of_columns {
  my ($max_cols, $amount, $word) = @_;
  my $columns;
  if ($amount <= $max_cols ** 2) {
    for my $num (1..$max_cols) {
      if ($amount >= $num ** 2 && $amount < ($num + 1) ** 2) {
        $columns = $word && $word =~ /^[yt1]/i ? NUMWORDS($num) : $num;
      }
    }
  }
  else {
    $columns = $word && $word =~ /^[yt1]/i ? NUMWORDS($max_cols) : $max_cols;
  }
  return $columns;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;