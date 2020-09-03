package Util::Columns;
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

=pod

=encoding utf8

=head1 NAME

B<Util::Columns> generates a number for getting columns based on exponential numbers.

=head1 VERSION

This document describes Util::Columns version 1.0.

=head1 SYNOPSIS

  use Util::Colums qw(number_of_columns);
  my @colors = ('red', 'orange', 'yellow', 'spring', 'green', 'teal', 'cyan', 'azure',
                'blue', 'violet', 'magenta', 'pink', 'white', 'black', 'gray');

  my $maximum_amount_of_columns = 4;
  my $amount_of_items_on_list  = \@colors;
  my $number_word_returned     = 'no';

  my $columns = number_of_columns($maximum_amount_of_columns, $amount_of_items_on_list, $number_word_returned);
  # 3

=head1 DESCRIPTION

Util::Columns exports C<number_of_columns> by default.

C<number_of_columns> takes three parameters. The first parameter is the maximum amount of columns allowed. The second parameter is the amount of items on the list. The third parameter is the option to return a number word instead of an integer, this is optional.

=head1 DEPENDENCIES

Util::Columns depends on L<Lingua::EN::Inflect> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;