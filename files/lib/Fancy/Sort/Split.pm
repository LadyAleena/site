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

=pod

=encoding utf8

=head1 NAME

B<Fancy::Sort::Split> returns the comparison expression to split the values in lists for sort.

=head1 VERSION

This document describes Fancy::Sort::Split version 1.0.

=head1 SYNOPSIS

  my @numbers = qw(1:2 1:02 3:4 5:78 50:89 10:5);

  my @split_sorted = sort { split_sort($a, $b, 'number', ':') } @numbers;
  # returns
  # (
  #   '1:2',
  #   '1:02',
  #   '3:4',
  #   '5:78',
  #   '10:5',
  #   '50:89'
  # );

  my @left  = qw(2:a 02:a 4:a 28:a 89:a 5:a);
  my @split_sorted_left  = sort { split_sort($a, $b, 'left', ':')    } @left;
  # returns
  # (
  #   '2:a',
  #   '02:a',
  #   '4:a',
  #   '5:a',
  #   '28:a',
  #   '89:a'
  # );

  my @right = qw(a:2 a:02 a:4 a:28 a:89 a:5);
  my @split_sorted_right = sort { split_sort($a, $b, 'right', ':')   } @right;
  # returns
  # (
  #   'a:2',
  #   'a:02',
  #   'a:4',
  #   'a:5',
  #   'a:28',
  #   'a:89'
  # );

=head1 DESCRIPTION

Fancy::Sort::Split returns the comparison expression to split the values in lists for L<sort|https://perldoc.perl.org/functions/sort.html> subroutines using C<split_sort>. C<split_sort> is not exported by default and has to be imported into your script.

  use Fancy::Sort::Split qw(split_sort);

C<split_sort> has three required parameters. The first and second paremeters are C<$a> and C<$b> from C<sort> or C<$b> and C<$a> if you want a descending sort. The third parameter is the type of sort you want: C<number>, C<left>, C<right>, or C<alpha> (C<letter>). The fourth parameter is the expression you want to split the strings by and can be ignored for alpha (letter) sort.

  split_sort($a, $b, 'type', 'expr');

A note of caution for the numerical sorts, when a number has a leading zero (C<02>), the leading zero will be dropped. So, C<02> will be the same as C<2> and will be returned in their original order. So, C<qw(02 2)> and C<qw(2 02)> will be sorted in that order.

It requires Perl version 5.16.0 or better.

=head2 Numerical sort

When you have numbers on both sides of the expression, use C<number> so the numbers on both sides are numerically sorted.

  split_sort($a, $b, 'number', 'expr');

=head2 Numerical sort on the left

When you have numbers on the left side of the expression, use C<left> so the numbers on the left side are numerically sorted.

  split_sort($a, $b, 'left', 'expr');

=head2 Numberial sort on the right

When you have numbers on the right side of the expression, use C<right> so the numbers on the right side are numerically sorted.

  split_sort($a, $b, 'right', 'expr');

=head2 Alphabetical sort

When you have letters on both sides of the expression, use C<alpha> or C<letter>. However, the alphabetical sort is redundant and was added for completeness. The sort expression returned will be the same as C<$a cmp $b> for the entire string. So, for alphabetical sorts, you may omit the expression for the split.

  split_sort($a, $b, 'alpha',  'expr');
  split_sort($a, $b, 'letter', 'expr');

=head1 DEPENDENCIES

Fancy::Sort::Split depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;