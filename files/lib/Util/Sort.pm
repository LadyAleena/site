package Util::Sort;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use HTML::Entities qw(decode_entities);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(article_sort name_sort split_sort);

sub split_out_leading_number {
    my $s = shift;
    if ( $s =~ /^(\d+[,\.\d]*|\.\d+[,\.\d]*)(.*)$/ ) {
        my ($leading_number, $rest) = ($1,$2);
        # Take any commas out of the number.
        $leading_number =~ s/,//g;
        return ($leading_number, $rest);
    }

    die "split_out_leading_number received bogus input '$s'!\n";
}

# Written by roboticus on PerlMonks.
# When sorting lists of files, I want the index file to always come first.
# There may be an index file in a directory of files I want sorted by name.
# Added on 2019 May 17:
# I have since added the optional sorting of Miscellany to be the last item of a list.
sub my_index_sort {
    my ($c, $d, $opt) = @_;
    # We want any item starting with "index." to sort to the top of
    # the list.  The rest of the ordering is handled by the caller.
    # So there are four cases we must handle:
    #
    #   Matches?
    #   $c    $d   return
    #   No    No     0
    #   Yes   No    -1
    #   No    Yes   +1
    #   Yes   Yes    0     (-1 + +1 == 0)
    #
    # In the fourth case, when both strings have the "index." prefix,
    # we want them to sort via the normal method so that "index.1" will
    # always sort before "index.2".

    my $return_value = 0;
    --$return_value  if $c =~ /^index\./;
    ++$return_value  if $d =~ /^index\./;
    if ($opt->{'misc'} && $opt->{'misc'} =~ /^[ytk1]/i) {
      ++$return_value  if $c =~ /^Miscellany/;
      --$return_value  if $d =~ /^Miscellany/;
    }
    return $return_value;
}

# This is my default sorting method.
# Written first with the help of kent/n in #perl on freenode, then later roboticus on PerlMonks.
sub article_sort {
  my ($c, $d, $opt) = @_;

  my $t = my_index_sort($c, $d, { 'misc' => $opt->{'misc'} });
  return $t if $t;

  for ($c, $d) {
    s/<.+?>//g; # Strip out any html tags.
    s/\s*\b(A|a|An|an|The|the)(_|\s)//xi; # Strip off leading articles (in English).
    s/\((.+)\)/$1/g;
    decode_entities($_);
  }
  if ( $c =~ /^(\d+[,\.\d]*|\.\d+[,\.\d]*)(.*)$/ && $d =~ /^(\d+[,\.\d]*|\.\d+[,\.\d]*)(.*)$/) {
    my ($num1, $text1) = split_out_leading_number($c);
    my ($num2, $text2) = split_out_leading_number($d);

    # First compare the numbers, then compare the remaining parts of the string.
    $num1 <=> $num2 || $text1 cmp $text2
  }
  else {
    $c cmp $d;
  }
}

sub name_sort {
  my ($c, $d) = @_;

  my $t = my_index_sort($c, $d);
  return $t if $t;

  # When I sort by name I prefer lastname firstname.
  # I have not yet written this to account for Roman numerals after the last name.

  for ($c, $d) {
    s/<.+?>//g; # Strip out any html tags.
    s/ (?:Jr.|Sr.)$//;
    $_ = join(' ', (reverse split(/(?:_|\s)(?=[^_\s]+$)/, $_, 2))) if $_ !~ /^_/;
    s/^_//;
    s/\s*\b(A|a|An|an|The|the)(_|\s)//xi; # Strip off leading articles (in English).
    s/\|.+$//;
    decode_entities($_);
  }
  return $c cmp $d;
}

=pod

=encoding utf8

=head1 NAME

B<Util::Sort> performs various sorts on lists.

=head1 VERSION

This document describes Util::Sort version 1.0.

=head1 DEPENDENCIES

Util::Sort depends on L<HTML::Entities> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;