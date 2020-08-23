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

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
