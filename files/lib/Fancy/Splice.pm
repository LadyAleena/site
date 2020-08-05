package Fancy::Splice;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(fancy_splice);

# written with the help of farang and wjw on PerlMonks
sub fancy_splice {
  my ($amount, @in_list) = @_;
  my @list;
  while (@in_list) {
    push @list, [splice(@in_list, 0, $amount)];
  }
  return \@list;
}

=pod

=encoding utf8

=head1 NAME

B<Fancy::Splice> splices an array into groups.

=head1 VERSION

This document describes Fancy::Splice version 1.0.

=head1 SYNOPSIS

  my @colors = ('red', 'orange', 'yellow', 'spring', 'green', 'teal', 'cyan', 'azure',
                'blue', 'violet', 'magenta', 'pink', 'white', 'black', 'gray');
  my $list = fancy_splice(2, @colors);

  [
    ['red','orange'],
    ['yellow','spring'],
    ['green','teal'],
    ['cyan','azure'],
    ['blue','violet'],
    ['magenta','pink'],
    ['white','black'],
    [gray']
  ];

=head1 DESCRIPTION

C<fancy_splice> can be exported and returns a referenced array of arrays spliced by a user specified amount. It takes two paraments: the size of the groups and the list. The size can be any integer, and the list is an array.

=head1 DEPENDENCY

Fancy::Splice depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;