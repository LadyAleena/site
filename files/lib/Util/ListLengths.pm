package Util::ListLengths;
use v5.8.8;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(longest_value shortest_value longest_length shortest_length);

sub longest_length {
  my $longest_length = 0;
  for my $item (@_) {
    $longest_length = length($item) if ( !$longest_length || length($item) > $longest_length );
  }
  return $longest_length;
}

sub shortest_length {
  my $shortest_length = 0;
  for my $item (@_) {
    $shortest_length = length($item) if ( !$shortest_length || length($item) < $shortest_length );
  }
  return $shortest_length;
}

sub longest_value {
  my $longest_length = longest_length(@_);
  my $long_list;
  for my $item (@_) {
    push @$long_list, $item if length($item) == $longest_length;
  }
  return $long_list;
}

sub shortest_value {
  my $shortest_length = shortest_length(@_);
  my $short_list;
  for my $item (@_) {
    push @$short_list, $item if length($item) == $shortest_length;
  }
  return $short_list;
}

=pod

=encoding utf8

=head1 Util::ListLengths

B<Util::ListLengths> returns the value of the longest or shortest value or the length of the longest or shortest value.

=head2 Version

This document describes Util::ListLengths version 1.0.

=head2 Synopsis

  use Util::ListLengths qw(longest_value shortest_value longest_length shortest_length);

  my @colors = ('red', 'orange', 'yellow', 'spring', 'green', 'teal', 'cyan', 'azure',
                'blue', 'violet', 'magenta', 'pink', 'white', 'black', 'gray');

  my $longest_values = longest_value(@colors);

  # [
  #   'magenta'
  # ]

  my $shortest_values = shortest_value(@colors);

  # [
  #   'red'
  # ]

  my $longest_length = longest_length(@colors);
  # 7

  my $shortest_length = shortest_length(@colors);
  # 3

=head2 Description

=head3 longest_value

C<longest_value> returns an arrayref with all the values that are the longest length.

=head3 shortest_value

C<shortest_value> returns an arrayref with all the values that are the shortest length.

=head3 longest_length

C<longest_length> returns the longest integer length of the values of an array.

=head3 shortest_length

C<shortest_length> returns the shortest integer length of the values of an array.

=head2 Dependency

Util::ListLengths depends on L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;